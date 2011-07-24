From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 06/11] vcs-svn: move commit parameters logic to
 svndump.c
Date: Sun, 24 Jul 2011 15:58:11 +0200
Message-ID: <20110724135811.GG2934@elie.dc0b.debconf.org>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-7-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 15:59:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkzD3-0008I9-DQ
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 15:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784Ab1GXN6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 09:58:38 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:56970 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab1GXN6g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 09:58:36 -0400
Received: by fxd18 with SMTP id 18so7622446fxd.11
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LxFJWAbXxw95QSTCW3mJnlh9xeWQP1D4iadwFTRhbwU=;
        b=bX9TAE26F7pJiQAm91nGQbsVvj3ovZPzyXPhfVDmhyXcTcunY4rda6wIyjNrYCv15i
         H/oHWV7sK1V0K8h4sESY3e/EKiCZmuvhWNiw9TGREZMTm3S8VSuUqgHSCHes8xnGpSIK
         pfUhQHGssQgmPAb2V3eXfEDHX7/uWPcPg9/z0=
Received: by 10.223.28.65 with SMTP id l1mr5265320fac.136.1311515914922;
        Sun, 24 Jul 2011 06:58:34 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id r12sm3217748fam.0.2011.07.24.06.58.25
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 06:58:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310559673-5026-7-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177750>

Dmitry Ivankov wrote:

> fast_export.c had logic to set up commit ref, author name, email,
> parent commit, import mark and git-svn-id: line based on both it's
> own state (current import batch history) and the arguments passed.
>
> Lift the decision on these parameters to the caller.

Again I find myself getting lost.  I think this is another internal
API change, with the intent being to make the fast_export lib more
intuitive by making it focus on communicating with fast-import and the
delta applier instead of taking care of so much svn-fe-specific logic.
In other words, the idea would be to avoid a few layering violations.
Is that right?

If so:

> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -13,9 +13,6 @@
[...]
> -static uint32_t first_commit_done;

This is a good change.

[...]
> @@ -73,42 +69,30 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
>  	putchar('\n');
>  }
>  
> -static char gitsvnline[MAX_GITSVN_LINE_LEN];
> -void fast_export_begin_commit(uint32_t revision, const char *author,
> -			const struct strbuf *log,
> -			const char *uuid, const char *url,
> -			unsigned long timestamp)
> +void fast_export_begin_commit(uint32_t set_mark, const char *committer_name,
> +			const char *committer_login, const char *committer_domain,
> +			const struct strbuf *log, const char *gitsvnline,
> +			unsigned long timestamp, uint32_t from_mark,
> +			const char *dst_ref)

The argument list is getting scary.

[...]
>  void fast_export_end_commit(uint32_t revision)
>  {
> -	printf("progress Imported commit %"PRIu32".\n\n", revision);
>  }

This change leaves fast_export_end_commit empty.  Why not remove
it?  (Later patches that want to insert code there could reintroduce
the function.)

