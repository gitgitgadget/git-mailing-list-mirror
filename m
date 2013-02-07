From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] count-objects: report garbage files in
 .git/objects/pack directory too
Date: Thu, 7 Feb 2013 14:37:52 +0700
Message-ID: <20130207073751.GA20672@duynguyen-vnpc.dek-tpc.internal>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1359982145-10792-2-git-send-email-pclouds@gmail.com>
 <7v1ucw2bd4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 08:38:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3M3t-0000DA-TH
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 08:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab3BGHiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 02:38:02 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43587 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab3BGHiB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 02:38:01 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so1273752pad.30
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 23:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=IYv03EqgabBtIbSk3UaLbgdGjoCyjnqEFUMQOLkRDUg=;
        b=jZ8ehuPnxTn1rPBDzs8YBen5O3JbOXQrvQCXhG6WH5ANXIZlpJq9XEk8HRClCt/gWf
         sXdU4N0+zwutvIy9Iav4ODaJ63rOHZQQ7tP5DEAI9vESAsaQ57eJdFHPl/5tW0zJv2va
         KyTACZKDxjg/c6X+pBoNULSFHZKzHmZOyGU6/dKMJq9ygJoMshH2VvRvjWzjLSwRBny4
         /WlT3LY8Nc1OfHkfHSjnYYJ1ut5bg3mNACfcke6It7i05J9505q989zZMRp7hYtKDlf0
         s6SjYqAEvH9aFZfhb/zLdZVVu2vQvJ3yDW/Ks/VDtMSrz4ikwbcRJKYaN2tftrtb46wC
         hkAQ==
X-Received: by 10.66.81.198 with SMTP id c6mr3040025pay.50.1360222680339;
        Wed, 06 Feb 2013 23:38:00 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id d1sm43856628pav.6.2013.02.06.23.37.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 23:37:59 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Feb 2013 14:37:52 +0700
Content-Disposition: inline
In-Reply-To: <7v1ucw2bd4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215677>

On Mon, Feb 04, 2013 at 10:16:23AM -0800, Junio C Hamano wrote:
> I forgot to mention one more thing.  Your report_pack_garbage()
> special cases ".pack" to see if it is a regular file, but this loop
> structure causes a regular file whose name ends with ".pack" but
> without corresponding ".idx" file to go unreported.
> 
> I think the loop should be restructured to iterate over all known
> file types and report unknown ones, if you want to repurpose it for
> the reporting, something along this line, perhaps:
> 
> 	for (each name) {
> 		if (does it end with ".idx") {
> 			if (is it unusable ".idx") {
> 				report garbage;
> 			}
>                         continue;
> 		}
> 		if (! we are in report mode)
> 			continue;
> 		if (does it end with ".pack") {
> 			if (!have we seen corresponding ".idx")
> 				remember it;
> 			continue;
> 		}
> 		report garbage;
> 	}
> 	for (remembered pack) {
> 		if (does it have corresponding ".idx" &&
> 			is it really usable ".pack")
> 			continue;
> 		report garbage;
> 	}
> 

How about the below patch? Ignoring good .commits files will be just a
couple more lines in the "for (remembered_pack)" loop.

Also in another mail in this thread:

> I also wonder, especially because you are enumerating the temporary
> pack files in .git/objects/pack/, if it make more sense to account
> for their sizes as well.  After all, you would end up doing stat()
> for a common case of files with ".pack" suffix---doing so for all of
> them shouldn't be too bad.

I thought about that, but we may need to do extra stat() for loose
garbage as well. As it is now, garbage is complained loudly, which
gives me enough motivation to clean up, even without looking at how
much disk space it uses.

-- 8< --
Subject: count-objects: report garbage pack directory too

prepare_packed_git_one() is modified to allow count-objects to hook a
report function to so we don't need to duplicate the pack searching
logic in count-objects.c. When report_pack_garbage is NULL, the
overhead is insignificant.

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index e816823..1611d7c 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -33,8 +33,8 @@ size-pack: disk space consumed by the packs, in KiB
 prune-packable: the number of loose objects that are also present in
 the packs. These objects could be pruned using `git prune-packed`.
 +
-garbage: the number of files in loose object database that are not
-valid loose objects
+garbage: the number of files in object database that are not valid
+loose objects nor valid packs
 
 GIT
 ---
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 9afaa88..7fdd508 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -9,6 +9,8 @@
 #include "builtin.h"
 #include "parse-options.h"
 
