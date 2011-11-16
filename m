From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] introduce strbuf_addpath()
Date: Wed, 16 Nov 2011 15:50:04 -0600
Message-ID: <20111116215004.GA29872@elie.hsd1.il.comcast.net>
References: <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net>
 <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com>
 <20111116085944.GA18781@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 22:50:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQnNA-0000tO-Jf
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 22:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab1KPVuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 16:50:16 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35850 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab1KPVuP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 16:50:15 -0500
Received: by yenq3 with SMTP id q3so220770yen.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 13:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rFf7yAzD9HEfyEjU8GzvzPTiTbGbbjjQB5lHb6VKBaM=;
        b=hqhqrQhgs6iyNTZpgK/wrnxzxmWymopCdoA3OyTPmjXI6f1PNBLo+0AJ3plUUIWRKA
         VI+ihPipgUAugAnsS7H18ozpAbXcYDw2EfbF7tQp83jRBZt32rblTAS73gYobfMpuUPB
         V8i6IQmw1ZBawEJAyT9dBu7Vcm/MudAA2Yjo0=
Received: by 10.236.185.198 with SMTP id u46mr4889166yhm.113.1321480214604;
        Wed, 16 Nov 2011 13:50:14 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 36sm1889326anz.2.2011.11.16.13.50.13
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 13:50:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111116085944.GA18781@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185555>

strbuf_addpath() is like git_path_unsafe(), except instead of
returning its own buffer, it appends its result to a buffer provided
by the caller.

Benefits:

 - Since it uses a caller-supplied buffer, unlike git_path_unsafe(),
   there is no risk that one call will clobber the result from
   another.

 - Unlike git_pathdup(), it does not need to waste time allocating
   memory in the middle of your tight loop over refs.

 - The size of the result is not limited to PATH_MAX.

Caveat: the size of its result is not limited to PATH_MAX.  Existing
code might be relying on git_path*() to produce a result that is safe
to copy to a PATH_MAX-sized buffer.  Be careful.

This patch introduces the strbuf_addpath() function and converts a few
existing users of the strbuf_addstr(git_path(...)) idiom to
demonstrate the API.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> I think if I ran the world, the fundamental operation would be
> strbuf_addpath().

Like this, maybe.

In these v1.7.8-rc2 days, you should probably spend your time
reviewing patch 2/3 of the previous series, though. ;-)

 cache.h       |    3 +++
 notes-merge.c |    2 +-
 path.c        |   34 ++++++++++++++++++++++++++++++++++
 sha1_file.c   |    2 +-
 transport.c   |    4 ++--
 5 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 7fb85445..33d7d147 100644
--- a/cache.h
+++ b/cache.h
@@ -659,6 +659,8 @@ extern char *git_snpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 extern char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
+extern void strbuf_addpath(struct strbuf *sb, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
 
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
diff --git a/notes-merge.c b/notes-merge.c
index 0b49e8ad..738442de 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -733,7 +733,7 @@ int notes_merge_abort(struct notes_merge_options *o)
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 
-	strbuf_addstr(&buf, git_path_unsafe(NOTES_MERGE_WORKTREE));
+	strbuf_addpath(&buf, NOTES_MERGE_WORKTREE);
 	OUTPUT(o, 3, "Removing notes merge worktree at %s", buf.buf);
 	ret = remove_dir_recursively(&buf, 0);
 	strbuf_release(&buf);
diff --git a/path.c b/path.c
index 0611b7be..28d6326d 100644
--- a/path.c
+++ b/path.c
@@ -33,6 +33,20 @@ static char *cleanup_path(char *path)
 	return path;
 }
 
+static void strbuf_cleanup_path(struct strbuf *sb, size_t pos)
+{
+	char *newstart;
+
+	/*
+	 * cleanup_path expects to be acting on a static buffer,
+	 * so it modifies its argument in place and returns
+	 * a pointer to the new start of the path.
+	 */
+	newstart = cleanup_path(sb->buf + pos);
+	strbuf_remove(sb, pos, newstart - sb->buf - pos);
+	strbuf_setlen(sb, strlen(sb->buf));
+}
+
 char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 {
 	va_list args;
@@ -68,6 +82,18 @@ bad:
 	return buf;
 }
 
+static void strbuf_vaddpath(struct strbuf *sb, const char *fmt, va_list args)
+{
+	const char *git_dir = get_git_dir();
+	size_t pos = sb->len;
+
+	strbuf_addstr(sb, git_dir);
+	if (pos < sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
+		strbuf_addch(sb, '/');
+	strbuf_vaddf(sb, fmt, args);
+	strbuf_cleanup_path(sb, pos);
+}
+
 char *git_snpath(char *buf, size_t n, const char *fmt, ...)
 {
 	va_list args;
@@ -87,6 +113,14 @@ char *git_pathdup(const char *fmt, ...)
 	return xstrdup(path);
 }
 
+void strbuf_addpath(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	strbuf_vaddpath(sb, fmt, args);
+	va_end(args);
+}
+
 char *mkpath(const char *fmt, ...)
 {
 	va_list args;
diff --git a/sha1_file.c b/sha1_file.c
index ba7eca89..315d1004 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2706,7 +2706,7 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
 	int len, tmpfd;
 
 	strbuf_addstr(&export_marks, "--export-marks=");
-	strbuf_addstr(&export_marks, git_path_unsafe("hashstream_XXXXXX"));
+	strbuf_addpath(&export_marks, "hashstream_XXXXXX");
 	tmpfile = export_marks.buf + strlen("--export-marks=");
 	tmpfd = git_mkstemp_mode(tmpfile, 0600);
 	if (tmpfd < 0)
diff --git a/transport.c b/transport.c
index cc0ca04c..f5c95b40 100644
--- a/transport.c
+++ b/transport.c
@@ -203,7 +203,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 
 	/* copy the refs to the temporary directory */
 
-	strbuf_addstr(&temp_dir, git_path_unsafe("rsync-refs-XXXXXX"));
+	strbuf_addpath(&temp_dir, "rsync-refs-XXXXXX");
 	if (!mkdtemp(temp_dir.buf))
 		die_errno ("Could not make temporary directory");
 	temp_dir_len = temp_dir.len;
@@ -366,7 +366,7 @@ static int rsync_transport_push(struct transport *transport,
 
 	/* copy the refs to the temporary directory; they could be packed. */
 
-	strbuf_addstr(&temp_dir, git_path_unsafe("rsync-refs-XXXXXX"));
+	strbuf_addpath(&temp_dir, "rsync-refs-XXXXXX");
 	if (!mkdtemp(temp_dir.buf))
 		die_errno ("Could not make temporary directory");
 	strbuf_addch(&temp_dir, '/');
-- 
1.7.8.rc2
