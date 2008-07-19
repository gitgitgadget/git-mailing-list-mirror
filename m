From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Sat, 19 Jul 2008 15:18:53 -0700
Message-ID: <7v3am5zfea.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org>
 <4882350B.6020003@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sun Jul 20 00:20:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKKme-0004zI-8R
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 00:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbYGSWTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbYGSWTH
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 18:19:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYGSWTG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 18:19:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3526B380DD;
	Sat, 19 Jul 2008 18:19:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 131C2380C8; Sat, 19 Jul 2008 18:18:54 -0400 (EDT)
In-Reply-To: <4882350B.6020003@free.fr> (Olivier Marin's message of "Sat, 19
 Jul 2008 20:40:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B2D035BE-55E0-11DD-9E14-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89138>

Olivier Marin <dkr+ml.git@free.fr> writes:

> Subject: [PATCH] git am --abort
>
> To squash.
>
> Signed-off-by: Olivier Marin <dkr@freesurf.fr>

Thanks.

> @@ -203,9 +204,10 @@ then
>  
>  	case "$abort" in
>  	t)
> -		rm -fr "$dotest" &&
> +		git rerere clear &&
>  		git read-tree -m -u ORIG_HEAD &&
> -		git reset ORIG_HEAD && :
> +		git reset ORIG_HEAD &&
> +		rm -fr "$dotest"
>  		exit ;;
>  	esac
>  else

Clearing the rerere information needs to be done, but I think we should
drop the last && to make sure we remove "$dotest" and exit with its exit
status.

I'm happy with the documentation and help-text parts of your patch, but
probably this, on top of 1a6f6bb (git am --abort, 2008-07-16), is more
appropriate?

--- 
 git-am.sh           |    6 +++---
 t/t4151-am-abort.sh |   46 +++++++++++++++++++++++++++-------------------
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index a44bd7a..5cbf8f4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -203,9 +203,9 @@ then
 
 	case "$abort" in
 	t)
-		rm -fr "$dotest" &&
-		git read-tree -m -u ORIG_HEAD &&
-		git reset ORIG_HEAD && :
+		git rerere clear
+		git read-tree --reset -u HEAD ORIG_HEAD
+		rm -fr "$dotest"
 		exit ;;
 	esac
 else
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 96b2cd5..dda7e2c 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -22,27 +22,35 @@ test_expect_success setup '
 	done &&
 	git format-patch initial &&
 	git checkout -b side initial &&
-	echo local change >file-2 &&
-	cp file-2 file-2-expect
+	echo local change >file-2-expect
 '
 
-test_expect_success 'am stops at a patch that does not apply' '
-	test_must_fail git am 000[124]-*.patch &&
-	git log --pretty=tformat:%s >actual &&
-	for i in 3 2 initial
-	do
-		echo $i
-	done >expect &&
-	test_cmp expect actual
-'
+for with3 in '' ' -3'
+do
+	test_expect_success "am$with3 stops at a patch that does not apply" '
 
-test_expect_success 'am --abort goes back' '
-	git am --abort &&
-	git rev-parse HEAD >actual &&
-	git rev-parse initial >expect &&
-	test_cmp expect actual &&
-	test_cmp file-2-expect file-2 &&
-	git diff-index --exit-code --cached HEAD
-'
+		git reset --hard initial &&
+		cp file-2-expect file-2 &&
+
+		test_must_fail git am$with3 000[124]-*.patch &&
+		git log --pretty=tformat:%s >actual &&
+		for i in 3 2 initial
+		do
+			echo $i
+		done >expect &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "am --abort goes back after failed am$with3" '
+		git-am --abort &&
+		git rev-parse HEAD >actual &&
+		git rev-parse initial >expect &&
+		test_cmp expect actual &&
+		test_cmp file-2-expect file-2 &&
+		git diff-index --exit-code --cached HEAD &&
+		test ! -f .git/rr-cache/MERGE_RR
+	'
+
+done
 
 test_done
