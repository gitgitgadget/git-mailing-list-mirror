From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/14] checkout -m --conflict=diff3: add a label for
 ancestor
Date: Sat, 20 Mar 2010 19:42:51 -0500
Message-ID: <20100321004251.GE23888@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt9Er-00020B-Q3
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab0CUAlx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 20:41:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32980 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab0CUAlw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:41:52 -0400
Received: by gwaa18 with SMTP id a18so399039gwa.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KdwmRLGrc6NkLDG8fi5bC/ACYnRjIOHWetN7sqpMqNk=;
        b=Re8Iy5KqMGuhAk5MaA6kAmkrG7OpQ1NT2SjRKSPsNK4kzQK/6sZNkq/0IPm3MJpaci
         7lnM+EkFnqiZLrEOzaeiEHm3NIevsmuFP1UTwL2s8gOLeufc4zTIEOVSkppYW2wxZd2B
         Qkth61pltmemnHBN6DjFnogfAX4cw7WfiUqPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NPrmX13baUXMTe0BfQiLGRl3tOxKhIAr/Nbbx/gtR+aNLpyzPEDrMnkiXabdnuL3HP
         U/V2nRtj9Difq3ngNJg7muhE4cRa0PbmoETdMzOJWF5vSq2NWfDoqw8+bzpaHaYgK+/t
         biW4jpz65/fAc1E4iv+1ILTa7JzR+dyOvM8uY=
Received: by 10.101.136.13 with SMTP id o13mr11862212ann.235.1269132111733;
        Sat, 20 Mar 2010 17:41:51 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1869602iwn.3.2010.03.20.17.41.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:41:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142778>

git checkout --merge --conflict=3Ddiff3 can be used to present conflict
hunks including text from the common ancestor.  The added information
is helpful for resolving a merge by hand, and merge tools tend to
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
=46rom <http://thread.gmane.org/gmane.comp.version-control.git/142374/f=
ocus=3D142384>.

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
1.7.0.2
