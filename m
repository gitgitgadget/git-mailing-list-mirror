From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCHv2 2/2] Support virtual repositories in smart http-backend, specified by environment
Date: Tue, 24 May 2011 14:54:26 -0700
Message-ID: <1306274066-4092-2-git-send-email-jamey@minilop.net>
References: <1306274066-4092-1-git-send-email-jamey@minilop.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 23:55:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOzZ6-0003BI-OL
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 23:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939Ab1EXVyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 17:54:54 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57438 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251Ab1EXVyw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 17:54:52 -0400
Received: by pvg12 with SMTP id 12so3154759pvg.19
        for <git@vger.kernel.org>; Tue, 24 May 2011 14:54:52 -0700 (PDT)
Received: by 10.68.21.164 with SMTP id w4mr3167578pbe.268.1306274092178;
        Tue, 24 May 2011 14:54:52 -0700 (PDT)
Received: from oh.minilop.net (host-247-13.pubnet.pdx.edu [131.252.247.13])
        by mx.google.com with ESMTPS id f1sm5244932pbm.93.2011.05.24.14.54.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2011 14:54:51 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QOzYw-00014v-Kd; Tue, 24 May 2011 14:54:50 -0700
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1306274066-4092-1-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174350>

Translate the GIT_REF_PREFIX and GIT_HEAD environment variables to the
--ref-prefix= and --head= options to upload-pack and receive-pack.

Add documentation, including a sample Apache configuration snippet.

Commit by Josh Triplett and Jamey Sharp.
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
Cc: Shawn O. Pearce <spearce@spearce.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
---
v2: add patch 2/2 for git-http-backend.

 Documentation/git-http-backend.txt |   14 ++++++++++++
 http-backend.c                     |   39 +++++++++++++++++++++++++++++------
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 277d9e1..4e0b243 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -119,6 +119,14 @@ ScriptAliasMatch \
 
 ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
++
+To serve multiple virtual repositories from a single storage
+repository:
++
+----------------------------------------------------------------
+SetEnvIf Request_URI "^/git/([^/]*)" GIT_REF_PREFIX=$1/ GIT_HEAD=$1-HEAD
+ScriptAliasMatch ^/git/[^/]*(.*) /usr/libexec/git-core/git-http-backend/storage.git$1
+----------------------------------------------------------------
 
 Accelerated static Apache 2.x::
 	Similar to the above, but Apache can be used to return static
@@ -167,6 +175,12 @@ The GIT_HTTP_EXPORT_ALL environmental variable may be passed to
 'git-http-backend' to bypass the check for the "git-daemon-export-ok"
 file in each repository before allowing export of that repository.
 
+The GIT_REF_PREFIX and GIT_HEAD environment variables allow
+http-backend to support multiple virtual repositories within a single
+storage repository.  If set, 'git http-backend' will operate on
+'refs/${GIT_REF_PREFIX}' rather than 'refs/', and '$GIT_HEAD' rather
+than HEAD.
+
 The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
 GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
 ensuring that any reflogs created by 'git-receive-pack' contain some
diff --git a/http-backend.c b/http-backend.c
index 8501504..3d9e3b1 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -315,16 +315,23 @@ done:
 	close(out);
 }
 
-static void run_service(const char **argv)
+#define RUN_SERVICE_LAST_EXTRA_ARG 2
+#define RUN_SERVICE_EXTRA_ARGS NULL, NULL, NULL
+
+static void run_service(const char *argv0, const char **argv)
 {
 	const char *encoding = getenv("HTTP_CONTENT_ENCODING");
 	const char *user = getenv("REMOTE_USER");
 	const char *host = getenv("REMOTE_ADDR");
+	char *ref_prefix = getenv("GIT_REF_PREFIX");
+	char *head = getenv("GIT_HEAD");
 	char *env[3];
 	struct strbuf buf = STRBUF_INIT;
 	int gzipped_request = 0;
 	struct child_process cld;
 
+	argv += RUN_SERVICE_LAST_EXTRA_ARG;
+
 	if (encoding && !strcmp(encoding, "gzip"))
 		gzipped_request = 1;
 	else if (encoding && !strcmp(encoding, "x-gzip"))
@@ -343,6 +350,24 @@ static void run_service(const char **argv)
 	env[1] = strbuf_detach(&buf, NULL);
 	env[2] = NULL;
 
+	if (ref_prefix && !*ref_prefix)
+		ref_prefix = NULL;
+	if (ref_prefix) {
+		strbuf_addf(&buf, "--ref-prefix=%s", ref_prefix);
+		ref_prefix = strbuf_detach(&buf, NULL);
+		*argv-- = ref_prefix;
+	}
+
+	if (head && !*head)
+		head = NULL;
+	if (head) {
+		strbuf_addf(&buf, "--head=%s", head);
+		head = strbuf_detach(&buf, NULL);
+		*argv-- = head;
+	}
+
+	*argv = argv0;
+
 	memset(&cld, 0, sizeof(cld));
 	cld.argv = argv;
 	cld.env = (const char *const *)env;
@@ -362,6 +387,8 @@ static void run_service(const char **argv)
 		exit(1);
 	free(env[0]);
 	free(env[1]);
+	free(ref_prefix);
+	free(head);
 	strbuf_release(&buf);
 }
 
@@ -391,7 +418,7 @@ static void get_info_refs(char *arg)
 	hdr_nocache();
 
 	if (service_name) {
-		const char *argv[] = {NULL /* service name */,
+		const char *argv[] = {RUN_SERVICE_EXTRA_ARGS,
 			"--stateless-rpc", "--advertise-refs",
 			".", NULL};
 		struct rpc_service *svc = select_service(service_name);
@@ -404,8 +431,7 @@ static void get_info_refs(char *arg)
 		packet_write(1, "# service=git-%s\n", svc->name);
 		packet_flush(1);
 
-		argv[0] = svc->name;
-		run_service(argv);
+		run_service(svc->name, argv);
 
 	} else {
 		select_getanyfile();
@@ -462,7 +488,7 @@ static void check_content_type(const char *accepted_type)
 
 static void service_rpc(char *service_name)
 {
-	const char *argv[] = {NULL, "--stateless-rpc", ".", NULL};
+	const char *argv[] = {RUN_SERVICE_EXTRA_ARGS, "--stateless-rpc", ".", NULL};
 	struct rpc_service *svc = select_service(service_name);
 	struct strbuf buf = STRBUF_INIT;
 
@@ -478,8 +504,7 @@ static void service_rpc(char *service_name)
 
 	end_headers();
 
-	argv[0] = svc->name;
-	run_service(argv);
+	run_service(svc->name, argv);
 	strbuf_release(&buf);
 }
 
-- 
1.7.5.1
