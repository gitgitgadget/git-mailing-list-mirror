From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5.1 2/3] http-backend: Use http.getanyfile to disable dumb HTTP serving
Date: Wed,  4 Nov 2009 17:16:37 -0800
Message-ID: <1257383798-29826-2-git-send-email-spearce@spearce.org>
References: <1257383798-29826-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 02:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5qyD-0002AX-J1
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 02:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbZKEBQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 20:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755541AbZKEBQe
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 20:16:34 -0500
Received: from george.spearce.org ([209.20.77.23]:37446 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963AbZKEBQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 20:16:34 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9DF8CE0006; Thu,  5 Nov 2009 01:16:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E3BDC381FE
	for <git@vger.kernel.org>; Thu,  5 Nov 2009 01:16:38 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257383798-29826-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132183>

Some repository owners may wish to enable smart HTTP, but disallow
dumb content serving.  Disallowing dumb serving might be because
the owners want to rely upon reachability to control which objects
clients may access from the repository, or they just want to
encourage clients to use the more bandwidth efficient transport.

If http.getanyfile is set to false the backend CGI will return with
'403 Forbidden' when an object file is accessed by a dumb client.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-http-backend.txt |    8 ++++++++
 http-backend.c                     |   34 ++++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index f17251a..67aec06 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -29,6 +29,14 @@ SERVICES
 These services can be enabled/disabled using the per-repository
 configuration file:
 
+http.getanyfile::
+	This serves older Git clients which are unable to use the
+	upload pack service.  When enabled, clients are able to read
+	any file within the repository, including objects that are
+	no longer reachable from a branch but are still present.
+	It is enabled by default, but a repository can disable it
+	by setting this configuration item to `false`.
+
 http.uploadpack::
 	This serves 'git-fetch-pack' and 'git-ls-remote' clients.
 	It is enabled by default, but a repository can disable it
diff --git a/http-backend.c b/http-backend.c
index 7900cda..9021266 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -10,6 +10,7 @@
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
 static const char last_modified[] = "Last-Modified";
+static int getanyfile = 1;
 
 static struct string_list *query_params;
 
@@ -194,6 +195,12 @@ static NORETURN void forbidden(const char *err, ...)
 	exit(0);
 }
 
+static void select_getanyfile(void)
+{
+	if (!getanyfile)
+		forbidden("Unsupported service: getanyfile");
+}
+
 static void send_strbuf(const char *type, struct strbuf *buf)
 {
 	hdr_int(content_length, buf->len);
@@ -238,38 +245,51 @@ static void send_file(const char *the_type, const char *name)
 
 static void get_text_file(char *name)
 {
+	select_getanyfile();
 	hdr_nocache();
 	send_file("text/plain", name);
 }
 
 static void get_loose_object(char *name)
 {
+	select_getanyfile();
 	hdr_cache_forever();
 	send_file("application/x-git-loose-object", name);
 }
 
 static void get_pack_file(char *name)
 {
+	select_getanyfile();
 	hdr_cache_forever();
 	send_file("application/x-git-packed-objects", name);
 }
 
 static void get_idx_file(char *name)
 {
+	select_getanyfile();
 	hdr_cache_forever();
 	send_file("application/x-git-packed-objects-toc", name);
 }
 
 static int http_config(const char *var, const char *value, void *cb)
 {
-	struct rpc_service *svc = cb;
-
-	if (!prefixcmp(var, "http.") &&
-	    !strcmp(var + 5, svc->config_name)) {
-		svc->enabled = git_config_bool(var, value);
+	if (!strcmp(var, "http.getanyfile")) {
+		getanyfile = git_config_bool(var, value);
 		return 0;
 	}
 
+	if (!prefixcmp(var, "http.")) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
+			struct rpc_service *svc = &rpc_service[i];
+			if (!strcmp(var + 5, svc->config_name)) {
+				svc->enabled = git_config_bool(var, value);
+				return 0;
+			}
+		}
+	}
+
 	/* we are not interested in parsing any other configuration here */
 	return 0;
 }
@@ -293,7 +313,6 @@ static struct rpc_service *select_service(const char *name)
 	if (!svc)
 		forbidden("Unsupported service: '%s'", name);
 
-	git_config(http_config, svc);
 	if (svc->enabled < 0) {
 		const char *user = getenv("REMOTE_USER");
 		svc->enabled = (user && *user) ? 1 : 0;
@@ -442,6 +461,7 @@ static void get_info_refs(char *arg)
 		run_service(argv);
 
 	} else {
+		select_getanyfile();
 		for_each_ref(show_text_ref, &buf);
 		send_strbuf("text/plain", &buf);
 	}
@@ -455,6 +475,7 @@ static void get_info_packs(char *arg)
 	struct packed_git *p;
 	size_t cnt = 0;
 
+	select_getanyfile();
 	prepare_packed_git();
 	for (p = packed_git; p; p = p->next) {
 		if (p->pack_local)
@@ -621,6 +642,7 @@ int main(int argc, char **argv)
 	if (!enter_repo(dir, 0))
 		not_found("Not a git repository: '%s'", dir);
 
+	git_config(http_config, NULL);
 	cmd->imp(cmd_arg);
 	return 0;
 }
-- 
1.6.5.2.295.g0d105
