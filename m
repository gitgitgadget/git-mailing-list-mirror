From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 20/23] transport-helper: implement marks location as capability
Date: Sat, 16 Jul 2011 15:03:40 +0200
Message-ID: <1310821424-4750-21-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4YY-0005RE-2Y
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab1GPNFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:05:07 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57335 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855Ab1GPNFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:05:03 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996062ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CuqGHDHHLUFLX+A16MapJTMIWj1Q8JcysHtwQa/7zM8=;
        b=qBA+OXbwhDm/pi5kxVeWCZswfjwiK6XDMbukS3E9OohaeZHgLc/l+57kU8LmqLWFgh
         hbf4lSmzKd7W9W5ywZqd0aBZZU6JxIwSd9QjgD31gdO4+6fVn207VD0/60xSWb+k1eo3
         q3VnciM9LpfTBQJ63m491qR2rR1Ru3jIWRKmg=
Received: by 10.14.98.142 with SMTP id v14mr1451324eef.4.1310821502563;
        Sat, 16 Jul 2011 06:05:02 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.05.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:05:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177265>

Now that the gitdir location is exported as an environment variable
this can be implemented elegantly without requiring any explicit
flushes nor an ad-hoc exchange of values.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 git-remote-testgit.py |   24 +++++++++++-------------
 transport-helper.c    |   47 ++++++++++++++++++-----------------------------
 2 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 1ed7a56..e9c832b 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -72,6 +72,17 @@ def do_capabilities(repo, args):
     print "export"
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
 
 
@@ -147,19 +158,6 @@ def do_export(repo, args):
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
index 0cfc9ae..74c3122 100644
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
@@ -184,6 +186,16 @@ static struct child_process *get_helper(struct transport *transport)
 			refspecs[refspec_nr++] = strdup(capname + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
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
@@ -369,10 +381,9 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 
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
@@ -383,10 +394,10 @@ static int get_exporter(struct transport *transport,
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
@@ -713,7 +724,6 @@ static int push_refs_with_export(struct transport *transport,
 	struct ref *ref;
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
-	char *export_marks = NULL, *import_marks = NULL;
 	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
 	struct strbuf buf = STRBUF_INIT;
 
@@ -721,26 +731,6 @@ static int push_refs_with_export(struct transport *transport,
 
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
@@ -761,8 +751,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	}
 
-	if (get_exporter(transport, &exporter,
-			 export_marks, import_marks, &revlist_args))
+	if (get_exporter(transport, &exporter, &revlist_args))
 		die("Couldn't run fast-export");
 
 	if (finish_command(&exporter))
-- 
1.7.5.1.292.g728120
