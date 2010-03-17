From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/16] ll_merge(): add ancestor label parameter for
 diff3-style output
Date: Wed, 17 Mar 2010 07:03:21 -0500
Message-ID: <20100317120321.GD25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:03:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrrxn-0005m1-P0
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500Ab0CQMC6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 08:02:58 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:53473 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab0CQMC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:02:57 -0400
Received: by pxi36 with SMTP id 36so443433pxi.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=P9Hu6Vv3vIQNaEpAfaa4uuVE8tnV8yVLEtnhY4fNxl4=;
        b=hDiwuMl860whyIly5oHvOFgzhy2hpCCwkVuKqpBfe06CEv9FS6/4ZMUX51y4tYsEZw
         RPFolWpNoMZRRV7kPz8rxvBwfIauyiG4J+Kv157tDE/N/GTDERjgecPvFVTRoTxsPBoR
         zJiT4iEuD9SmGiM22Eaglt2poqNerd3EO1R4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TTrQG9n0fM/AF7bk709Gt8XUNHYmrIWUAXGXIkogdy5KkOdOZQJTorAMvFdBKJY0oB
         W/KhXE1DU7vwtk+kDDRQmMDF7+ByTVJjza/nrlaxYolWWVHb9v0iFmk1jvHqH6iaowbm
         Zxnn/u0iR1wf2DzyLoEyX9K8l2O7LiEjOMS1M=
Received: by 10.114.16.9 with SMTP id 9mr553377wap.133.1268827376368;
        Wed, 17 Mar 2010 05:02:56 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6324509iwn.14.2010.03.17.05.02.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:02:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142379>

Various commands using the ll_merge() function present conflict hunks
in output something like what =E2=80=98diff3 -m=E2=80=99 produces if th=
e
merge.conflictstyle configuration option is set to diff3.  The output
leaves out the name of the merge base on the ||||||| line of the
output, and some tools misparse the conflict hunks without that.

