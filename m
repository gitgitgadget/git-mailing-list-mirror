From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [REROLL PATCH v2 3/8] Pass unknown protocols to external protocol handlers
Date: Wed,  9 Dec 2009 17:26:29 +0200
Message-ID: <1260372394-16427-4-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 09 16:27:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIORf-0002on-66
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbZLIP0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755427AbZLIP0h
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:26:37 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:54044 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285AbZLIP0e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:26:34 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 95F4BEF442
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:40 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A06E1E90F74; Wed, 09 Dec 2009 17:26:40 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 705F32BD44
	for <git@vger.kernel.org>; Wed,  9 Dec 2009 17:26:39 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260372394-16427-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134984>

Change URL handling to allow external protocol handlers to implement
new protocols without the '::' syntax if helper name does not conflict
with any built-in protocol.

foo:// now invokes git-remote-foo with foo:// as the URL.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   12 +++++++-
 transport.c        |   76 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4b17aaa..271af34 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -63,6 +63,16 @@ static void write_constant(int fd, const char *str)
 		die_errno("Full write to remote helper failed");
 }
 
+const char *remove_ext_force(const char *url)
+{
+	if (url) {
+		const char *colon = strchr(url, ':');
+		if (colon && colon[1] == ':')
+			return colon + 2;
+	}
+	return url;
+}
+
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
@@ -83,7 +93,7 @@ static struct child_process *get_helper(struct transport *transport)
 	strbuf_addf(&buf, "remote-%s", data->name);
 	helper->argv[0] = strbuf_detach(&buf, NULL);
 	helper->argv[1] = transport->remote->name;
-	helper->argv[2] = transport->url;
+	helper->argv[2] = remove_ext_force(transport->url);
 	helper->git_cmd = 1;
 	if (start_command(helper))
 		die("Unable to run helper: git %s", helper->argv[0]);
diff --git a/transport.c b/transport.c
index 3eea836..dea37d0 100644
--- a/transport.c
+++ b/transport.c
@@ -780,6 +780,44 @@ static int is_file(const char *url)
 	return S_ISREG(buf.st_mode);
 }
 
+static int is_url(const char *url)
+{
+	const char *url2, *first_slash;
+
+	if (!url)
+		return 0;
+	url2 = url;
+	first_slash = strchr(url, '/');
+
+	/* Input with no slash at all or slash first can't be URL. */
+	if (!first_slash || first_slash == url)
+		return 0;
+	/* Character before must be : and next must be /. */
+	if (first_slash[-1] != ':' || first_slash[1] != '/')
+		return 0;
+	/* There must be something before the :// */
+	if (first_slash == url + 1)
+		return 0;
+	/*
+	 * Check all characters up to first slash - 1. Only alphanum
+	 * is allowed.
+	 */
+	url2 = url;
+	while (url2 < first_slash - 1) {
+		if (!isalnum((unsigned char)*url2))
+			return 0;
+		url2++;
+	}
+
+	/* Valid enough. */
+	return 1;
+}
+
+static int external_specification_len(const char *url)
+{
+	return strchr(url, ':') - url;
+}
+
 struct transport *transport_get(struct remote *remote, const char *url)
 {
 	struct transport *ret = xcalloc(1, sizeof(*ret));
@@ -805,30 +843,23 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 	if (remote && remote->foreign_vcs) {
 		transport_helper_init(ret, remote->foreign_vcs);
-		return ret;
-	}
-
-	if (!prefixcmp(url, "rsync:")) {
+	} else if (!prefixcmp(url, "rsync:")) {
 		ret->get_refs_list = get_refs_via_rsync;
 		ret->fetch = fetch_objs_via_rsync;
 		ret->push = rsync_transport_push;
-
-	} else if (!prefixcmp(url, "http://")
-	        || !prefixcmp(url, "https://")
-	        || !prefixcmp(url, "ftp://")) {
-		transport_helper_init(ret, "curl");
-#ifdef NO_CURL
-		error("git was compiled without libcurl support.");
-#endif
-
 	} else if (is_local(url) && is_file(url)) {
 		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->get_refs_list = get_refs_from_bundle;
 		ret->fetch = fetch_refs_from_bundle;
 		ret->disconnect = close_bundle;
-
-	} else {
+	} else if (!is_url(url)
+		|| !prefixcmp(url, "file://")
+		|| !prefixcmp(url, "git://")
+		|| !prefixcmp(url, "ssh://")
+		|| !prefixcmp(url, "git+ssh://")
+		|| !prefixcmp(url, "ssh+git://")) {
+		/* These are builtin smart transports. */
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->set_option = set_git_option;
@@ -845,6 +876,21 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		data->receivepack = "git-receive-pack";
 		if (remote->receivepack)
 			data->receivepack = remote->receivepack;
+	} else if (!prefixcmp(url, "http://")
+		|| !prefixcmp(url, "https://")
+		|| !prefixcmp(url, "ftp://")) {
+		/* These three are just plain special. */
+		transport_helper_init(ret, "curl");
+#ifdef NO_CURL
+		error("git was compiled without libcurl support.");
+#endif
+	} else {
+		/* Unknown protocol in URL. Pass to external handler. */
+		int len = external_specification_len(url);
+		char *handler = xmalloc(len + 1);
+		handler[len] = 0;
+		strncpy(handler, url, len);
+		transport_helper_init(ret, handler);
 	}
 
 	return ret;
-- 
1.6.6.rc1.300.gfbc27
