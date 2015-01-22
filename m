From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 20/24] update-index: test the system before enabling
 untracked cache
Date: Thu, 22 Jan 2015 17:26:24 +0700
Message-ID: <20150122102624.GA25892@lanh>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
 <1421759013-8494-21-git-send-email-pclouds@gmail.com>
 <xmqqwq4gy1nq.fsf@gitster.dls.corp.google.com>
 <CACsJy8CDgUWEE=QKAgw4G8pgA-cOmLMs4sH67C47Ohd5XJQDNQ@mail.gmail.com>
 <xmqqvbk0vug9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 11:26:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEExs-00058c-G4
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 11:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbbAVK0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 05:26:13 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33162 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbAVK0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 05:26:11 -0500
Received: by mail-pa0-f48.google.com with SMTP id ey11so966210pad.7
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 02:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=viZRoaNZc+NZS6s26Uct9qpju93GmFJjGFQLSXnKI74=;
        b=jRzARAA4Ni3qxQvT7M+xLnxpQ7LP7JmgaUYYna6fYBt3A5boOuvnwi3HwGq68thHg9
         ZHZ49dHFUC0jzwyFlqT/r5QREaMlxd3Lui1eXM50Evc9T2WUUtbxy+0Dk0NEYRU0aplf
         M8dH6Ib/zeGJ4kehMjL9YrpLokoRyvaEK1LqMqcOKRZTiv64RJOBrJ01WDknrIJ5102Y
         qllbBdMWlDi2/pW/8oNWl7GbteCffnDDxXlp+YmuZgIBXPSZfxlmT0cT4yTiqdYUFaW1
         LAaIaWDx9IY84kZv/EIVc3NmIBw4DEETCel8t9JhMWg7Sk04xrMmJBPEK/1ZVGZd/NIN
         4fAQ==
X-Received: by 10.68.201.232 with SMTP id kd8mr954413pbc.164.1421922370715;
        Thu, 22 Jan 2015 02:26:10 -0800 (PST)
Received: from lanh ([115.73.217.78])
        by mx.google.com with ESMTPSA id pm2sm8423095pbb.81.2015.01.22.02.26.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2015 02:26:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 22 Jan 2015 17:26:24 +0700
Content-Disposition: inline
In-Reply-To: <xmqqvbk0vug9.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262815>

On Wed, Jan 21, 2015 at 10:51:02AM -0800, Junio C Hamano wrote:
> >> It appears that this hijacks a fixed name dir-mtime-test at the root
> >> level of every project managed by Git.  Is that intended?
> >
> > I did think about filename clash, but I chose a fixed name anyway for
> > simplicity, otherwise we would need to reconstruct paths
> > "dir-mtime-test/..." in many places.
> 
> If you stuff the name of test directory (default "dir-mtime-test")
> in a strbuf and formulate test paths by chomping to the original and
> then appending "/..." at the end, like your remove_test_directory()
> already does, wouldn't that be sufficient?

It looks actually good. How about this on top?

-- 8< --
diff --git a/builtin/update-index.c b/builtin/update-index.c
index f23ec83..f5f6689 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -32,6 +32,7 @@ static int mark_valid_only;
 static int mark_skip_worktree_only;
 #define MARK_FLAG 1
 #define UNMARK_FLAG 2
+static struct strbuf mtime_dir = STRBUF_INIT;
 
 __attribute__((format (printf, 1, 2)))
 static void report(const char *fmt, ...)
@@ -49,28 +50,37 @@ static void report(const char *fmt, ...)
 
 static void remove_test_directory(void)
 {
-	struct strbuf sb = STRBUF_INIT;
-	strbuf_addstr(&sb, "dir-mtime-test");
-	remove_dir_recursively(&sb, 0);
-	strbuf_release(&sb);
+	if (mtime_dir.len)
+		remove_dir_recursively(&mtime_dir, 0);
+}
+
+static const char *get_mtime_path(const char *path)
+{
+	static struct strbuf sb = STRBUF_INIT;
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/%s", mtime_dir.buf, path);
+	return sb.buf;
 }
 
 static void xmkdir(const char *path)
 {
+	path = get_mtime_path(path);
 	if (mkdir(path, 0700))
 		die_errno(_("failed to create directory %s"), path);
 }
 
