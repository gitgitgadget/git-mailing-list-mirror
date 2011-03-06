From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/12] vcs-svn: add a comment before each commit
Date: Sun, 6 Mar 2011 17:09:52 -0600
Message-ID: <20110306230951.GH24327@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 00:10:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwN5N-0008RI-MG
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab1CFXJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:09:57 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50720 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1CFXJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:09:56 -0500
Received: by mail-yw0-f46.google.com with SMTP id 3so1416737ywj.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3irDXvFHSsa2X8vMje4ilwvvczKoknQuuRJp1C+AlaA=;
        b=WvIiOOjJsLHALaiZ8Vj8Dd/Jr2BNL1JZgZdn1c8Rtcfie3dK0PZbX9yAMErU2bfSEm
         to15fDgHXf9PWoOM4ysfQS8Mu1UduMHOvDVwHyEUUwtxStxSJ+ptJ2Rz2Q2WIXTOE/m1
         zVnPfA//xAty/z/hmLabi7D7Xww9YVfUdANLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=W4nI5sPrz0vb33ouobVexguE9X5mb1frRo80smqQSCkx1OSwVZTsXCK9oFjn23kx2s
         gCbta9SIkNyMgTzH4s9iqsP7VgrliKRH34neAjvg1OzOjii7dj8kWSaGu6TLA5IX7zmK
         /43VFb0PfBPLN4OGbHZMB4MkQvsXVWCe4D+EY=
Received: by 10.150.100.18 with SMTP id x18mr3688912ybb.329.1299452996377;
        Sun, 06 Mar 2011 15:09:56 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.ameritech.net [69.209.66.207])
        by mx.google.com with ESMTPS id n56sm1299894yhn.7.2011.03.06.15.09.54
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:09:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168553>

Date: Tue, 4 Jan 2011 21:53:33 -0600

Current svn-fe produces output like this:

	blob
	mark :7382321
	data 5
	hello

	blob
	mark :7382322
	data 5
	Hello

	commit
	mark :3
[...]
	M 100644 :7382321 hello.c
	M 100644 :7382322 hello2.c

This means svn-fe has to keep track of the paths modified in each
commit and the corresponding marks, instead of dealing with each file
as it arrives in input and then forgetting about it.  A better
strategy would be to use inline blobs:

	commit
	mark :3
[...]
	M 100644 inline hello.c
	data 5
	hello
[...]

As a first step towards that, teach svn-fe to notice when the
collection of blobs for each commit starts and write a comment
("# commit 3.") there.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |    5 +++++
 vcs-svn/fast_export.h |    1 +
 vcs-svn/svndump.c     |   29 ++++++++++++++++++++++-------
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 932824a..5a105ad 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -30,6 +30,11 @@ void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
 	putchar('\n');
 }
 
+void fast_export_begin_commit(uint32_t revision)
+{
+	printf("# commit %"PRIu32".\n", revision);
+}
+
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
 void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 			uint32_t uuid, uint32_t url,
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 054e7d5..aff8005 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -6,6 +6,7 @@
 void fast_export_delete(uint32_t depth, uint32_t *path);
 void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
 			uint32_t mark);
+void fast_export_begin_commit(uint32_t revision);
 void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 			uint32_t uuid, uint32_t url, unsigned long timestamp);
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index e6d84ba..a384996 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -20,9 +20,11 @@
 #define NODEACT_CHANGE 1
 #define NODEACT_UNKNOWN 0
 
-#define DUMP_CTX 0
-#define REV_CTX  1
-#define NODE_CTX 2
+/* States: */
+#define DUMP_CTX 0	/* dump metadata */
+#define REV_CTX  1	/* revision metadata */
+#define NODE_CTX 2	/* node metadata */
+#define INTERNODE_CTX 3	/* between nodes */
 
 #define LENGTH_UNKNOWN (~0)
 #define DATE_RFC2822_LEN 31
@@ -267,7 +269,14 @@ static void handle_node(void)
 				 node_ctx.textLength, &input);
 }
 
-static void handle_revision(void)
+static void begin_revision(void)
+{
+	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
+		return;
+	fast_export_begin_commit(rev_ctx.revision);
+}
+
+static void end_revision(void)
 {
 	if (rev_ctx.revision)
 		repo_commit(rev_ctx.revision, rev_ctx.author, rev_ctx.log,
@@ -301,13 +310,17 @@ void svndump_read(const char *url)
 		} else if (key == keys.revision_number) {
 			if (active_ctx == NODE_CTX)
 				handle_node();
+			if (active_ctx == REV_CTX)
+				begin_revision();
 			if (active_ctx != DUMP_CTX)
-				handle_revision();
+				end_revision();
 			active_ctx = REV_CTX;
 			reset_rev_ctx(atoi(val));
 		} else if (key == keys.node_path) {
 			if (active_ctx == NODE_CTX)
 				handle_node();
+			if (active_ctx == REV_CTX)
+				begin_revision();
 			active_ctx = NODE_CTX;
 			reset_node_ctx(val);
 		} else if (key == keys.node_kind) {
@@ -349,7 +362,7 @@ void svndump_read(const char *url)
 				read_props();
 			} else if (active_ctx == NODE_CTX) {
 				handle_node();
-				active_ctx = REV_CTX;
+				active_ctx = INTERNODE_CTX;
 			} else {
 				fprintf(stderr, "Unexpected content length header: %"PRIu32"\n", len);
 				buffer_skip_bytes(&input, len);
@@ -358,8 +371,10 @@ void svndump_read(const char *url)
 	}
 	if (active_ctx == NODE_CTX)
 		handle_node();
+	if (active_ctx == REV_CTX)
+		begin_revision();
 	if (active_ctx != DUMP_CTX)
-		handle_revision();
+		end_revision();
 }
 
 int svndump_init(const char *filename)
-- 
1.7.4.1
