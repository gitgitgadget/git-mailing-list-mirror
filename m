From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 6/6] http-push: cleanup
Date: Fri, 10 Mar 2006 20:18:33 -0800
Message-ID: <20060311041833.GH3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 11 05:18:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHvYs-0004wz-CQ
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 05:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWCKESf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 23:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWCKESf
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 23:18:35 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:50127 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932414AbWCKESe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 23:18:34 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2B4IYOv007678
	for <git@vger.kernel.org>; Fri, 10 Mar 2006 20:18:34 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2B4IYwF007676
	for git@vger.kernel.org; Fri, 10 Mar 2006 20:18:34 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17492>

More consistent usage string, condense push output, remove extra slashes
in URLs, fix unused variables, include HTTP method name in failure
messages.

---

 http-push.c |   51 ++++++++++++++++++++++++++++++---------------------
 1 files changed, 30 insertions(+), 21 deletions(-)

84bd077e6aa433485124d9dd433ef3d7b674e5ea
diff --git a/http-push.c b/http-push.c
index 65c6664..181a0d4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -11,7 +11,7 @@
 #include <expat.h>
 
 static const char http_push_usage[] =
-"git-http-push [--complete] [--force] [--verbose] <url> <ref> [<ref>...]\n";
+"git-http-push [--all] [--force] [--verbose] <remote> [<head>...]\n";
 
 #ifndef XML_STATUS_OK
 enum XML_Status {
@@ -707,8 +707,9 @@ static void finish_request(struct transf
 		}
 	} else if (request->state == RUN_MOVE) {
 		if (request->curl_result == CURLE_OK) {
-			fprintf(stderr, "    sent %s\n",
-				sha1_to_hex(request->obj->sha1));
+			if (push_verbosely)
+				fprintf(stderr, "    sent %s\n",
+					sha1_to_hex(request->obj->sha1));
 			request->obj->flags |= REMOTE;
 			release_request(request);
 		} else {
@@ -848,7 +849,7 @@ static void add_fetch_request(struct obj
 	step_active_slots();
 }
 
-static void add_send_request(struct object *obj, struct remote_lock *lock)
+static int add_send_request(struct object *obj, struct remote_lock *lock)
 {
 	struct transfer_request *request = request_queue_head;
 	struct packed_git *target;
@@ -863,11 +864,11 @@ static void add_send_request(struct obje
 	if (remote_dir_exists[obj->sha1[0]] == -1)
 		get_remote_object_list(obj->sha1[0]);
 	if (obj->flags & (REMOTE | PUSHING))
-		return;
+		return 0;
 	target = find_sha1_pack(obj->sha1, remote->packs);
 	if (target) {
 		obj->flags |= REMOTE;
-		return;
+		return 0;
 	}
 
 	obj->flags |= PUSHING;
@@ -884,6 +885,8 @@ static void add_send_request(struct obje
 
 	fill_active_slots();
 	step_active_slots();
+
+	return 1;
 }
 
 static int fetch_index(unsigned char *sha1)
@@ -901,8 +904,8 @@ static int fetch_index(unsigned char *sh
 	struct slot_results results;
 
 	/* Don't use the index if the pack isn't there */
-	url = xmalloc(strlen(remote->url) + 65);
-	sprintf(url, "%s/objects/pack/pack-%s.pack", remote->url, hex);
+	url = xmalloc(strlen(remote->url) + 64);
+	sprintf(url, "%sobjects/pack/pack-%s.pack", remote->url, hex);
 	slot = get_active_slot();
 	slot->results = &results;
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
@@ -924,7 +927,7 @@ static int fetch_index(unsigned char *sh
 	if (push_verbosely)
 		fprintf(stderr, "Getting index for pack %s\n", hex);
 	
-	sprintf(url, "%s/objects/pack/pack-%s.idx", remote->url, hex);
+	sprintf(url, "%sobjects/pack/pack-%s.idx", remote->url, hex);
 	
 	filename = sha1_pack_index_name(sha1);
 	snprintf(tmpfile, sizeof(tmpfile), "%s.temp", filename);
@@ -1009,8 +1012,8 @@ static int fetch_indices(void)
 	if (push_verbosely)
 		fprintf(stderr, "Getting pack list\n");
 	
-	url = xmalloc(strlen(remote->url) + 21);
-	sprintf(url, "%s/objects/info/packs", remote->url);
+	url = xmalloc(strlen(remote->url) + 20);
+	sprintf(url, "%sobjects/info/packs", remote->url);
 
 	slot = get_active_slot();
 	slot->results = &results;
@@ -1298,7 +1301,7 @@ static struct remote_lock *lock_remote(c
 				return NULL;
 			}
 		} else {
-			fprintf(stderr, "Unable to start request\n");
+			fprintf(stderr, "Unable to start MKCOL request\n");
 			free(url);
 			return NULL;
 		}
@@ -1359,7 +1362,7 @@ static struct remote_lock *lock_remote(c
 			}
 		}
 	} else {
-		fprintf(stderr, "Unable to start request\n");
+		fprintf(stderr, "Unable to start LOCK request\n");
 	}
 
 	curl_slist_free_all(dav_headers);
@@ -1673,7 +1676,7 @@ static int locking_available(void)
 			}
 		}
 	} else {
-		fprintf(stderr, "Unable to start request\n");
+		fprintf(stderr, "Unable to start PROPFIND request\n");
 	}
 
 	free(out_data);
