From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] write first for-merge ref to FETCH_HEAD first
Date: Mon, 26 Dec 2011 12:16:56 -0400
Message-ID: <20111226161656.GB29582@gnu.kitenet.net>
References: <20111225173901.GA668@gnu.kitenet.net>
 <7vd3bb929n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 26 17:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfDEe-0002tZ-Nb
	for gcvg-git-2@lo.gmane.org; Mon, 26 Dec 2011 17:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab1LZQRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Dec 2011 11:17:07 -0500
Received: from wren.kitenet.net ([80.68.85.49]:49029 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261Ab1LZQRF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2011 11:17:05 -0500
Received: from gnu.kitenet.net (dialup-4.153.8.110.Dial1.Atlanta1.Level3.net [4.153.8.110])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id A252E11841A;
	Mon, 26 Dec 2011 11:17:02 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 6600E44699; Mon, 26 Dec 2011 11:16:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vd3bb929n.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187699>


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The FETCH_HEAD refname is supposed to refer to the ref that was fetched
and should be merged. However all fetched refs are written to
=2Egit/FETCH_HEAD in an arbitrary order, and resolve_ref_unsafe simply
takes the first ref as the FETCH_HEAD, which is often the wrong one,
when other branches were also fetched.

The solution is to write the for-merge ref(s) to FETCH_HEAD first.
Then, unless --append is used, the FETCH_HEAD refname behaves as intended.
If the user uses --append, they presumably are doing so in order to
preserve the old FETCH_HEAD.

Also included a fix to documentation that assumes FETCH_HEAD contains
only a single ref.
---
 Documentation/git-read-tree.txt |    2 +-
 builtin/fetch.c                 |  158 +++++++++++++++++++++--------------=
----
 2 files changed, 85 insertions(+), 75 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.=
txt
index 5375549..2d3ff23 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -342,7 +342,7 @@ since you pulled from him:
=20
 ----------------
 $ git fetch git://.... linus
-$ LT=3D`cat .git/FETCH_HEAD`
+$ LT=3D`git rev-parse FETCH_HEAD`
 ----------------
=20
 Your work tree is still based on your HEAD ($JC), but you have
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 33ad3aa..db565cd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -377,6 +377,7 @@ static int store_updated_refs(const char *raw_url, cons=
t char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url, *filename =3D dry_run ? "/dev/null" : git_path("FETCH_HEAD");
+	signed int want_merge;
=20
 	fp =3D fopen(filename, "a");
 	if (!fp)
@@ -393,84 +394,93 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 		goto abort;
 	}
=20
-	for (rm =3D ref_map; rm; rm =3D rm->next) {
-		struct ref *ref =3D NULL;
-
-		if (rm->peer_ref) {
-			ref =3D xcalloc(1, sizeof(*ref) + strlen(rm->peer_ref->name) + 1);
-			strcpy(ref->name, rm->peer_ref->name);
-			hashcpy(ref->old_sha1, rm->peer_ref->old_sha1);
-			hashcpy(ref->new_sha1, rm->old_sha1);
-			ref->force =3D rm->peer_ref->force;
-		}
+	/* Two passes are made over the ref_map, to write merge refs
+	 * to FETCH_HEAD first. This allows using FETCH_HEAD as a refname
+	 * to refer to the ref to be merged. */
+	for (want_merge =3D 1; want_merge >=3D 0 ; want_merge--) {
+		for (rm =3D ref_map; rm; rm =3D rm->next) {
+			struct ref *ref =3D NULL;
+
+			commit =3D lookup_commit_reference_gently(rm->old_sha1, 1);
+			if (!commit)
+				rm->merge =3D 0;
+
+			if (rm->merge !=3D want_merge)
+				continue;
+
+			if (rm->peer_ref) {
+				ref =3D xcalloc(1, sizeof(*ref) + strlen(rm->peer_ref->name) + 1);
+				strcpy(ref->name, rm->peer_ref->name);
+				hashcpy(ref->old_sha1, rm->peer_ref->old_sha1);
+				hashcpy(ref->new_sha1, rm->old_sha1);
+				ref->force =3D rm->peer_ref->force;
+			}
=20
-		commit =3D lookup_commit_reference_gently(rm->old_sha1, 1);
-		if (!commit)
-			rm->merge =3D 0;
=20
-		if (!strcmp(rm->name, "HEAD")) {
-			kind =3D "";
-			what =3D "";
-		}
-		else if (!prefixcmp(rm->name, "refs/heads/")) {
-			kind =3D "branch";
-			what =3D rm->name + 11;
-		}
-		else if (!prefixcmp(rm->name, "refs/tags/")) {
-			kind =3D "tag";
-			what =3D rm->name + 10;
-		}
-		else if (!prefixcmp(rm->name, "refs/remotes/")) {
-			kind =3D "remote-tracking branch";
-			what =3D rm->name + 13;
-		}
-		else {
-			kind =3D "";
-			what =3D rm->name;
-		}
+			if (!strcmp(rm->name, "HEAD")) {
+				kind =3D "";
+				what =3D "";
+			}
+			else if (!prefixcmp(rm->name, "refs/heads/")) {
+				kind =3D "branch";
+				what =3D rm->name + 11;
+			}
+			else if (!prefixcmp(rm->name, "refs/tags/")) {
+				kind =3D "tag";
+				what =3D rm->name + 10;
+			}
+			else if (!prefixcmp(rm->name, "refs/remotes/")) {
+				kind =3D "remote-tracking branch";
+				what =3D rm->name + 13;
+			}
+			else {
+				kind =3D "";
+				what =3D rm->name;
+			}
=20
-		url_len =3D strlen(url);
-		for (i =3D url_len - 1; url[i] =3D=3D '/' && 0 <=3D i; i--)
-			;
-		url_len =3D i + 1;
-		if (4 < i && !strncmp(".git", url + i - 3, 4))
-			url_len =3D i - 3;
-
-		strbuf_reset(&note);
-		if (*what) {
-			if (*kind)
-				strbuf_addf(&note, "%s ", kind);
-			strbuf_addf(&note, "'%s' of ", what);
-		}
-		fprintf(fp, "%s\t%s\t%s",
-			sha1_to_hex(rm->old_sha1),
-			rm->merge ? "" : "not-for-merge",
-			note.buf);
-		for (i =3D 0; i < url_len; ++i)
-			if ('\n' =3D=3D url[i])
-				fputs("\\n", fp);
-			else
-				fputc(url[i], fp);
-		fputc('\n', fp);
-
-		strbuf_reset(&note);
-		if (ref) {
-			rc |=3D update_local_ref(ref, what, &note);
-			free(ref);
-		} else
-			strbuf_addf(&note, "* %-*s %-*s -> FETCH_HEAD",
-				    TRANSPORT_SUMMARY_WIDTH,
-				    *kind ? kind : "branch",
-				    REFCOL_WIDTH,
-				    *what ? what : "HEAD");
-		if (note.len) {
-			if (verbosity >=3D 0 && !shown_url) {
-				fprintf(stderr, _("From %.*s\n"),
-						url_len, url);
-				shown_url =3D 1;
+			url_len =3D strlen(url);
+			for (i =3D url_len - 1; url[i] =3D=3D '/' && 0 <=3D i; i--)
+				;
+			url_len =3D i + 1;
+			if (4 < i && !strncmp(".git", url + i - 3, 4))
+				url_len =3D i - 3;
+
+			strbuf_reset(&note);
+			if (*what) {
+				if (*kind)
+					strbuf_addf(&note, "%s ", kind);
+				strbuf_addf(&note, "'%s' of ", what);
+			}
+			fprintf(fp, "%s\t%s\t%s",
+				sha1_to_hex(rm->old_sha1),
+				rm->merge ? "" : "not-for-merge",
+				note.buf);
+			for (i =3D 0; i < url_len; ++i)
+				if ('\n' =3D=3D url[i])
+					fputs("\\n", fp);
+				else
+					fputc(url[i], fp);
+			fputc('\n', fp);
+
+			strbuf_reset(&note);
+			if (ref) {
+				rc |=3D update_local_ref(ref, what, &note);
+				free(ref);
+			} else
+				strbuf_addf(&note, "* %-*s %-*s -> FETCH_HEAD",
+					    TRANSPORT_SUMMARY_WIDTH,
+					    *kind ? kind : "branch",
+					    REFCOL_WIDTH,
+					    *what ? what : "HEAD");
+			if (note.len) {
+				if (verbosity >=3D 0 && !shown_url) {
+					fprintf(stderr, _("From %.*s\n"),
+							url_len, url);
+					shown_url =3D 1;
+				}
+				if (verbosity >=3D 0)
+					fprintf(stderr, " %s\n", note.buf);
 			}
-			if (verbosity >=3D 0)
-				fprintf(stderr, " %s\n", note.buf);
 		}
 	}
=20
--=20
1.7.7.3


--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTvid98kQ2SIlEuPHAQh9rQ/9F1CdqyuEj0XHuTEdkhbdEScQyzE/7kge
fso9WtYIprqdFNmVrn7L+4OB6gfsx/ul4FZsgIEnKO5z555WaNNeh8coJg1cZHc/
lCHC9QGSDacJsi73DQpseQribK+RZJn2hhWGULUmXMF9uuxRxyHYHQWWLuxSMd8x
3RPq3YHMGNRgeymRKRy5SpD1fy2xwE2O8p9B6u/Yt4WlMLrPGN+wQXbl/HmZhQz5
18dNEYRDme2Orxale2HQRgWKBt8fPEOyy9+583XgOaGW6HmlP9wtfFCajTbePpw8
QxO+nDsEXDcEebnBGzj4olZIzXJBMT68MRxgSNo0+HLuBe6X2HNq3qt/zWinemUy
1hNbN7xuQGy8mKR/vatfqvfrsOH/Is3aAdWnfmrS2JHHKgX4nRLp3CEhSZTNlBDW
2a9Tc39BjCzNFDW/JO7URzqY7EODBSDhqW/+8qi8jZweQepYyE5acK0l3myG5SED
YebCUzHVkayeEoMigp6h5xszdDrl9dBT4N8U0ORSrWOvu6NH0A7UE3JCV4r/qlht
09MKKCxa1frVzVkG9u4lpgozzBU5y4Yr0/8uAtmjmWDY0EchRzaCTubror6QdgEy
O1ck4Ryd7M3RTlTQnNVcg7VkkdK8Qe+h5xpcGqKGsTrJtSo/hD1qT9No6dp6gpA0
EFWXATjPT94=
=eX7y
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