Add a new ancestor_label parameter to ll_merge() to give callers the
power to rectify this situation.  All callers pass NULL for now to
avoid distracting changes in outward behavior when testing this
interface change.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
change from v1:

 --- b/ll-merge.c
 +++ b/ll-merge.c
 @@ -108,7 +108,7 @@ static int ll_union_merge(const struct ll_merge_dr

  	saved_style =3D git_xmerge_style;
        git_xmerge_style =3D 0;
        status =3D ll_xdl_merge(drv_unused, result, path_unused,
 -                             orig, orig_name, src1, NULL, src2, NULL,
 +                             orig, NULL, src1, NULL, src2, NULL,
                              flag, marker_size);
        git_xmerge_style =3D saved_style;
        if (status <=3D 0)

There is no possibility of a diff3-style merge in that codepath.

 builtin/checkout.c |    2 +-
 ll-merge.c         |   20 +++++++++++---------
 ll-merge.h         |    2 +-
 merge-file.c       |    2 +-
 merge-recursive.c  |    2 +-
 rerere.c           |    4 ++--
 6 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index acefaaf..d67f809 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -149,7 +149,7 @@ static int checkout_merged(int pos, struct checkout=
 *state)
 	read_mmblob(&ours, active_cache[pos+1]->sha1);
 	read_mmblob(&theirs, active_cache[pos+2]->sha1);
=20
-	status =3D ll_merge(&result_buf, path, &ancestor,
+	status =3D ll_merge(&result_buf, path, &ancestor, NULL,
 			  &ours, "ours", &theirs, "theirs", 0);
 	free(ancestor.ptr);
 	free(ours.ptr);
diff --git a/ll-merge.c b/ll-merge.c
index b8e8971..92670af 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -15,7 +15,7 @@ struct ll_merge_driver;
 typedef int (*ll_merge_fn)(const struct ll_merge_driver *,
 			   mmbuffer_t *result,
 			   const char *path,
-			   mmfile_t *orig,
+			   mmfile_t *orig, const char *orig_name,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
 			   int flag,
@@ -36,7 +36,7 @@ struct ll_merge_driver {
 static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   mmbuffer_t *result,
 			   const char *path_unused,
-			   mmfile_t *orig,
+			   mmfile_t *orig, const char *orig_name,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
 			   int flag, int marker_size)
@@ -57,7 +57,7 @@ static int ll_binary_merge(const struct ll_merge_driv=
er *drv_unused,
 static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmbuffer_t *result,
 			const char *path,
-			mmfile_t *orig,
+			mmfile_t *orig, const char *orig_name,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
 			int flag, int marker_size)
@@ -73,7 +73,8 @@ static int ll_xdl_merge(const struct ll_merge_driver =
*drv_unused,
 			path, name1, name2);
 		return ll_binary_merge(drv_unused, result,
 				       path,
-				       orig, src1, name1,
+				       orig, orig_name,
+				       src1, name1,
 				       src2, name2,
 				       flag, marker_size);
 	}
@@ -83,6 +84,7 @@ static int ll_xdl_merge(const struct ll_merge_driver =
*drv_unused,
 		style =3D git_xmerge_style;
 	if (marker_size > 0)
 		xmp.marker_size =3D marker_size;
+	xmp.ancestor =3D orig_name;
 	xmp.file1 =3D name1;
 	xmp.file2 =3D name2;
 	return xdl_merge(orig, src1, src2, &xmp,
@@ -93,7 +95,7 @@ static int ll_xdl_merge(const struct ll_merge_driver =
*drv_unused,
 static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  mmbuffer_t *result,
 			  const char *path_unused,
-			  mmfile_t *orig,
+			  mmfile_t *orig, const char *orig_name,
 			  mmfile_t *src1, const char *name1,
 			  mmfile_t *src2, const char *name2,
 			  int flag, int marker_size)
@@ -106,7 +108,7 @@ static int ll_union_merge(const struct ll_merge_dri=
ver *drv_unused,
 	saved_style =3D git_xmerge_style;
 	git_xmerge_style =3D 0;
 	status =3D ll_xdl_merge(drv_unused, result, path_unused,
-			      orig, src1, NULL, src2, NULL,
+			      orig, NULL, src1, NULL, src2, NULL,
 			      flag, marker_size);
 	git_xmerge_style =3D saved_style;
 	if (status <=3D 0)
@@ -165,7 +167,7 @@ static void create_temp(mmfile_t *src, char *path)
 static int ll_ext_merge(const struct ll_merge_driver *fn,
 			mmbuffer_t *result,
 			const char *path,
-			mmfile_t *orig,
+			mmfile_t *orig, const char *orig_name,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
 			int flag, int marker_size)
@@ -356,7 +358,7 @@ static int git_path_check_merge(const char *path, s=
truct git_attr_check check[2]
=20
 int ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
-	     mmfile_t *ancestor,
+	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
 	     int flag)
@@ -378,7 +380,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	driver =3D find_ll_merge_driver(ll_driver_name);
 	if (virtual_ancestor && driver->recursive)
 		driver =3D find_ll_merge_driver(driver->recursive);
-	return driver->fn(driver, result_buf, path, ancestor,
+	return driver->fn(driver, result_buf, path, ancestor, ancestor_label,
 			  ours, our_label, theirs, their_label,
 			  flag, marker_size);
 }
diff --git a/ll-merge.h b/ll-merge.h
index 5788922..57754cc 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -7,7 +7,7 @@
=20
 int ll_merge(mmbuffer_t *result_buf,
 	     const char *path,
-	     mmfile_t *ancestor,
+	     mmfile_t *ancestor, const char *ancestor_label,
 	     mmfile_t *ours, const char *our_label,
 	     mmfile_t *theirs, const char *their_label,
 	     int flag);
diff --git a/merge-file.c b/merge-file.c
index fd34d76..07cc0c9 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -30,7 +30,7 @@ static void *three_way_filemerge(const char *path, mm=
file_t *base, mmfile_t *our
 	int merge_status;
 	mmbuffer_t res;
=20
-	merge_status =3D ll_merge(&res, path, base,
+	merge_status =3D ll_merge(&res, path, base, NULL,
 				our, ".our", their, ".their", 0);
 	if (merge_status < 0)
 		return NULL;
diff --git a/merge-recursive.c b/merge-recursive.c
index 195ebf9..3b2cc9d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -640,7 +640,7 @@ static int merge_3way(struct merge_options *o,
 	read_mmblob(&src1, a->sha1);
 	read_mmblob(&src2, b->sha1);
=20
-	merge_status =3D ll_merge(result_buf, a->path, &orig,
+	merge_status =3D ll_merge(result_buf, a->path, &orig, NULL,
 				&src1, name1, &src2, name2,
 				(!!o->call_depth) | (favor << 1));
=20
diff --git a/rerere.c b/rerere.c
index a59f74f..f221bed 100644
--- a/rerere.c
+++ b/rerere.c
@@ -319,7 +319,7 @@ static int handle_cache(const char *path, unsigned =
char *sha1, const char *outpu
 		if (!mmfile[i].ptr && !mmfile[i].size)
 			mmfile[i].ptr =3D xstrdup("");
 	}
-	ll_merge(&result, path, &mmfile[0],
+	ll_merge(&result, path, &mmfile[0], NULL,
 		 &mmfile[1], "ours",
 		 &mmfile[2], "theirs", 0);
 	for (i =3D 0; i < 3; i++)
@@ -376,7 +376,7 @@ static int merge(const char *name, const char *path=
)
 		ret =3D 1;
 		goto out;
 	}
-	ret =3D ll_merge(&result, path, &base, &cur, "", &other, "", 0);
+	ret =3D ll_merge(&result, path, &base, NULL, &cur, "", &other, "", 0)=
;
 	if (!ret) {
 		FILE *f =3D fopen(path, "w");
 		if (!f)
--=20
1.7.0
