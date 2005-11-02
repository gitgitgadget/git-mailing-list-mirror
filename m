From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Warn when calling deref_tag() on broken tags
Date: Wed, 2 Nov 2005 21:41:01 +0100
Message-ID: <20051102204101.GE1431@pasky.or.cz>
References: <20051102200751.26904.5780.stgit@machine.or.cz> <Pine.LNX.4.63.0511022115250.13746@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 21:43:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXPQ2-0000lR-IB
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 21:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbVKBUlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 15:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbVKBUlG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 15:41:06 -0500
Received: from w241.dkm.cz ([62.24.88.241]:53944 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965228AbVKBUlF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 15:41:05 -0500
Received: (qmail 29818 invoked by uid 2001); 2 Nov 2005 21:41:01 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511022115250.13746@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11039>

Dear diary, on Wed, Nov 02, 2005 at 09:16:13PM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> On Wed, 2 Nov 2005, Petr Baudis wrote:
> 
> > On many places, we didn't bother checking deref_tag() return value against
> > NULL, causing GIT segfaulting e.g. on some old Cogito checkouts containing
> > residual tags from GIT.
> 
> Shouldn't a warning be issued in every of those cases? I don't know, but 
> those tags pointing nowhere don't seem useful to me.

Good idea. Not that I would be excited by the awing elegancy of the
patch...

---

When we hit a broken tag by deref_tag(), warn the user.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 commit.c      |    2 +-
 fetch-pack.c  |    4 ++--
 name-rev.c    |    2 +-
 send-pack.c   |    4 ++--
 server-info.c |    2 +-
 sha1_name.c   |    2 +-
 tag.c         |   12 ++++++++++--
 tag.h         |    2 +-
 upload-pack.c |    2 +-
 9 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/commit.c b/commit.c
index 8f40318..78aac42 100644
--- a/commit.c
+++ b/commit.c
@@ -55,7 +55,7 @@ static struct commit *check_commit(struc
 struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
 					      int quiet)
 {
-	struct object *obj = deref_tag(parse_object(sha1));
+	struct object *obj = deref_tag(parse_object(sha1), NULL);
 
 	if (!obj)
 		return NULL;
diff --git a/fetch-pack.c b/fetch-pack.c
index 1fae211..14b5918 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -38,7 +38,7 @@ static void rev_list_push(struct commit 
 
 static int rev_list_insert_ref(const char *path, const unsigned char *sha1)
 {
-	struct object *o = deref_tag(parse_object(sha1));
+	struct object *o = deref_tag(parse_object(sha1), path);
 
 	if (o && o->type == commit_type)
 		rev_list_push((struct commit *)o, SEEN);
@@ -317,7 +317,7 @@ static int everything_local(struct ref *
 	 * Don't mark them common yet; the server has to be told so first.
 	 */
 	for (ref = *refs; ref; ref = ref->next) {
-		struct object *o = deref_tag(lookup_object(ref->old_sha1));
+		struct object *o = deref_tag(lookup_object(ref->old_sha1), ref->name);
 
 		if (!o || o->type != commit_type || !(o->flags & COMPLETE))
 			continue;
diff --git a/name-rev.c b/name-rev.c
index 21fecdf..8ac2d72 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -164,7 +164,7 @@ int main(int argc, char **argv)
 			continue;
 		}
 
-		o = deref_tag(parse_object(sha1));
+		o = deref_tag(parse_object(sha1), *argv);
 		if (!o || o->type != commit_type) {
 			fprintf(stderr, "Could not get commit for %s. Skipping.\n",
 					*argv);
diff --git a/send-pack.c b/send-pack.c
index 9f9a6e7..3ee6794 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -126,12 +126,12 @@ static int ref_newer(const unsigned char
 	/* Both new and old must be commit-ish and new is descendant of
 	 * old.  Otherwise we require --force.
 	 */
-	o = deref_tag(parse_object(old_sha1));
+	o = deref_tag(parse_object(old_sha1), NULL);
 	if (!o || o->type != commit_type)
 		return 0;
 	old = (struct commit *) o;
 
-	o = deref_tag(parse_object(new_sha1));
+	o = deref_tag(parse_object(new_sha1), NULL);
 	if (!o || o->type != commit_type)
 		return 0;
 	new = (struct commit *) o;
diff --git a/server-info.c b/server-info.c
index 8e13c94..23d89fb 100644
--- a/server-info.c
+++ b/server-info.c
@@ -13,7 +13,7 @@ static int add_info_ref(const char *path
 
 	fprintf(info_ref_fp, "%s	%s\n", sha1_to_hex(sha1), path);
 	if (o->type == tag_type) {
-		o = deref_tag(o);
+		o = deref_tag(o, path);
 		if (o)
 			fprintf(info_ref_fp, "%s	%s^{}\n",
 				sha1_to_hex(o->sha1), path);
diff --git a/sha1_name.c b/sha1_name.c
index fe409fb..ae4c801 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -349,7 +349,7 @@ static int peel_onion(const char *name, 
 	if (!o)
 		return -1;
 	if (!type_string) {
-		o = deref_tag(o);
+		o = deref_tag(o, NULL);
 		if (!o || (!o->parsed && !parse_object(o->sha1)))
 			return -1;
 		memcpy(sha1, o->sha1, 20);
diff --git a/tag.c b/tag.c
index b1ab75f..9cd09cf 100644
--- a/tag.c
+++ b/tag.c
@@ -3,10 +3,18 @@
 
 const char *tag_type = "tag";
 
-struct object *deref_tag(struct object *o)
+/* The refname argument is optional and suitable to use only if
+ * we use this to resolve an actual tag ref. */
+struct object *deref_tag(struct object *o, const char *refname)
 {
+	struct object *o2 = o;
 	while (o && o->type == tag_type)
-		o = parse_object(((struct tag *)o)->tagged->sha1);
+		o = parse_object(((struct tag *)(o2 = o))->tagged->sha1);
+	if (!o)
+		fprintf(stderr, "warning: invalid tag %s\n",
+		        refname ? refname
+		        : (o2 ? sha1_to_hex(o2->sha1)
+		           : "<unknown> (this is probably internal GIT error)"));
 	return o;
 }
 
diff --git a/tag.h b/tag.h
index 36e5324..2b60b45 100644
--- a/tag.h
+++ b/tag.h
@@ -15,6 +15,6 @@ struct tag {
 extern struct tag *lookup_tag(const unsigned char *sha1);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
-extern struct object *deref_tag(struct object *);
+extern struct object *deref_tag(struct object *, const char *refname);
 
 #endif /* TAG_H */
diff --git a/upload-pack.c b/upload-pack.c
index f0b8e63..cc5b3e3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -226,7 +226,7 @@ static int send_ref(const char *refname,
 		nr_our_refs++;
 	}
 	if (o->type == tag_type) {
-		o = deref_tag(o);
+		o = deref_tag(o, refname);
 		if (o)
 			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
 	}

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
