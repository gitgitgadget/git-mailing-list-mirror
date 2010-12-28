From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] vcs-svn: improve reporting of input errors
Date: Tue, 28 Dec 2010 04:54:10 -0600
Message-ID: <20101228105410.GD13360@burratino>
References: <20101228104503.GA5422@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 11:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXXCR-0004gQ-Nb
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 11:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab0L1Kyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 05:54:35 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55473 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab0L1Kye (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 05:54:34 -0500
Received: by ywl5 with SMTP id 5so3829189ywl.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 02:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dNWULkVnco9hrJjjWjM49lXGWh09uCGfrXlz+iW+40s=;
        b=x095DMF0A7QIWTydAW6KakSlYE+J3fFY/mORtSIixh50N/qXou+dGQ1qduiQEE3Vc9
         kCTxZ/cyF7jKSr1BY5dusHSt3oTPJOVUAKIf8g6eSKxalyHGjpWpHQOtcYUD5TmuyGuF
         +qdC0u43GbssClS7YiSGgaQrFd7cLTw89DajA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=b2roCevK7i6Q5fudzusur9GRn4aNm7BxzuY8TUBOng3UnwofHYGSmBS8yY1ZFW3s70
         IYs3TlXxaYiLac5SJhRGu/N2F7z1HMMqVjmiH6kNAPGss3oD7kQVUS4S4Knf9Py18eQk
         2xtXtItGNvVSR5zitp5DQKBZH3kYYNObafsrY=
Received: by 10.150.50.16 with SMTP id x16mr17899955ybx.308.1293533672356;
        Tue, 28 Dec 2010 02:54:32 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id u3sm12537727yba.16.2010.12.28.02.54.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 02:54:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101228104503.GA5422@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164238>

Catch input errors and exit early enough to print a reasonable
diagnosis based on errno.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Patches 1 and 2 first appeared in the svndiff0 series[1] (and that
is the application I have in mind in sending them now).

This patch #4 is just a demo.  Untested, I'm afraid.  I would be
very interested in ideas for automatically testing it --- how to
easily stimulate error paths?

Good night,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/158731

 vcs-svn/fast_export.c |   13 ++++++++++-
 vcs-svn/svndump.c     |   53 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 256a052..dc0ae4e 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -62,14 +62,23 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 	printf("progress Imported commit %d.\n\n", revision);
 }
 
+static void die_short_read(void)
+{
+	if (buffer_ferror())
+		die_errno("error reading dump file");
+	die("invalid dump: unexpected end of file");
+}
+
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len)
 {
 	if (mode == REPO_MODE_LNK) {
 		/* svn symlink blobs start with "link " */
-		buffer_skip_bytes(5);
 		len -= 5;
+		if (buffer_skip_bytes(5) != 5)
+			die_short_read();
 	}
 	printf("blob\nmark :%d\ndata %d\n", mark, len);
-	buffer_copy_bytes(len);
+	if (buffer_copy_bytes(len) != len)
+		die_short_read();
 	fputc('\n', stdout);
 }
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 630eeb5..09bcebd 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -107,20 +107,37 @@ static void init_keys(void)
 	keys.content_length = pool_intern("Content-length");
 }
 
+static void die_short_read(void)
+{
+	if (buffer_ferror())
+		die_errno("error reading dump file");
+	die("invalid dump: unexpected end of file");
+}
+
 static void read_props(void)
 {
 	uint32_t len;
 	uint32_t key = ~0;
 	char *val = NULL;
-	char *t;
-	while ((t = buffer_read_line()) && strcmp(t, "PROPS-END")) {
+	for (;;) {
+		char *t = buffer_read_line();
+		if (!t)
+			die_short_read();
+		if (!strcmp(t, "PROPS-END"))
+			return;
 		if (!strncmp(t, "K ", 2)) {
 			len = atoi(&t[2]);
-			key = pool_intern(buffer_read_string(len));
-			buffer_read_line();
+			t = buffer_read_line();
+			if (!t)
+				die_short_read();
+			if (strlen(t) != len)
+				die("invalid dump: incorrect key length");
+			key = pool_intern(t);
 		} else if (!strncmp(t, "V ", 2)) {
 			len = atoi(&t[2]);
 			val = buffer_read_string(len);
+			if (!t)
+				die_short_read();
 			if (key == keys.svn_log) {
 				/* Value length excludes terminating nul. */
 				rev_ctx.log = log_copy(len + 1, val);
@@ -135,7 +152,11 @@ static void read_props(void)
 				node_ctx.type = REPO_MODE_LNK;
 			}
 			key = ~0;
-			buffer_read_line();
+			t = buffer_read_line();
+			if (!t)
+				die_short_read();
+			if (*t)
+				die("invalid dump: incorrect value length");
 		}
 	}
 }
@@ -176,10 +197,12 @@ static void handle_node(void)
 	if (node_ctx.propLength == LENGTH_UNKNOWN && node_ctx.srcMode)
 		node_ctx.type = node_ctx.srcMode;
 
-	if (node_ctx.mark)
+	if (node_ctx.mark) {
 		fast_export_blob(node_ctx.type, node_ctx.mark, node_ctx.textLength);
-	else if (node_ctx.textLength != LENGTH_UNKNOWN)
-		buffer_skip_bytes(node_ctx.textLength);
+	} else if (node_ctx.textLength != LENGTH_UNKNOWN) {
+		if (buffer_skip_bytes(node_ctx.textLength) != node_ctx.textLength)
+			die_short_read();
+	}
 }
 
 static void handle_revision(void)
@@ -250,7 +273,11 @@ void svndump_read(const char *url)
 			node_ctx.propLength = atoi(val);
 		} else if (key == keys.content_length) {
 			len = atoi(val);
-			buffer_read_line();
+			t = buffer_read_line();
+			if (!t)
+				die_short_read();
+			if (*t)
+				die("invalid dump: expected blank line after content length header");
 			if (active_ctx == REV_CTX) {
 				read_props();
 			} else if (active_ctx == NODE_CTX) {
@@ -258,10 +285,13 @@ void svndump_read(const char *url)
 				active_ctx = REV_CTX;
 			} else {
 				fprintf(stderr, "Unexpected content length header: %d\n", len);
-				buffer_skip_bytes(len);
+				if (buffer_skip_bytes(len) != len)
+					die_short_read();
 			}
 		}
 	}
+	if (buffer_ferror())
+		die_short_read();
 	if (active_ctx == NODE_CTX)
 		handle_node();
 	if (active_ctx != DUMP_CTX)
@@ -270,7 +300,8 @@ void svndump_read(const char *url)
 
 void svndump_init(const char *filename)
 {
-	buffer_init(filename);
+	if (buffer_init(filename))
+		die_errno("cannot open dump file: %s", filename);
 	repo_init();
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
-- 
1.7.2.3.554.gc9b5c.dirty
