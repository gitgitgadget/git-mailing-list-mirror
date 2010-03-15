From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/10] checkout --conflict=diff3: add a label for ancestor
Date: Mon, 15 Mar 2010 02:55:09 -0500
Message-ID: <20100315075509.GD8824@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 08:55:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr58v-0008Kh-3Y
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 08:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935731Ab0COHzM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 03:55:12 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:52932 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935715Ab0COHzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 03:55:10 -0400
Received: by yxe29 with SMTP id 29so1376037yxe.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 00:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OjzH23T7OpKNIprS5m1Q2WoockToWVaTkun9OhZE59Y=;
        b=Yqy9dcco+dG09bcL9tHMyyQBrCcqwWrUO+aZK45EAJNoSCgM39m6HnfzQJAzEjjydF
         aLiNKjA0hbhJ2p85iBxxm+2yO15dyRwWTeol5G9ozAiX+jmkU9KOYWnY+6wrBPAwyZ/J
         WiTqA6FG7mpfBERJ5ukgd7epVyGC1fhHJZu4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vI02GIEFyrATYX+HcaFaA1mEUCCmWl13VIcnamW28JFpOM9CMFtRUOwuVXaLtTY97S
         vMqB3pN7O1vsII55yTTmqSXRDyiug7yqSu3bC6y3u8mudSakAvX9s3HEpAt7EyZzIGaI
         yDy1gGXGTarb538xGar3xwZ//CAdX9coAOOFs=
Received: by 10.101.178.8 with SMTP id f8mr1431507anp.213.1268639707054;
        Mon, 15 Mar 2010 00:55:07 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4007062iwn.4.2010.03.15.00.55.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 00:55:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100315074748.GA28827@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142180>

git checkout --conflict=3Ddiff3 can be used to present conflicts hunks
including text from the common ancestor:

	<<<<<<< ours
	ourside
	|||||||
	original
	=3D=3D=3D=3D=3D=3D=3D
	theirside
	>>>>>>> theirs

The added information can be very helpful for resolving a merge by
hand, and merge tools can usually understand it without trouble
because it looks like output from =E2=80=98diff3 -m=E2=80=99.

Unfortunately, not all can: =E2=80=98diff3=E2=80=99 includes a label fo=
r the merge
base on the ||||||| line and it seems some tools cannot parse conflict
hunks without such a label.  Humans could use help in interpreting the
output, too.  So mark the start of the text from the common ancestor
with the label =E2=80=9C||||||| original=E2=80=9D.

git rerere will not have trouble parsing this output, since instead of
looking for a newline, it looks for whitespace after the |||||||
marker.  No other code in git tries to parse conflict hunks.

Reported-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Since =E2=80=9Coriginal=E2=80=9D a good name for the common ancestor?  =
I also
considered =E2=80=9Cbase=E2=80=9D and =E2=80=9Cancestor=E2=80=9D; the l=
atter is too jargon-y for my
taste, but =E2=80=9Cbase=E2=80=9D seems all right.

 builtin/checkout.c |    2 +-
 t/t7201-co.sh      |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d67f809..c60c3e0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -149,7 +149,7 @@ static int checkout_merged(int pos, struct checkout=
 *state)
 	read_mmblob(&ours, active_cache[pos+1]->sha1);
 	read_mmblob(&theirs, active_cache[pos+2]->sha1);
=20
-	status =3D ll_merge(&result_buf, path, &ancestor, NULL,
+	status =3D ll_merge(&result_buf, path, &ancestor, "original",
 			  &ours, "ours", &theirs, "theirs", 0);
 	free(ancestor.ptr);
 	free(ours.ptr);
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index d20ed61..ebfa5ca 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -481,7 +481,7 @@ test_expect_success 'checkout with --merge, in diff=
3 -m style' '
 	(
 		echo "<<<<<<< ours"
 		echo ourside
-		echo "|||||||"
+		echo "||||||| original"
 		echo original
 		echo "=3D=3D=3D=3D=3D=3D=3D"
 		echo theirside
@@ -525,7 +525,7 @@ test_expect_success 'checkout --conflict=3Ddiff3' '
 	(
 		echo "<<<<<<< ours"
 		echo ourside
-		echo "|||||||"
+		echo "||||||| original"
 		echo original
 		echo "=3D=3D=3D=3D=3D=3D=3D"
 		echo theirside
--=20
1.7.0
