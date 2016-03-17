From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 04/10] Extending internal CURL wrapper for POST upload
Date: Thu, 17 Mar 2016 19:46:55 +0100
Message-ID: <1458240421-3593-5-git-send-email-anton.wuerfel@fau.de>
References: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:47:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxZ-0007X0-0y
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936552AbcCQSrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:47:42 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43319 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933303AbcCQSri (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:38 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id B16E158C4D2;
	Thu, 17 Mar 2016 19:47:35 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:35 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289142>

This commit adds POST upload capabilities to the internal libcurl wrapp=
er, which
are necessary for uploading RFC3161 Time Stamping Queries to a Time Sta=
mping
Authority.

Therefore, the internal struct http_get_options is renamed to
http_request_options and extended by 2 strbuf fields named `postfields`=
 and
`post_content_type`. If either one of them is non-NULL, the correspondi=
ng
curl_easy_setopt() functions are called.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
---
 http.c        | 30 +++++++++++++++++++++++-------
 http.h        | 17 +++++++++++++++--
 remote-curl.c |  2 +-
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/http.c b/http.c
index 69da445..a108658 100644
--- a/http.c
+++ b/http.c
@@ -1373,17 +1373,19 @@ static void http_opt_request_remainder(CURL *cu=
rl, off_t pos)
=20
 static int http_request(const char *url,
 			void *result, int target,
-			const struct http_get_options *options)
+			const struct http_request_options *options)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
 	struct curl_slist *headers =3D NULL;
 	struct strbuf buf =3D STRBUF_INIT;
+	struct strbuf content_type =3D STRBUF_INIT;
 	const char *accept_language;
 	int ret;
=20
 	slot =3D get_active_slot();
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
+	if (options && !options->postfields)
+		curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
=20
 	if (result =3D=3D NULL) {
 		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
@@ -1407,6 +1409,19 @@ static int http_request(const char *url,
 	if (accept_language)
 		headers =3D curl_slist_append(headers, accept_language);
=20
+	if (options && options->postfields && options->post_content_type) {
+		strbuf_addstr(&content_type, "Content-Type: ");
+		strbuf_addbuf(&content_type, options->post_content_type);
+		headers =3D curl_slist_append(headers, content_type.buf);
+	}
+
+	if (options && options->postfields) {
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS,
+				 options->postfields->buf);
+		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE,
+				 options->postfields->len);
+	}
+
 	strbuf_addstr(&buf, "Pragma:");
 	if (options && options->no_cache)
 		strbuf_addstr(&buf, " no-cache");
@@ -1434,6 +1449,7 @@ static int http_request(const char *url,
 				options->effective_url);
=20
 	curl_slist_free_all(headers);
+	strbuf_release(&content_type);
 	strbuf_release(&buf);
=20
 	return ret;
@@ -1491,7 +1507,7 @@ static int update_url_from_redirect(struct strbuf=
 *base,
=20
 static int http_request_reauth(const char *url,
 			       void *result, int target,
-			       struct http_get_options *options)
+			       struct http_request_options *options)
 {
 	int ret =3D http_request(url, result, target, options);
=20
@@ -1529,7 +1545,7 @@ static int http_request_reauth(const char *url,
=20
 int http_get_strbuf(const char *url,
 		    struct strbuf *result,
-		    struct http_get_options *options)
+		    struct http_request_options *options)
 {
 	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options)=
;
 }
@@ -1541,7 +1557,7 @@ int http_get_strbuf(const char *url,
  * file is still around) the download is resumed.
  */
 static int http_get_file(const char *url, const char *filename,
-			 struct http_get_options *options)
+			 struct http_request_options *options)
 {
 	int ret;
 	struct strbuf tmpfile =3D STRBUF_INIT;
@@ -1567,7 +1583,7 @@ cleanup:
=20
 int http_fetch_ref(const char *base, struct ref *ref)
 {
-	struct http_get_options options =3D {0};
+	struct http_request_options options =3D {0};
 	char *url;
 	struct strbuf buffer =3D STRBUF_INIT;
 	int ret =3D -1;
@@ -1659,7 +1675,7 @@ add_pack:
=20
 int http_get_info_packs(const char *base_url, struct packed_git **pack=
s_head)
 {
-	struct http_get_options options =3D {0};
+	struct http_request_options options =3D {0};
 	int ret =3D 0, i =3D 0;
 	char *url, *data;
 	struct strbuf buf =3D STRBUF_INIT;
diff --git a/http.h b/http.h
index 4ef4bbd..0b7cebf 100644
--- a/http.h
+++ b/http.h
@@ -136,7 +136,7 @@ extern char *get_remote_object_url(const char *url,=
 const char *hex,
 				   int only_two_digit_prefix);
=20
 /* Options for http_get_*() */
-struct http_get_options {
+struct http_request_options {
 	unsigned no_cache:1,
 		 keep_error:1;
=20
@@ -163,6 +163,18 @@ struct http_get_options {
 	 * for details.
 	 */
 	struct strbuf *base_url;
+
+	/*
+	 * If non-NULL, a HTTP POST request is sent with the raw post data
+	 * contained in postfields.
+	 */
+	struct strbuf *postfields;
+
+	/*
+	 * If non-NULL, a content-type header is applied to the HTTP POST
+	 * request.
+	 */
+	struct strbuf *post_content_type;
 };
=20
 /* Return values for http_get_*() */
@@ -178,7 +190,8 @@ struct http_get_options {
  *
  * If the result pointer is NULL, a HTTP HEAD request is made instead =
of GET.
  */
-int http_get_strbuf(const char *url, struct strbuf *result, struct htt=
p_get_options *options);
+int http_get_strbuf(const char *url, struct strbuf *result,
+		    struct http_request_options *options);
=20
 extern int http_fetch_ref(const char *base, struct ref *ref);
=20
diff --git a/remote-curl.c b/remote-curl.c
index 15e48e2..345a5e6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -254,7 +254,7 @@ static struct discovery *discover_refs(const char *=
service, int for_push)
 	struct strbuf effective_url =3D STRBUF_INIT;
 	struct discovery *last =3D last_discovery;
 	int http_ret, maybe_smart =3D 0;
-	struct http_get_options options;
+	struct http_request_options options;
=20
 	if (last && !strcmp(service, last->service))
 		return last;
--=20
2.8.0.rc0.62.gfc8aefa.dirty
