From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] vcs-svn: handle log message with embedded null bytes
Date: Thu, 24 Mar 2011 23:11:20 -0500
Message-ID: <20110325041120.GE3007@elie>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
 <20110325033431.GA3007@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 05:11:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2yN0-0005oJ-H1
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 05:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028Ab1CYEL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 00:11:26 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61658 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab1CYELZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 00:11:25 -0400
Received: by yxs7 with SMTP id 7so323745yxs.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 21:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lDKbqtuV0vVmnDHgPWYWh1ELCkX/8sDQoyEr/bc6YAM=;
        b=GWuoAiyQ2HHDapbM6qLX342G+HuLSZJIs6OE5t/rIPDHihsqSjKM27V2fFhpYVIF++
         T+qrmmym0Ln0kinb7S9wZHh17oBsKnbkDozx93KPPcJ8uKfgss26dd0UQEJl0Z+V3wxK
         2rDJNWf/wp8iXqKu/heS57chU7gC5lKc9SUnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=suORi4FTtj1L9RqloSGAHEIzyYFjtwq+M7pINYY2bQjAPPcPZ+IUkXGjw4qHIZt5WH
         S1SlInxpd2DF1o2surZN2/Wr1bFbwUDO6afWjVEKuI5CIkKorU+9c5Tm3xTu7nCxlUMc
         LhnACSHdrSESKesWCjr72NTPBghjQXuylvpMg=
Received: by 10.150.95.6 with SMTP id s6mr341055ybb.321.1301026284431;
        Thu, 24 Mar 2011 21:11:24 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.sbcglobal.net [68.255.102.141])
        by mx.google.com with ESMTPS id p59sm345388yhm.46.2011.03.24.21.11.22
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 21:11:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110325033431.GA3007@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169963>

Use fwrite instead of printf to write the log message to fast-import
so embedded ASCII NUL characters can be preserved.

Currently "git log" doesn't show the embedded NULs but "git cat-file
commit" can.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh     |   77 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/fast_export.c |   12 ++++---
 vcs-svn/fast_export.h |    9 +++--
 vcs-svn/repo_tree.c   |    5 ++-
 vcs-svn/repo_tree.h   |    4 +-
 vcs-svn/svndump.c     |    2 +-
 6 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 47f1e4f..be35139 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -397,6 +397,83 @@ test_expect_success 'null byte in property value' '
 	test_cmp expect.message actual.message
 '
 
