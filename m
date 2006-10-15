From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 00:44:40 -0700
Message-ID: <7virim10rb.fsf@assigned-by-dhcp.cox.net>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 09:44:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ0g4-0002yn-O0
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 09:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWJOHom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 03:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWJOHom
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 03:44:42 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:13475 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964820AbWJOHol (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 03:44:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061015074441.XJLT18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Oct 2006 03:44:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id aXkU1V00B1kojtg0000000
	Sun, 15 Oct 2006 03:44:29 -0400
To: git@vger.kernel.org
In-Reply-To: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 14 Oct 2006 23:29:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28907>

This introduces a new configuration item, pack.deltaversion, to
control whether pack-objects is allowed to use version 3 delta.
By default, we keep generating version 2 delta (and version 2
packfile format) to be compatible with git earlier than v1.2.0.

This configuration affects the command in the following ways:

 - the resulting packfile will have the specified version;

 - when generating delta, larger copies are allowed only when
   deltaversion is 3;

 - the logic to reuse delta from existing packs refuses to reuse
   delta from packs that uses delta version 3 when the
   configuration is set to 2.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Nico, I'd really appreciate it if you can eyeball this
   patch.  For the upcoming v1.4.3, we'd at least want to
   revert:

     commit 16854571aae6302f457c5fbee41ac64669b09595
     Author: Nicolas Pitre <nico@cam.org>
     Date:   Thu Sep 21 00:11:59 2006 -0400

     move pack creation to version 3

     It's been quite a while now that GIT is able to read version 3 packs.
     Let's create them at last.

     Signed-off-by: Nicolas Pitre <nico@cam.org>
     Signed-off-by: Junio C Hamano <junkio@cox.net>

   but I'd like to allow people to explicitly tell what version
   is to be created by default per repository to avoid future
   problems.

   For now it would be advised to leave this configuration empty
   in public repositories, which would cause them to have
   version 2 packs.  People who know their repositories are only
   used with git v1.2.0 or newer can use the configuration to
   allow version 3 packs.

   We should later add a command line override to pack-objects
   to explicitly say which delta version to be used, so that
   pack protocol can negotiate the allowed delta version between
   client and the server and pass that command line option when
   upload-pack runs pack-objects.

 builtin-pack-objects.c |   16 ++++++++++++----
 cache.h                |    1 +
 delta.h                |    2 ++
 diff-delta.c           |   15 +++++++++++++--
 environment.c          |    3 +++
 sha1_file.c            |    1 +
 6 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 96c069a..4d2147b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -456,7 +456,7 @@ static void write_pack_file(void)
 		fprintf(stderr, "Writing %d objects.\n", nr_result);
 
 	hdr.hdr_signature = htonl(PACK_SIGNATURE);
-	hdr.hdr_version = htonl(PACK_VERSION);
+	hdr.hdr_version = htonl(delta_version);
 	hdr.hdr_entries = htonl(nr_result);
 	sha1write(f, &hdr, sizeof(hdr));
 	offset = sizeof(hdr);
@@ -914,12 +914,15 @@ static void check_object(struct object_e
 		/* Check if it is delta, and the base is also an object
 		 * we are going to pack.  If so we will reuse the existing
 		 * delta.
+		 *
+		 * Also make sure that we do not reuse delta from an existing
+		 * pack that uses higher delta version than allowed.
 		 */
 		if (!no_reuse_delta &&
 		    entry->in_pack_type == OBJ_DELTA &&
 		    (base_entry = locate_object_entry(base)) &&
-		    (!base_entry->preferred_base)) {
-
+		    (!base_entry->preferred_base) &&
+		    entry->in_pack->pack_version <= delta_version) {
 			/* Depth value does not matter - find_deltas()
 			 * will never consider reused delta as the
 			 * base object to deltify other objects
@@ -1326,10 +1329,15 @@ static void setup_progress_signal(void)
 
 static int git_pack_config(const char *k, const char *v)
 {
-	if(!strcmp(k, "pack.window")) {
+	if (!strcmp(k, "pack.window")) {
 		window = git_config_int(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.deltaversion")) {
+		delta_version = git_config_int(k, v);
+		if (!pack_version_ok(htonl(delta_version)))
+			die("value %s for '%s' not allowed", v, k);
+	}
 	return git_default_config(k, v);
 }
 
diff --git a/cache.h b/cache.h
index c354701..724c09a 100644
--- a/cache.h
+++ b/cache.h
@@ -337,6 +337,7 @@ extern struct packed_git {
 	unsigned int pack_last_used;
 	unsigned int pack_use_cnt;
 	int pack_local;
+	int pack_version;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
diff --git a/delta.h b/delta.h
index 7b3f86d..55af3d2 100644
--- a/delta.h
+++ b/delta.h
@@ -1,6 +1,8 @@
 #ifndef DELTA_H
 #define DELTA_H
 
+extern int delta_version;
+
 /* opaque object for delta index */
 struct delta_index;
 
diff --git a/diff-delta.c b/diff-delta.c
index fa16d06..2f6dcfb 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -253,10 +253,13 @@ create_delta(const struct delta_index *i
 	int inscnt;
 	const unsigned char *ref_data, *ref_top, *data, *top;
 	unsigned char *out;
+	unsigned int ref_size_limit;
 
 	if (!trg_buf || !trg_size)
 		return NULL;
 
+	ref_size_limit = (delta_version > 2) ? 0xffffff : 0x10000;
+
 	outpos = 0;
 	outsize = 8192;
 	if (max_size && outsize >= max_size)
@@ -308,8 +311,8 @@ create_delta(const struct delta_index *i
 				continue;
 			if (ref_size > top - src)
 				ref_size = top - src;
-			if (ref_size > 0x10000)
-				ref_size = 0x10000;
+			if (ref_size > ref_size_limit)
+				ref_size = ref_size_limit;
 			if (ref_size <= msize)
 				break;
 			while (ref_size-- && *src++ == *ref)
@@ -318,6 +321,8 @@ create_delta(const struct delta_index *i
 				/* this is our best match so far */
 				msize = ref - entry->ptr;
 				moff = entry->ptr - ref_data;
+				if (delta_version > 2 && msize >= 0x10000)
+					break; /* this is good enough */
 			}
 		}
 
@@ -381,6 +386,12 @@ create_delta(const struct delta_index *i
 			if (msize & 0xff) { out[outpos++] = msize; i |= 0x10; }
 			msize >>= 8;
 			if (msize & 0xff) { out[outpos++] = msize; i |= 0x20; }
+			if (delta_version > 2) {
+				msize >>= 8;
+				if (msize & 0xff) {
+					out[outpos++] = msize; i |= 0x40;
+				}
+			}
 
 			*op = i;
 		}
diff --git a/environment.c b/environment.c
index 63b1d15..e266f83 100644
--- a/environment.c
+++ b/environment.c
@@ -8,6 +8,7 @@
  * are.
  */
 #include "cache.h"
+#include "pack.h"
 
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
@@ -25,6 +26,8 @@ const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
 int pager_use_color = 1;
+/* by default we allow 2 but up to PACK_VERSION is allowed */
+int delta_version = 2;
 
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
diff --git a/sha1_file.c b/sha1_file.c
index d111be7..6653182 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -527,6 +527,7 @@ int use_packed_git(struct packed_git *p)
 			    p->pack_size - 20)) {
 			die("packfile %s does not match index.", p->pack_name);
 		}
+		p->pack_version = ntohl(hdr->hdr_version);
 	}
 	p->pack_last_used = pack_used_ctr++;
 	p->pack_use_cnt++;
-- 
1.4.3.rc3.ga5ce
