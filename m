From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] git-fetch: avoid local fetching from alternate (again)
Date: Thu, 8 Nov 2007 17:27:02 -0500
Message-ID: <20071108222702.GO14735@spearce.org>
References: <20071108080058.GC16690@spearce.org> <20071108100039.GM14735@spearce.org> <7vhcjx2gq5.fsf@gitster.siamese.dyndns.org> <20071108112254.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 23:27:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqFqP-00078m-H2
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 23:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759556AbXKHW1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 17:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758937AbXKHW1H
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 17:27:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37384 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758555AbXKHW1G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 17:27:06 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqFpu-0008Op-GF; Thu, 08 Nov 2007 17:26:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 391C020FBAE; Thu,  8 Nov 2007 17:27:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071108112254.GN14735@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64083>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > 
> > > I'm starting to suspect heap corruption again in builtin-fetch.
> > > This patch alters the malloc() calls we are doing and may be shifting
> > > something around just enough in memory to cause a data overwrite or
> > > something and that's why this tag just drops out of the linked list?
> > > But then why does that happen in the test suite but not outside.
> > > Maybe because the test suite is setting environment variables that
> > > I'm not and the impact of those combined with these additional
> > > mallocs is what is breaking it?  *sigh*
> 
> Found it.  This ain't pretty.  Remember, what's failing in the test
> suite is we aren't getting "tag-three-file" automatically followed
> during fetch.  This is an annotated tag referring to a blob.

Here's one possible way of fixing this.  I think what we want is to
include "--not --all" when we run the object listing immediately
after the fetch so we mark *only* those objects we just fetched
and ignore the ones we already had reachable through existing refs.
This makes the walking cost proportional to the size of the fetch
and not the size of the object database.

Unfortunately when you insert "--not" in front of "--all" in the args
array below the test vectors all fail again.  Apparently we already
have the blob that "tag-three-file" refers to so its not something
we walk over during this process and the tag isn't followed.
That happens because the test repository we are fetching into
already has a number of objects through its refs/remotes/origin/*
namespace created by git-clone and the blob is already considered
to be reachable.

I'm not formatting this as a real patch because I'm not yet sure this
is the right way to fix the automatic tag following code.  Or the
right way to abuse the revision walking machinary within git-fetch
to implement such a feature.  Comments would be most appreciated.  :)


--8>--
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 847db73..77f1901 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -8,6 +8,9 @@
 #include "path-list.h"
 #include "remote.h"
 #include "transport.h"
+#include "diff.h"
+#include "list-objects.h"
+#include "revision.h"
 
 static const char fetch_usage[] = "git-fetch [-a | --append] [--upload-pack <upload-pack>] [-f | --force] [--no-tags] [-t | --tags] [-k | --keep] [-u | --update-head-ok] [--depth <depth>] [-v | --verbose] [<repository> <refspec>...]";
 
@@ -335,11 +338,43 @@ static void store_updated_refs(const char *url, struct ref *ref_map)
 	fclose(fp);
 }
 
+static void mark_just_fetched_commit(struct commit *commit)
+{
+}
+
+static void mark_just_fetched_object(struct object_array_entry *p)
+{
+	if (p->item->type == OBJ_BLOB && !has_sha1_file(p->item->sha1))
+		die("missing blob object '%s'", sha1_to_hex(p->item->sha1));
+}
+
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
 	int ret = transport_fetch_refs(transport, ref_map);
-	if (!ret)
+	if (!ret) {
+		const char *args[] = { "rev-list", "--objects", "--all", NULL};
+		struct rev_info revs;
+		struct ref *ref;
+
+		init_revisions(&revs, NULL);
+		setup_revisions(ARRAY_SIZE(args) - 1, args, &revs, NULL);
+		save_commit_buffer = 0;
+		track_object_refs = 0;
+
+		for (ref = ref_map; ref; ref = ref->next) {
+			struct object *o = parse_object(ref->old_sha1);
+			if (o)
+				add_pending_object(&revs, o, "(just-fetched)");
+		}
+
+		prepare_revision_walk(&revs);
+		mark_edges_uninteresting(revs.commits, &revs, NULL);
+		traverse_commit_list(&revs,
+			mark_just_fetched_commit,
+			mark_just_fetched_object);
+
 		store_updated_refs(transport->url, ref_map);
+	}
 	transport_unlock_pack(transport);
 	return ret;
 }
@@ -365,6 +400,7 @@ static struct ref *find_non_local_tags(struct transport *transport,
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
 	const struct ref *ref;
+	struct object *obj;
 
 	for_each_ref(add_existing, &existing_refs);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
@@ -389,7 +425,8 @@ static struct ref *find_non_local_tags(struct transport *transport,
 
 		if (!path_list_has_path(&existing_refs, ref_name) &&
 		    !path_list_has_path(&new_refs, ref_name) &&
-		    lookup_object(ref->old_sha1)) {
+		    (obj = lookup_object(ref->old_sha1)) &&
+		    obj->flags & SEEN) {
 			path_list_insert(ref_name, &new_refs);
 
 			rm = alloc_ref(strlen(ref_name) + 1);
diff --git a/list-objects.c b/list-objects.c
index e5c88c2..78bf04c 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -170,4 +170,5 @@ void traverse_commit_list(struct rev_info *revs,
 	}
 	for (i = 0; i < objects.nr; i++)
 		show_object(&objects.objects[i]);
+	free(objects.objects);
 }

-- 
Shawn.
