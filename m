From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] stash: introduce 'git stash store'
Date: Mon, 13 May 2013 18:15:52 +0530
Message-ID: <1368449154-21882-5-git-send-email-artagnon@gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 14:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubs7G-0003rq-8a
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 14:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab3EMMo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 08:44:27 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52952 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab3EMMoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 08:44:25 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so4407653pde.4
        for <git@vger.kernel.org>; Mon, 13 May 2013 05:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bbHT/XF4P/lFW4VTGYFddkDh+N11tbChGHbsewH41Gs=;
        b=Rqh2h4ki82fxjuK29z0hx9XaQXZWTmab+vt70DLa8tHElKiqPTvNz7ToDsFnBcqRxC
         79RJgMdgQiCsfF3s9Ju+h9l9c/vnfRWLnit3deHMa7tcnCxQC11rEUCCvh2V5YVt6D0h
         inIrJ7Y6FG85VaWnf6mZ9y+fHefjhRfQ3TYIe9yqNHcrXXL1uJ40TQ6DVZ0sNPjCX0J+
         RqM+hRZg0siomGn7QUAC+jnHwVL6tRafGTviaLu1FuP79+KWuo7sqOZbbWBiKvrH5RW2
         yuWk2MbXwbGuS8A8sX/MGaUgtUvTfvcQDHI0SVB10+xmtuapcueu2lHEMv4p+WQNAeJl
         aHhg==
X-Received: by 10.66.9.99 with SMTP id y3mr29751870paa.189.1368449064673;
        Mon, 13 May 2013 05:44:24 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm3050227pbc.12.2013.05.13.05.44.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 05:44:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.57.g4ac1522
In-Reply-To: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224127>

save_stash() contains the logic for doing two potentially independent
operations; the first is preparing the stash merge commit, and the
second is updating the stash ref/ reflog accordingly.  While the first
operation is abstracted out into a create_stash() for callers to access
via 'git stash create', the second one is not.  Fix this by factoring
out the logic for storing the stash into a store_stash() that callers
can access via 'git stash store'.

Like create, store is not intended for end user interactive use, but for
callers in other scripts.  We can simplify the logic in the
rebase.autostash feature using this new subcommand.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-stash.txt |  6 ++++++
 git-stash.sh                | 25 +++++++++++++++++++------
 t/t3903-stash.sh            | 20 ++++++++++++++++++++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 05e462b..e58ab74 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create [<message> [<include-untracked-p>]]
+'git stash' store <commit> <message>
 
 DESCRIPTION
 -----------
@@ -152,6 +153,11 @@ create::
 	Create a stash (which is a regular commit object) and return its
 	object name, without storing it anywhere in the ref namespace.
 
+store::
+
+	Store a given stash created via 'git stash create' (which is a
+	dangling merge commit) in the stash ref, updating the stash
+	reflog.
 
 DISCUSSION
 ----------
diff --git a/git-stash.sh b/git-stash.sh
index 0ede313..1d483f5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -156,6 +156,20 @@ create_stash () {
 	die "$(gettext "Cannot record working tree state")"
 }
 
+store_stash () {
+	if test $# != 2
+	then
+		die "$(gettext "git stash store requires two arguments")"
+	fi
+	w_commit="$1"
+	stash_msg="$2"
+
+	# Make sure the reflog for stash is kept.
+	: >>"$GIT_DIR/logs/$ref_stash"
+	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
+	die "$(gettext "Cannot save the current status")"
+}
+
 save_stash () {
 	keep_index=
 	patch_mode=
@@ -227,12 +241,7 @@ save_stash () {
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
 	create_stash "$stash_msg" $untracked
-
-	# Make sure the reflog for stash is kept.
-	: >>"$GIT_DIR/logs/$ref_stash"
-
-	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
-		die "$(gettext "Cannot save the current status")"
+	store_stash $w_commit "$stash_msg"
 	say Saved working directory and index state "$stash_msg"
 
 	if test -z "$patch_mode"
@@ -549,6 +558,10 @@ create)
 	shift
 	create_stash "$@" && echo "$w_commit"
 	;;
+store)
+	shift
+	store_stash "$@"
+	;;
 drop)
 	shift
 	drop_stash "$@"
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5dfbda7..2ff3afd 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -637,4 +637,24 @@ test_expect_success 'stash where working directory contains "HEAD" file' '
 	test_cmp output expect
 '
 
+test_expect_success 'store - argument 1 not a commit' '
+	test_must_fail git stash store foo bar
+'
+
+test_expect_success 'store - updates stash ref and reflog' '
+	git stash clear &&
+	git reset --hard &&
+	echo quux >file &&
+	git add file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	! grep quux file &&
+	git stash store ${STASH_ID} quuxery &&
+	test $(cat .git/refs/stash) = ${STASH_ID} &&
+	grep ${STASH_ID} .git/logs/refs/stash &&
+	git stash pop &&
+	grep quux file &&
+	false
+'
+
 test_done
-- 
1.8.3.rc1.57.g4ac1522
