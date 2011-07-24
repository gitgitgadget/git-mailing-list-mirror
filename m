From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 05/11] vcs-svn: move url parameter from _read to _init
Date: Sun, 24 Jul 2011 15:40:09 +0200
Message-ID: <20110724134009.GE2934@elie.dc0b.debconf.org>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-6-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 15:41:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkyvn-00034g-Kh
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 15:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab1GXNkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 09:40:21 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:53675 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1GXNkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 09:40:19 -0400
Received: by fxd18 with SMTP id 18so7605833fxd.11
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pcJPmg2VtXZVHq7dgZxA7yvUymAuJR5/loCtDRfQERo=;
        b=ApoNCyc+wKYT5eMpndBz1AySUDos65W6rRf0PbVUkat3q3g5dzxic/sbC9J+8BfGxC
         /3Od8vSckUB1iExlySqxXxW57ewD25di0dWPpfQmHjMWPRB8GYTblYuB/U058y1EWbLK
         wzx6x83IraiAPj+lu6EY9MgaRIdZLiCvs8fbQ=
Received: by 10.223.16.136 with SMTP id o8mr5283504faa.21.1311514818582;
        Sun, 24 Jul 2011 06:40:18 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id a24sm3206167fak.12.2011.07.24.06.40.14
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 06:40:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310559673-5026-6-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177748>

Dmitry Ivankov wrote:

> svndump_read takes a url parameter that is used in git-svn-id: lines
[...]
> Move url parameter to svndump_init so that reset_dump_ctx is done
> once per dump and in the same place as other resets. Wrap all _init
[...]

I'm getting lost seeing the forest for the trees, so let me try to
summarize.

Before:

	if (svndump_init(url))
		die("svndump_init failed");
	svndump_read(dumpfile);

After:

	struct svndump_args opts;

	memset(&opts, 0, sizeof(opts));
	opts.url = url;
	opts.filename = dumpfile;

	if (svndump_init(&opts))
		die("svndump_init failed");
	svndump_read();

Using an options struct instead of a list of arguments means each
option is optional and has a descriptive name mentioned at the call
site, and means it is easy to add new arguments in the future.

The patch still keeps the init/read distinction even though we don't
need it anywhere (i.e., all call sites look the same) to minimize its
invasiveness.

Do I understand correctly?

If so, it sounds like a good idea, and I have only minor nitpicks:

 - It's tempting to call the struct svndump_options, by analogy
   with struct merge_options from merge-recursive.h.

 - Now that we're making the name of the "url" argument part of the
   public API, maybe we should emphasize that the url is only for
   show and git will never try to contact it.  Maybe something like
   "metadata_url"?  (Sorry, I'm not so great at coming up with names.)

 - Likewise, the "filename" argument could be made more
   self-explanatory.  Maybe "dumpfile"?

 - Now that the filename argument is passed at init time instead of
   read time, there is some uncertainty about when the file is going
   to be opened.  A comment could help, or merging the two functions
   could help. :)

Thanks, and hope that helps.
Jonathan
---
 contrib/svn-fe/svn-fe.c |    4 ++--
 test-svn-fe.c           |    4 ++--
 vcs-svn/svndump.c       |   10 ++++++----
 vcs-svn/svndump.h       |    7 ++++---
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 22d4cc14..88fca6a3 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -9,10 +9,10 @@
 
 int main(int argc, char **argv)
 {
-	struct svndump_args args;
+	struct svndump_options args;
 
 	memset(&args, 0, sizeof(args));
-	args.url = argc > 1 ? argv[1] : NULL;
+	args.metadata_url = argc > 1 ? argv[1] : NULL;
 	if (svndump_init(&args))
 		return 1;
 	svndump_read();
diff --git a/test-svn-fe.c b/test-svn-fe.c
index d80734fd..12a5c3ab 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -39,11 +39,11 @@ static int apply_delta(int argc, char *argv[])
 
 int main(int argc, char *argv[])
 {
-	struct svndump_args args;
+	struct svndump_options args;
 
 	memset(&args, 0, sizeof(args));
 	if (argc == 2) {
-		args.filename = argv[1];
+		args.dumpfile = argv[1];
 		if (svndump_init(&args))
 			return 1;
 		svndump_read();
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 60cccadc..805c94b6 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -455,10 +455,12 @@ void svndump_read(void)
 		end_revision();
 }
 
-int svndump_init(const struct svndump_args *args)
+int svndump_init(const struct svndump_options *opts)
 {
-	if (buffer_init(&input, args->filename))
-		return error("cannot open %s: %s", args->filename, strerror(errno));
+	const char *filename = opts->dumpfile;
+
+	if (buffer_init(&input, filename))
+		return error("cannot open %s: %s", filename, strerror(errno));
 	fast_export_init(REPORT_FILENO);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
@@ -466,7 +468,7 @@ int svndump_init(const struct svndump_args *args)
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(args->url);
+	reset_dump_ctx(opts->metadata_url);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index b3dbf24e..b8f52172 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,11 +1,12 @@
 #ifndef SVNDUMP_H_
 #define SVNDUMP_H_
 
-struct svndump_args {
-	const char *filename, *url;
+struct svndump_options {
+	const char *dumpfile;
+	const char *metadata_url;
 };
 
-int svndump_init(const struct svndump_args *args);
+int svndump_init(const struct svndump_options *o);
 void svndump_read(void);
 void svndump_deinit(void);
 void svndump_reset(void);
-- 
1.7.6
