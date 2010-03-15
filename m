From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/10] merge_trees(): add ancestor label parameter for
 diff3-style output
Date: Mon, 15 Mar 2010 03:00:32 -0500
Message-ID: <20100315080032.GF8824@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 09:00:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5E4-0001Xw-Mm
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759736Ab0COIAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 04:00:32 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:42880 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759722Ab0COIAb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:00:31 -0400
Received: by yxe29 with SMTP id 29so1377664yxe.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=u+JJbkmHXz6o+F74o4TJhd1EiWbAy0EDY9bTWAdpD/I=;
        b=mmU3An9QMrpy7KzYwFK4CPFNlCSovkKCQvJXoBv294s8HTexDzeTkxtUzvncXRPG5M
         8eruSLWSwdkNIi1JOXZNJAxTPKf8KqglmEyEUAs+VajK20TZG5+AAmeOSkiD1ezrWUEw
         +RwsZh/VTlJ+vD0RoSd+4fOrrnwTFObYkEFwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KOHSJ337a53Fa0pt+LggIO8p/Q7FXir0fYq9bNpUheJxqqU3DkqViQqMfHJMaAIguB
         RhD3G4IS2OHsieQOAjjPG7GRcZScjfojEQ5GBj6rsWleSJULWBGUFeGjf4bASYMGsvTd
         doOrnUVYEsZmGrCrqyzBaHxxuvrm6rZTEoWU8=
Received: by 10.150.120.15 with SMTP id s15mr2938733ybc.143.1268640030545;
        Mon, 15 Mar 2010 01:00:30 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3982379iwn.11.2010.03.15.01.00.29
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 01:00:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100315074748.GA28827@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142181>

Commands using the merge_trees() machinery will present conflict hunks
in output something like what =E2=80=98diff3 -m=E2=80=99 produces if th=
e
merge.conflictstyle configuration option is set to diff3.

Unfortunately, the format is not fully compatible yet.  =E2=80=98diff3=E2=
=80=99
includes the name of the merge base on the ||||||| line of the output,
and tools can misparse the conflict hunks without it.  Add a new
o->ancestor parameter to merge_trees() for use as a label for the
ancestor in conflict hunks to give callers the power to rectify this
situation.

If o->ancestor is NULL, the output format is as before.  All callers
pass NULL, so this patch does not affect the outward behavior of git.

If o->ancestor is non-NULL and both branches renamed the base file
to the same name, that name is included in the conflict hunk labels.
Even if o->ancestor is NULL I think this would be a good change, but
this patch only does it in the non-NULL case to ensure the output
format does not change where it might matter.

Reported-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Another no-op.

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
