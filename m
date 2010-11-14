From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] do not overwrite untracked during merge from unborn branch
Date: Sun, 14 Nov 2010 22:46:02 +0100
Message-ID: <20101114214601.GB29287@localhost>
References: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
 <20101114213453.GA29287@localhost>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Cc: Gert Palok <gert@planc.ee>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 22:46:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkOm-0000zC-2o
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab0KNVqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 16:46:02 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56324 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757053Ab0KNVqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:46:00 -0500
Received: by bwz15 with SMTP id 15so4673818bwz.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Z8M99vxrZsE6pyO9GAeDzql3/H/MiCeKehMw+YmdLuw=;
        b=Fzft2BRVhX9gZnxRR7uwmH4IEO1Di0RfymTh0KMXmfmPsNFZLvfc7fjIxuBbPkA+Aq
         Q8f4k43YYjjBaZBOmNrB86uP/frndFmKJGjhTmGohQtppHUjvB/oSRe6RQbn0iGH8mHn
         6+HghttNlVkidYDFiQRJ4+3Sc0jrcnUwBq+wo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=KJYq0+YjZ0Mns4SlWo39XFTC77R3aRok4R8lUNl0/Df+jiPXtLfpHd0pUopVQk4ImO
         uRQUSyRle5N/cMe72E0i29SlZK7RQgX+kV+MWErdGJwMadLj2If79ZHmZwrKQlFRYgYO
         HGarNI5jp7s1sSJlaArQ0C8tFPilyucJb0FtI=
Received: by 10.204.65.198 with SMTP id k6mr5387720bki.18.1289771159160;
        Sun, 14 Nov 2010 13:45:59 -0800 (PST)
Received: from darc.lan (p549A7640.dip.t-dialin.net [84.154.118.64])
        by mx.google.com with ESMTPS id a25sm2667334bks.20.2010.11.14.13.45.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:45:58 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PHkOg-0007jq-1W; Sun, 14 Nov 2010 22:46:02 +0100
Content-Disposition: inline
In-Reply-To: <20101114213453.GA29287@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161449>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In case HEAD does not point to a valid commit yet, merge is
implemented as a hard reset. This will cause untracked files to be
overwritten.

Instead, assume the empty tree for HEAD and do a regular merge. An
untracked file will cause the merge to abort and do nothing. If no
conflicting files are present, the merge will have the same effect
as a hard reset.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

This is based on next and does not apply cleanly to master because
of t7607. I can rebase it to master, but then it will conflict with
next later.

Clemens

 builtin/merge.c            |   20 +++++++++++++++++++-
 t/t7607-merge-overwrite.sh |   16 ++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 10f091b..7571c93 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -234,6 +234,24 @@ static void save_state(void)
 		die("not a valid object: %s", buffer.buf);
 }
=20
+static void read_empty(unsigned const char *sha1, int verbose)
+{
+	int i =3D 0;
+	const char *args[7];
+
+	args[i++] =3D "read-tree";
+	if (verbose)
+		args[i++] =3D "-v";
+	args[i++] =3D "-m";
+	args[i++] =3D "-u";
+	args[i++] =3D EMPTY_TREE_SHA1_HEX;
+	args[i++] =3D sha1_to_hex(sha1);
+	args[i] =3D NULL;
+
+	if (run_command_v_opt(args, RUN_GIT_CMD))
+		die("read-tree failed");
+}
+
 static void reset_hard(unsigned const char *sha1, int verbose)
 {
 	int i =3D 0;
@@ -985,7 +1003,7 @@ int cmd_merge(int argc, const char **argv, const char =
*prefix)
 			die("%s - not something we can merge", argv[0]);
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
 				DIE_ON_ERR);
-		reset_hard(remote_head->sha1, 0);
+		read_empty(remote_head->sha1, 0);
 		return 0;
 	} else {
 		struct strbuf merge_names =3D STRBUF_INIT;
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index e49dd80..d4a499d 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -127,4 +127,20 @@ test_expect_success SYMLINKS 'will not be confused by =
symlink in leading path' '
 	git checkout sub
 '
=20
+cat >expect <<\EOF
+error: Untracked working tree file 'c0.c' would be overwritten by merge.
+fatal: read-tree failed
+EOF
+
+test_expect_success 'will not overwrite untracked file on unborn branch' '
+	git reset --hard c0 &&
+	git rm -fr . &&
+	git checkout --orphan new &&
+	cp important c0.c &&
+	test_must_fail git merge c0 2>out &&
+	test_cmp out expect &&
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_cmp important c0.c
+'
+
 test_done
--=20
1.7.3.1.105.g84915


--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJM4FiZAAoJELKdZexG8uqM41AIAKZuAawuV2WUCFiWDxxPRyVe
2/Vlfem7Ej3A70g4+2ca51ENRh2CgVVEtqPQuOhdBJ9aenhL0YsLQsoAefSEuXmZ
J0yNSUBHVNYWVd9+TiONVDAyn+6ra3V0VdBxz4plRJ+RqrocN3ctmu8FYPyBez3/
ok3oc09dU9ovqALXPKCXtfu9pcNr2aTPMioqsBPw8W+XrCGwY4+OGqBPKJPzEucd
dFD7XtCy/W41cdSc7WD0shZjBPXZUWyoMvqWjLq3yJTw03VQyKpW32yU1I9T7R/T
w7PKKZLK7vnZoiX6A6+7ikFNfFQORjhXPdBhnRQrUmpbskvDxVLsMojSiKgJLMw=
=YQh3
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
