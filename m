From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/14] merge_trees(): add ancestor label parameter for
 diff3-style output
Date: Sat, 20 Mar 2010 19:41:38 -0500
Message-ID: <20100321004138.GD23888@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:40:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt9Df-0001S8-LS
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab0CUAkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 20:40:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63908 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab0CUAki (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:40:38 -0400
Received: by gyg8 with SMTP id 8so2112474gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=v0IXKwodPfUgCj+9HbRITcAoQLeLe6Nwh5oqIYw/A4I=;
        b=fTzkc8sbJ8xfciztvC2txrt5UhpPZEawxFEuKDHO424NflZd6OtmTr29mq4cYxM+V7
         kzTXR02+8grYRS2BYeqEc5y7+RDwhlNSVQzNs8AwSF23GCSipWBkZbnuDHBhWjq/sbgO
         GjQnJr3MXK5dhMrn6CSmCj6cSxM4Nn5cw6D2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KM+X7c6ASgrKA0ZeW3n6suLmHQWdkvmSo89RcJ97jfvCr9HeappnA+NqX1JFPxpa9B
         tt00QUW2xZxtUYLn2miGzfFB+H4pIutgxwJEGTbWwOmezRjBhKUpz2DqxYIrmaLjKdwc
         FF7nmD9oM9kxjdvtJ+Djzhm2iviQIM4a4zd9M=
Received: by 10.101.184.7 with SMTP id l7mr4185733anp.125.1269132038333;
        Sat, 20 Mar 2010 17:40:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1868468iwn.7.2010.03.20.17.40.37
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:40:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142777>

Commands using the merge_trees() machinery will present conflict hunks
in output something like what =E2=80=98diff3 -m=E2=80=99 produces if th=
e
merge.conflictstyle configuration option is set to diff3.  The output
lacks the name of the merge base on the ||||||| line of the output,
and tools can misparse the conflict hunks without it.  Add a new
o->ancestor parameter to merge_trees() for use as a label for the
ancestor in conflict hunks.

If o->ancestor is NULL, the output format is as before.  All callers
pass NULL for now.

If o->ancestor is non-NULL and both branches renamed the base file
to the same name, that name is included in the conflict hunk labels.
Even if o->ancestor is NULL I think this would be a good change, but
this patch only does it in the non-NULL case to ensure the output
format does not change where it might matter.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
=46rom <http://thread.gmane.org/gmane.comp.version-control.git/142374/f=
ocus=3D142382>.

 merge-recursive.c |   11 ++++++++---
 merge-recursive.h |    1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3b2cc9d..017cafd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -608,7 +608,7 @@ static int merge_3way(struct merge_options *o,
 		      const char *branch2)
 {
 	mmfile_t orig, src1, src2;
-	char *name1, *name2;
+	char *base_name, *name1, *name2;
 	int merge_status;
 	int favor;
=20
@@ -628,10 +628,15 @@ static int merge_3way(struct merge_options *o,
 		}
 	}
=20
-	if (strcmp(a->path, b->path)) {
+	if (strcmp(a->path, b->path) ||
+	    (o->ancestor !=3D NULL && strcmp(a->path, one->path) !=3D 0)) {
+		base_name =3D o->ancestor =3D=3D NULL ? NULL :
+			xstrdup(mkpath("%s:%s", o->ancestor, one->path));
 		name1 =3D xstrdup(mkpath("%s:%s", branch1, a->path));
 		name2 =3D xstrdup(mkpath("%s:%s", branch2, b->path));
 	} else {
+		base_name =3D o->ancestor =3D=3D NULL ? NULL :
+			xstrdup(mkpath("%s", o->ancestor));
 		name1 =3D xstrdup(mkpath("%s", branch1));
 		name2 =3D xstrdup(mkpath("%s", branch2));
 	}
@@ -640,7 +645,7 @@ static int merge_3way(struct merge_options *o,
 	read_mmblob(&src1, a->sha1);
 	read_mmblob(&src2, b->sha1);
=20
-	merge_status =3D ll_merge(result_buf, a->path, &orig, NULL,
+	merge_status =3D ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2,
 				(!!o->call_depth) | (favor << 1));
=20
diff --git a/merge-recursive.h b/merge-recursive.h
index be8410a..d1192f5 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -4,6 +4,7 @@
 #include "string-list.h"
=20
 struct merge_options {
+	const char *ancestor;
 	const char *branch1;
 	const char *branch2;
 	enum {
--=20
1.7.0.2
