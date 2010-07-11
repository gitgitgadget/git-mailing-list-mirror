From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Question about 'branch -d' safety
Date: Sun, 11 Jul 2010 15:37:30 +0200
Message-ID: <20100711133730.GA10338@localhost>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain>
 <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 15:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXwkY-0002tS-Gp
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 15:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab0GKNjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 09:39:13 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39500 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab0GKNjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 09:39:11 -0400
Received: by eya25 with SMTP id 25so437109eya.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=RtWN7r1M0oLImZ7KqNqqqYgo6Z63OvFMtoaHofUZNxk=;
        b=JShAcAV12h504m+YnbAjwHNexF6WPb6ThE1+pK43Fn/kA9S+kA5Er7toV18VeSigU6
         VZ3Iq2JDQotwfk3gcaFRHImclws+6DOsxq1En0PkCcotpUvjsDExZo9eAvi0xpD5Ahae
         DgIxQF3GeZA3sGg0srgBQfjiwK6i7jr2I5iyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=aMsFLB4V3WSA+qqmkxSeZEXg+J5ThEIwwwQlalPTZz1BIBHg8O5LEsy+MNnbDOaE+3
         bLmw1riVSLSXjC3Nv+rj0ieWjSoTPHm3lafu5mDlVvF7l4nKVnOq5JeEiPsa8a0gkJCm
         1He+ASM9/Lh9mmz7Xx5rTBMC3OnZILMCqytm8=
Received: by 10.213.10.12 with SMTP id n12mr5410965ebn.71.1278855548734;
        Sun, 11 Jul 2010 06:39:08 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id a48sm27335245eei.7.2010.07.11.06.39.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 06:39:06 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OXwio-0002ic-5D; Sun, 11 Jul 2010 15:37:30 +0200
Content-Disposition: inline
In-Reply-To: <201007110916.29567.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150778>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 11, 2010 at 09:16:26AM +0200, Jakub Narebski wrote:
>=20
> The problem is, that when you have 'foo/bar' branch, then you have
> 'foo/bar' reflog.  When you delete branch 'foo/bar', but do not delete
> 'foo/bar' reflog (only add to it branch deletion event), and then you
> want to create 'foo' branch, git wouldn't be able to create reflog
> fo 'foo' because of directory / file (D/F) conflict: there is 'foo/'
> directory preventing file 'foo' from being created.

Right, of course. So how about this?

Clemens

-->o--
Date: Sun, 11 Jul 2010 12:37:06 +0200
Subject: [PATCH/RFC] graveyard for reflogs

Instead of removing reflogs together with refs, keep them around
and reuse them as a starting point, if a ref of the same name is
created again.

When a ref is deleted, a ~ is appended to each directory of the
corresponding reflog entry, e.g., refs/heads/branch is renamed to
refs~/heads~/branch. Since ~ must not be used for ref names,
directory/file conflicts are thus avoided.

Known issues:

 - The reflog cannot be accessed while the ref does not exist.

 - Older git versions will not resurrect the reflog, and therefore
   leave the renamed reflog behind.

 - Breaks t7701, because git-expire tries to lock log entries,
   which fails because ~ is an illegal character for refs.

 - Breaks t9300.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 reflog-walk.c   |    9 +++++--
 refs.c          |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 t/t1450-fsck.sh |    1 +
 3 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 4879615..9415ac8 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -228,15 +228,18 @@ void fake_reflog_parent(struct reflog_walk_info *info=
, struct commit *commit)
 		return;
 	}
=20
-	reflog =3D &commit_reflog->reflogs->items[commit_reflog->recno];
 	info->last_commit_reflog =3D commit_reflog;
 	commit_reflog->recno--;
-	commit_info->commit =3D (struct commit *)parse_object(reflog->osha1);
-	if (!commit_info->commit) {
+	if (commit_reflog->recno < 0) {
 		commit->parents =3D NULL;
 		return;
 	}
=20
+	reflog =3D &commit_reflog->reflogs->items[commit_reflog->recno];
+	commit_info->commit =3D (struct commit *)parse_object(reflog->nsha1);
+	if (!commit_info->commit)
+		die("Invalid reflog entry");
+
 	commit->parents =3D xcalloc(sizeof(struct commit_list), 1);
 	commit->parents->item =3D commit_info->commit;
 	commit->object.flags &=3D ~(ADDED | SEEN | SHOWN);
diff --git a/refs.c b/refs.c
index b540067..78c48ad 100644
--- a/refs.c
+++ b/refs.c
@@ -1052,6 +1052,70 @@ static int repack_without_ref(const char *refname)
 	return commit_lock_file(&packlock);
 }
