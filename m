From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/86] transport*: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:01 +0100
Message-ID: <20131109070720.18178.55096.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hn-0005cp-Me
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933374Ab3KIHL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:29 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54084 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933225Ab3KIHIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:24 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id B4F8345;
	Sat,  9 Nov 2013 08:08:22 +0100 (CET)
X-git-sha1: 779961ac7df15aa82986fa7cacb15857ca65b1b1 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237536>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 transport-helper.c | 16 ++++++++--------
 transport.c        | 28 ++++++++++++++--------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b32e2d6..bf8d7a0 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -190,7 +190,7 @@ static struct child_process *get_helper(struct transport *transport)
 			data->export = 1;
 		else if (!strcmp(capname, "check-connectivity"))
 			data->check_connectivity = 1;
-		else if (!data->refspecs && !prefixcmp(capname, "refspec ")) {
+		else if (!data->refspecs && has_prefix(capname, "refspec ")) {
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
@@ -199,17 +199,17 @@ static struct child_process *get_helper(struct transport *transport)
 			data->connect = 1;
 		} else if (!strcmp(capname, "signed-tags")) {
 			data->signed_tags = 1;
-		} else if (!prefixcmp(capname, "export-marks ")) {
+		} else if (has_prefix(capname, "export-marks ")) {
 			struct strbuf arg = STRBUF_INIT;
 			strbuf_addstr(&arg, "--export-marks=");
 			strbuf_addstr(&arg, capname + strlen("export-marks "));
 			data->export_marks = strbuf_detach(&arg, NULL);
-		} else if (!prefixcmp(capname, "import-marks")) {
+		} else if (has_prefix(capname, "import-marks")) {
 			struct strbuf arg = STRBUF_INIT;
 			strbuf_addstr(&arg, "--import-marks=");
 			strbuf_addstr(&arg, capname + strlen("import-marks "));
 			data->import_marks = strbuf_detach(&arg, NULL);
-		} else if (!prefixcmp(capname, "no-private-update")) {
+		} else if (has_prefix(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
 			die("Unknown mandatory capability %s. This remote "
@@ -310,7 +310,7 @@ static int set_helper_option(struct transport *transport,
 
 	if (!strcmp(buf.buf, "ok"))
 		ret = 0;
-	else if (!prefixcmp(buf.buf, "error")) {
+	else if (has_prefix(buf.buf, "error")) {
 		ret = -1;
 	} else if (!strcmp(buf.buf, "unsupported"))
 		ret = 1;
@@ -374,7 +374,7 @@ static int fetch_with_fetch(struct transport *transport,
 	while (1) {
 		recvline(data, &buf);
 
-		if (!prefixcmp(buf.buf, "lock ")) {
+		if (has_prefix(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
 			if (transport->pack_lockfile)
 				warning("%s also locked %s", data->name, name);
@@ -645,10 +645,10 @@ static int push_update_ref_status(struct strbuf *buf,
 	char *refname, *msg;
 	int status;
 
-	if (!prefixcmp(buf->buf, "ok ")) {
+	if (has_prefix(buf->buf, "ok ")) {
 		status = REF_STATUS_OK;
 		refname = buf->buf + 3;
-	} else if (!prefixcmp(buf->buf, "error ")) {
+	} else if (has_prefix(buf->buf, "error ")) {
 		status = REF_STATUS_REMOTE_REJECT;
 		refname = buf->buf + 6;
 	} else
diff --git a/transport.c b/transport.c
index 7202b77..24b781c 100644
--- a/transport.c
+++ b/transport.c
@@ -169,13 +169,13 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		remotename = ref->name;
 		tmp = resolve_ref_unsafe(localname, sha, 1, &flag);
 		if (tmp && flag & REF_ISSYMREF &&
-			!prefixcmp(tmp, "refs/heads/"))
+			has_prefix(tmp, "refs/heads/"))
 			localname = tmp;
 
 		/* Both source and destination must be local branches. */
-		if (!localname || prefixcmp(localname, "refs/heads/"))
+		if (!localname || !has_prefix(localname, "refs/heads/"))
 			continue;
-		if (!remotename || prefixcmp(remotename, "refs/heads/"))
+		if (!remotename || !has_prefix(remotename, "refs/heads/"))
 			continue;
 
 		if (!pretend)
@@ -191,7 +191,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 
 static const char *rsync_url(const char *url)
 {
-	return prefixcmp(url, "rsync://") ? skip_prefix(url, "rsync:") : url;
+	return !has_prefix(url, "rsync://") ? skip_prefix(url, "rsync:") : url;
 }
 
 static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
@@ -296,8 +296,8 @@ static int write_one_ref(const char *name, const unsigned char *sha1,
 	FILE *f;
 
 	/* when called via for_each_ref(), flags is non-zero */
-	if (flags && prefixcmp(name, "refs/heads/") &&
-			prefixcmp(name, "refs/tags/"))
+	if (flags && !has_prefix(name, "refs/heads/") &&
+			!has_prefix(name, "refs/tags/"))
 		return 0;
 
 	strbuf_addstr(buf, name);
@@ -652,7 +652,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
 	else if (is_null_sha1(ref->old_sha1))
 		print_ref_status('*',
-			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
+			(has_prefix(ref->name, "refs/tags/") ? "[new tag]" :
 			"[new branch]"),
 			ref, ref->peer_ref, NULL, porcelain);
 	else {
@@ -930,13 +930,13 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 		while (is_urlschemechar(p == url, *p))
 			p++;
-		if (!prefixcmp(p, "::"))
+		if (has_prefix(p, "::"))
 			helper = xstrndup(url, p - url);
 	}
 
 	if (helper) {
 		transport_helper_init(ret, helper);
-	} else if (!prefixcmp(url, "rsync:")) {
+	} else if (has_prefix(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
@@ -949,11 +949,11 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->disconnect = close_bundle;
 		ret->smart_options = NULL;
 	} else if (!is_url(url)
-		|| !prefixcmp(url, "file://")
-		|| !prefixcmp(url, "git://")
-		|| !prefixcmp(url, "ssh://")
-		|| !prefixcmp(url, "git+ssh://")
-		|| !prefixcmp(url, "ssh+git://")) {
+		|| has_prefix(url, "file://")
+		|| has_prefix(url, "git://")
+		|| has_prefix(url, "ssh://")
+		|| has_prefix(url, "git+ssh://")
+		|| has_prefix(url, "ssh+git://")) {
 		/* These are builtin smart transports. */
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
-- 
1.8.4.1.566.geca833c
