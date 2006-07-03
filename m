From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2nd try] Make git-fmt-merge-msg a builtin
Date: Mon, 03 Jul 2006 15:39:14 -0700
Message-ID: <7vwtaunwj1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607031717540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 00:39:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxX4Z-00029f-Mb
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 00:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWGCWjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 18:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWGCWjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 18:39:16 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:20116 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751113AbWGCWjP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 18:39:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703223915.MWPV11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 18:39:15 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607031717540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 3 Jul 2006 17:18:43 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23220>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> ---
> 	This retires git-fmt-merge-msg.perl, since it passes all the
> 	tests, but removes the Perl version not now.

There is no point not removing the script if you update git.c
and Makefile to point at the new one.

We do not have a test specific for fmt-merge-msg, so it
obviously passes all the tests ;-).  A new one is attached.

I think we should extend boolean to accept 'yes' and 'no', as I
suggested earlier on the list, but other than that things look
good.

Thanks for the patch; no need to resubmit -- I'll munge the
points I raised above.

-- >8 --
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
new file mode 100755
index 0000000..63e49f3
--- /dev/null
+++ b/t/t6200-fmt-merge-msg.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+#
+# Copyright (c) 2006, Junio C Hamano
+#
+
+test_description='fmt-merge-msg test'
+
+. ./test-lib.sh
+
+datestamp=1151939923
+setdate () {
+	GIT_COMMITTER_DATE="$datestamp +0200"
+	GIT_AUTHOR_DATE="$datestamp +0200"
+	datestamp=`expr "$datestamp" + 1`
+	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+}
+
+test_expect_success setup '
+	echo one >one &&
+	git add one &&
+	setdate &&
+	git commit -m "Initial" &&
+
+	echo uno >one &&
+	echo dos >two &&
+	git add two &&
+	setdate &&
+	git commit -a -m "Second" &&
+
+	git checkout -b left &&
+
+	echo $datestamp >one &&
+	setdate &&
+	git commit -a -m "Common #1" &&
+
+	echo $datestamp >one &&
+	setdate &&
+	git commit -a -m "Common #2" &&
+
+	git branch right &&
+
+	echo $datestamp >two &&
+	setdate &&
+	git commit -a -m "Left #3" &&
+
+	echo $datestamp >two &&
+	setdate &&
+	git commit -a -m "Left #4" &&
+
+	echo $datestamp >two &&
+	setdate &&
+	git commit -a -m "Left #5" &&
+
+	git checkout right &&
+
+	echo $datestamp >three &&
+	git add three &&
+	setdate &&
+	git commit -a -m "Right #3" &&
+
+	echo $datestamp >three &&
+	setdate &&
+	git commit -a -m "Right #4" &&
+
+	echo $datestamp >three &&
+	setdate &&
+	git commit -a -m "Right #5" &&
+
+	git show-branch
+'
+
+cat >expected <<\EOF
+Merge branch 'left'
+EOF
+
+test_expect_success 'merge-msg test #1' '
+
+	git checkout master &&
+	git fetch . left &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	diff -u actual expected
+'
+
+cat >expected <<\EOF
+Merge branch 'left' of ../trash
+EOF
+
+test_expect_success 'merge-msg test #2' '
+
+	git checkout master &&
+	git fetch ../trash left &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	diff -u actual expected
+'
+
+cat >expected <<\EOF
+Merge branch 'left'
+
+* left:
+  Left #5
+  Left #4
+  Left #3
+  Common #2
+  Common #1
+EOF
+
+test_expect_success 'merge-msg test #3' '
+
+	git repo-config merge.summary true &&
+
+	git checkout master &&
+	setdate &&
+	git fetch . left &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	diff -u actual expected
+'
+
+cat >expected <<\EOF
+Merge branches 'left' and 'right'
+
+* left:
+  Left #5
+  Left #4
+  Left #3
+  Common #2
+  Common #1
+
+* right:
+  Right #5
+  Right #4
+  Right #3
+  Common #2
+  Common #1
+EOF
+
+test_expect_success 'merge-msg test #4' '
+
+	git repo-config merge.summary true &&
+
+	git checkout master &&
+	setdate &&
+	git fetch . left right &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	diff -u actual expected
+'
+
+test_expect_success 'merge-msg test #5' '
+
+	git repo-config merge.summary yes &&
+
+	git checkout master &&
+	setdate &&
+	git fetch . left right &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	diff -u actual expected
+'
+
+test_done
