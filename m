From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Sat, 21 Aug 2010 15:23:56 +0200
Message-ID: <20100821132356.GA31998@localhost>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org>
 <20100818233900.GA27531@localhost>
 <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 15:24:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omo3V-0000PY-9l
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 15:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab0HUNX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 09:23:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38923 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab0HUNX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 09:23:57 -0400
Received: by fxm13 with SMTP id 13so2265625fxm.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=OaKhBLZBIJsBAGncc5F3GCDsCSlr67i9pjcq5csYWsk=;
        b=q/b/ozdRbQEymGnKJ2QT5Ht8FpXwxTjjjXmOtySobCt5cZUQ8CaCE/KZFzO8DPKbG9
         dshy1YGyNgtjw9IOn09fVMx4P05vQIl2j7W1s+TBc+nUT/3qwR6DyE+LpOAdsxINlPix
         vomvIU8PdXL5+jFxdgUgMaoeHWC4mzmZpj32k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=V2G/nFTphk71oYcznbO3Uq+kIN7eEibTIe5rKd5ouyOcNwXXoaY8yPRX242r9yB2wb
         QQ/RrnMLJQ11+r4rd5PF8xc15v7Jj8s5TUF4dCeISXTO4kzqGBTNq0AfOlAo4TggYtnL
         uVMuZ5Y5ApnShRlFEpzYB4gSB2+GfJ3Oz0Lno=
Received: by 10.223.106.132 with SMTP id x4mr2268367fao.15.1282397035061;
        Sat, 21 Aug 2010 06:23:55 -0700 (PDT)
Received: from darc.lan (p549A39C7.dip.t-dialin.net [84.154.57.199])
        by mx.google.com with ESMTPS id q17sm1613890faa.45.2010.08.21.06.23.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 06:23:54 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Omo3A-0008MR-OG; Sat, 21 Aug 2010 15:23:56 +0200
Content-Disposition: inline
In-Reply-To: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154140>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2010 at 01:35:32PM -0700, Junio C Hamano wrote:
>
>     $ echo foo >po
>     $ git checkout pu
>=20
> should error out, as "po" is a directory that has tracked contents, and we
> never said the untracked regular file "po" is trashable, but the above
> sequence happily checks the branch out.

Looks like this case is simply overlooked in verify_absent_1(). The
following takes the existing lstat_cache() code and deals with the
FL_ERR case, which is when there is a file in the way of the
leading path.

The patch below fixes the issue and passes the test suite, but it's
lacking in various ways and I am probably breaking something in
lstat_cache(), which I do not completely understand yet.

So it's going to take some more work to fix this properly.

Clemens

 cache.h        |    1 +
 symlinks.c     |   20 ++++++++++++++++++--
 unpack-trees.c |   25 ++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index dd1b8f7..5a8a99d 100644
--- a/cache.h
+++ b/cache.h
@@ -850,6 +850,7 @@ struct cache_def {
 extern int has_symlink_leading_path(const char *name, int len);
 extern int threaded_has_symlink_leading_path(struct cache_def *, const cha=
r *, int);
 extern int has_symlink_or_noent_leading_path(const char *name, int len);
+extern int find_leading_path(const char *name, int len, const char **path,=
 int *path_len);
 extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
diff --git a/symlinks.c b/symlinks.c
index 8860120..3f78168 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -152,7 +152,7 @@ static int lstat_cache(struct cache_def *cache, const c=
har *name, int len,
 	 * path types, FL_NOENT, FL_SYMLINK and FL_DIR, can be cached
 	 * for the moment!
 	 */
-	save_flags =3D ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
+	save_flags =3D ret_flags & track_flags & (FL_NOENT|FL_SYMLINK|FL_ERR);
 	if (save_flags && last_slash > 0 && last_slash <=3D PATH_MAX) {
 		cache->path[last_slash] =3D '\0';
 		cache->len =3D last_slash;
@@ -199,7 +199,7 @@ int has_symlink_leading_path(const char *name, int len)
=20
 /*
  * Return non-zero if path 'name' has a leading symlink component or
- * if some leading path component does not exists.
+ * if some leading path component does not exist.
  */
 int has_symlink_or_noent_leading_path(const char *name, int len)
 {
@@ -210,6 +210,22 @@ int has_symlink_or_noent_leading_path(const char *name=
, int len)
 }
=20
 /*
+ * Stat for leading path.
+ */
+int find_leading_path(const char *name, int len, const char **path, int *p=
ath_len)
+{
+	struct cache_def *cache =3D &default_cache;	/* FIXME */
+	int flags =3D lstat_cache(cache, name, len,
+			   FL_SYMLINK|FL_NOENT|FL_DIR|FL_ERR, USE_ONLY_LSTAT);
+	*path =3D cache->path;
+	*path_len =3D cache->len;
+	if (flags & FL_ERR)
+		return -1;
+	else
+		return flags & (FL_SYMLINK|FL_NOENT);
+}
+
+/*
  * Return non-zero if all path components of 'name' exists as a
  * directory.  If prefix_len > 0, we will test with the stat()
  * function instead of the lstat() function for a prefix length of
diff --git a/unpack-trees.c b/unpack-trees.c
index 8cf0da3..250ed7c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1016,12 +1016,35 @@ static int verify_absent_1(struct cache_entry *ce, =
const char *action,
 				 const char *error_msg)
 {
 	struct stat st;
+	const char *path;
+	int path_len;
+	int ret;
=20
 	if (o->index_only || o->reset || !o->update)
 		return 0;
=20
-	if (has_symlink_or_noent_leading_path(ce->name, ce_namelen(ce)))
+	ret =3D find_leading_path(ce->name, ce_namelen(ce), &path, &path_len);
+	if (ret > 0)
 		return 0;
+	else if (ret < 0) {
+		struct cache_entry *result;
+
+		/* FIXME: respect ignores etc. as below */
+
+		/*
+		 * The previous round may already have decided to
+		 * delete this path, which is in a subdirectory that
+		 * is being replaced with a blob.
+		 */
+		result =3D index_name_exists(&o->result, path, path_len, 0);
+		if (result) {
+			if (result->ce_flags & CE_REMOVE)
+				return 0;
+		}
+
+		return o->gently ? -1 :
+			error(ERRORMSG(o, would_lose_untracked), path, action);
+	}
=20
 	if (!lstat(ce->name, &st)) {
 		int dtype =3D ce_to_dtype(ce);
--=20
1.7.2.1.1.g202c


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMb9NsAAoJELKdZexG8uqM+xUIAJ8XJHMOLYswGmaEyOtxdo2W
t7JWFXFPmcbMLHgVrZ/dNoxnhHBpFOb9PhaQtt+l8uKNRHxKJpBJIzk3XXhwR0oq
OZjMWE7vV5wsnbFVKTXvIVCgZnE6tmdKjGMxsa66a6alHnrMCgDvcSej7p5qoMSQ
odF+HQtsBp6TMwmZYDjdtSjsEigsjR2YUtTktmn3ms4dfNArDpRt7plMwFaw1QQn
MMo3janNcGZfKgD5W4ishiN4e0zheCIkMyLMz08xrwWZsxdV/iWMulwgg7coeyRH
2OE2JBJ0Fu7YJrfJQ3UzvTsJ7N1RTebwblLXPWiHl+lZfRFGM19SgXQRyonOeJg=
=L9uv
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
