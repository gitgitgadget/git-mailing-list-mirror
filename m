From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v3 3/8] Pass unknown protocols to external protocol handlers
Date: Sun,  6 Dec 2009 18:28:46 +0200
Message-ID: <1260116931-16549-4-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 17:29:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHJzN-0006Vu-6Z
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 17:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885AbZLFQ27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 11:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933833AbZLFQ24
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 11:28:56 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:48106 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857AbZLFQ2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 11:28:51 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id AE3288BAA5
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:28:56 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A011E5AB0F2; Sun, 06 Dec 2009 18:28:56 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 89194402E
	for <git@vger.kernel.org>; Sun,  6 Dec 2009 18:28:55 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134674>

Change URL handling to allow external protocol handlers to implement
new protocols without the '::' syntax if helper name does not conflict
with any built-in protocol.

foo:// now invokes git-remote-foo with foo:// URL.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   22 ++++++++++++-
 transport.c        |   87 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 93 insertions(+), 16 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index f5c585d..95aaa02 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -63,6 +63,26 @@ static void write_constant(int fd, const char *str)
 		die_errno("Full write to remote helper failed");
 }
 
+const char* remove_ext_force(const char* url)
+{
+	const char* url2 = url;
+	const char* first_colon = NULL;
+
+	if (!url)
+		return NULL;
+
+	while (*url2 && !first_colon)
+		if (*url2 == ':')
+			first_colon = url2;
+		else
+			url2++;
+
+	if (first_colon && first_colon[1] == ':')
+		return first_colon + 2;
+	else
+		return url;
+}
+
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
@@ -83,7 +103,7 @@ static struct child_process *get_helper(struct transport *transport)
 	strbuf_addf(&buf, "remote-%s", data->name);
 	helper->argv[0] = strbuf_detach(&buf, NULL);
 	helper->argv[1] = transport->remote->name;
-	helper->argv[2] = transport->url;
+	helper->argv[2] = remove_ext_force(transport->url);
 	helper->git_cmd = 1;
 	if (start_command(helper))
 		die("Unable to run helper: git %s", helper->argv[0]);
diff --git a/transport.c b/transport.c
index 3eea836..eadd553 100644
--- a/transport.c
+++ b/transport.c
@@ -780,6 +780,55 @@ static int is_file(const char *url)
 	return S_ISREG(buf.st_mode);
 }
 
+static const char* strchrc(const char* str, int c)
+{
+	while (*str)
+		if (*str == c)
+			return str;
+		else
+			str++;
+	return NULL;
+}
+
+static int is_url(const char* url)
+{
+	if (!url)
+		return 0;
+
+	const char* url2 = url;
+	const char* first_slash = strchrc(url, '/');
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
+	/* Check all characters up to first slash. Only alpha, num and
+	   : are allowed. : must be followed by : or / */
+	url2 = url;
+	while (url2 < first_slash) {
+		if (*url2 != ':' && !isalnum((unsigned char)*url2))
+			return 0;
+		if (*url2 == ':' && url2[1] != ':' && url2[1] != '/')
+			return 0;
+		if (*url2 == ':')
+			url2++;		/* Skip second : */
+		url2++;
+	}
+
+	/* Valid enough. */
+	return 1;
+}
+
+static int external_specification_len(const char* url)
+{
+	return strchrc(url, ':') - url;
+}
+
 struct transport *transport_get(struct remote *remote, const char *url)
 {
 	struct transport *ret = xcalloc(1, sizeof(*ret));
@@ -805,30 +854,23 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
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
@@ -845,6 +887,21 @@ struct transport *transport_get(struct remote *remote, const char *url)
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
+		char* handler = xmalloc(len + 1);
+		handler[len] = 0;
+		strncpy(handler, url, len);
+		transport_helper_init(ret, handler);
 	}
 
 	return ret;
-- 
1.6.6.rc1.300.gfbc27
