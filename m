From: Joachim B Haga <cjhaga@fys.uio.no>
Subject: [PATCH] Make zlib compression level configurable, and change default.
Date: 03 Jul 2006 20:59:56 +0200
Message-ID: <85d5cm8qfn.fsf_-_@lupus.ig3.net>
References: <loom.20060703T124601-969@post.gmane.org> <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com> <44A91C7A.6090902@fys.uio.no> <Pine.LNX.4.64.0607031030150.1213@localhost.localdomain> <Pine.LNX.4.64.0607030929490.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 03 21:00:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxTek-00063f-2N
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 21:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWGCTAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 15:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWGCTAP
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 15:00:15 -0400
Received: from main.gmane.org ([80.91.229.2]:57240 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750875AbWGCTAN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 15:00:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FxTeP-000612-6H
	for git@vger.kernel.org; Mon, 03 Jul 2006 21:00:05 +0200
Received: from 67.80-203-45.nextgentel.com ([80.203.45.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 21:00:05 +0200
Received: from cjhaga by 67.80-203-45.nextgentel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 21:00:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 67.80-203-45.nextgentel.com
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23191>

Make zlib compression level configurable, and change the default.

With the change in default, "git add ." on kernel dir is about
twice as fast as before, with only minimal (0.5%) change in
object size. The speed difference is even more noticeable
when committing large files, which is now up to 8 times faster.

The configurability is through setting core.compression = [-1..9]
which maps to the zlib constants; -1 is the default, 0 is no
compression, and 1..9 are various speed/size tradeoffs, 9
being slowest.

Signed-off-by: Joachim B Haga (cjhaga@fys.uio.no)
---
 Documentation/config.txt |    6 ++++++
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 sha1_file.c              |    4 ++--
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a04c5ad..ac89be7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -91,6 +91,12 @@ core.warnAmbiguousRefs::
        If true, git will warn you if the ref name you passed it is ambiguous
        and might match multiple refs in the .git/refs/ tree. True by default.
 
+core.compression:
+       An integer -1..9, indicating the compression level for objects that
+       are not in a pack file. -1 is the zlib and git default. 0 means no 
+       compression, and 1..9 are various speed/size tradeoffs, 9 being
+       slowest.
+
 alias.*::
        Command aliases for the gitlink:git[1] command wrapper - e.g.
        after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/cache.h b/cache.h
index 8719939..84770bf 100644
--- a/cache.h
+++ b/cache.h
@@ -183,6 +183,7 @@ extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
+extern int zlib_compression_level;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index ec44827..61563be 100644
--- a/config.c
+++ b/config.c
@@ -279,6 +279,11 @@ int git_default_config(const char *var, 
                return 0;
        }
 
+       if (!strcmp(var, "core.compression")) {
+               zlib_compression_level = git_config_int(var, value);
+               return 0;
+       }
+
        if (!strcmp(var, "user.name")) {
                strlcpy(git_default_name, value, sizeof(git_default_name));
                return 0;
diff --git a/environment.c b/environment.c
index 3de8eb3..1d8ceef 100644
--- a/environment.c
+++ b/environment.c
@@ -20,6 +20,7 @@ int repository_format_version = 0;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace = NULL;
+int zlib_compression_level = -1;
 
 static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
        *git_graft_file;
diff --git a/sha1_file.c b/sha1_file.c
index 8179630..bc35808 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1458,7 +1458,7 @@ int write_sha1_file(void *buf, unsigned 
 
        /* Set it up */
        memset(&stream, 0, sizeof(stream));
-       deflateInit(&stream, Z_BEST_COMPRESSION);
+       deflateInit(&stream, zlib_compression_level);
        size = deflateBound(&stream, len+hdrlen);
        compressed = xmalloc(size);
 
@@ -1511,7 +1511,7 @@ static void *repack_object(const unsigne
 
        /* Set it up */
        memset(&stream, 0, sizeof(stream));
-       deflateInit(&stream, Z_BEST_COMPRESSION);
+       deflateInit(&stream, zlib_compression_level);
        size = deflateBound(&stream, len + hdrlen);
        buf = xmalloc(size);
 
-- 
1.4.1.g8fced-dirty
