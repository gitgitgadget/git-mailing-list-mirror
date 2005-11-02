From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Warn when calling deref_tag() on broken tags
Date: Wed, 02 Nov 2005 15:21:01 -0800
Message-ID: <7vhdauocv6.fsf@assigned-by-dhcp.cox.net>
References: <20051102200751.26904.5780.stgit@machine.or.cz>
	<Pine.LNX.4.63.0511022115250.13746@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051102204101.GE1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 00:23:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXRv0-0005a7-EU
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 00:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbVKBXVD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 18:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965334AbVKBXVD
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 18:21:03 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:19926 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751528AbVKBXVC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 18:21:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102232018.QTKT776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 18:20:18 -0500
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11057>

Petr Baudis <pasky@suse.cz> writes:

> Good idea. Not that I would be excited by the awing elegancy of the
> patch...

It turns out to be not so good idea.  Some places call deref_tag
just to see if we can unwrap it but not having the referenced
object but having the tag object does not necessarily mean a
corrupt repository.

For example, after a fetch that retrieved and stored a tag
object but was interrupted before retrieving and storing the
object the tag refers to, we do not update the refs of our end
(which is correct).  After this, imagine fetching from the same
remote for the same tag.  fetch-pack.c::everything_local will
find that we do have the tag object the remote says it has,
hoping that we can mark it one of the common refs, if that tag
is something reachable from our refs (it is not).  The caller of
the deref_tag() there is careful not to assume the tag is
complete, but it should not bark -- we should just ignore and
pretend that dangling tag object is something we do not have.

I've done it a slightly differently.  Does this look OK to you?

-- >8 -- cut here -- >8 --

Subject: [PATCH] Be careful when dereferencing tags.

One caller of deref_tag() was not careful enough to make sure
what deref_tag() returned was not NULL (i.e. we found a tag
object that points at an object we do not have).  Fix it, and
warn about refs that point at such an incomplete tag where
needed.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 commit.c      |    2 +-
 fetch-pack.c  |    7 ++++---
 name-rev.c    |    2 +-
 send-pack.c   |    4 ++--
 server-info.c |    7 ++++---
 sha1_name.c   |    2 +-
 tag.c         |    7 ++++++-
 tag.h         |    2 +-
 upload-pack.c |    2 +-
 9 files changed, 21 insertions(+), 14 deletions(-)

applies-to: 003cf1e61da5c5fe13ed574ae3630c1ee8b56cae
30a28f848f666ae6f6641baa2917a8ea15ad3160
diff --git a/commit.c b/commit.c
index 8f40318..a8c9bfc 100644
--- a/commit.c
+++ b/commit.c
@@ -55,7 +55,7 @@ static struct commit *check_commit(struc
 struct commit *lookup_commit_reference_gently(const unsigned char *sha1,
 					      int quiet)
 {
-	struct object *obj = deref_tag(parse_object(sha1));
+	struct object *obj = deref_tag(parse_object(sha1), NULL, 0);
 
 	if (!obj)
 		return NULL;
diff --git a/fetch-pack.c b/fetch-pack.c
index 3df9911..cb21715 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -38,9 +38,9 @@ static void rev_list_push(struct commit 
 
 static int rev_list_insert_ref(const char *path, const unsigned char *sha1)
 {
-	struct object *o = deref_tag(parse_object(sha1));
+	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
-	if (o->type == commit_type)
+	if (o && o->type == commit_type)
 		rev_list_push((struct commit *)o, SEEN);
 
 	return 0;
@@ -317,7 +317,8 @@ static int everything_local(struct ref *
 	 * Don't mark them common yet; the server has to be told so first.
 	 */
 	for (ref = *refs; ref; ref = ref->next) {
-		struct object *o = deref_tag(lookup_object(ref->old_sha1));
+		struct object *o = deref_tag(lookup_object(ref->old_sha1),
+					     NULL, 0);
 
 		if (!o || o->type != commit_type || !(o->flags & COMPLETE))
 			continue;
diff --git a/name-rev.c b/name-rev.c
index 21fecdf..59194f1 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -164,7 +164,7 @@ int main(int argc, char **argv)
 			continue;
 		}
 
-		o = deref_tag(parse_object(sha1));
+		o = deref_tag(parse_object(sha1), *argv, 0);
 		if (!o || o->type != commit_type) {
 			fprintf(stderr, "Could not get commit for %s. Skipping.\n",
 					*argv);
diff --git a/send-pack.c b/send-pack.c
index 9f9a6e7..3eeb18f 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -126,12 +126,12 @@ static int ref_newer(const unsigned char
 	/* Both new and old must be commit-ish and new is descendant of
 	 * old.  Otherwise we require --force.
 	 */
-	o = deref_tag(parse_object(old_sha1));
+	o = deref_tag(parse_object(old_sha1), NULL, 0);
 	if (!o || o->type != commit_type)
 		return 0;
 	old = (struct commit *) o;
 
-	o = deref_tag(parse_object(new_sha1));
+	o = deref_tag(parse_object(new_sha1), NULL, 0);
 	if (!o || o->type != commit_type)
 		return 0;
 	new = (struct commit *) o;
diff --git a/server-info.c b/server-info.c
index ba53591..0cba8e1 100644
--- a/server-info.c
+++ b/server-info.c
@@ -13,9 +13,10 @@ static int add_info_ref(const char *path
 
 	fprintf(info_ref_fp, "%s	%s\n", sha1_to_hex(sha1), path);
 	if (o->type == tag_type) {
-		o = deref_tag(o);
-		fprintf(info_ref_fp, "%s	%s^{}\n",
-			sha1_to_hex(o->sha1), path);
+		o = deref_tag(o, path, 0);
+		if (o)
+			fprintf(info_ref_fp, "%s	%s^{}\n",
+				sha1_to_hex(o->sha1), path);
 	}
 	return 0;
 }
diff --git a/sha1_name.c b/sha1_name.c
index fe409fb..be1755a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -349,7 +349,7 @@ static int peel_onion(const char *name, 
 	if (!o)
 		return -1;
 	if (!type_string) {
-		o = deref_tag(o);
+		o = deref_tag(o, name, sp - name - 2);
 		if (!o || (!o->parsed && !parse_object(o->sha1)))
 			return -1;
 		memcpy(sha1, o->sha1, 20);
diff --git a/tag.c b/tag.c
index b1ab75f..e574c4b 100644
--- a/tag.c
+++ b/tag.c
@@ -3,10 +3,15 @@
 
 const char *tag_type = "tag";
 
-struct object *deref_tag(struct object *o)
+struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == tag_type)
 		o = parse_object(((struct tag *)o)->tagged->sha1);
+	if (!o && warn) {
+		if (!warnlen)
+			warnlen = strlen(warn);
+		error("missing object referenced by '%.*s'", warnlen, warn);
+	}
 	return o;
 }
 
diff --git a/tag.h b/tag.h
index 36e5324..7a0cb00 100644
--- a/tag.h
+++ b/tag.h
@@ -15,6 +15,6 @@ struct tag {
 extern struct tag *lookup_tag(const unsigned char *sha1);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
-extern struct object *deref_tag(struct object *);
+extern struct object *deref_tag(struct object *, const char *, int);
 
 #endif /* TAG_H */
diff --git a/upload-pack.c b/upload-pack.c
index c5eff21..be63132 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -226,7 +226,7 @@ static int send_ref(const char *refname,
 		nr_our_refs++;
 	}
 	if (o->type == tag_type) {
-		o = deref_tag(o);
+		o = deref_tag(o, refname, 0);
 		packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
 	}
 	return 0;
---
0.99.9.GIT