+test_expect_success 'null bytes' '
+	# Caveat: svnadmin 1.6.16 (r1073529) truncates at \0 in the
+	# svn:specialQnotreally example.
+	reinit_git &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	greeting
+	OBJID
+	:000000 100644 OBJID OBJID A	greeting
+	EOF
+	printf "\n%s" "something with a null byte (Q)" >expect.message &&
+	printf "%s\n" "helQo" >expect.hello1 &&
+	printf "%s\n" "link hello" >expect.hello2 &&
+	{
+		properties svn:log "something with a null byte (Q)" &&
+		echo PROPS-END
+	} |
+	q_to_nul >props &&
+	{
+		q_to_nul <<-\EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: greeting
+		Node-kind: file
+		Node-action: add
+		Prop-content-length: 10
+		Text-content-length: 6
+		Content-length: 16
+
+		PROPS-END
+		helQo
+
+		Revision-number: 2
+		EOF
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props &&
+		q_to_nul <<-\EOF
+
+		Node-path: greeting
+		Node-kind: file
+		Node-action: change
+		Prop-content-length: 43
+		Text-content-length: 11
+		Content-length: 54
+
+		K 21
+		svn:specialQnotreally
+		V 1
+		*
+		PROPS-END
+		link hello
+		EOF
+	} >8bitclean.dump &&
+	test-svn-fe 8bitclean.dump >stream &&
+	git fast-import <stream &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	git cat-file commit HEAD | nul_to_q | sed -ne "/^\$/,\$ p" >actual.message &&
+	git cat-file blob HEAD^:greeting | nul_to_q >actual.hello1 &&
+	git cat-file blob HEAD:greeting | nul_to_q >actual.hello2 &&
+	test_cmp expect actual &&
+	test_cmp expect.message actual.message &&
+	test_cmp expect.hello1 actual.hello1 &&
+	test_cmp expect.hello2 actual.hello2
+'
+
 test_expect_success 'change file mode and reiterate content' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index a4d4d99..2e5bb67 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -31,12 +31,14 @@ void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
 }
 
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
-void fast_export_commit(uint32_t revision, const char *author, char *log,
+void fast_export_commit(uint32_t revision, const char *author,
+			const struct strbuf *log,
 			const char *uuid, const char *url,
 			unsigned long timestamp)
 {
+	static const struct strbuf empty = STRBUF_INIT;
 	if (!log)
-		log = "";
+		log = &empty;
 	if (*uuid && *url) {
 		snprintf(gitsvnline, MAX_GITSVN_LINE_LEN,
 				"\n\ngit-svn-id: %s@%"PRIu32" %s\n",
@@ -49,9 +51,9 @@ void fast_export_commit(uint32_t revision, const char *author, char *log,
 		   *author ? author : "nobody",
 		   *author ? author : "nobody",
 		   *uuid ? uuid : "local", timestamp);
-	printf("data %"PRIu32"\n%s%s\n",
-		   (uint32_t) (strlen(log) + strlen(gitsvnline)),
-		   log, gitsvnline);
+	printf("data %"PRIuMAX"\n", log->len + strlen(gitsvnline));
+	fwrite(log->buf, log->len, 1, stdout);
+	printf("%s\n", gitsvnline);
 	if (!first_commit_done) {
 		if (revision > 1)
 			printf("from refs/heads/master^0\n");
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 05cf97f..5878381 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -1,14 +1,15 @@
 #ifndef FAST_EXPORT_H_
 #define FAST_EXPORT_H_
 
-#include "line_buffer.h"
+struct line_buffer;
+struct strbuf;
 
 void fast_export_delete(uint32_t depth, uint32_t *path);
 void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
 			uint32_t mark);
-void fast_export_commit(uint32_t revision, const char *author, char *log,
-			const char *uuid, const char *url,
-			unsigned long timestamp);
+void fast_export_commit(uint32_t revision, const char *author,
+			const struct strbuf *log, const char *uuid,
+			const char *url, unsigned long timestamp);
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
 		      struct line_buffer *input);
 
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index d722e32..8caa015 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -278,8 +278,9 @@ void repo_diff(uint32_t r1, uint32_t r2)
 		    repo_commit_root_dir(commit_pointer(r2)));
 }
 
-void repo_commit(uint32_t revision, const char *author, char *log,
-		 const char *uuid, const char *url, unsigned long timestamp)
+void repo_commit(uint32_t revision, const char *author,
+		const struct strbuf *log, const char *uuid, const char *url,
+		unsigned long timestamp)
 {
 	fast_export_commit(revision, author, log, uuid, url, timestamp);
 	dent_commit();
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index a1b0e87..37bde2e 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -1,7 +1,7 @@
 #ifndef REPO_TREE_H_
 #define REPO_TREE_H_
 
-#include "git-compat-util.h"
+struct strbuf;
 
 #define REPO_MODE_DIR 0040000
 #define REPO_MODE_BLB 0100644
@@ -18,7 +18,7 @@ uint32_t repo_read_path(const uint32_t *path);
 uint32_t repo_read_mode(const uint32_t *path);
 void repo_delete(uint32_t *path);
 void repo_commit(uint32_t revision, const char *author,
-		char *log, const char *uuid, const char *url,
+		const struct strbuf *log, const char *uuid, const char *url,
 		long unsigned timestamp);
 void repo_diff(uint32_t r1, uint32_t r2);
 void repo_init(void);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 88ecef1..eef49ca 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -274,7 +274,7 @@ static void handle_revision(void)
 {
 	if (rev_ctx.revision)
 		repo_commit(rev_ctx.revision, rev_ctx.author.buf,
-			rev_ctx.log.buf, dump_ctx.uuid.buf, dump_ctx.url.buf,
+			&rev_ctx.log, dump_ctx.uuid.buf, dump_ctx.url.buf,
 			rev_ctx.timestamp);
 }
 
-- 
1.7.4.1
