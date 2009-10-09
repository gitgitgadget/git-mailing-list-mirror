From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH 4/4] Smart fetch and push over HTTP: server side
Date: Thu,  8 Oct 2009 22:22:48 -0700
Message-ID: <1255065768-10428-5-git-send-email-spearce@spearce.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1255065768-10428-3-git-send-email-spearce@spearce.org>
 <1255065768-10428-4-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 07:26:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw80E-0001sK-DV
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 07:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbZJIFXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 01:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbZJIFXd
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 01:23:33 -0400
Received: from george.spearce.org ([209.20.77.23]:37235 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbZJIFXa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 01:23:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id AEE75381FE; Fri,  9 Oct 2009 05:22:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D262038200
	for <git@vger.kernel.org>; Fri,  9 Oct 2009 05:22:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.rc3.193.gdf7a
In-Reply-To: <1255065768-10428-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129731>

Requests for $GIT_URL/git-receive-pack and $GIT_URL/git-upload-pack
are forwarded to the corresponding backend process by directly
executing it and leaving stdin and stdout connected to the web
server.  Prior to starting the backend HTTP headers are sent, thereby
freeing the backend from needing to know about the HTTP protocol.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http-backend.c |  135 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 134 insertions(+), 1 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 39cfd25..978f820 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -77,6 +77,95 @@ static NORETURN void not_found(const char *err, ...)
 	exit(0);
 }
 
+static NORETURN void forbidden(const char *err, ...)
+{
+	va_list params;
+
+	write_status(403, "Forbidden");
+	write_nocache();
+	end_headers();
+
+	va_start(params, err);
+	if (err && *err) {
+		vsnprintf(buffer, sizeof(buffer), err, params);
+		fprintf(stderr, "%s\n", buffer);
+	}
+	va_end(params);
+	exit(0);
+}
+
+struct http_service {
+	const char *name;
+	const char *config_name;
+	int enabled;
+};
+static struct http_service *service;
+
+static struct http_service http_service[] = {
+	{ "upload-pack", "uploadpack", 1 },
+	{ "receive-pack", "receivepack", 0 },
+};
+
+static int http_config(const char *var, const char *value, void *cb)
+{
+	if (!prefixcmp(var, "http.") &&
+	    !strcmp(var + 7, service->config_name)) {
+		service->enabled = git_config_bool(var, value);
+		return 0;
+	}
+
+	/* we are not interested in parsing any other configuration here */
+	return 0;
+}
+
+static void select_service(const char *name)
+{
+	int i;
+
+	if (prefixcmp(name, "git-"))
+		forbidden("Unsupported service: '%s'", name);
+
+	for (i = 0; i < ARRAY_SIZE(http_service); i++) {
+		service = &http_service[i];
+		if (!strcmp(service->name, name + 4)) {
+			git_config(http_config, NULL);
+			if (!service->enabled)
+				forbidden("Service not enabled: '%s'", name);
+			return;
+		}
+	}
+	forbidden("Unsupported service: '%s'", name);
+}
+
+static void run_service(const char **argv)
+{
+#ifndef WIN32
+	execv_git_cmd(argv);
+#else
+	struct child_process cld;
+
+	memset(&cld, 0, sizeof(cld));
+	cld.argv = argv;
+	cld.git_cmd = 1;
+	if (start_command(&cld))
+		die("Cannot start git-%s service", service->name);
+	close(0);
+	close(1);
+	finish_command(&cld);
+#endif
+}
+
+static void require_content_type(const char *need_type)
+{
+	const char *input_type = getenv("CONTENT_TYPE");
+	if (!input_type || strcmp(input_type, need_type)) {
+		write_status(415, "Unsupported Media Type");
+		write_nocache();
+		end_headers();
+		exit(0);
+	}
+}
+
 static void write_file(const char *the_type, const char *name)
 {
 	const char *p = git_path("%s", name);
@@ -151,6 +240,25 @@ static int show_text_ref(const char *name, const unsigned char *sha1,
 
 static void get_info_refs(char *arg)
 {
+	char *query = getenv("QUERY_STRING");
+
+	if (query && !prefixcmp(query, "service=")) {
+		const char *argv[] = {NULL /* service name */,
+			"--smart-http", "--advertise-refs",
+			".", NULL};
+
+		select_service(query + 8);
+
+		write_nocache();
+		format_write("%s: application/x-git-%s-advertisement\r\n",
+			content_type, service->name);
+		end_headers();
+		packet_write(1, "# service=git-%s\n", service->name);
+
+		argv[0] = service->name;
+		run_service(argv);
+	}
+
 	write_nocache();
 	write_header(content_type, "text/plain; charset=utf-8");
 	end_headers();
@@ -176,6 +284,28 @@ static void get_info_packs(char *arg)
 	safe_write(1, "\n", 1);
 }
 
+static void post_to_service(char *service_name)
+{
+	const char *argv[] = {NULL, "--smart-http", ".", NULL};
+	unsigned n;
+
+	select_service(service_name);
+
+	n = snprintf(buffer, sizeof(buffer),
+		"application/x-git-%s-request", service->name);
+	if (n >= sizeof(buffer))
+		die("impossibly long service name");
+	require_content_type(buffer);
+
+	write_nocache();
+	format_write("%s: application/x-git-%s-result\r\n",
+		content_type, service->name);
+	end_headers();
+
+	argv[0] = service->name;
+	run_service(argv);
+}
+
 static NORETURN void die_webcgi(const char *err, va_list params)
 {
 	write_status(500, "Internal Server Error");
@@ -198,7 +328,10 @@ static struct service_cmd {
 	{"GET", "/objects/info/[^/]*$", get_text_file},
 	{"GET", "/objects/[0-9a-f]{2}/[0-9a-f]{38}$", get_loose_object},
 	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.pack$", get_pack_file},
-	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file}
+	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
+
+	{"POST", "/git-upload-pack$", post_to_service},
+	{"POST", "/git-receive-pack$", post_to_service}
 };
 
 int main(int argc, char **argv)
-- 
1.6.5.rc3.193.gdf7a
