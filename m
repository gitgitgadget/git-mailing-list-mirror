From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/16] merge_trees(): add ancestor label parameter for
 diff3-style output
Date: Wed, 17 Mar 2010 07:08:29 -0500
Message-ID: <20100317120829.GG25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:08:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrs2x-0007tz-Pt
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab0CQMIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 08:08:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39981 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab0CQMIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:08:06 -0400
Received: by pva4 with SMTP id 4so442502pva.19
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OieChUohE4NxNsj4Wo5fXieQgcIMImr6HriapCBe94E=;
        b=lbTd2xdI+GDkzmOE0QyhY4xF76q6kMjywvhc7wKlFyclgML0jXO+eZbdT/Tph0x8Xs
         BDYK1l4xzq8rkfWicn1jZ5NWZcapmsTMtcUIl6ZopQ4dXgKuXorW0kD2hlTkywTQBseC
         YMtsbSrt+XEYowWkqdZPWu5KhhKIzpi7P51DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oZumK1pIb1K+elV25nVL25DznmNcDOkZnxJi6l/1iQKKZRulXxm0373xjV8lOI6PVP
         +tuyKhqKcMPMnP1R5fjXYpMZUF5uVnt39RciTrqEZoL/7tIDKUpINKnVAq6IYwaMuYfo
         m6hwI6ekPe4jI4SwAGnx2JYOMqqSu94ojI0/U=
Received: by 10.114.50.5 with SMTP id x5mr563540wax.96.1268827685552;
        Wed, 17 Mar 2010 05:08:05 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6328141iwn.14.2010.03.17.05.08.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:08:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142382>

Commands using the merge_trees() machinery will present conflict hunks
in output something like what =E2=80=98diff3 -m=E2=80=99 produces if th=
e
merge.conflictstyle configuration option is set to diff3.  The output
lacks the name of the merge base on the ||||||| line of the output,
and tools can misparse the conflict hunks without it.  Add a new
o->ancestor parameter to merge_trees() for use as a label for the
ancestor in conflict hunks.

If o->ancestor is NULL, the output format is as before.  All callers
pass NULL, so this patch does not affect the outward behavior of git.

If o->ancestor is non-NULL and both branches renamed the base file
to the same name, that name is included in the conflict hunk labels.
Even if o->ancestor is NULL I think this would be a good change, but
this patch only does it in the non-NULL case to ensure the output
format does not change where it might matter.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Only the commit message was changed.

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
1.7.0
