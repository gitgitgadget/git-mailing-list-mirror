Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 10520 invoked by uid 111); 30 Sep 2008 16:52:05 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 30 Sep 2008 12:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbYI3Qv5 (ORCPT <rfc822;peff@peff.net>);
	Tue, 30 Sep 2008 12:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbYI3Qv5
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 12:51:57 -0400
Received: from [212.249.11.140] ([212.249.11.140]:11177 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751705AbYI3Qv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 12:51:56 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id B11712AC8E5; Tue, 30 Sep 2008 18:51:41 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	spearce@spearce.org, Petr Baudis <petr.baudis@novartis.com>
Subject: [PATCH] git-gui: Implement a 'clone' subcommand
Date:	Tue, 30 Sep 2008 18:51:41 +0200
Message-Id: <1222793501-17997-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This enables git-gui to be started with the clone dialog opened right
away, possibly with the URL prefilled when it is passed as another
argument. git-gui can then be e.g. registered as the git:// protocol
handler.

This is just a simple implementation - we construct the front actions
page, then throw it away immediately; I wanted to avoid unnecessary
refactoring and complication of the code, though.

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---
 Documentation/git-gui.txt         |    5 +++++
 git-gui/git-gui.sh                |   21 ++++++++++++++++++---
 git-gui/lib/choose_repository.tcl |   11 ++++++++++-
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 0e650f4..9ce63be 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -43,6 +43,11 @@ citool::
 	to only commit actions, slightly reducing the application's
 	startup time and simplifying the menubar.
 
+clone::
+	Start the 'git-gui' clone dialog, optionally taking
+	a source location as an extra argument to pre-fill
+	in the dialog.
+
 version::
 	Display the currently running version of 'git-gui'.
 
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 4085e8f..86f0151 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -950,6 +950,8 @@ enable_option multicommit
 enable_option branch
 enable_option transport
 disable_option bare
+set init_action {}
+set clone_url {}
 
 switch -- $subcommand {
 browser -
@@ -960,6 +962,13 @@ blame {
 	disable_option branch
 	disable_option transport
 }
+clone {
+	set init_action "clone"
+	if {[llength $argv] > 0} {
+		set clone_url [lindex $argv 0]
+		set argv [lrange $argv 1 end]
+	}
+}
 citool {
 	enable_option singlecommit
 	enable_option retcode
@@ -995,7 +1004,12 @@ citool {
 ##
 ## repository setup
 
-if {[catch {
+if {$init_action != ""} {
+	load_config 1
+	apply_config
+	choose_repository::pick $init_action
+
+} elseif {[catch {
 		set _gitdir $env(GIT_DIR)
 		set _prefix {}
 		}]
@@ -1005,7 +1019,7 @@ if {[catch {
 	} err]} {
 	load_config 1
 	apply_config
-	choose_repository::pick
+	choose_repository::pick {}
 }
 if {![file isdirectory $_gitdir] && [is_Cygwin]} {
 	catch {set _gitdir [exec cygpath --windows $_gitdir]}
@@ -2622,6 +2636,7 @@ blame {
 	return
 }
 citool -
+clone -
 gui {
 	if {[llength $argv] != 0} {
 		puts -nonewline stderr "usage: $argv0"
@@ -2635,7 +2650,7 @@ gui {
 	# fall through to setup UI for commits
 }
 default {
-	puts stderr "usage: $argv0 \[{blame|browser|citool}\]"
+	puts stderr "usage: $argv0 \[{blame|browser|citool|clone}\]"
 	exit 1
 }
 }
diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index 3180786..290fbc0 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -21,7 +21,7 @@ field clone_type hardlink ; # Type of clone to construct
 field readtree_err        ; # Error output from read-tree (if any)
 field sorted_recent       ; # recent repositories (sorted)
 
-constructor pick {} {
+constructor pick {action} {
 	global M1T M1B
 
 	make_toplevel top w
@@ -195,6 +195,11 @@ constructor pick {} {
 		bind $top <Visibility> {}
 	"
 	wm deiconify $top
+
+	if {$action != ""} {
+		_next $this $action
+	}
+
 	tkwait variable @done
 
 	if {$top eq {.}} {
@@ -447,6 +452,10 @@ proc _new_ok {p} {
 ## Clone Existing Repository
 
 method _do_clone {} {
+	if {$::clone_url != ""} {
+		set origin_url $::clone_url
+	}
+
 	$w_next conf \
 		-state disabled \
 		-command [cb _do_clone2] \
-- 
tg: (9800c0d..) t/git-gui/clonecmd (depends on: vanilla/master)
