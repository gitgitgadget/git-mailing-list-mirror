From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Re: git-http-pull broken in latest git
Date: Thu, 11 Aug 2005 19:38:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508111929010.12816@iabervon.org>
References: <42F8D472.3080404@de.bosch.com> <20050811223349.GI25280@pasky.ji.cz>
 <7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 01:35:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3MZg-0002IB-5v
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 01:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVHKXe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 19:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVHKXe5
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 19:34:57 -0400
Received: from iabervon.org ([66.92.72.58]:49168 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751044AbVHKXe4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 19:34:56 -0400
Received: (qmail 15391 invoked by uid 1000); 11 Aug 2005 19:38:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Aug 2005 19:38:09 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Aug 2005, Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
> > $ git-cat-file commit bf570303153902ec3d85570ed24515bcf8948848 | grep tree
> > tree 41f10531f1799bbb31a1e0f7652363154ce96f45
> > $ git-read-tree 41f10531f1799bbb31a1e0f7652363154ce96f45
> > fatal: failed to unpack tree object 41f10531f1799bbb31a1e0f7652363154ce96f45
> 
> > Kaboom. I think the issue might be that the reference dependency tree
> > building is broken and it should've pulled the other pack as well.
> 
> Last time I checked, git-http-pull did not utilize the pack
> dependency information, which indeed is wrong. 

Is there documentation on the format?

> When it decides to fetch a pack instead of an asked-for object, it 
> should check which commits the pack expects to have in your local 
> repository and add them to its list of things to slurp.

It should work anyway, except that I messed up some logic in the parallel 
pull stuff; when it finds it has something already, it ignores it 
entirely, rather than processing it. The following patch fixes this.
---
[PATCH] Fix parallel pull dependancy tracking.

It didn't refetch an object it already had (good), but didn't process
it, either (bad). Synchronously process anything you already have.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 pull.c |   57 ++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 32 insertions(+), 25 deletions(-)

9b6b4b259c6b00d5b2502c158bc800d7623352bc
diff --git a/pull.c b/pull.c
--- a/pull.c
+++ b/pull.c
@@ -98,12 +98,38 @@ static int process_tag(struct tag *tag)
 static struct object_list *process_queue = NULL;
 static struct object_list **process_queue_end = &process_queue;
 
-static int process(unsigned char *sha1, const char *type)
+static int process_object(struct object *obj)
 {
-	struct object *obj;
-	if (has_sha1_file(sha1))
+	if (obj->type == commit_type) {
+		if (process_commit((struct commit *)obj))
+			return -1;
+		return 0;
+	}
+	if (obj->type == tree_type) {
+		if (process_tree((struct tree *)obj))
+			return -1;
 		return 0;
-	obj = lookup_object_type(sha1, type);
+	}
+	if (obj->type == blob_type) {
+		return 0;
+	}
+	if (obj->type == tag_type) {
+		if (process_tag((struct tag *)obj))
+			return -1;
+		return 0;
+	}
+	return error("Unable to determine requirements "
+		     "of type %s for %s",
+		     obj->type, sha1_to_hex(obj->sha1));
+}
+
+static int process(unsigned char *sha1, const char *type)
+{
+	struct object *obj = lookup_object_type(sha1, type);
+	if (has_sha1_file(sha1)) {
+		/* We already have it, so we should scan it now. */
+		return process_object(obj);
+	}
 	if (object_list_contains(process_queue, obj))
 		return 0;
 	object_list_insert(obj, process_queue_end);
@@ -134,27 +160,8 @@ static int loop(void)
 			return -1;
 		if (!obj->type)
 			parse_object(obj->sha1);
-		if (obj->type == commit_type) {
-			if (process_commit((struct commit *)obj))
-				return -1;
-			continue;
-		}
-		if (obj->type == tree_type) {
-			if (process_tree((struct tree *)obj))
-				return -1;
-			continue;
-		}
-		if (obj->type == blob_type) {
-			continue;
-		}
-		if (obj->type == tag_type) {
-			if (process_tag((struct tag *)obj))
-				return -1;
-			continue;
-		}
-		return error("Unable to determine requirements "
-			     "of type %s for %s",
-			     obj->type, sha1_to_hex(obj->sha1));
+		if (process_object(obj))
+			return -1;
 	}
 	return 0;
 }
