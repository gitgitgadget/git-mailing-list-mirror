From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] vcs-svn: Refactor dump_export code into dispatch table
Date: Tue,  1 Feb 2011 19:56:43 +0530
Message-ID: <1296570403-9082-4-git-send-email-artagnon@gmail.com>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 01 15:26:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHBg-0007hB-36
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 15:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134Ab1BAO0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 09:26:20 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39810 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756979Ab1BAO0T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 09:26:19 -0500
Received: by gxk9 with SMTP id 9so2485461gxk.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 06:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=HNIfidhyiC286f1IXgWksvh8UABHSM+e7LnbrApytqI=;
        b=DGlvThHPF5Gc3/MDKQb5+O0Ronj6KwbYkiAmo/zqMvhbgiktHIKY/0mX0kBtOsHNSz
         xq9uQ1W/6nfEMop+oic1uCjrtCyRXdkjH+u+zJaH6w+g9ALRux/BzrZpi4miarLQJVwK
         /G71vnUBP6jkciGZRJypa6hUikK7IOL8CfQRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KR+LNKInGejB4OXYmaaub181fF9VspI/CVHm5iOg2pv4OaMevPMx/cKqwDKErTGfQn
         GyPM3V3bRXRn3B7xk8awQSAOrFfCf7xmpgFAOSkpL0l5QLeNcxeuO4mP7uRHW6lBSwq5
         Sjq+ZDZ9J7ENLxQqmT5nynP9L/Vs/hId9f3NI=
Received: by 10.151.153.4 with SMTP id f4mr9640562ybo.289.1296570378438;
        Tue, 01 Feb 2011 06:26:18 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id i36sm1494275yhd.27.2011.02.01.06.26.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 06:26:17 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165807>

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/dump_export.c |   89 +++++++++++++++++++++++++------------------------
 vcs-svn/dump_export.h |    6 ++-
 2 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/vcs-svn/dump_export.c b/vcs-svn/dump_export.c
index 2b23f77..a8331fd 100644
--- a/vcs-svn/dump_export.c
+++ b/vcs-svn/dump_export.c
@@ -11,6 +11,48 @@
 
 static struct strbuf props;
 
