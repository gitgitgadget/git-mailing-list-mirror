From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/10] checkout -m --conflict=diff3: add a label for
 ancestor
Date: Mon, 15 Mar 2010 03:01:34 -0500
Message-ID: <20100315080134.GH8824@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 09:01:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5F6-0001vr-AH
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759760Ab0COIBf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 04:01:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59596 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759739Ab0COIBf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:01:35 -0400
Received: by gyg8 with SMTP id 8so1360919gyg.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 01:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MU8+O+J4aF1PxjLZdsKSeWLqPJnkm9S1zg9u2G+3El4=;
        b=o6X70HA+wY4JpvnQl/DICjwmA2moLzNVETmpiPWRgOMQ00sTm5BDO8pFv0CB4ZC0cZ
         h8/j/aJhSzbQLMQpC7scGQAC7fjechsZuwtK7MC+QvRFmBXaLWTCDUFl0OsbJq7yauL4
         yRXQjP2uVa2lWfA7fr6ScJALm1cpi0NJ7S51s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=i4VtdR5RjGiEoMJzqJRzJo8RbA1sz8Njwtdo1el5msIwc/uuj3y4O1js91i31EhVoq
         LInCyKL0zNxvH5a4dwFlvgHvOdpHYvLUFtp8GQai0tt2kHMawouifDuIVJlcDcd1XE4Z
         dMI/mD6okJePoqTAM/L5C43uidt6r75W7bL6U=
Received: by 10.90.127.18 with SMTP id z18mr2708463agc.52.1268640093291;
        Mon, 15 Mar 2010 01:01:33 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4046791iwn.9.2010.03.15.01.01.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 01:01:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100315074748.GA28827@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142183>

git checkout --merge --conflict=3Ddiff3 can be used to present conflict=
s
hunks including text from the common ancestor.

The added information can be very helpful for resolving a merge by
hand, and many merge tools can usually grok it because it is very
similar to the output from =E2=80=98diff3 -m=E2=80=99.

Unfortunately, some tools reportedly cannot parse the conflict hunks
because of a small difference from diff3: diff3 -m includes a label
for the merge base on the ||||||| line.  Humans can benefit from a
cue when learning to interpreting the format, too.  So mark the start
of the text from the old branch with a label based on the branch=E2=80=99=
s
name.

git rerere will not have trouble parsing this output, since instead of
looking for a newline, it looks for whitespace after the |||||||
marker.  No other code in git tries to parse conflict hunks.

Reported-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/checkout.c |    1 +
 t/t7201-co.sh      |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c60c3e0..ebc5891 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -439,6 +439,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 			ret =3D reset_tree(new->commit->tree, opts, 1);
 			if (ret)
 				return ret;
+			o.ancestor =3D old->name;
 			o.branch1 =3D new->name;
 			o.branch2 =3D "local";
 			merge_trees(&o, new->commit->tree, work,
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 970a460..ae14b19 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -209,7 +209,7 @@ test_expect_success 'checkout --merge --conflict=3D=
diff3 <branch>' '
 	a
 	c
 	e
-	|||||||
+	||||||| master
 	a
 	b
 	c
--=20
1.7.0
