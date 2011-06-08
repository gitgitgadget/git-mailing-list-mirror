From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 19/19] transport-helper: implement marks location as capability
Date: Wed,  8 Jun 2011 20:48:50 +0200
Message-ID: <1307558930-16074-20-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpx-000098-3S
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab1FHSuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:50:24 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57207 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab1FHSt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:56 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so282684ewy.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=5gQMwHV7hqwy80UkNsI4lwrdT61oY3krtU6QD731UiA=;
        b=vTv1SAjS6bea6+LK+AYW5HP3cPNU40/3aXl8So21Ngrjl/9S71ChFdig4IL4wqIEgo
         PZIVST7RXjSM2H4tI2nM0OVvLwERlePbnxaCXfaA4+rEPjO3xLV2ez1XdMyXRi82H2ly
         wN9iz9JVOzfDxlE3/Z6OwQlZ2Uxb+uJXt/3ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oBSloSCj0PPNRgTBMQYAjG93L8c+rp635wi1fK+9hKyZ9d8RruExAc9VAW3kY+SsgV
         LmG7y9YgzL7W7Ng+RiVOw9HZiQePmONCZwBpG7KT5XL8kBaNRKaXhTDUiLXFf8pMfcb7
         rKFBlPO+ZUzGxdNvggMO3RUjUl5VzllRaaI38=
Received: by 10.213.16.199 with SMTP id p7mr421508eba.99.1307558995505;
        Wed, 08 Jun 2011 11:49:55 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175437>

While this requires the helper to flush stdout after listing 'gitdir'
as capability, and read a command (the 'gitdir' response from the
remote helper infrastructure) right after that, this is more elegant
and does not require an ad-hoc exchange of values.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Sanity check added as suggested by Jonathan during review.

 git-remote-testgit.py |   31 ++++++++++++++++++-------------
 transport-helper.c    |   47 ++++++++++++++++++-----------------------------
 2 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 88bcb20..d882fa3 100644
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
     repo.importer.do_import(repo.gitdir)
 
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
