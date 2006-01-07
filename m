From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.0.7
Date: Sat, 07 Jan 2006 01:56:41 -0800
Message-ID: <7vmzi8mkdi.fsf@assigned-by-dhcp.cox.net>
References: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>
	<20060107.021614.94523887.yoshfuji@linux-ipv6.org>
	<7vsls0mns8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 10:57:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvAog-00009C-Dk
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 10:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWAGJ4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 04:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWAGJ4n
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 04:56:43 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:33498 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030385AbWAGJ4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 04:56:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107095444.YMYY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 04:54:44 -0500
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <7vsls0mns8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 07 Jan 2006 00:43:03 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14249>

Junio C Hamano <junkio@cox.net> writes:

> YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org> writes:
>
>> Allow compilation w/ gcc 2.95.4.
>> (Or, it is okay to replace path[] with path[0].)
>
> This is unfortunate; path[] is the correct C (and path[0] is
> not---it is an gcc extension), and we have quite a few of them.
> Last time somebody wanted to change all of them to path[] we
> found out gcc 2.95 did not like it, and ended up doing path[0]
> form.  So I'd say change it to path[0] for now.

Here is what I am planning to merge into the master/maint.  The
patch is for maint which does not ship with describe, but the
problematic path[] can be updated to path[FLEX_ARRAY] as others
when merging it to the master branch.

-- >8 --
Subject: [PATCH] Compilation: zero-length array declaration.

ISO C99 (and GCC 3.x or later) lets you write a flexible array
at the end of a structure, like this:

	struct frotz {
		int xyzzy;
		char nitfol[]; /* more */
	};

GCC 2.95 lets you to do this with "char nitfol[0]";
unfortunately this is not allowed by ISO C90.

This declares such construct like this:

	struct frotz {
		int xyzzy;
		char nitfol[FLEX_ARRAY]; /* more */
	};

and git-compat-util.h defines FLEX_ARRAY to 0 for gcc 2.95 and
empty for others.

Although I have not tried this myself, if you are using a C90 C
compiler, you should be able to override this with
CFLAGS=-DFLEX_ARRAY=1 from the command line of "make".

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 blob.c            |    2 +-
 cache.h           |    9 +++++----
 commit.c          |    2 +-
 git-compat-util.h |    8 ++++++++
 ls-files.c        |    2 +-
 object.c          |    2 +-
 object.h          |    2 +-
 receive-pack.c    |    2 +-
 tag.c             |    2 +-
 tree.c            |    2 +-
 10 files changed, 21 insertions(+), 12 deletions(-)

33751f1c4e23e928f18a019292cb8562cd7c7f76
diff --git a/blob.c b/blob.c
index ea52ad5..84ec121 100644
--- a/blob.c
+++ b/blob.c
@@ -1,5 +1,5 @@
-#include "blob.h"
 #include "cache.h"
+#include "blob.h"
 #include <stdlib.h>
 
 const char *blob_type = "blob";
diff --git a/cache.h b/cache.h
index cb87bec..5fd2687 100644
--- a/cache.h
+++ b/cache.h
@@ -81,7 +81,7 @@ struct cache_entry {
 	unsigned int ce_size;
 	unsigned char sha1[20];
 	unsigned short ce_flags;
-	char name[0];
+	char name[FLEX_ARRAY]; /* more */
 };
 
 #define CE_NAMEMASK  (0x0fff)
@@ -257,7 +257,7 @@ extern int checkout_entry(struct cache_e
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
 	char *name;
-	char base[0]; /* more */
+	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 
@@ -271,7 +271,8 @@ extern struct packed_git {
 	unsigned int pack_use_cnt;
 	int pack_local;
 	unsigned char sha1[20];
-	char pack_name[0]; /* something like ".git/objects/pack/xxxxx.pack" */
+	/* something like ".git/objects/pack/xxxxx.pack" */
+	char pack_name[FLEX_ARRAY]; /* more */
 } *packed_git;
 
 struct pack_entry {
@@ -286,7 +287,7 @@ struct ref {
 	unsigned char new_sha1[20];
 	unsigned char force;
 	struct ref *peer_ref; /* when renaming */
-	char name[0];
+	char name[FLEX_ARRAY]; /* more */
 };
 
 extern int git_connect(int fd[2], char *url, const char *prog);
diff --git a/commit.c b/commit.c
index edd4ded..fb02ba6 100644
--- a/commit.c
+++ b/commit.c
@@ -1,6 +1,6 @@
+#include "cache.h"
 #include "tag.h"
 #include "commit.h"
-#include "cache.h"
 
 int save_commit_buffer = 1;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index c353b27..1a263a6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1,6 +1,14 @@
 #ifndef GIT_COMPAT_UTIL_H
 #define GIT_COMPAT_UTIL_H
 
+#ifndef FLEX_ARRAY
+#if (__GNUC__ == 2) && (__GNUC_MINOR__ == 95)
+#define FLEX_ARRAY 0
+#else
+#define FLEX_ARRAY /* empty */
+#endif
+#endif
+
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
diff --git a/ls-files.c b/ls-files.c
index cd87430..74ec8c0 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -208,7 +208,7 @@ static int excluded(const char *pathname
 
 struct nond_on_fs {
 	int len;
-	char name[0];
+	char name[FLEX_ARRAY]; /* more */
 };
 
 static struct nond_on_fs **dir;
diff --git a/object.c b/object.c
index cf5931a..1577f74 100644
--- a/object.c
+++ b/object.c
@@ -1,8 +1,8 @@
+#include "cache.h"
 #include "object.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
-#include "cache.h"
 #include "tag.h"
 
 struct object **objs;
diff --git a/object.h b/object.h
index 336d986..0e76182 100644
--- a/object.h
+++ b/object.h
@@ -9,7 +9,7 @@ struct object_list {
 
 struct object_refs {
 	unsigned count;
-	struct object *ref[0];
+	struct object *ref[FLEX_ARRAY]; /* more */
 };
 
 struct object {
diff --git a/receive-pack.c b/receive-pack.c
index 92878ec..ce986fe 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -24,7 +24,7 @@ struct command {
 	unsigned char updated;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
-	char ref_name[0];
+	char ref_name[FLEX_ARRAY]; /* more */
 };
 
 static struct command *commands = NULL;
diff --git a/tag.c b/tag.c
index 61ac434..ac0e573 100644
--- a/tag.c
+++ b/tag.c
@@ -1,5 +1,5 @@
-#include "tag.h"
 #include "cache.h"
+#include "tag.h"
 
 const char *tag_type = "tag";
 
diff --git a/tree.c b/tree.c
index e7a7b71..dc1c41e 100644
--- a/tree.c
+++ b/tree.c
@@ -1,8 +1,8 @@
+#include "cache.h"
 #include "tree.h"
 #include "blob.h"
 #include "commit.h"
 #include "tag.h"
-#include "cache.h"
 #include <stdlib.h>
 
 const char *tree_type = "tree";
-- 
1.0.7-g0263
