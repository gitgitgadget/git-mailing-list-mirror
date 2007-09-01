From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -m: Fix incorrect short-logs of already applied commits.
Date: Sat, 01 Sep 2007 02:01:41 -0700
Message-ID: <7vmyw6u5ca.fsf@gitster.siamese.dyndns.org>
References: <200709010925.27926.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Sep 01 11:01:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IROrW-0002wN-Tj
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 11:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbXIAJBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 05:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbXIAJBq
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 05:01:46 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:50367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbXIAJBp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 05:01:45 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C1BB12AC5F;
	Sat,  1 Sep 2007 05:02:05 -0400 (EDT)
In-Reply-To: <200709010925.27926.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sat, 1 Sep 2007 09:25:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57260>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> When a topic branch is rebased, some of whose commits are already
> cherry-picked upstream:
>
>     o--X--A--B--Y    <- master
>      \
>       A--B--Z        <- topic
>
> then 'git rebase -m master' would report:
>
>     Already applied: 0001 Y
>     Already applied: 0002 Y
>
> With this fix it reports the expected:
>
>     Already applied: 0001 A
>     Already applied: 0002 B

Well, good eyes.  A new test script would have been nice.

> +		printf "Already applied: %0${prec}d " $msgnum
> +		git rev-list --pretty=oneline -1 "$cmt" | \
> +			sed 's/^[a-f0-9]\+ //'

This is not your fault but I just noticed this sed script that
steps outside BRE [*1*, *2*].  In this case we do not even need
to use '\+', as we know what we are reading.

A few "sed" disciplines to keep things portable I tried to
follow so far are:

 - Always use '-e' to introduce expression;
 - Don't use two expressions concatenated with ';' in a single
   string; multi-line scripts tend to be more portable;
 - Do not use one-or-more "\+", that's not BRE.

I would propose doing the attached patch on top of yours.
Opinion?

[Footnotes] 

*1* http://www.opengroup.org/onlinepubs/000095399/utilities/sed.html
*2* http://www.opengroup.org/onlinepubs/000095399/basedefs/xbd_chap09.html#tag_09_03

---

 git-rebase.sh             |    5 +----
 t/t3406-rebase-message.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9cf0056..3bd66b0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -69,13 +69,10 @@ continue_merge () {
 			die "$RESOLVEMSG"
 		fi
 		printf "Committed: %0${prec}d " $msgnum
-		git rev-list --pretty=oneline -1 HEAD | \
-			sed 's/^[a-f0-9]\+ //'
 	else
 		printf "Already applied: %0${prec}d " $msgnum
-		git rev-list --pretty=oneline -1 "$cmt" | \
-			sed 's/^[a-f0-9]\+ //'
 	fi
+	git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'
 
 	prev_head=`git rev-parse HEAD^0`
 	# save the resulting commit so we can read-tree on it later
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
new file mode 100755
index 0000000..332b2b2
--- /dev/null
+++ b/t/t3406-rebase-message.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='messages from rebase operation'
+
+. ./test-lib.sh
+
+quick_one () {
+	echo "$1" >"file$1" &&
+	git add "file$1" &&
+	test_tick &&
+	git commit -m "$1"
+}
+
+test_expect_success setup '
+	quick_one O &&
+	git branch topic &&
+	quick_one X &&
+	quick_one A &&
+	quick_one B &&
+	quick_one Y &&
+
+	git checkout topic &&
+	quick_one A &&
+	quick_one B &&
+	quick_one Z
+
+'
+
+cat >expect <<\EOF
+Already applied: 0001 A
+Already applied: 0002 B
+Committed: 0003 Z
+EOF
+
+test_expect_success 'rebase -m' '
+
+	git rebase -m master >report &&
+	sed -n -e "/^Already applied: /p" \
+		-e "/^Committed: /p" report >actual &&
+	diff -u expect actual
+
+'
+
+test_done
