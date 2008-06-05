From: David =?utf-8?q?=E2=80=98Bombe=E2=80=99_Roden?= 
	<bombe@pterodactylus.net>
Subject: Re: [PATCH] handle http urls with query string ("?foo") correctly
Date: Thu, 5 Jun 2008 08:48:39 +0200
Message-ID: <200806050848.43462.bombe@pterodactylus.net>
References: <200806050128.33467.bombe@pterodactylus.net> <alpine.DEB.1.00.0806050103520.21190@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1511518.2mjezhmkZD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 08:49:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K49IC-0000Jo-3i
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 08:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbYFEGsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 02:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbYFEGsz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 02:48:55 -0400
Received: from wing.pterodactylus.net ([89.207.253.13]:34026 "HELO
	pterodactylus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751868AbYFEGsy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 02:48:54 -0400
Received: (qmail 15360 invoked from network); 5 Jun 2008 06:48:52 -0000
Received: from unknown (HELO ?192.168.178.19?) (10.98.86.10)
  by 10.98.86.1 with SMTP; 5 Jun 2008 06:48:52 -0000
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0806050103520.21190@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83866>

--nextPart1511518.2mjezhmkZD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 05 June 2008 02:12:21 Johannes Schindelin wrote:

> I think that this paragraph should be rewritten into a less "I did" form,
> and be the commit message.

Okay.


> This part of Git's source code predates the strbuf work, and therefore it
> is understandable that strbufs are not used there.  However, I think that
> your changes just cry for want of strbufs.

Sounds good. strbuf is indeed a tad more convenient than sprintf and strcat=
=2E :)


> Maybe you want to rewrite your patch before I keep on repeating these two
> comments? ;-)

I did. Find the revised version below. :)

=2D--
handle http urls with query string ("?foo") correctly
git breaks when a repository is cloned from an http url that contains a
query string. This patch fixes this behaviour be inserting the name of
the requested object (like "/info/refs") before the query string.

 http-walker.c |   31 ++++++++++++-------------------
 http.c        |   42 +++++++++++++++++++++++++++++++++---------
 http.h        |    2 ++
 transport.c   |    5 +++--
 4 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 99f397e..b14497a 100644
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
@@ -109,6 +108,7 @@ static void start_object_request(struct walker *walker,
 	struct curl_slist *range_header =3D NULL;
 	struct active_request_slot *slot;
 	struct walker_data *data =3D walker->data;
+	struct strbuf suffix_buffer =3D STRBUF_INIT;
=20
 	snprintf(prevfile, sizeof(prevfile), "%s.prev", obj_req->filename);
 	unlink(prevfile);
@@ -146,16 +146,10 @@ static void start_object_request(struct walker *walke=
r,
=20
 	SHA1_Init(&obj_req->c);
=20
=2D	url =3D xmalloc(strlen(obj_req->repo->base) + 51);
+	strbuf_addstr(&suffix_buffer, "/objects/");
+	strbuf_addf(&suffix_buffer, "%c%c/%s", hex[0], hex[1], hex + 2);
+	url =3D transform_url(obj_req->repo->base, strbuf_detach(&suffix_buffer, =
NULL));
 	obj_req->url =3D xmalloc(strlen(obj_req->repo->base) + 51);
=2D	strcpy(url, obj_req->repo->base);
=2D	posn =3D url + strlen(obj_req->repo->base);
=2D	strcpy(posn, "/objects/");
=2D	posn +=3D 9;
=2D	memcpy(posn, hex, 2);
=2D	posn +=3D 2;
=2D	*(posn++) =3D '/';
=2D	strcpy(posn, hex + 2);
 	strcpy(obj_req->url, url);
=20
 	/* If a previous temp file is present, process what was already
@@ -373,6 +367,7 @@ static int fetch_index(struct walker *walker, struct al=
t_base *repo, unsigned ch
 	char range[RANGE_HEADER_SIZE];
 	struct curl_slist *range_header =3D NULL;
 	struct walker_data *data =3D walker->data;
+	struct strbuf suffix_buffer =3D STRBUF_INIT;
=20
 	FILE *indexfile;
 	struct active_request_slot *slot;
@@ -384,8 +379,8 @@ static int fetch_index(struct walker *walker, struct al=
t_base *repo, unsigned ch
 	if (walker->get_verbosely)
 		fprintf(stderr, "Getting index for pack %s\n", hex);
=20
=2D	url =3D xmalloc(strlen(repo->base) + 64);
=2D	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
+	strbuf_addf(&suffix_buffer, "/objects/pack/pack-%s.idx", hex);
+	url =3D transform_url(repo->base, strbuf_detach(&suffix_buffer, NULL));
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
@@ -722,6 +715,7 @@ static int fetch_pack(struct walker *walker, struct alt=
_base *repo, unsigned cha
 	char range[RANGE_HEADER_SIZE];
 	struct curl_slist *range_header =3D NULL;
 	struct walker_data *data =3D walker->data;
+	struct strbuf suffix_buffer =3D STRBUF_INIT;
=20
 	struct active_request_slot *slot;
 	struct slot_results results;
@@ -739,9 +733,8 @@ static int fetch_pack(struct walker *walker, struct alt=
_base *repo, unsigned cha
 			sha1_to_hex(sha1));
 	}
=20
=2D	url =3D xmalloc(strlen(repo->base) + 65);
=2D	sprintf(url, "%s/objects/pack/pack-%s.pack",
=2D		repo->base, sha1_to_hex(target->sha1));
+	strbuf_addf(&suffix_buffer, "/objects/pack/pack-%s.pack", sha1_to_hex(tar=
get->sha1));
+	url =3D transform_url(repo->base, strbuf_detach(&suffix_buffer, NULL));
=20
 	filename =3D sha1_pack_name(target->sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
diff --git a/http.c b/http.c
index 2a21ccb..a60f9ea 100644
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
@@ -611,9 +613,12 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	struct strbuf buffer =3D STRBUF_INIT;
 	struct active_request_slot *slot;
 	struct slot_results results;
+	struct strbuf suffix_buffer =3D STRBUF_INIT;
 	int ret;
=20
=2D	url =3D quote_ref_url(base, ref->name);
+	strbuf_addf(&suffix_buffer, "/%s", ref->name);
+	url =3D transform_url(base, strbuf_detach(&suffix_buffer, NULL));
+	url =3D quote_ref_url(url, "");
 	slot =3D get_active_slot();
 	slot->results =3D &results;
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
@@ -643,3 +648,22 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	free(url);
 	return ret;
 }
+
+char *transform_url(const char *url, const char *suffix)
+{
+	struct strbuf new_url =3D STRBUF_INIT;
+	char *question_mark;
+	ptrdiff_t offset;
+
+	if ((question_mark =3D strchr(url, '?'))) {
+		offset =3D (ptrdiff_t) question_mark - (ptrdiff_t) url;
+		strbuf_add(&new_url, url, offset);
+		strbuf_addstr(&new_url, suffix);
+		strbuf_addstr(&new_url, url + offset);
+	} else {
+		strbuf_addstr(&new_url, url);
+		strbuf_addstr(&new_url, suffix);
+	}
+	return strbuf_detach(&new_url, NULL);
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
1.5.5.3


Thanks,

	David

--nextPart1511518.2mjezhmkZD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhHjEsACgkQsh8Hgp5TwkOMNwCfS0LVRhPvXOzJtFpFa0dT8YW6
cykAn2k9nY0HK9n4gU/9Keg5Hv8Jp6Af
=+GGA
-----END PGP SIGNATURE-----

--nextPart1511518.2mjezhmkZD--
