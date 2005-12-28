From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add a "git-describe" command
Date: Wed, 28 Dec 2005 03:05:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512280300280.3194@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
 <Pine.LNX.4.64.0512241409300.14098@g5.osdl.org> <7v7j9q3vdu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 03:05:43 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErQh7-0005NQ-2l
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 03:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVL1CF0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 21:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVL1CF0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 21:05:26 -0500
Received: from mail.gmx.net ([213.165.64.21]:51377 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932396AbVL1CF0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Dec 2005 21:05:26 -0500
Received: (qmail invoked by alias); 28 Dec 2005 02:05:24 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp031) with SMTP; 28 Dec 2005 03:05:24 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j9q3vdu.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14091>

Hi,

On Tue, 27 Dec 2005, Junio C Hamano wrote:

> One problem with git-describe is that getting tags is a concious
> user action, and you need to do "git fetch --tags" from time to
> time in order to see the v1.0.4-g6e9961d6 name.

This is probably the biggest problem. I trust you to set the correct 
version in the Makefile just before tagging it.

Also, Linus hinted at similarities between git-describe and git-name-rev:

---
[PATCH] Teach name-rev to understand the "--inverse" flag

If "--inverse" is passed to name-rev, instead of naming the given revs
by the available refs, it does the opposite. The output is sorted by
distance, i.e. how many hops are between the rev and the ref. If the ref is
not an ancestor of the rev, the distance is inifinite, and the name is
undefined.

You can combine "--inverse" with "--tags", in effect getting the list of tags
ordered such that the tag describing the rev best comes first.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I guess this is what Linus has been hinting at when he said that
	git-name-rev could be adapted to achieve something similar to
	git-describe.

 name-rev.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 78 insertions(+), 7 deletions(-)

b1831f3f66f659445d2628dda73a1d79fc8c3b6f
diff --git a/name-rev.c b/name-rev.c
index 65333d4..4f7c04e 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -5,19 +5,21 @@
 #include "refs.h"
 
 static const char name_rev_usage[] =
-	"git-name-rev [--tags] ( --all | --stdin | commitish [commitish...] )\n";
+	"git-name-rev [--tags] ( --all | --stdin | \n"
+	"                       [--inverse] commitish [commitish...] )\n";
 
 typedef struct rev_name {
 	const char *tip_name;
 	int merge_traversals;
 	int generation;
+	int distance;
 } rev_name;
 
 static long cutoff = LONG_MAX;
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, int merge_traversals, int generation,
-		int deref)
+		int distance, int deref)
 {
 	struct rev_name *name = (struct rev_name *)commit->object.util;
 	struct commit_list *parents;
@@ -50,6 +52,7 @@ copy_data:
 		name->tip_name = tip_name;
 		name->merge_traversals = merge_traversals;
 		name->generation = generation;
+		name->distance = distance;
 	} else
 		return;
 
@@ -66,10 +69,10 @@ copy_data:
 				sprintf(new_name, "%s^%d", tip_name, parent_number);
 
 			name_rev(parents->item, new_name,
-				merge_traversals + 1 , 0, 0);
+				merge_traversals + 1 , 0, distance + 1, 0);
 		} else {
 			name_rev(parents->item, tip_name, merge_traversals,
-				generation + 1, 0);
+				generation + 1, distance + 1, 0);
 		}
 	}
 }
@@ -98,7 +101,7 @@ static int name_ref(const char *path, co
 		while ((p = strchr(path, '/')))
 			path = p+1;
 
-		name_rev(commit, strdup(path), 0, 0, deref);
+		name_rev(commit, strdup(path), 0, 0, 0, deref);
 	}
 	return 0;
 }
@@ -118,12 +121,56 @@ static const char* get_rev_name(struct o
 
 	return buffer;
 }
-	
+
+typedef struct {
+	const char* name;
+	struct object* o;
+} named_commit_t;
+static named_commit_t* ref_list = NULL;
+static int ref_count = 0;
+
+static int inverse_build_ref_list(const char *path, const unsigned char *sha1)
+{
+	struct object *o = deref_tag(parse_object(sha1), path, 0);
+
+	if ((!tags_only || !strncmp(path, "refs/tags/", 10)) &&
+			o->type == commit_type) {
+		struct commit* commit = (struct commit*)o;
+
+		if (cutoff > commit->date)
+			cutoff = commit->date;
+
+		if ((ref_count % 256) == 0)
+			ref_list = xrealloc(ref_list,
+				sizeof(named_commit_t*) * (ref_count + 256));
+		ref_list[ref_count].name = strdup(path);
+		ref_list[ref_count].o = (struct object*)commit;
+		ref_count++;
+	}
+	return 0;
+}
+
+static int name_comp(const void* a, const void* b)
+{
+	const rev_name* c = ((const named_commit_t*)a)->o->util;
+	const rev_name* d = ((const named_commit_t*)b)->o->util;
+
+	if (!c)
+		return 1;
+	if (!d)
+		return -1;
+	if (c->distance > d->distance)
+		return 1;
+	if (c->distance < d->distance)
+		return -1;
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	struct object_list *revs = NULL;
 	struct object_list **walker = &revs;
-	int as_is = 0, all = 0, transform_stdin = 0;
+	int as_is = 0, all = 0, inverse = 0, transform_stdin = 0;
 
 	setup_git_directory();
 
@@ -142,6 +189,9 @@ int main(int argc, char **argv)
 			} else if (!strcmp(*argv, "--tags")) {
 				tags_only = 1;
 				continue;
+			} else if (!strcmp(*argv, "--inverse")) {
+				inverse = 1;
+				continue;
 			} else if (!strcmp(*argv, "--all")) {
 				if (argc > 1)
 					die("Specify either a list, or --all, not both!");
@@ -181,6 +231,27 @@ int main(int argc, char **argv)
 		walker = &((*walker)->next);
 	}
 
+	if (inverse) {
+		int i;
+
+		if (transform_stdin || all || !revs)
+			usage(name_rev_usage);
+
+		for_each_ref(inverse_build_ref_list);
+		
+		tags_only = 0;
+		for (; revs; revs = revs->next)
+			name_ref(revs->name, revs->item->sha1);
+
+		qsort(ref_list, ref_count, sizeof(named_commit_t), name_comp);
+
+		for (i = 0; i < ref_count; i++)
+			printf("%s %s\n", ref_list[i].name,
+				get_rev_name(ref_list[i].o));
+
+		return 0;
+	}
+
 	for_each_ref(name_ref);
 
 	if (transform_stdin) {
-- 
1.0.GIT