@@ -1734,16 +1737,17 @@ static struct object_list **process_tree
 	return p;
 }
 
-static void get_delta(struct rev_info *revs, struct remote_lock *lock)
+static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 {
 	struct commit *commit;
 	struct object_list **p = &objects, *pending;
+	int count = 0;
 
 	while ((commit = get_revision(revs)) != NULL) {
 		p = process_tree(commit->tree, p, NULL, "");
 		commit->object.flags |= LOCAL;
 		if (!(commit->object.flags & UNINTERESTING))
-			add_send_request(&commit->object, lock);
+			count += add_send_request(&commit->object, lock);
 	}
 
 	for (pending = revs->pending_objects; pending; pending = pending->next) {
@@ -1770,9 +1774,11 @@ static void get_delta(struct rev_info *r
 
 	while (objects) {
 		if (!(objects->item->flags & UNINTERESTING))
-			add_send_request(objects->item, lock);
+			count += add_send_request(objects->item, lock);
 		objects = objects->next;
 	}
+
+	return count;
 }
 
 static int update_remote(unsigned char *sha1, struct remote_lock *lock)
@@ -2106,6 +2112,7 @@ int main(int argc, char **argv)
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
 	struct rev_info revs;
+	int objects_to_send;
 	int rc = 0;
 	int i;
 
@@ -2197,7 +2204,6 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
-	int ret = 0;
 	int new_refs = 0;
 	struct ref *ref;
 	for (ref = remote_refs; ref; ref = ref->next) {
@@ -2229,14 +2235,14 @@ int main(int argc, char **argv)
 				      "need to pull first?",
 				      ref->name,
 				      ref->peer_ref->name);
-				ret = -2;
+				rc = -2;
 				continue;
 			}
 		}
 		memcpy(ref->new_sha1, ref->peer_ref->new_sha1, 20);
 		if (is_zero_sha1(ref->new_sha1)) {
 			error("cannot happen anymore");
-			ret = -3;
+			rc = -3;
 			continue;
 		}
 		new_refs++;
@@ -2283,12 +2289,15 @@ int main(int argc, char **argv)
 		pushing = 0;
 		prepare_revision_walk(&revs);
 		mark_edges_uninteresting(revs.commits);
-		get_delta(&revs, ref_lock);
+		objects_to_send = get_delta(&revs, ref_lock);
 		finish_all_active_slots();
 
 		/* Push missing objects to remote, this would be a
 		   convenient time to pack them first if appropriate. */
 		pushing = 1;
+		if (objects_to_send)
+			fprintf(stderr, "    sending %d objects\n",
+				objects_to_send);
 		fill_active_slots();
 		finish_all_active_slots();
 
-- 
1.2.4.g8e81-dirty