[...]
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -37,6 +37,8 @@
>  #define LENGTH_UNKNOWN (~0)
>  #define DATE_RFC2822_LEN 31
>  
> +#define MAX_GITSVN_LINE_LEN 4096
> +
>  static struct line_buffer input = LINE_BUFFER_INIT;
>  
>  static struct {
> @@ -54,6 +56,7 @@ static struct {
>  static struct {
>  	uint32_t version;
>  	struct strbuf uuid, url;
> +	int first_commit_done;

Sneaky: changing the type from uint32_t to int.  Good. :)

[...]
> @@ -299,19 +303,37 @@ static void handle_node(void)
[...]
> +	fast_export_begin_commit(rev_ctx.revision, author, author, domain,
> +		&rev_ctx.log, gitsvnline, rev_ctx.timestamp,
> +		from_mark);

This doesn't compile for me (missing "ref" argument).

>  }
>  
>  static void end_revision(void)
>  {
> -	if (rev_ctx.revision)
> +	if (rev_ctx.revision) {
>  		fast_export_end_commit(rev_ctx.revision);
> +		printf("progress Imported commit %"PRIu32".\n\n", rev_ctx.revision);

Until now, svndump.c did not have to know about the fast-import
format (e.g., the existence of a "progress" command).  Is that
worth changing?

Quick sketch with suggestions.  What do you think?

-- >8 --
Subject: squash! vcs-svn: move commit parameters logic to svndump.c

The previous commit doesn't build because we forgot to pass the new
ref name argument to the fast_export API.  While fixing that, simplify
fast_export_begin_commit to be more intuitive by using a set of
parameters closer to what gets written to fast-import.

The actual impact of this patch would be to run a little slower, since
we needlessly copy the author name into a temporary buffer for an
email address.  That is a small per-commit rather than per-path cost
so the loss in speed might be worth the gain in readability.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |   35 ++++++++++++++++-------------------
 vcs-svn/fast_export.h |   10 ++++------
 vcs-svn/svndump.c     |   41 ++++++++++++++++++++++++-----------------
 3 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 04001b83..f61113b4 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -69,30 +69,27 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 	putchar('\n');
 }
 
-void fast_export_begin_commit(uint32_t set_mark, const char *committer_name,
-			const char *committer_login, const char *committer_domain,
-			const struct strbuf *log, const char *gitsvnline,
-			unsigned long timestamp, uint32_t from_mark,
-			const char *dst_ref)
+void fast_export_begin_commit(const char *ref, uint32_t mark, uint32_t prev_mark,
+			const char *author_name, const char *author_email,
+			const struct strbuf *log, unsigned long timestamp)
 {
-	if (!gitsvnline)
-		gitsvnline = "";
-	printf("commit %s\n", dst_ref);
-	if (set_mark)
-		printf("mark :%"PRIu32"\n", set_mark);
-	printf("committer %s <%s@%s> %ld +0000\n",
-		committer_name, committer_login, committer_domain,
-		timestamp);
-	printf("data %"PRIuMAX"\n",
-		(uintmax_t) (log->len + strlen(gitsvnline)));
+	if (!ref)
+		ref = "refs/heads/master";
+	printf("commit %s\n", ref);
+	if (mark)
+		printf("mark :%"PRIu32"\n", mark);
+	printf("committer %s <%s> %ld +0000\n",
+		author_name, author_email, timestamp);
+	printf("data %"PRIuMAX"\n", (uintmax_t) log->len);
 	fwrite(log->buf, log->len, 1, stdout);
-	printf("%s\n", gitsvnline);
-	if (from_mark)
-		printf("from :%"PRIu32"\n", from_mark);
+	putchar('\n');
+	if (prev_mark)
+		printf("from :%"PRIu32"\n", prev_mark);
 }
 
-void fast_export_end_commit(uint32_t revision)
+void fast_export_progress(uint32_t revision)
 {
+	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
 static void ls_from_rev(uint32_t rev, const char *path)
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 6c1c2be9..f2baf99d 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -10,12 +10,10 @@ void fast_export_reset(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
-void fast_export_begin_commit(uint32_t set_mark, const char *committer_name,
-			const char *committer_login, const char *committer_domain,
-			const struct strbuf *log, const char *gitsvnline,
-			unsigned long timestamp, uint32_t from_mark,
-			const char *dst_ref);
-void fast_export_end_commit(uint32_t revision);
+void fast_export_begin_commit(const char *ref, uint32_t mark, uint32_t prev_mark,
+			const char *author_name, const char *author_email,
+			const struct strbuf *log, unsigned long timestamp);
+void fast_export_progress(uint32_t revision);
 void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input);
 void fast_export_blob_delta(uint32_t mode,
 			uint32_t old_mode, const char *old_data,
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 97d5fdb7..c562cdaa 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -302,35 +302,42 @@ static void handle_node(void)
 				node_ctx.textLength, &input);
 }
 
-static char gitsvnline[MAX_GITSVN_LINE_LEN];
+static void add_metadata_trailer(struct strbuf *buf)
+{
+	if (*dump_ctx.uuid.buf && *dump_ctx.url.buf)
+		strbuf_addf(buf, "\n\ngit-svn-id: %s@%"PRIu32" %s\n",
+			 dump_ctx.url.buf, rev_ctx.revision, dump_ctx.uuid.buf);
+}
+
 static void begin_revision(void)
 {
-	int from_mark;
+	static struct strbuf email;
 	const char *author;
-	const char *domain;
+	uint32_t prev;
+
 	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
 		return;
-	if (*dump_ctx.uuid.buf && *dump_ctx.url.buf) {
-		snprintf(gitsvnline, MAX_GITSVN_LINE_LEN,
-				"\n\ngit-svn-id: %s@%"PRIu32" %s\n",
-				 dump_ctx.url.buf, rev_ctx.revision, dump_ctx.uuid.buf);
-	} else {
-		*gitsvnline = 0;
-	}
-	from_mark = dump_ctx.first_commit_done ? rev_ctx.revision - 1 : 0;
+	prev = dump_ctx.first_commit_done ? rev_ctx.revision - 1 : 0;
 	author = *rev_ctx.author.buf ? rev_ctx.author.buf : "nobody";
-	domain = *dump_ctx.uuid.buf ? dump_ctx.uuid.buf : "local";
 
-	fast_export_begin_commit(rev_ctx.revision, author, author, domain,
-		&rev_ctx.log, gitsvnline, rev_ctx.timestamp,
-		from_mark);
+	strbuf_reset(&email);
+	strbuf_addstr(&email, author);
+	strbuf_addch(&email, '@');
+	if (*dump_ctx.uuid.buf)
+		strbuf_addstr(&email, dump_ctx.uuid.buf);
+	else
+		strbuf_addstr(&email, "local");
+
+	add_metadata_trailer(&rev_ctx.log);
+
+	fast_export_begin_commit(NULL, rev_ctx.revision, prev,
+		author, email.buf, &rev_ctx.log, rev_ctx.timestamp);
 }
 
 static void end_revision(void)
 {
 	if (rev_ctx.revision) {
-		fast_export_end_commit(rev_ctx.revision);
-		printf("progress Imported commit %"PRIu32".\n\n", rev_ctx.revision);
+		fast_export_progress(rev_ctx.revision);
 		dump_ctx.first_commit_done = 1;
 	}
 }
-- 
1.7.6
