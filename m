From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Wed, 16 Jul 2008 12:18:04 -0700
Message-ID: <7viqv5r637.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <20080716012619.GM8185@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 21:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCX1-0004Qa-8T
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbYGPTSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754940AbYGPTST
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:18:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYGPTST (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:18:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6353424114;
	Wed, 16 Jul 2008 15:18:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2A1A32410B; Wed, 16 Jul 2008 15:18:06 -0400 (EDT)
In-Reply-To: <20080716012619.GM8185@mit.edu> (Theodore Tso's message of "Tue,
 15 Jul 2008 21:26:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F12DF9EE-536B-11DD-8A36-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88729>

Theodore Tso <tytso@mit.edu> writes:

> While you have "git am" open, how about adding an "git am --abort"
> which nukes the .dotest aka .git/rebase directory, and resets HEAD
> back to the original position?

This does not seem to have reached the list nor its archives.  I cannot
say I have really looked at it deeply but it may be a good starting
point.  It needs docs ;-)

-- >8 --
From: Nanako Shiraishi <nanako3@lavabit.com>
Date: Wed, 16 Jul 2008 19:39:10 +0900
Subject: [PATCH] git am --abort

After failing to apply patches in the middle of a series, "git am --abort"
lets you go back to the original commit.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 git-am.sh           |   19 +++++++++++++++----
 t/t4151-am-abort.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 4 deletions(-)
 create mode 100755 t/t4151-am-abort.sh

diff --git a/git-am.sh b/git-am.sh
index cc8787b..a44bd7a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -22,6 +22,7 @@ p=              pass it through git-apply
 resolvemsg=     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
 skip            skip the current patch
+abort           abandon patch application and clear .dotest directory
 rebasing        (internal use for git-rebase)"
 
 . git-sh-setup
@@ -120,7 +121,7 @@ It does not apply to blobs recorded in its index."
 
 prec=4
 dotest="$GIT_DIR/rebase"
-sign= utf8=t keep= skip= interactive= resolved= binary= rebasing=
+sign= utf8=t keep= skip= interactive= resolved= binary= rebasing= abort=
 resolvemsg= resume=
 git_apply_opt=
 
@@ -145,6 +146,8 @@ do
 		resolved=t ;;
 	--skip)
 		skip=t ;;
+	--abort)
+		abort=t ;;
 	--rebasing)
 		rebasing=t threeway=t keep=t binary=t ;;
 	-d|--dotest)
@@ -177,7 +180,7 @@ fi
 
 if test -d "$dotest"
 then
-	case "$#,$skip$resolved" in
+	case "$#,$skip$resolved$abort" in
 	0,*t*)
 		# Explicit resume command and we do not have file, so
 		# we are happy.
@@ -197,9 +200,17 @@ then
 	esac ||
 	die "previous rebase directory $dotest still exists but mbox given."
 	resume=yes
+
+	case "$abort" in
+	t)
+		rm -fr "$dotest" &&
+		git read-tree -m -u ORIG_HEAD &&
+		git reset ORIG_HEAD && :
+		exit ;;
+	esac
 else
-	# Make sure we are not given --skip nor --resolved
-	test ",$skip,$resolved," = ,,, ||
+	# Make sure we are not given --skip, --resolved, nor --abort
+	test "$skip$resolved$abort" = "" ||
 		die "Resolve operation not in progress, we are not resuming."
 
 	# Start afresh.
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
new file mode 100755
index 0000000..96b2cd5
--- /dev/null
+++ b/t/t4151-am-abort.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='am --abort'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	for i in a b c d e f g
+	do
+		echo $i
+	done >file-1 &&
+	cp file-1 file-2 &&
+	test_tick &&
+	git add file-1 file-2 &&
+	git commit -m initial &&
+	git tag initial &&
+	for i in 2 3 4 5
+	do
+		echo $i >>file-1 &&
+		test_tick &&
+		git commit -a -m $i || break
+	done &&
+	git format-patch initial &&
+	git checkout -b side initial &&
+	echo local change >file-2 &&
+	cp file-2 file-2-expect
+'
+
+test_expect_success 'am stops at a patch that does not apply' '
+	test_must_fail git am 000[124]-*.patch &&
+	git log --pretty=tformat:%s >actual &&
+	for i in 3 2 initial
+	do
+		echo $i
+	done >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'am --abort goes back' '
+	git am --abort &&
+	git rev-parse HEAD >actual &&
+	git rev-parse initial >expect &&
+	test_cmp expect actual &&
+	test_cmp file-2-expect file-2 &&
+	git diff-index --exit-code --cached HEAD
+'
+
+test_done
-- 
1.5.6
