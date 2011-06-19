From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 20/20] transport-helper: implement marks location as capability
Date: Sun, 19 Jun 2011 17:18:45 +0200
Message-ID: <1308496725-22329-21-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJnr-0004DI-Kt
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416Ab1FSPUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:20:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43954 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab1FSPUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:20:16 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981189ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=QZD2n/jipfHM0j3sUxIkIqSfktXWbAGQdqTGMHWGM9c=;
        b=uOtDMsaW1FUCOsY6kV9AtPs4C35Y9PrOFtboozIm89mupJnwuZAi2jTg91ps7GElD9
         aZhFm8IaOynX+aeAu3cYo4Ni/fm2QnZto6l7N4juLm1dVIu9Jektq3v8kqwekp1PgUre
         8A5Gbei63h1AHiRihHFnI+YHEYsqFKS+UuLV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x3xEDynFKUnDQd0WH1cz6t+SKuZqNWDJ/e6AyIS4wSEbSzewKjgBNFL8PUP2f465I7
         4myejJbL4FbUrXMcDxY1TstXeqSflRZ4kHbaLcUihRDchs93rhZNDfrhmNnZ2aLv6T3o
         29VwfOqGPWCy1i+B1xIP7plWyoJkh/jpaKMBw=
Received: by 10.14.96.78 with SMTP id q54mr1583090eef.157.1308496815014;
        Sun, 19 Jun 2011 08:20:15 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.20.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:20:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176022>

While this requires the helper to flush stdout after listing 'gitdir'
as capability, and read a command (the 'gitdir' response from the
remote helper infrastructure) right after that, this is more elegant
and does not require an ad-hoc exchange of values.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 git-remote-testgit.py |   31 ++++++++++++++++++-------------
 transport-helper.c    |   47 ++++++++++++++++++-----------------------------
 2 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 4939853..30f775e 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -71,8 +71,26 @@ def do_capabilities(repo, args):
     print "import"
     print "export"
     print "gitdir"
+
+    sys.stdout.flush()
+    if not read_one_line(repo):
+        die("Expected gitdir, got empty line")
+    if not repo.gitdir:
+        die("Expected gitdir, got something else")
+
     print "refspec refs/heads/*:%s*" % repo.prefix
 
+    dirname = repo.get_base_path(repo.gitdir)
+
+    if not os.path.exists(dirname):
+        os.makedirs(dirname)
+
+    path = os.path.join(dirname, 'testgit.marks')
+
+    print "*export-marks %s" % path
+    if os.path.exists(path):
+        print "*import-marks %s" % path
+
     print # end capabilities
 
 
@@ -142,19 +160,6 @@ def do_export(repo, args):
     if not repo.gitdir:
         die("Need gitdir to export")
 
-    dirname = repo.get_base_path(repo.gitdir)
-
-    if not os.path.exists(dirname):
-        os.makedirs(dirname)
-
-    path = os.path.join(dirname, 'testgit.marks')
-    print path
-    if os.path.exists(path):
-        print path
-    else:
-        print ""
-    sys.stdout.flush()
-
     update_local_repo(repo)
     changed = repo.importer.do_import(repo.gitdir)
 
diff --git a/transport-helper.c b/transport-helper.c
index ddf0ffa..12f08a1 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -23,6 +23,8 @@ struct helper_data {
 		push : 1,
 		connect : 1,
 		no_disconnect_req : 1;
+	char *export_marks;
+	char *import_marks;
 	/* These go from remote name (as in "list") to private name */
 	struct refspec *refspecs;
 	int refspec_nr;
@@ -179,6 +181,16 @@ static struct child_process *get_helper(struct transport *transport)
 			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());
 			sendline(data, &gitdir);
 			strbuf_release(&gitdir);
+		} else if (!prefixcmp(capname, "export-marks ")) {
+			struct strbuf arg = STRBUF_INIT;
+			strbuf_addstr(&arg, "--export-marks=");
+			strbuf_addstr(&arg, capname + strlen("export-marks "));
+			data->export_marks = strbuf_detach(&arg, NULL);
+		} else if (!prefixcmp(capname, "import-marks")) {
+			struct strbuf arg = STRBUF_INIT;
+			strbuf_addstr(&arg, "--import-marks=");
+			strbuf_addstr(&arg, capname + strlen("import-marks "));
+			data->import_marks = strbuf_detach(&arg, NULL);
 		} else if (mandatory) {
 			die("Unknown mandatory capability %s. This remote "
 			    "helper probably needs newer version of Git.\n",
@@ -364,10 +376,9 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 
 static int get_exporter(struct transport *transport,
 			struct child_process *fastexport,
-			const char *export_marks,
-			const char *import_marks,
 			struct string_list *revlist_args)
 {
+	struct helper_data *data = transport->data;
 	struct child_process *helper = get_helper(transport);
 	int argc = 0, i;
 	memset(fastexport, 0, sizeof(*fastexport));
@@ -378,10 +389,10 @@ static int get_exporter(struct transport *transport,
 	fastexport->argv = xcalloc(5 + revlist_args->nr, sizeof(*fastexport->argv));
 	fastexport->argv[argc++] = "fast-export";
 	fastexport->argv[argc++] = "--use-done-feature";
-	if (export_marks)
-		fastexport->argv[argc++] = export_marks;
-	if (import_marks)
-		fastexport->argv[argc++] = import_marks;
+	if (data->export_marks)
+		fastexport->argv[argc++] = data->export_marks;
+	if (data->import_marks)
+		fastexport->argv[argc++] = data->import_marks;
 
 	for (i = 0; i < revlist_args->nr; i++)
 		fastexport->argv[argc++] = revlist_args->items[i].string;
@@ -710,7 +721,6 @@ static int push_refs_with_export(struct transport *transport,
 	struct ref *ref;
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
-	char *export_marks = NULL, *import_marks = NULL;
 	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
 	struct strbuf buf = STRBUF_INIT;
 
@@ -718,26 +728,6 @@ static int push_refs_with_export(struct transport *transport,
 
 	write_constant(helper->in, "export\n");
 
-	recvline(data, &buf);
-	if (debug)
-		fprintf(stderr, "Debug: Got export_marks '%s'\n", buf.buf);
-	if (buf.len) {
-		struct strbuf arg = STRBUF_INIT;
-		strbuf_addstr(&arg, "--export-marks=");
-		strbuf_addbuf(&arg, &buf);
-		export_marks = strbuf_detach(&arg, NULL);
-	}
-
-	recvline(data, &buf);
-	if (debug)
-		fprintf(stderr, "Debug: Got import_marks '%s'\n", buf.buf);
-	if (buf.len) {
-		struct strbuf arg = STRBUF_INIT;
-		strbuf_addstr(&arg, "--import-marks=");
-		strbuf_addbuf(&arg, &buf);
-		import_marks = strbuf_detach(&arg, NULL);
-	}
-
 	strbuf_reset(&buf);
 
 	for (ref = remote_refs; ref; ref = ref->next) {
@@ -758,8 +748,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	}
 
-	if (get_exporter(transport, &exporter,
-			 export_marks, import_marks, &revlist_args))
+	if (get_exporter(transport, &exporter, &revlist_args))
 		die("Couldn't run fast-export");
 
 	if (finish_command(&exporter))
-- 
1.7.5.1.292.g728120
