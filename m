From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 1/8] Pass unknown protocols to external protocol handlers
Date: Fri,  4 Dec 2009 17:56:01 +0200
Message-ID: <1259942168-24869-4-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 17:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaWL-00021k-0p
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbZLDP4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756773AbZLDP4X
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:56:23 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:48181 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795AbZLDP4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:56:22 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 4AD058BF96
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:28 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02E984386C; Fri, 04 Dec 2009 17:56:28 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 20DC341BE8
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:24 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.288.g40e67
In-Reply-To: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134528>

Change URL handling to allow external protocol handlers to implement
new protocols without the '::' syntax if helper name does not conflict
with any built-in protocol.

foo:// now invokes git-remote-foo with foo:// URL.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   37 ++++++++++++++++++++++-
 transport.c        |   82 +++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 106 insertions(+), 13 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 11f3d7e..d3aad5c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -22,6 +22,26 @@ struct helper_data
 	int refspec_nr;
 };
 
+const char* remove_ext_force(const char* url)
+{
+	const char* url2 = url;
+	const char* first_colon = NULL;
+
+	if(!url)
+		return NULL;
+
+	while(*url2 && !first_colon)
+		if(*url2 == ':')
+			first_colon = url2;
+		else
+			url2++;
+
+	if(first_colon && first_colon[1] == ':')
+		return first_colon + 2;
+	else
+		return url;
+}
+
 static struct child_process *get_helper(struct transport *transport)
 {
 	struct helper_data *data = transport->data;
@@ -30,6 +50,7 @@ static struct child_process *get_helper(struct transport *transport)
 	const char **refspecs = NULL;
 	int refspec_nr = 0;
 	int refspec_alloc = 0;
+	int duped;
 
 	if (data->helper)
 		return data->helper;
@@ -42,15 +63,26 @@ static struct child_process *get_helper(struct transport *transport)
 	strbuf_addf(&buf, "remote-%s", data->name);
 	helper->argv[0] = strbuf_detach(&buf, NULL);
 	helper->argv[1] = transport->remote->name;
-	helper->argv[2] = transport->url;
+	helper->argv[2] = remove_ext_force(transport->url);
 	helper->git_cmd = 1;
 	if (start_command(helper))
 		die("Unable to run helper: git %s", helper->argv[0]);
 	data->helper = helper;
 
+	/* Open the output as FILE* so strbuf_getline() can be used.
+	   Do this with duped fd because fclose() will close the fd,
+	   and stuff like disowning will require the fd to remain.
+
+	   Set the stream to unbuffered because some reads are critical
+	   in sense that any overreading will cause deadlocks.
+	*/
+	if((duped = dup(helper->out)) < 0)
+		die_errno("Can't dup helper output fd");
+	data->out = xfdopen(duped, "r");
+	setvbuf(data->out, NULL, _IONBF, 0);
+
 	write_str_in_full(helper->in, "capabilities\n");
 
-	data->out = xfdopen(helper->out, "r");
 	while (1) {
 		if (strbuf_getline(&buf, data->out, '\n') == EOF)
 			exit(128); /* child died, message supplied already */
@@ -91,6 +123,7 @@ static int disconnect_helper(struct transport *transport)
 	if (data->helper) {
 		write_str_in_full(data->helper->in, "\n");
 		close(data->helper->in);
+		close(data->helper->out);
 		fclose(data->out);
 		finish_command(data->helper);
 		free((char *)data->helper->argv[0]);
diff --git a/transport.c b/transport.c
index 3eea836..162d022 100644
--- a/transport.c
+++ b/transport.c
@@ -780,6 +780,55 @@ static int is_file(const char *url)
 	return S_ISREG(buf.st_mode);
 }
 
+static const char* strchrc(const char* str, int c)
+{
+	while(*str)
+		if(*str == c)
+			return str;
+		else
+			str++;
+	return NULL;
+}
+
+static int is_url(const char* url)
+{
+	if(!url)
+		return 0;
+
+	const char* url2 = url;
+	const char* first_slash = strchrc(url, '/');
+
+	/* Input with no slash at all or slash first can't be URL. */
+	if(!first_slash || first_slash == url)
+		return 0;
+	/* Character before must be : and next must be /. */
+	if(first_slash[-1] != ':' || first_slash[1] != '/')
+		return 0;
+	/* There must be something before the :// */
+	if(first_slash == url + 1)
+		return 0;
+	/* Check all characters up to first slash. Only alpha, num and
+	   : are allowed. : must be followed by : or / */
+	url2 = url;
+	while(url2 < first_slash) {
+		if(*url2 != ':' && !isalnum((unsigned char)*url2))
+			return 0;
+		if(*url2 == ':' && url2[1] != ':' && url2[1] != '/')
+			return 0;
+		if(*url2 == ':')
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
@@ -812,23 +861,19 @@ struct transport *transport_get(struct remote *remote, const char *url)
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
+	} else if(!is_url(url)
+		|| !prefixcmp(url, "file://")
+		|| !prefixcmp(url, "git://")
+		|| !prefixcmp(url, "ssh://")
+		|| !prefixcmp(url, "git+ssh://")
+		|| !prefixcmp(url, "ssh+git://")) {
+		/* These are builtin smart transports. */
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
 		ret->data = data;
 		ret->set_option = set_git_option;
@@ -845,6 +890,21 @@ struct transport *transport_get(struct remote *remote, const char *url)
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
1.6.6.rc1.288.g40e67