=20
+static void pronounce_dead(struct strbuf *dead_ref, const char *ref)
+{
+	const char *p =3D ref;
+	while (*p) {
+		if (*p =3D=3D '/') {
+			int len =3D p - ref;
+			strbuf_add(dead_ref, ref, len);
+			if (len > 0)
+				strbuf_addstr(dead_ref, "~/");
+			ref =3D p + 1;
+		}
+		p++;
+	}
+	strbuf_addstr(dead_ref, ref);
+}
+
+static int bury_log(const char *ref)
+{
+	struct strbuf dead_ref =3D STRBUF_INIT;
+	struct stat loginfo;
+
+	if (lstat(git_path("logs/%s", ref), &loginfo))
+		return 0;
+
+	pronounce_dead(&dead_ref, ref);
+
+	if (S_ISLNK(loginfo.st_mode))
+		return error("reflog for %s is a symlink", ref);
+
+	if (safe_create_leading_directories(git_path("logs/%s", dead_ref.buf)))
+		return error("unable to create directory for %s", dead_ref.buf);
+
+	if (rename(git_path("logs/%s", ref), git_path("logs/%s", dead_ref.buf)))
+		return error("unable to move logfile to logs/%s: %s",
+			dead_ref.buf, strerror(errno));
+
+	strbuf_release(&dead_ref);
+	return 0;
+}
+
+static int resurrect_log(const char *ref)
+{
+	struct strbuf dead_ref =3D STRBUF_INIT;
+	struct stat loginfo;
+
+	pronounce_dead(&dead_ref, ref);
+
+	if (lstat(git_path("logs/%s", dead_ref.buf), &loginfo))
+		return 0;
+
+	if (S_ISLNK(loginfo.st_mode))
+		return error("reflog for %s is a symlink", dead_ref.buf);
+
+	if (safe_create_leading_directories(git_path("logs/%s", ref)))
+		return error("unable to create directory for %s", ref);
+
+	if (rename(git_path("logs/%s", dead_ref.buf), git_path("logs/%s", ref)))
+		return error("unable to move logfile to logs/%s: %s",
+			ref, strerror(errno));
+
+	strbuf_release(&dead_ref);
+	return 0;
+}
+
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
 	struct ref_lock *lock;
@@ -1084,7 +1148,7 @@ int delete_ref(const char *refname, const unsigned ch=
ar *sha1, int delopt)
 	 */
 	ret |=3D repack_without_ref(refname);
=20
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
+	bury_log(lock->ref_name);
 	invalidate_cached_refs();
 	unlock_ref(lock);
 	return ret;
@@ -1384,6 +1448,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
+	resurrect_log(lock->ref_name);
 	invalidate_cached_refs();
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 759cf12..65f160e 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -55,6 +55,7 @@ test_expect_success 'object with bad sha1' '
 	grep "$sha.*corrupt" out &&
 	rm -f .git/objects/$new &&
 	git update-ref -d refs/heads/bogus &&
+	rm -f .git/logs/refs~/heads~/bogus &&
 	git read-tree -u --reset HEAD
 '
=20
--=20
1.7.1.571.gba4d01


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMOckVAAoJELKdZexG8uqMhS4H/ReTmsDSjTQPVYxxg4zz6ZSq
aVxoNns7TSpkaFj9g1F9NzH7gxbPcjrwuuuJ6fvMDaI1xvXAnDOFMQ7zxa5+Qjj8
gbY/JhVZHNueizWIUvPfsrvG7J+Kl92rVjvfrkpn4hjUigfnKQ8UBp2wFiHJVS6p
UbxyDAg/IF4qTxq6ujyfbZTMB60DHsl3Pl28He4+5l4ipjX9aEDkMRG+HytXMv7k
p+j/Di7+Dyy55K5IrCLeLVCJOZBFNRIZ6nnPO7+1daMJpXeUVgUPYpxY4xiU5s+r
DtlIPc+yv7bZ2045moG34cwwqZmssxNORMEb/qwfiNtfIEivmeUQwhZaFhlaKgY=
=w0rW
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
