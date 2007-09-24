From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-remote rm: add tests and minor fix-ups
Date: Sun, 23 Sep 2007 22:39:30 -0700
Message-ID: <7vsl54bp0t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Bowes <jbowes@dangerouslyinc.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 07:39:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZgfW-00068C-9T
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 07:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbXIXFjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 01:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbXIXFjg
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 01:39:36 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbXIXFjg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 01:39:36 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E4A2A139AF4;
	Mon, 24 Sep 2007 01:39:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59018>

This fixes "git remote rm" which always exited with a failure,
corrects indentation, and adds tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * People seemed to have liked "git remote rm"; additional tests
   were requested to complete the series when the patch was
   submitted but they never came, so I ended up doing the
   janitorial work myself, which led to discovery of breakage in
   the implementation.

   Needless to say, I am not overly amused.

 git-remote.perl   |   10 ++---
 t/t5505-remote.sh |  100 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 6 deletions(-)
 create mode 100755 t/t5505-remote.sh

diff --git a/git-remote.perl b/git-remote.perl
index f513a8a..b7c1e01 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -317,7 +317,7 @@ sub update_remote {
 }
 
 sub rm_remote {
-    my ($name) = @_;
+	my ($name) = @_;
 	if (!exists $remote->{$name}) {
 		print STDERR "No such remote $name\n";
 		return;
@@ -336,7 +336,7 @@ sub rm_remote {
 	};
 
 
-    my @refs = $git->command('for-each-ref',
+	my @refs = $git->command('for-each-ref',
 		'--format=%(refname) %(objectname)', "refs/remotes/$name");
 	for (@refs) {
 		($ref, $object) = split;
@@ -453,11 +453,9 @@ elsif ($ARGV[0] eq 'add') {
 elsif ($ARGV[0] eq 'rm') {
 	if (@ARGV <= 1) {
 		print STDERR "Usage: git remote rm <remote>\n";
+		exit(1);
 	}
-    else {
-        rm_remote($ARGV[1]);
-	}
-    exit(1);
+	rm_remote($ARGV[1]);
 }
 else {
 	print STDERR "Usage: git remote\n";
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
new file mode 100755
index 0000000..636aec2
--- /dev/null
+++ b/t/t5505-remote.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='git remote porcelain-ish'
+
+. ./test-lib.sh
+
+GIT_CONFIG=.git/config
+export GIT_CONFIG
+
+setup_repository () {
+	mkdir "$1" && (
+	cd "$1" &&
+	git init &&
+	>file &&
+	git add file &&
+	git commit -m "Initial" &&
+	git checkout -b side &&
+	>elif &&
+	git add elif &&
+	git commit -m "Second" &&
+	git checkout master
+	)
+}
+
+tokens_match () {
+	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
+	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
+	diff -u expect actual
+}
+
+check_remote_track () {
+	actual=$(git remote show "$1" | sed -n -e '$p') &&
+	shift &&
+	tokens_match "$*" "$actual"
+}
+
+check_tracking_branch () {
+	f="" &&
+	r=$(git for-each-ref "--format=%(refname)" |
+		sed -ne "s|^refs/remotes/$1/||p") &&
+	shift &&
+	tokens_match "$*" "$r"
+}
+
+test_expect_success setup '
+
+	setup_repository one &&
+	setup_repository two &&
+	(
+		cd two && git branch another
+	) &&
+	git clone one test
+
+'
+
+test_expect_success 'remote information for the origin' '
+(
+	cd test &&
+	tokens_match origin "$(git remote)" &&
+	check_remote_track origin master side &&
+	check_tracking_branch origin HEAD master side
+)
+'
+
+test_expect_success 'add another remote' '
+(
+	cd test &&
+	git remote add -f second ../two &&
+	tokens_match "origin second" "$(git remote)" &&
+	check_remote_track origin master side &&
+	check_remote_track second master side another &&
+	check_tracking_branch second master side another &&
+	git for-each-ref "--format=%(refname)" refs/remotes |
+	sed -e "/^refs\/remotes\/origin\//d" \
+	    -e "/^refs\/remotes\/second\//d" >actual &&
+	>expect &&
+	diff -u expect actual
+)
+'
+
+test_expect_success 'remove remote' '
+(
+	cd test &&
+	git remote rm second
+)
+'
+
+test_expect_success 'remove remote' '
+(
+	cd test &&
+	tokens_match origin "$(git remote)" &&
+	check_remote_track origin master side &&
+	git for-each-ref "--format=%(refname)" refs/remotes |
+	sed -e "/^refs\/remotes\/origin\//d" >actual &&
+	>expect &&
+	diff -u expect actual
+)
+'
+
+test_done
-- 
1.5.3.2.1053.g5065
