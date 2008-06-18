From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/4] Add config option to enable 'fsync()' of object files
Date: Wed, 18 Jun 2008 15:32:24 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806181531370.2907@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806181524490.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181529570.2907@woody.linux-foundation.org> <alpine.LFD.1.10.0806181530420.2907@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806181531120.2907@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Denis Bueno <dbueno@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:34:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K96Ek-0004V9-E3
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 00:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348AbYFRWdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 18:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbYFRWdZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 18:33:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47934 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755904AbYFRWdY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 18:33:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IMWPn3017192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jun 2008 15:32:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5IMWOOG024144;
	Wed, 18 Jun 2008 15:32:25 -0700
In-Reply-To: <alpine.LFD.1.10.0806181531120.2907@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.853 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85417>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Jun 2008 15:18:44 -0700
Subject: [PATCH 4/4] Add config option to enable 'fsync()' of object files

As explained in the documentation[*] this is totally useless on
filesystems that do ordered/journalled data writes, but it can be a
useful safety feature on filesystems like HFS+ that only journal the
metadata, not the actual file contents.

It defaults to off, although we could presumably in theory some day
auto-enable it on a per-filesystem basis.

[*] Yes, I updated the docs for the thing.  Hell really _has_ frozen
    over, and the four horsemen are probably just beyond the horizon.
    EVERYBODY PANIC!

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Ok, this is the actual real and trivial patch. 

 Documentation/config.txt |    8 ++++++++
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 sha1_file.c              |    3 ++-
 5 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5331b45..01689f1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -372,6 +372,14 @@ core.whitespace::
   does not trigger if the character before such a carriage-return
   is not a whitespace (not enabled by default).
 
+core.fsyncobjectfiles::
+	This boolean will enable 'fsync()' when writing object files. 
++
+This is a total waste of time and effort on a filesystem that orders
+data writes properly, but can be useful for filesystems that do not use
+journalling (traditional UNIX filesystems) or that only journal metadata
+and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
+
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/cache.h b/cache.h
index 81b7e17..01c8502 100644
--- a/cache.h
+++ b/cache.h
@@ -435,6 +435,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
+extern int fsync_object_files;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/config.c b/config.c
index 9d14a74..b2d5b4e 100644
--- a/config.c
+++ b/config.c
@@ -460,6 +460,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.fsyncobjectfiles")) {
+		fsync_object_files = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 73feb2d..d5c3e29 100644
--- a/environment.c
+++ b/environment.c
@@ -29,6 +29,7 @@ const char *apply_default_whitespace;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
+int fsync_object_files;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 16 * 1024 * 1024;
diff --git a/sha1_file.c b/sha1_file.c
index e2a65c5..c34ac6d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2083,7 +2083,8 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 /* Finalize a file on disk, and close it. */
 static void close_sha1_file(int fd)
 {
-	/* For safe-mode, we could fsync_or_die(fd, "sha1 file") here */
+	if (fsync_object_files)
+		fsync_or_die(fd, "sha1 file");
 	fchmod(fd, 0444);
 	if (close(fd) != 0)
 		die("unable to write sha1 file");
-- 
1.5.6.rc3.7.g336d0.dirty
