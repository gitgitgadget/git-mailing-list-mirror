From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [RFC] updates for git-pull-script
Date: Sun, 24 Apr 2005 14:55:32 -0500
Message-ID: <1114372532.5188.4.camel@mulgrave>
References: <1114352069.4997.24.camel@mulgrave>
	 <Pine.LNX.4.58.0504241045260.15879@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 21:51:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPn8K-0000GX-DZ
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 21:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVDXT4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVDXT4I
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 15:56:08 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:39401 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262381AbVDXTzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 15:55:45 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3OJtXA13443;
	Sun, 24 Apr 2005 15:55:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504241045260.15879@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-04-24 at 10:49 -0700, Linus Torvalds wrote:
> I don't think anybody preferes the original behaviour - the reason 
> git-pull-script punted with any non-trivial merge was that when I wrote 
> the damn thing, I was still just testing out the merges, and I definitely 
> didn't trust the automated script.

Well ... I kept checking it against BK for a while ... however it seems
to do the right thing, so I've been happy ...

> However, when you remove the "checkout-cache -f -a" thing, it means that 
> you are leaving all teh checked-out files in a state where it's _very_ 
> easy to mess up later, and doign so silently really is very bad.

Yes ... I really want the BK behaviour back where it would abort the
update if a change has to be made to a file that I've already touched.
I'm still thinking about how best to do this

> So at the _very_ least you should do an "update-cache --refresh", and 
> _tell_ the user about the files that are checked-out but not up-to-date.
> 
> And it really sounds like the whole and only reason you don't like 
> checkout-cache is that you normally work with an empty tree, so I actually 
> think that the _right_ answer for you is to add a new flag to 
> "checkout-cache" that only updates files that already exist. Something 
> like "-n" for "don't create new files". 

OK, look over the attached.  I added the -n option to checkout-cache and
an --ignore-missing to update-cache.  Now if I add

checkout-cache -n -f -a && update-cache --ignore-missing --refresh

it should do the right thing.

James

checkout-cache.c: f65be62b4abad184bd755884fb72681fc28c8b3b
--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -34,7 +34,7 @@
  */
 #include "cache.h"
 
-static int force = 0, quiet = 0;
+static int force = 0, quiet = 0, not_new = 0;
 
 static void create_directories(const char *path)
 {
@@ -118,7 +118,8 @@ static int checkout_entry(struct cache_e
 		 * just do the right thing)
 		 */
 		unlink(path);
-	}
+	} else if (not_new) 
+		return 0;
 	return write_entry(ce, path);
 }
 
@@ -182,6 +183,10 @@ int main(int argc, char **argv)
 				quiet = 1;
 				continue;
 			}
+			if (!strcmp(arg, "-n")) {
+				not_new = 1;
+				continue;
+			}
 			if (!memcmp(arg, "--prefix=", 9)) {
 				base_dir = arg+9;
 				continue;
update-cache.c: 4353b80890ba2afbe22248a4dc25060aa4a429b2
--- a/update-cache.c
+++ b/update-cache.c
@@ -12,7 +12,23 @@
  * like "update-cache *" and suddenly having all the object
  * files be revision controlled.
  */
-static int allow_add = 0, allow_remove = 0;
+static int allow_add = 0, allow_remove = 0, not_new = 0;
+
+/* Three functions to allow overloaded pointer return; see linux/err.h */
+static inline void *ERR_PTR(long error)
+{
+	return (void *) error;
+}
+
+static inline long PTR_ERR(const void *ptr)
+{
+	return (long) ptr;
+}
+
+static inline long IS_ERR(const void *ptr)
+{
+	return (unsigned long)ptr > (unsigned long)-1000L;
+}
 
 static int index_fd(unsigned char *sha1, int fd, struct stat *st)
 {
@@ -172,7 +188,7 @@ static struct cache_entry *refresh_entry
 	int changed, size;
 
 	if (stat(ce->name, &st) < 0)
-		return NULL;
+		return ERR_PTR(-errno);
 
 	changed = cache_match_stat(ce, &st);
 	if (!changed)
@@ -183,10 +199,10 @@ static struct cache_entry *refresh_entry
 	 * to refresh the entry - it's not going to match
 	 */
 	if (changed & MODE_CHANGED)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (compare_data(ce, st.st_size))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	size = ce_size(ce);
 	updated = malloc(size);
@@ -212,8 +228,9 @@ static void refresh_cache(void)
 		}
 
 		new = refresh_entry(ce);
-		if (!new) {
-			printf("%s: needs update\n", ce->name);
+		if (IS_ERR(new)) {
+			if (!(not_new && PTR_ERR(new) == -ENOENT))
+				printf("%s: needs update\n", ce->name);
 			continue;
 		}
 		active_cache[i] = new;
@@ -328,6 +345,10 @@ int main(int argc, char **argv)
 				i += 3;
 				continue;
 			}
+			if (!strcmp(path, "--ignore-missing")) {
+				not_new = 1;
+				continue;
+			}
 			die("unknown option %s", path);
 		}
 		if (!verify_path(path)) {