+typedef void state_fn(void);
+
+static void Kfile   (void) { printf("Node-kind: file\n"); }
+static void Kdir    (void) { printf("Node-kind: dir\n"); }
+static void Achange (void) { printf("Node-action: change\n"); }
+static void Aadd    (void) { printf("Node-action: add\n"); }
+static void Adelete (void) { printf("Node-action: delete\n"); }
+static void Areplace(void) { printf("Node-action: replace\n"); }
+static void Pexec   (void) { strbuf_addf(&props, "K 14\nsvn:executable\nV 1\n*\n"); }
+static void Psym    (void) { strbuf_addf(&props, "K 11\nsvn:special\nV 1\n*\n"); }
+static void Pend    (void) { strbuf_add(&props, "PROPS-END\n", 10); }
+
+static void Nchange (void) { Kfile(); Achange(); }
+static void Nadd    (void) { Kfile(); Aadd(); }
+static void Nreplace(void) { Kfile(); Areplace(); }
+static void Echange (void) { Pexec(); Pend(); Kfile(); Achange(); }
+static void Eadd    (void) { Pexec(); Pend(); Kfile(); Aadd(); }
+static void Ereplace(void) { Pexec(); Pend(); Kfile(); Areplace(); }
+static void Schange (void) { Psym(); Pend(); Kfile(); Achange(); }
+static void Sadd    (void) { Psym(); Pend(); Kfile(); Aadd(); }
+static void Sreplace(void) { Psym(); Pend(); Kfile(); Areplace(); }
+static void Dchange (void) { Kdir(); Achange(); }
+static void Dadd    (void) { Kdir(); Aadd(); }
+static void Dreplace(void) { Kdir(); Areplace(); }
+
+static state_fn *const dispatch_table[NODE_KIND_COUNT][NODE_ACTION_COUNT] = {
+	/* NODE_KIND_UNKNOWN */
+	{abort, abort, abort, Adelete, abort},
+	/* NODE_KIND_NORMAL */
+	{abort, Nchange, Nadd, Adelete, Nreplace},
+	/* NODE_KIND_EXECUTABLE */
+	{abort, Echange, Eadd, Adelete, Ereplace},
+	/* NODE_KIND_SYMLINK */
+	{abort, Schange, Sadd, Adelete, Sreplace},
+	/* NODE_KIND_GITLINK */
+	{abort, abort, abort, abort, abort},
+	/* NODE_KIND_DIR */
+	{abort, Dchange, Dadd, Adelete, Dreplace},
+	/* NODE_KIND_SUBDIR */
+	{abort, abort, abort, abort, abort}
+};
+
 void dump_export_begin_rev(int revision, const char *revprops,
 			int prop_len)
 {
@@ -24,56 +66,15 @@ void dump_export_node(const char *path, enum node_kind kind,
 		enum node_action action, unsigned long text_len,
 		unsigned long copyfrom_rev, const char *copyfrom_path)
 {
-	int dump_props = 1; /* Boolean */
 	strbuf_reset(&props);
 	printf("Node-path: %s\n", path);
-	switch (kind) {
-	case NODE_KIND_NORMAL:
-		printf("Node-kind: file\n");
-		break;
-	case NODE_KIND_EXECUTABLE:
-		printf("Node-kind: file\n");
-		strbuf_addf(&props, "K 14\nsvn:executable\nV 1\n*\n");
-		break;
-	case NODE_KIND_SYMLINK:
-		printf("Node-kind: file\n");
-		strbuf_addf(&props, "K 11\nsvn:special\nV 1\n*\n");
-		break;
-	case NODE_KIND_GITLINK:
-		printf("Node-kind: file\n");
-		break;
-	case NODE_KIND_DIR:
-		printf("Node-kind: dir\n");
-		break;
-	case NODE_KIND_SUBDIR:
-		die("Unsupported: subdirectory");
-	default:
-		break;
-	}
-	strbuf_add(&props, "PROPS-END\n", 10);
+	dispatch_table[kind][action]();
 
-	switch (action) {
-	case NODE_ACTION_CHANGE:
-		printf("Node-action: change\n");
-		break;
-	case NODE_ACTION_ADD:
-		printf("Node-action: add\n");
-		break;
-	case NODE_ACTION_REPLACE:
-		printf("Node-action: replace\n");
-		break;
-	case NODE_ACTION_DELETE:
-		printf("Node-action: delete\n");
-		dump_props = 0;
-		break;
-	default:
-		break;
-	}
 	if (copyfrom_rev != SVN_INVALID_REV) {
 		printf("Node-copyfrom-rev: %lu\n", copyfrom_rev);
 		printf("Node-copyfrom-path: %s\n", copyfrom_path);
 	}
-	if (dump_props) {
+	if (props.len) {
 		printf("Prop-delta: false\n");
 		printf("Prop-content-length: %lu\n", props.len);
 	}
@@ -81,7 +82,7 @@ void dump_export_node(const char *path, enum node_kind kind,
 		printf("Text-delta: false\n");		
 		printf("Text-content-length: %lu\n", text_len);
 	}
-	if (text_len || dump_props) {
+	if (text_len || props.len) {
 		printf("Content-length: %lu\n\n", text_len + props.len);
 		printf("%s", props.buf);
 	}
diff --git a/vcs-svn/dump_export.h b/vcs-svn/dump_export.h
index e9f51a3..8265170 100644
--- a/vcs-svn/dump_export.h
+++ b/vcs-svn/dump_export.h
@@ -9,7 +9,8 @@ enum node_action {
 	NODE_ACTION_CHANGE,
 	NODE_ACTION_ADD,
 	NODE_ACTION_DELETE,
-	NODE_ACTION_REPLACE
+	NODE_ACTION_REPLACE,
+	NODE_ACTION_COUNT
 };
 
 enum node_kind {
@@ -19,7 +20,8 @@ enum node_kind {
 	NODE_KIND_SYMLINK,
 	NODE_KIND_GITLINK,
 	NODE_KIND_DIR,           /* SVN-specific */
-	NODE_KIND_SUBDIR
+	NODE_KIND_SUBDIR,
+	NODE_KIND_COUNT
 };
 
 void dump_export_begin_rev(int revision, const char *revprops, int prop_len);
-- 
1.7.4.rc1.7.g2cf08.dirty
