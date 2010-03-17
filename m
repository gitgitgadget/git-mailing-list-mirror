From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/16] checkout --conflict=diff3: add a label for ancestor
Date: Wed, 17 Mar 2010 07:04:59 -0500
Message-ID: <20100317120459.GE25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:04:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrrzM-0006Pf-Ik
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab0CQMEg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 08:04:36 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:49761 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0CQMEf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:04:35 -0400
Received: by pzk38 with SMTP id 38so679536pzk.33
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NrsCS+H61vg6Peklz0R3lFCvHUTvGXhc6J3Tt0BKfXQ=;
        b=rpXdBDs1Jl2gZpKYSkbYBtnYYdSijhoTN0NPZZX1ft0D1iBP4BM+v7o28Ct/N4endP
         Vp6IdC0DWeyP8yiSsAM9lE9StGkjUo13OvDD/SPZjnXjMUuaWwd5gaaIjSdOxtawcmK6
         c8Ep9tC8F0ZP9MjjikQmOnxPkdU/X1s5tAIpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xRZi18/6yQ1AG3PEmGBueAURIgGSUsKroWMyXjqLzUFnUtWF/tX65l3GPtGuwM9piN
         YIDIEcomu1sOYVeTKQGr8jAS8ARijuzX4CLaDAo1zvvJ4XlqGsek3sE/IY2d7s6LIviy
         xiTbHPR8tG8ldX1VSGZXDvmN3YCXDqMpBYhNU=
Received: by 10.141.124.13 with SMTP id b13mr599085rvn.68.1268827474660;
        Wed, 17 Mar 2010 05:04:34 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm627187iwn.12.2010.03.17.05.04.33
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:04:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142380>

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

Unfortunately, not all can: diff3 includes a label for the merge base
on the ||||||| line and it seems some tools cannot parse conflict
hunks without such a label.  Humans could use help in interpreting the
output, too.  So mark the start of the text from the common ancestor
with the label =E2=80=9C||||||| base=E2=80=9D.

git rerere=E2=80=99s conflict identifiers are not affected: to parse co=
nflict
hunks, rerere looks for whitespace after the ||||||| marker rather
than a newline, and to compute preimage ids, rerere has its own code
for creating conflict hunks.  No other code in git tries to parse
conflict hunks.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Label changed.  Thanks for the feedback.

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
index d20ed61..981ae8f 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -481,7 +481,7 @@ test_expect_success 'checkout with --merge, in diff=
3 -m style' '
 	(
 		echo "<<<<<<< ours"
 		echo ourside
-		echo "|||||||"
+		echo "||||||| base"
 		echo original
 		echo "=3D=3D=3D=3D=3D=3D=3D"
 		echo theirside
@@ -525,7 +525,7 @@ test_expect_success 'checkout --conflict=3Ddiff3' '
 	(
 		echo "<<<<<<< ours"
 		echo ourside
-		echo "|||||||"
+		echo "||||||| base"
 		echo original
 		echo "=3D=3D=3D=3D=3D=3D=3D"
 		echo theirside
--=20
1.7.0
