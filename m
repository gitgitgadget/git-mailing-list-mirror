Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 24282 invoked by uid 111); 24 Sep 2008 21:57:32 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 24 Sep 2008 17:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYIXV52 (ORCPT <rfc822;peff@peff.net>);
	Wed, 24 Sep 2008 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbYIXV52
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 17:57:28 -0400
Received: from 132-201.104-92.cust.bluewin.ch ([92.104.201.132]:65016 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751651AbYIXV51 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 17:57:27 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 719F72AC8FA; Wed, 24 Sep 2008 23:57:16 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	spearce@spearce.org
Subject: [PATCH] git-gui: Use git web--browser for web browsing
Date:	Wed, 24 Sep 2008 23:57:16 +0200
Message-Id: <1222293436-6245-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch removes git-gui specific webbrowser guessing and instead
relies on git web--browser to do the right thing, removing unnecessary
code duplication. New function start_browser encapsulates the browser
execution, for usage from other parts of code. This will also make
git-gui show the documentation menu item even in cases it might not
be able to start up a browser, these cases should be however only
very rare.

This patch has been sponsored by Novartis.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 git-gui/git-gui.sh |   30 +++++++-----------------------
 1 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 10d8a44..fc67eb8 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2345,8 +2345,7 @@ if {![is_MacOSX]} {
 		-command do_about
 }
 
-set browser {}
-catch {set browser $repo_config(instaweb.browser)}
+
 set doc_path [file dirname [gitexec]]
 set doc_path [file join $doc_path Documentation index.html]
 
@@ -2354,34 +2353,19 @@ if {[is_Cygwin]} {
 	set doc_path [exec cygpath --mixed $doc_path]
 }
 
-if {$browser eq {}} {
-	if {[is_MacOSX]} {
-		set browser open
-	} elseif {[is_Cygwin]} {
-		set program_files [file dirname [exec cygpath --windir]]
-		set program_files [file join $program_files {Program Files}]
-		set firefox [file join $program_files {Mozilla Firefox} firefox.exe]
-		set ie [file join $program_files {Internet Explorer} IEXPLORE.EXE]
-		if {[file exists $firefox]} {
-			set browser $firefox
-		} elseif {[file exists $ie]} {
-			set browser $ie
-		}
-		unset program_files firefox ie
-	}
-}
-
 if {[file isfile $doc_path]} {
 	set doc_url "file:$doc_path"
 } else {
 	set doc_url {http://www.kernel.org/pub/software/scm/git/docs/}
 }
 
-if {$browser ne {}} {
-	.mbar.help add command -label [mc "Online Documentation"] \
-		-command [list exec $browser $doc_url &]
+proc start_browser {url} {
+	git "web--browse" $url
 }
-unset browser doc_path doc_url
+
+.mbar.help add command -label [mc "Online Documentation"] \
+	-command [list start_browser $doc_url]
+unset doc_path doc_url
 
 # -- Standard bindings
 #
-- 
tg: (c427559..) t/git-gui/web-browse (depends on: vanilla/master)