-static int xstat(const char *path, struct stat *st)
+static int xstat_mtime_dir(struct stat *st)
 {
-	if (stat(path, st))
-		die_errno(_("failed to stat %s"), path);
+	if (stat(mtime_dir.buf, st))
+		die_errno(_("failed to stat %s"), mtime_dir.buf);
 	return 0;
 }
 
 static int create_file(const char *path)
 {
-	int fd = open(path, O_CREAT | O_RDWR, 0644);
+	int fd;
+	path = get_mtime_path(path);
+	fd = open(path, O_CREAT | O_RDWR, 0644);
 	if (fd < 0)
 		die_errno(_("failed to create file %s"), path);
 	return fd;
@@ -78,12 +88,14 @@ static int create_file(const char *path)
 
 static void xunlink(const char *path)
 {
+	path = get_mtime_path(path);
 	if (unlink(path))
 		die_errno(_("failed to delete file %s"), path);
 }
 
 static void xrmdir(const char *path)
 {
+	path = get_mtime_path(path);
 	if (rmdir(path))
 		die_errno(_("failed to delete directory %s"), path);
 }
@@ -102,37 +114,40 @@ static int test_if_untracked_cache_is_supported(void)
 {
 	struct stat st;
 	struct stat_data base;
-	int fd;
+	int fd, ret = 0;
+
+	strbuf_addstr(&mtime_dir, "mtime-test-XXXXXX");
+	if (!mkdtemp(mtime_dir.buf))
+		die_errno("Could not make temporary directory");
 
 	fprintf(stderr, _("Testing "));
-	xmkdir("dir-mtime-test");
 	atexit(remove_test_directory);
-	xstat("dir-mtime-test", &st);
+	xstat_mtime_dir(&st);
 	fill_stat_data(&base, &st);
 	fputc('.', stderr);
 
 	avoid_racy();
-	fd = create_file("dir-mtime-test/newfile");
-	xstat("dir-mtime-test", &st);
+	fd = create_file("newfile");
+	xstat_mtime_dir(&st);
 	if (!match_stat_data(&base, &st)) {
 		close(fd);
 		fputc('\n', stderr);
 		fprintf_ln(stderr,_("directory stat info does not "
 				    "change after adding a new file"));
-		return 0;
+		goto done;
 	}
 	fill_stat_data(&base, &st);
 	fputc('.', stderr);
 
 	avoid_racy();
-	xmkdir("dir-mtime-test/new-dir");
-	xstat("dir-mtime-test", &st);
+	xmkdir("new-dir");
+	xstat_mtime_dir(&st);
 	if (!match_stat_data(&base, &st)) {
 		close(fd);
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info does not change "
 				     "after adding a new directory"));
-		return 0;
+		goto done;
 	}
 	fill_stat_data(&base, &st);
 	fputc('.', stderr);
@@ -140,52 +155,57 @@ static int test_if_untracked_cache_is_supported(void)
 	avoid_racy();
 	write_or_die(fd, "data", 4);
 	close(fd);
-	xstat("dir-mtime-test", &st);
+	xstat_mtime_dir(&st);
 	if (match_stat_data(&base, &st)) {
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info changes "
 				     "after updating a file"));
-		return 0;
+		goto done;
 	}
 	fputc('.', stderr);
 
 	avoid_racy();
-	close(create_file("dir-mtime-test/new-dir/new"));
-	xstat("dir-mtime-test", &st);
+	close(create_file("new-dir/new"));
+	xstat_mtime_dir(&st);
 	if (match_stat_data(&base, &st)) {
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info changes after "
 				     "adding a file inside subdirectory"));
-		return 0;
+		goto done;
 	}
 	fputc('.', stderr);
 
 	avoid_racy();
-	xunlink("dir-mtime-test/newfile");
-	xstat("dir-mtime-test", &st);
+	xunlink("newfile");
+	xstat_mtime_dir(&st);
 	if (!match_stat_data(&base, &st)) {
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info does not "
 				     "change after deleting a file"));
-		return 0;
+		goto done;
 	}
 	fill_stat_data(&base, &st);
 	fputc('.', stderr);
 
 	avoid_racy();
-	xunlink("dir-mtime-test/new-dir/new");
-	xrmdir("dir-mtime-test/new-dir");
-	xstat("dir-mtime-test", &st);
+	xunlink("new-dir/new");
+	xrmdir("new-dir");
+	xstat_mtime_dir(&st);
 	if (!match_stat_data(&base, &st)) {
 		fputc('\n', stderr);
 		fprintf_ln(stderr, _("directory stat info does not "
 				     "change after deleting a directory"));
-		return 0;
+		goto done;
 	}
 
-	xrmdir("dir-mtime-test");
+	if (rmdir(mtime_dir.buf))
+		die_errno(_("failed to delete directory %s"), mtime_dir.buf);
 	fprintf_ln(stderr, _(" OK"));
-	return 1;
+	ret = 1;
+
+done:
+	strbuf_release(&mtime_dir);
+	return ret;
 }
 
 static int mark_ce_flags(const char *path, int flag, int mark)
-- 8< --
