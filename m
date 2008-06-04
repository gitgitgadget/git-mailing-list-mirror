From: David =?utf-8?q?=E2=80=98Bombe=E2=80=99_Roden?= 
	<bombe@pterodactylus.net>
Subject: [PATCH] handle http urls with query string ("?foo") correctly
Date: Thu, 5 Jun 2008 01:28:31 +0200
Message-ID: <200806050128.33467.bombe@pterodactylus.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2125091.nGLNeb2FYz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 01:36:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K42Wr-0003lj-49
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 01:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbYFDXff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 19:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754850AbYFDXff
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 19:35:35 -0400
Received: from wing.pterodactylus.net ([89.207.253.13]:44626 "HELO
	pterodactylus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752317AbYFDXfe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 19:35:34 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jun 2008 19:35:33 EDT
Received: (qmail 17532 invoked from network); 4 Jun 2008 23:28:49 -0000
Received: from unknown (HELO ?192.168.178.19?) (10.98.86.6)
  by 10.98.86.1 with SMTP; 4 Jun 2008 23:28:49 -0000
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83837>

--nextPart2125091.nGLNeb2FYz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46rom 1f55b9176248673b78c77ff292fb5c6c988a7f8b Mon Sep 17 00:00:00 2001
=46rom: =3D?utf-8?q?David=3D20=3DE2=3D80=3D98Bombe=3DE2=3D80=3D99=3D20Roden=
?=3D <bombe@pterodactylus.net>
Date: Thu, 5 Jun 2008 00:53:56 +0200
Subject: [PATCH] handle http urls with query string ("?foo") correctly

=2D--
I'm a developer for the Freenet Project[1] and tried to get git running wit=
h Freenet's http-gateway. For several reasons I have to use URLs=20
like "http://host:8888/USK@<lots-of-stuff>/project.git/4?type=3Dtext/plain"=
=2E This breaks the way git creates http URLs to retrieve. The=20
following patch remedys this situation by inserting the git-generated part =
of the URL (like "/info/refs") before the query string.

 http-walker.c |   31 ++++++++++++-------------------
 http.c        |   43 ++++++++++++++++++++++++++++++++++---------
 http.h        |    2 ++
 transport.c   |    5 +++--
 4 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 99f397e..711e55b 100644
=2D-- a/http-walker.c
+++ b/http-walker.c
@@ -100,7 +100,6 @@ static void start_object_request(struct walker *walker,
 	char *hex =3D sha1_to_hex(obj_req->sha1);
 	char prevfile[PATH_MAX];
 	char *url;
=2D	char *posn;
 	int prevlocal;
 	unsigned char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read =3D 0;
@@ -146,16 +145,11 @@ static void start_object_request(struct walker *walke=
r,
=20
 	SHA1_Init(&obj_req->c);
=20
=2D	url =3D xmalloc(strlen(obj_req->repo->base) + 51);
+	char *suffix =3D xmalloc(51);
 	obj_req->url =3D xmalloc(strlen(obj_req->repo->base) + 51);
=2D	strcpy(url, obj_req->repo->base);
=2D	posn =3D url + strlen(obj_req->repo->base);
=2D	strcpy(posn, "/objects/");
=2D	posn +=3D 9;
=2D	memcpy(posn, hex, 2);
=2D	posn +=3D 2;
=2D	*(posn++) =3D '/';
=2D	strcpy(posn, hex + 2);
+	strcpy(suffix, "/objects/");
+	sprintf(suffix + 9, "%c%c/%s", hex[0], hex[1], hex + 2);
+	url =3D transform_url(obj_req->repo->base, suffix);
 	strcpy(obj_req->url, url);
=20
 	/* If a previous temp file is present, process what was already
@@ -384,8 +378,9 @@ static int fetch_index(struct walker *walker, struct al=
t_base *repo, unsigned ch
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting index for pack %s\n", hex);
=20
=2D	url =3D xmalloc(strlen(repo->base) + 64);
=2D	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
+	char *index_url =3D xmalloc(64);
+	sprintf(index_url, "/objects/pack/pack-%s.idx", hex);
+	url =3D transform_url(repo->base, index_url);
=20
 	filename =3D sha1_pack_index_name(sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
@@ -608,8 +603,7 @@ static void fetch_alternates(struct walker *walker, con=
st char *base)
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting alternates list for %s\n", base);
=20
=2D	url =3D xmalloc(strlen(base) + 31);
=2D	sprintf(url, "%s/objects/info/http-alternates", base);
+	url =3D transform_url(base, "/objects/info/http-alternates");
=20
 	/* Use a callback to process the result, since another request
 	   may fail and need to have alternates loaded before continuing */
@@ -655,8 +649,7 @@ static int fetch_indices(struct walker *walker, struct =
alt_base *repo)
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting pack list for %s\n", repo->base);
=20
=2D	url =3D xmalloc(strlen(repo->base) + 21);
=2D	sprintf(url, "%s/objects/info/packs", repo->base);
+	url =3D transform_url(repo->base, "/objects/info/packs");
=20
 	slot =3D get_active_slot();
 	slot->results =3D &results;
@@ -739,9 +732,9 @@ static int fetch_pack(struct walker *walker, struct alt=
_base *repo, unsigned cha
 			sha1_to_hex(sha1));
 	}
=20
=2D	url =3D xmalloc(strlen(repo->base) + 65);
=2D	sprintf(url, "%s/objects/pack/pack-%s.pack",
=2D		repo->base, sha1_to_hex(target->sha1));
+	char *pack_url =3D xmalloc(65);
+	sprintf(pack_url, "/objects/pack/pack-%s.pack", sha1_to_hex(target->sha1)=
);
+	url =3D transform_url(repo->base, pack_url);
=20
 	filename =3D sha1_pack_name(target->sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
diff --git a/http.c b/http.c
index 2a21ccb..e2b764a 100644
=2D-- a/http.c
+++ b/http.c
@@ -590,15 +590,17 @@ static char *quote_ref_url(const char *base, const ch=
ar *ref)
 	qref =3D xmalloc(len);
 	memcpy(qref, base, baselen);
 	dp =3D qref + baselen;
=2D	*(dp++) =3D '/';
=2D	for (cp =3D ref; (ch =3D *cp) !=3D 0; cp++) {
=2D		if (needs_quote(ch)) {
=2D			*dp++ =3D '%';
=2D			*dp++ =3D hex((ch >> 4) & 0xF);
=2D			*dp++ =3D hex(ch & 0xF);
+	if (*ref) {
+		*(dp++) =3D '/';
+		for (cp =3D ref; (ch =3D *cp) !=3D 0; cp++) {
+			if (needs_quote(ch)) {
+				*dp++ =3D '%';
+				*dp++ =3D hex((ch >> 4) & 0xF);
+				*dp++ =3D hex(ch & 0xF);
+			}
+			else
+				*dp++ =3D ch;
 		}
=2D		else
=2D			*dp++ =3D ch;
 	}
 	*dp =3D 0;
=20
@@ -613,7 +615,10 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	struct slot_results results;
 	int ret;
=20
=2D	url =3D quote_ref_url(base, ref->name);
+	char *real_ref_name =3D xmalloc(strlen(ref->name) + 2);
+	sprintf(real_ref_name, "/%s", ref->name);
+	char *real_url =3D transform_url(base, real_ref_name);
+	url =3D quote_ref_url(real_url, "");
 	slot =3D get_active_slot();
 	slot->results =3D &results;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
@@ -643,3 +648,23 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	free(url);
 	return ret;
 }
+
+char *transform_url(const char *url, const char *suffix)
+{
+	char *new_url;
+	char *question_mark;
+	ptrdiff_t offset;
+
+	new_url =3D xmalloc(strlen(url) + strlen(suffix) + 1);
+
+	if ((question_mark =3D strchr(url, '?'))) {
+		offset =3D (ptrdiff_t) question_mark - (ptrdiff_t) url;
+		snprintf(new_url, offset + 1, "%s", url);
+		strcat(new_url, suffix);
+		strcat(new_url, url + offset);
+	} else {
+		sprintf(new_url, "%s%s", url, suffix);
+	}
+	return new_url;
+}
+
diff --git a/http.h b/http.h
index a04fc6a..58730b8 100644
=2D-- a/http.h
+++ b/http.h
@@ -107,4 +107,6 @@ static inline int missing__target(int code, int result)
=20
 extern int http_fetch_ref(const char *base, struct ref *ref);
=20
+extern char *transform_url(const char *url, const char *suffix);
+
 #endif /* HTTP_H */
diff --git a/transport.c b/transport.c
index 3ff8519..b1966d8 100644
=2D-- a/transport.c
+++ b/transport.c
@@ -1,3 +1,4 @@
+#include <stddef.h>
 #include "cache.h"
 #include "transport.h"
 #include "run-command.h"
@@ -449,8 +450,7 @@ static struct ref *get_refs_via_curl(struct transport *=
transport)
=20
 	walker =3D transport->data;
=20
=2D	refs_url =3D xmalloc(strlen(transport->url) + 11);
=2D	sprintf(refs_url, "%s/info/refs", transport->url);
+	refs_url =3D transform_url(transport->url, "/info/refs");
=20
 	slot =3D get_active_slot();
 	slot->results =3D &results;
@@ -833,3 +833,4 @@ int transport_disconnect(struct transport *transport)
 	free(transport);
 	return ret;
 }
+
=2D-=20
1.5.6.rc1.6.gc8c52


--nextPart2125091.nGLNeb2FYz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhHJSEACgkQsh8Hgp5TwkNTNQCgq2vv23uo+30ld/RKmknYDkf1
oCsAn3STrBap9sAHAfHz2p2Sl9xcjeRP
=paeQ
-----END PGP SIGNATURE-----

--nextPart2125091.nGLNeb2FYz--
