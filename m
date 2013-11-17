From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 08/86] transport*: replace prefixcmp() with starts_with()
Date: Sun, 17 Nov 2013 23:06:00 +0100
Message-ID: <20131117220719.4386.15982.chriscool@tuxfamily.org>
References: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 22:05:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VisUU-0002aL-9l
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 22:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab3KSVFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 16:05:42 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:63459 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798Ab3KSVFd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 16:05:33 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 978BF57;
	Tue, 19 Nov 2013 22:05:31 +0100 (CET)
X-git-sha1: 8020d1377aa715cc914e0b0d05305595073e98c8 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131117215732.4386.19345.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238046>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 transport-helper.c | 16 ++++++++--------
 transport.c        | 28 ++++++++++++++--------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b32e2d6..96de26d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -190,7 +190,7 @@ static struct child_process *get_helper(struct transport *transport)
 			data->export = 1;
 		else if (!strcmp(capname, "check-connectivity"))
 			data->check_connectivity = 1;
-		else if (!data->refspecs && !prefixcmp(capname, "refspec ")) {
+		else if (!data->refspecs && starts_with(capname, "refspec ")) {
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
@@ -199,17 +199,17 @@ static struct child_process *get_helper(struct transport *transport)
 			data->connect = 1;
 		} else if (!strcmp(capname, "signed-tags")) {
 			data->signed_tags = 1;
-		} else if (!prefixcmp(capname, "export-marks ")) {
+		} else if (starts_with(capname, "export-marks ")) {
 			struct strbuf arg = STRBUF_INIT;
 			strbuf_addstr(&arg, "--export-marks=");
 			strbuf_addstr(&arg, capname + strlen("export-marks "));
 			data->export_marks = strbuf_detach(&arg, NULL);
-		} else if (!prefixcmp(capname, "import-marks")) {
+		} else if (starts_with(capname, "import-marks")) {
 			struct strbuf arg = STRBUF_INIT;
 			strbuf_addstr(&arg, "--import-marks=");
 			strbuf_addstr(&arg, capname + strlen("import-marks "));
 			data->import_marks = strbuf_detach(&arg, NULL);
-		} else if (!prefixcmp(capname, "no-private-update")) {
+		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
 			die("Unknown mandatory capability %s. This remote "
@@ -310,7 +310,7 @@ static int set_helper_option(struct transport *transport,
 
 	if (!strcmp(buf.buf, "ok"))
 		ret = 0;
-	else if (!prefixcmp(buf.buf, "error")) {
+	else if (starts_with(buf.buf, "error")) {
 		ret = -1;
 	} else if (!strcmp(buf.buf, "unsupported"))
 		ret = 1;
@@ -374,7 +374,7 @@ static int fetch_with_fetch(struct transport *transport,
 	while (1) {
 		recvline(data, &buf);
 
-		if (!prefixcmp(buf.buf, "lock ")) {
+		if (starts_with(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
 			if (transport->pack_lockfile)
 				warning("%s also locked %s", data->name, name);
@@ -645,10 +645,10 @@ static int push_update_ref_status(struct strbuf *buf,
 	char *refname, *msg;
 	int status;
 
-	if (!prefixcmp(buf->buf, "ok ")) {
+	if (starts_with(buf->buf, "ok ")) {
 		status = REF_STATUS_OK;
 		refname = buf->buf + 3;
-	} else if (!prefixcmp(buf->buf, "error ")) {
+	} else if (starts_with(buf->buf, "error ")) {
 		status = REF_STATUS_REMOTE_REJECT;
 		refname = buf->buf + 6;
 	} else
diff --git a/transport.c b/transport.c
index 7202b77..8023956 100644
--- a/transport.c
+++ b/transport.c
@@ -169,13 +169,13 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		remotename = ref->name;
 		tmp = resolve_ref_unsafe(localname, sha, 1, &flag);
 		if (tmp && flag & REF_ISSYMREF &&
-			!prefixcmp(tmp, "refs/heads/"))
+			starts_with(tmp, "refs/heads/"))
 			localname = tmp;
 
 		/* Both source and destination must be local branches. */
-		if (!localname || prefixcmp(localname, "refs/heads/"))
+		if (!localname || !starts_with(localname, "refs/heads/"))
 			continue;
-		if (!remotename || prefixcmp(remotename, "refs/heads/"))
+		if (!remotename || !starts_with(remotename, "refs/heads/"))
 			continue;
 
 		if (!pretend)
@@ -191,7 +191,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 
 static const char *rsync_url(const char *url)
 {
-	return prefixcmp(url, "rsync://") ? skip_prefix(url, "rsync:") : url;
+	return !starts_with(url, "rsync://") ? skip_prefix(url, "rsync:") : url;
 }
 
 static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
@@ -296,8 +296,8 @@ static int write_one_ref(const char *name, const unsigned char *sha1,
 	FILE *f;
 
 	/* when called via for_each_ref(), flags is non-zero */
-	if (flags && prefixcmp(name, "refs/heads/") &&
-			prefixcmp(name, "refs/tags/"))
+	if (flags && !starts_with(name, "refs/heads/") &&
+			!starts_with(name, "refs/tags/"))
 		return 0;
 
 	strbuf_addstr(buf, name);
@@ -652,7 +652,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
 	else if (is_null_sha1(ref->old_sha1))
 		print_ref_status('*',
-			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
+			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
 			"[new branch]"),
 			ref, ref->peer_ref, NULL, porcelain);
 	else {
@@ -930,13 +930,13 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 		while (is_urlschemechar(p == url, *p))
 			p++;
-		if (!prefixcmp(p, "::"))
+		if (starts_with(p, "::"))
 			helper = xstrndup(url, p - url);
 	}
 
 	if (helper) {
 		transport_helper_init(ret, helper);
-	} else if (!prefixcmp(url, "rsync:")) {
+	} else if (starts_with(url, "rsync:")) {
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
+		|| starts_with(url, "file://")
+		|| starts_with(url, "git://")
+		|| starts_with(url, "ssh://")
+		|| starts_with(url, "git+ssh://")
+		|| starts_with(url, "ssh+git://")) {
 		/* These are builtin smart transports. */
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
-- 
1.8.4.1.561.g12affca
