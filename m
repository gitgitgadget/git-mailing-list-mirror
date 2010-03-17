From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/16] checkout -m --conflict=diff3: add a label for
 ancestor
Date: Wed, 17 Mar 2010 07:13:25 -0500
Message-ID: <20100317121325.GI25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrs7Z-0001pE-CX
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab0CQMNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 08:13:01 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:42647 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab0CQMNB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:13:01 -0400
Received: by pzk38 with SMTP id 38so684496pzk.33
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dV9JP4cP/5ZZnbAP0zglGnvpFpr+vfhnauzoKWoOfRw=;
        b=mv9B43jtsYnUc2KSCsN8FhxIsw6fykIDrCoIJLog7/vqnfIrAthpalNbhmIfRC+U5W
         ywN2dKH1Q+NInn/2PVv3IptaDeAc/f4YDcj65XVHC1Hym5ZwpJrVO49G+RFhKQM7LH7Y
         GbehorZIrQ5791CKKrrlDkI7aX50NKzHMZfM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=v4MV7WvsUN2drRcg++V6X845wF+SpqroMUpZsCf596AYqVZ0ibnYFo5dVmh5KSf8r0
         D4i/i46hqnVSyBoMTwt7/Fy5qIXcQ/1/tMFwD6IDL4DTtv69Pa1GBhieRLvyQGrJvTwA
         WqGvHNNEVbCMNtoHRCxhfiIjFWbkVuypI6mlI=
Received: by 10.142.1.2 with SMTP id 2mr350790wfa.73.1268827980743;
        Wed, 17 Mar 2010 05:13:00 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm633549iwn.12.2010.03.17.05.12.59
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:13:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142384>

git checkout --merge --conflict=3Ddiff3 can be used to present conflict
hunks including text from the common ancestor.  The added information
can be helpful for resolving a merge by hand, and merge tools tend to
understand it because it is very similar to what =E2=80=98diff3 -m=E2=80=
=99 produces.

Unlike current git, diff3 -m includes a label for the merge base on
the ||||||| line, and unfortunately, some tools cannot parse the
conflict hunks without it.  Humans can benefit from a cue when
learning to interpreting the format, too.  Mark the start of the text
from the old branch with a label based on the branch=E2=80=99s name.

git rerere does not have trouble parsing this output and its preimage
ids are unchanged since it includes its own code for recreating
conflict hunks.  No other code in git tries to parse conflict hunks.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Unchanged.

 builtin/checkout.c |    1 +
 t/t7201-co.sh      |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d652b4c..88b1f43 100644
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
index f3f0c4c..1337fa5 100755
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
