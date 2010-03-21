From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/14] checkout --conflict=diff3: add a label for ancestor
Date: Sat, 20 Mar 2010 19:40:19 -0500
Message-ID: <20100321004019.GB23888@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:39:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt9CO-00014w-RD
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab0CUAjU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 20:39:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61278 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab0CUAjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:39:19 -0400
Received: by gyg8 with SMTP id 8so2112116gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=q/pN3fpmkRjWTuYdFDixRJ/GHqNYPYP2m4t+JM4ckG4=;
        b=ix/FTg7mHC8eKvRK8k2ltvt9FOm309OyICcAdHRz4u2iV+jDNJ8ynlWFy1XAsP7RBN
         0Z4MV75ip3BxsPFY+6oBp3TlV07rObgmIZD8TRYdbmUDCTxVCqZuRhMpsUUsCRNIlD9E
         vz+QDb0t5B/mXwNSTRW8bE1kMOexT+ExGMQrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wQERUGvuVfbTG/KED3Tzp3LBf9AqowmeiVeHlQ5fY/JJOjIovItNyihnqFVKhhdgog
         DvX83OO+R89sEZL70Z8XoITmrjuZLmkfmn62q8nmCAxfzbldghp5JuOoMw7mZxG5htMo
         zVooqY11uoOzJjHgqVmXuPvM0bn7C7zgppVJE=
Received: by 10.150.13.8 with SMTP id 8mr9587799ybm.198.1269131959238;
        Sat, 20 Mar 2010 17:39:19 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1867268iwn.7.2010.03.20.17.39.18
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:39:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142775>

git checkout --conflict=3Ddiff3 can be used to present conflicts hunks
including text from the common ancestor:

	<<<<<<< ours
	ourside
	|||||||
	original
	=3D=3D=3D=3D=3D=3D=3D
	theirside
	>>>>>>> theirs

The added information is helpful for resolving a merge by hand, and
merge tools can usually understand it without trouble because it looks
like output from =E2=80=98diff3 -m=E2=80=99.

diff3 includes a label for the merge base on the ||||||| line, and it
seems some tools (for example, Emacs 22=E2=80=99s smerge-mode) cannot p=
arse
conflict hunks without such a label.  Humans could use help in
interpreting the output, too.  So change the marker for the start of th=
e
text from the common ancestor to include the label =E2=80=9Cbase=E2=80=9D=
=2E

git rerere=E2=80=99s conflict identifiers are not affected: to parse co=
nflict
hunks, rerere looks for whitespace after the ||||||| marker rather
than a newline, and to compute preimage ids, rerere has its own code
for creating conflict hunks.  No other code in git tries to parse
conflict hunks.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
=46rom <http://thread.gmane.org/gmane.comp.version-control.git/142374/f=
ocus=3D142380>.

 builtin/checkout.c |    2 +-
 t/t7201-co.sh      |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d67f809..d652b4c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -149,7 +149,7 @@ static int checkout_merged(int pos, struct checkout=
 *state)
 	read_mmblob(&ours, active_cache[pos+1]->sha1);
 	read_mmblob(&theirs, active_cache[pos+2]->sha1);
=20
-	status =3D ll_merge(&result_buf, path, &ancestor, NULL,
+	status =3D ll_merge(&result_buf, path, &ancestor, "base",
 			  &ours, "ours", &theirs, "theirs", 0);
 	free(ancestor.ptr);
 	free(ours.ptr);
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 01175f7..f3f0c4c 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -538,7 +538,7 @@ test_expect_success 'checkout with --merge, in diff=
3 -m style' '
 	(
 		echo "<<<<<<< ours"
 		echo ourside
-		echo "|||||||"
+		echo "||||||| base"
 		echo original
 		echo "=3D=3D=3D=3D=3D=3D=3D"
 		echo theirside
@@ -582,7 +582,7 @@ test_expect_success 'checkout --conflict=3Ddiff3' '
 	(
 		echo "<<<<<<< ours"
 		echo ourside
-		echo "|||||||"
+		echo "||||||| base"
 		echo original
 		echo "=3D=3D=3D=3D=3D=3D=3D"
 		echo theirside
--=20
1.7.0.2
