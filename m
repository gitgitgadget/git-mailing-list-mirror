From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] read-tree -m -u: avoid getting confused by intermediate symlinks.
Date: Fri, 11 May 2007 13:38:58 -0700
Message-ID: <7vps579jtp.fsf@assigned-by-dhcp.cox.net>
References: <7vveezde8b.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0705110708y7e3a9024p9e117e2da84ae916@mail.gmail.com>
	<7vwszfb80y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 22:39:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmbtK-0005ke-0V
	for gcvg-git@gmane.org; Fri, 11 May 2007 22:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbXEKUjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 16:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756123AbXEKUjA
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 16:39:00 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62647 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979AbXEKUi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 16:38:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511203859.QONH26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 16:38:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xwey1W00Q1kojtg0000000; Fri, 11 May 2007 16:38:59 -0400
In-Reply-To: <7vwszfb80y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 11 May 2007 10:10:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46982>

Junio C Hamano <junkio@cox.net> writes:

> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
>> On 5/11/07, Junio C Hamano <junkio@cox.net> wrote:
>>> @@ -268,6 +268,8 @@ static void unlink_entry(char *name)
>>>  {
>>>         char *cp, *prev;
>>>
>>> +       if (has_symlink_leading_path(name))
>>> +               return;
>>
>> This can slow down the unlink case quiet considerably.
>> Maybe the symlink paths can be cached?
>
> Yes it can, and probably doable.
>
> This is called once per each path that disappears from the
> result, relative to the current tree.  The number of calls to
> this function is potentially quite large.

-- >8 --
has_symlink_leading_path(): cache the last lookup

This is on top of the previous one to implement a single-entry
cache for symlinks.  The idea is that:

 * The caller optionally allocates a buffer to hold the symlink
   that caused the check to succeed and passes it in.  This is
   an in-out parameter that the check reuses the result from the
   previous round;

 * Because we call things in the index order, removed entries
   under what used to be a directory but now is a symlink
   cluster together.  The has_symlink_leading_path() function
   will return true because they are under the same symlink;

 * When we see a "this is updated/created" entry, we know we are
   no longer inside the directory that previous round of
   last_symlink is useful, so we can clear the cached value.

So the calling sequence becomes:

	char last_symlink[PATH_MAX];

        *last_symlink = '\0';
        for each index entry { 
		if (lose)
                	unlink_entry(it, last_symlink);
		else if (update) {
			checkout_entry(it);
                        *last_symlink = '\0';
	}


---

diff --git a/builtin-apply.c b/builtin-apply.c
index 01acba8..8b8705a 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2022,7 +2022,7 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 		 * In such a case, path "new_name" does not exist as
 		 * far as git is concerned.
 		 */
-		if (has_symlink_leading_path(new_name))
+		if (has_symlink_leading_path(new_name, NULL))
 			return 0;
 
 		return error("%s: already exists in working directory", new_name);
diff --git a/cache.h b/cache.h
index ab66263..aaeb04a 100644
--- a/cache.h
+++ b/cache.h
@@ -410,7 +410,7 @@ struct checkout {
 };
 
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
-extern int has_symlink_leading_path(const char *name);
+extern int has_symlink_leading_path(const char *name, char *last_symlink);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
index cfecfcf..ee3f914 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-int has_symlink_leading_path(const char *name)
+int has_symlink_leading_path(const char *name, char *last_symlink)
 {
 	char path[PATH_MAX];
 	const char *sp, *ep;
@@ -9,6 +9,16 @@ int has_symlink_leading_path(const char *name)
 	sp = name;
 	dp = path;
 
+	if (last_symlink && *last_symlink) {
+		size_t last_len = strlen(last_symlink);
+		size_t len = strlen(name); 
+		if (last_len < len &&
+		    !strncmp(name, last_symlink, last_len) &&
+		    name[last_len] == '/')
+			return 1;
+		*last_symlink = '\0';
+	}
+
 	while (1) {
 		size_t len;
 		struct stat st;
@@ -24,8 +34,11 @@ int has_symlink_leading_path(const char *name)
 
 		if (lstat(path, &st))
 			return 0;
-		if (S_ISLNK(st.st_mode))
+		if (S_ISLNK(st.st_mode)) {
+			if (last_symlink)
+				strcpy(last_symlink, path);
 			return 1;
+		}
 
 		dp[len++] = '/';
 		dp = dp + len;
diff --git a/unpack-trees.c b/unpack-trees.c
index a6fa32f..906ce69 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -264,11 +264,11 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
  * directories, in case this unlink is the removal of the
  * last entry in the directory -- empty directories are removed.
  */
-static void unlink_entry(char *name)
+static void unlink_entry(char *name, char *last_symlink)
 {
 	char *cp, *prev;
 
-	if (has_symlink_leading_path(name))
+	if (has_symlink_leading_path(name, last_symlink))
 		return;
 	if (unlink(name))
 		return;
@@ -293,11 +293,12 @@ static void unlink_entry(char *name)
 
 static struct checkout state;
 static void check_updates(struct cache_entry **src, int nr,
-		struct unpack_trees_options *o)
+			struct unpack_trees_options *o)
 {
 	unsigned short mask = htons(CE_UPDATE);
 	unsigned cnt = 0, total = 0;
 	struct progress progress;
+	char last_symlink[PATH_MAX];
 
 	if (o->update && o->verbose_update) {
 		for (total = cnt = 0; cnt < nr; cnt++) {
@@ -311,6 +312,7 @@ static void check_updates(struct cache_entry **src, int nr,
 		cnt = 0;
 	}
 
+	*last_symlink = '\0';
 	while (nr--) {
 		struct cache_entry *ce = *src++;
 
@@ -319,13 +321,15 @@ static void check_updates(struct cache_entry **src, int nr,
 				display_progress(&progress, ++cnt);
 		if (!ce->ce_mode) {
 			if (o->update)
-				unlink_entry(ce->name);
+				unlink_entry(ce->name, last_symlink);
 			continue;
 		}
 		if (ce->ce_flags & mask) {
 			ce->ce_flags &= ~mask;
-			if (o->update)
+			if (o->update) {
 				checkout_entry(ce, &state, NULL);
+				*last_symlink = '\0';
+			}
 		}
 	}
 	if (total)
