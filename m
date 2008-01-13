From: =?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
Subject: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Sun, 13 Jan 2008 20:02:57 +0100
Message-ID: <1200250979-19604-1-git-send-email-gb@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 20:03:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE87M-00078E-Ny
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 20:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbYAMTDK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2008 14:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbYAMTDJ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 14:03:09 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:37545 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560AbYAMTDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 14:03:04 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D7DF51AB357;
	Sun, 13 Jan 2008 20:03:00 +0100 (CET)
Received: from localhost.localdomain (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E559E1AB38B;
	Sun, 13 Jan 2008 20:02:59 +0100 (CET)
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70406>

=46ail when info/refs exists and is already locked (avoiding strange be=
haviour
and errors, and maybe avoiding some repository corruption).

Warn if the URL does not end with '/' (since 302 is not yet handled)

More explicit error message when the URL or password is not set correct=
ly
(instead of "no DAV locking support").

DAV locking time of 1 minute instead of 10 minutes (avoid waiting 10 mi=
nutes
for a orphan lock to expire before anyone can do a push on the repo).

Signed-off-by: Gr=C3=A9goire Barbier <gb@gbarbier.org>
---
 http-push.c |   17 ++++++++++++++++-
 http.c      |   25 +++++++++++++++++++++++++
 http.h      |    1 +
 3 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 55d0c94..c005903 100644
--- a/http-push.c
+++ b/http-push.c
@@ -57,7 +57,7 @@ enum XML_Status {
 #define PROPFIND_ALL_REQUEST "<?xml version=3D\"1.0\" encoding=3D\"utf=
-8\" ?>\n<D:propfind xmlns:D=3D\"DAV:\">\n<D:allprop/>\n</D:propfind>"
 #define LOCK_REQUEST "<?xml version=3D\"1.0\" encoding=3D\"utf-8\" ?>\=
n<D:lockinfo xmlns:D=3D\"DAV:\">\n<D:lockscope><D:exclusive/></D:locksc=
ope>\n<D:locktype><D:write/></D:locktype>\n<D:owner>\n<D:href>mailto:%s=
</D:href>\n</D:owner>\n</D:lockinfo>"
=20
-#define LOCK_TIME 600
+#define LOCK_TIME 60
 #define LOCK_REFRESH 30
=20
 /* bits #0-15 in revision.h */
@@ -2224,6 +2224,16 @@ int main(int argc, char **argv)
=20
 	no_pragma_header =3D curl_slist_append(no_pragma_header, "Pragma:");
=20
+	/* Verify connexion string (agains bad URLs or password errors) */
+	if (remote->url && remote->url[strlen(remote->url)-1] !=3D '/') {
+		fprintf(stderr, "Warning: remote URL does not end with a '/' which o=
ften leads to problems\n");
+	}
+	if (!http_test_connection(remote->url)) {
+		fprintf(stderr, "Error: cannot access to remote URL (maybe malformed=
 URL, network error or bad credentials)\n");
+		rc =3D 1;
+		goto cleanup;
+	}
+
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
 		fprintf(stderr, "Error: no DAV locking support on remote repo %s\n",=
 remote->url);
@@ -2239,6 +2249,11 @@ int main(int argc, char **argv)
 		info_ref_lock =3D lock_remote("info/refs", LOCK_TIME);
 		if (info_ref_lock)
 			remote->can_update_info_refs =3D 1;
+		else {
+			fprintf(stderr, "Error: cannot lock existing info/refs\n");
+			rc =3D 1;
+			goto cleanup;
+		}
 	}
 	if (remote->has_info_packs)
 		fetch_indices();
diff --git a/http.c b/http.c
index d2c11ae..8b04ae9 100644
--- a/http.c
+++ b/http.c
@@ -634,3 +634,28 @@ int http_fetch_ref(const char *base, const char *r=
ef, unsigned char *sha1)
 	free(url);
 	return ret;
 }
+
+int http_test_connection(const char *url)
+{
+	struct strbuf buffer =3D STRBUF_INIT;
+	struct active_request_slot *slot;
+	struct slot_results results;
+	int ret =3D 0;
+
+	slot =3D get_active_slot();
+	slot->results =3D &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result =3D=3D CURLE_OK)
+			ret =3D -1;
+		else
+			error("Cannot access to URL %s, return code %d", url, results.curl_=
result);
+	} else
+		error("Unable to start request");
+	strbuf_release(&buffer);
+	return ret;
+}
diff --git a/http.h b/http.h
index aeba930..b353007 100644
--- a/http.h
+++ b/http.h
@@ -77,6 +77,7 @@ extern void step_active_slots(void);
=20
 extern void http_init(void);
 extern void http_cleanup(void);
+extern int http_test_connection(const char *url);
=20
 extern int data_received;
 extern int active_requests;
--=20
1.5.3.6