+static unsigned long garbage;
+
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
 			  off_t *loose_size,
@@ -65,6 +67,16 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 	}
 }
 
+extern void (*report_pack_garbage)(const char *path, int len, const char *name);
+static void real_report_pack_garbage(const char *path, int len, const char *name)
+{
+	if (len)
+		error("garbage found: %.*s/%s", len, path, name);
+	else
+		error("garbage found: %s", path);
+	garbage++;
+}
+
 static char const * const count_objects_usage[] = {
 	N_("git count-objects [-v]"),
 	NULL
@@ -76,7 +88,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	const char *objdir = get_object_directory();
 	int len = strlen(objdir);
 	char *path = xmalloc(len + 50);
-	unsigned long loose = 0, packed = 0, packed_loose = 0, garbage = 0;
+	unsigned long loose = 0, packed = 0, packed_loose = 0;
 	off_t loose_size = 0;
 	struct option opts[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -87,6 +99,8 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 	/* we do not take arguments other than flags for now */
 	if (argc)
 		usage_with_options(count_objects_usage, opts);
+	if (verbose)
+		report_pack_garbage = real_report_pack_garbage;
 	memcpy(path, objdir, len);
 	if (len && objdir[len-1] != '/')
 		path[len++] = '/';
diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..5b70e55 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -21,6 +21,7 @@
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
 #include "streaming.h"
+#include "dir.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -1000,15 +1001,19 @@ void install_packed_git(struct packed_git *pack)
 	packed_git = pack;
 }
 
+void (*report_pack_garbage)(const char *path, int len, const char *name);
+
 static void prepare_packed_git_one(char *objdir, int local)
 {
 	/* Ensure that this buffer is large enough so that we can
 	   append "/pack/" without clobbering the stack even if
 	   strlen(objdir) were PATH_MAX.  */
 	char path[PATH_MAX + 1 + 4 + 1 + 1];
-	int len;
+	int i, len;
 	DIR *dir;
 	struct dirent *de;
+	struct packed_git *p;
+	struct string_list garbage = STRING_LIST_INIT_DUP;
 
 	sprintf(path, "%s/pack", objdir);
 	len = strlen(path);
@@ -1024,14 +1029,33 @@ static void prepare_packed_git_one(char *objdir, int local)
 		int namelen = strlen(de->d_name);
 		struct packed_git *p;
 
-		if (!has_extension(de->d_name, ".idx"))
+		if (len + namelen + 1 > sizeof(path)) {
+			if (report_pack_garbage)
+				report_pack_garbage(path, len - 1, de->d_name);
 			continue;
+		}
 
-		if (len + namelen + 1 > sizeof(path))
+		strcpy(path + len, de->d_name);
+
+		if (!has_extension(de->d_name, ".idx")) {
+			if (!report_pack_garbage)
+				continue;
+			if (is_dot_or_dotdot(de->d_name))
+				continue;
+			if (!has_extension(de->d_name, ".pack")) {
+				report_pack_garbage(path, 0, NULL);
+				continue;
+			}
+			/*
+			 * we can't decide right know if this .pack is
+			 * garbage. Delay until we identify all good
+			 * packs.
+			 */
+			string_list_append(&garbage, path);
 			continue;
+		}
 
 		/* Don't reopen a pack we already have. */
-		strcpy(path + len, de->d_name);
 		for (p = packed_git; p; p = p->next) {
 			if (!memcmp(path, p->pack_name, len + namelen - 4))
 				break;
@@ -1047,6 +1071,25 @@ static void prepare_packed_git_one(char *objdir, int local)
 		install_packed_git(p);
 	}
 	closedir(dir);
+
+	if (!report_pack_garbage)
+		return;
+
+	sort_string_list(&garbage);
+	for (p = packed_git; p; p = p->next) {
+		struct string_list_item *item;
+		if (!p->pack_local)
+			continue;
+		item = string_list_lookup(&garbage, p->pack_name);
+		if (item)
+			item->util = &garbage; /* anything but NULL */
+	}
+	for (i = 0; i < garbage.nr; i++) {
+		struct string_list_item *item = garbage.items + i;
+		if (!item->util)
+			report_pack_garbage(item->string, 0, NULL);
+	}
+	string_list_clear(&garbage, 0);
 }
 
 static int sort_pack(const void *a_, const void *b_)
-- 8< --
