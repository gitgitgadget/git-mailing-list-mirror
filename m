From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recent change in git.git/master broke my repos
Date: Fri, 26 Oct 2007 23:09:48 -0700
Message-ID: <7vejfhulzn.fsf@gitster.siamese.dyndns.org>
References: <86oden6z97.fsf@blue.stonehenge.com>
	<20071025165633.GA24143@coredump.intra.peff.net>
	<Pine.LNX.4.64.0710251351330.7345@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 08:10:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iles8-0000tL-LR
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 08:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXJ0GJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 02:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbXJ0GJ7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 02:09:59 -0400
Received: from rune.pobox.com ([208.210.124.79]:59088 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbXJ0GJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 02:09:58 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 0883E15091D;
	Sat, 27 Oct 2007 02:10:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AB4AB150916;
	Sat, 27 Oct 2007 02:10:12 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0710251351330.7345@iabervon.org> (Daniel
	Barkalow's message of "Thu, 25 Oct 2007 14:05:20 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62462>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Thu, 25 Oct 2007, Jeff King wrote:
>
>> On Thu, Oct 25, 2007 at 07:32:36AM -0700, Randal L. Schwartz wrote:
>> 
>> > I have echo "ref: refs/remotes/origin/master" >.git/refs/heads/upstream
>> > so that my daily update script can go:
>> > 
>> >    git-fetch
>> >    if [ repo is on master, and is not dirty ];
>> >       git-merge upstream
>> >    fi
>> > 
>> > Yesterday that worked.
>> > 
>> > Today I get a rash of:
>> > 
>> >   fatal: Couldn't find remote ref refs/remotes/origin/master
>> > 
>> > from my git-fetch.
>> 
>> Randal and I discussed this a bit on IRC, and it turns out not to be
>> related to the 'upstream' symref. Instead, he had a broken
>> branch.master.merge config that pointed to "refs/remotes/origin/master"
>> (which you can see from his script above doesn't actually get used).
>> 
>> So presumably the old git-fetch didn't care that the contents of
>> branch.*.master didn't exist (it's just that nothing got marked for
>> merging), but the one just merged from the db/fetch-pack topic does.
>> 
>> Is this behavior change intentional?
>
> It's not exactly intentional; it's just that nobody seems to have tested 
> this particular misconfiguration. It should probably report an error 
> (since the configuration is, in fact, broken and potentially misleading), 
> but it probably shouldn't be fatal and certainly shouldn't be so 
> uninformative.

How would we proceed from here, then?

If you had "branch.master.merge = refs/heads/foobar", kept
running happily, and suddenly the remote stopped carrying that
foobar branch, you would get a configuration that uses
nonexistent remote branch name, so this is not purely a
configuration error on the fetcher's side.

Older git used to enumerate remote tracking branches explicitly,
and one of the remote.origin.fetch entries would have said
"refs/heads/foobar:refs/remotes/origin/foobar", and that would
have made git-fetch fail with the error, complaining that such a
branch does not exist.

You are suggesting that git-fetch should not fail if
remote.origin.fetch is refs/heads/*:refs/remotes/origin/*
wildcard, and I think I can agree with that; "git pull" however
should notice and and exit with an error.

Perhaps something like this?

-- >8 --
[PATCH] git-fetch: do not fail when remote branch disappears

When the branch named with branch.$name.merge is not covered by
the fetch configuration for the remote repository named with
branch.$name.remote, we automatically add that branch to the set
of branches to be fetched.  However, if the remote repository
does not have that branch (e.g. it used to exist, but got
removed), this is not a reason to fail the git-fetch itself.

The situation however will be noticed if git-fetch was called by
git-pull, as the resulting FETCH_HEAD would not have any entry
that is marked for merging.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-fetch.c |   24 ++++++++++++++++--------
 remote.c        |   22 +++++++++++++---------
 remote.h        |    5 ++++-
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index b9d2b0c..003ed76 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -48,15 +48,21 @@ static void add_merge_config(struct ref **head,
 		if (rm)
 			continue;
 
-		/* Not fetched to a tracking branch?  We need to fetch
+		/*
+		 * Not fetched to a tracking branch?  We need to fetch
 		 * it anyway to allow this branch's "branch.$name.merge"
-		 * to be honored by git-pull.
+		 * to be honored by git-pull, but we do not have to
+		 * fail if branch.$name.merge is misconfigured to point
+		 * at a nonexisting branch.  If we were indeed called by
+		 * git-pull, it will notice the misconfiguration because
+		 * there is no entry in the resulting FETCH_HEAD marked
+		 * for merging.
 		 */
 		refspec.src = branch->merge[i]->src;
 		refspec.dst = NULL;
 		refspec.pattern = 0;
 		refspec.force = 0;
-		get_fetch_map(remote_refs, &refspec, tail);
+		get_fetch_map(remote_refs, &refspec, tail, 1);
 		for (rm = *old_tail; rm; rm = rm->next)
 			rm->merge = 1;
 	}
@@ -75,7 +81,7 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	if (ref_count || tags) {
 		for (i = 0; i < ref_count; i++) {
-			get_fetch_map(remote_refs, &refs[i], &tail);
+			get_fetch_map(remote_refs, &refs[i], &tail, 0);
 			if (refs[i].dst && refs[i].dst[0])
 				*autotags = 1;
 		}
@@ -88,7 +94,7 @@ static struct ref *get_ref_map(struct transport *transport,
 			refspec.dst = "refs/tags/";
 			refspec.pattern = 1;
 			refspec.force = 0;
-			get_fetch_map(remote_refs, &refspec, &tail);
+			get_fetch_map(remote_refs, &refspec, &tail, 0);
 		}
 	} else {
 		/* Use the defaults */
@@ -97,7 +103,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		int has_merge = branch_has_merge_config(branch);
 		if (remote && (remote->fetch_refspec_nr || has_merge)) {
 			for (i = 0; i < remote->fetch_refspec_nr; i++) {
-				get_fetch_map(remote_refs, &remote->fetch[i], &tail);
+				get_fetch_map(remote_refs, &remote->fetch[i], &tail, 0);
 				if (remote->fetch[i].dst &&
 				    remote->fetch[i].dst[0])
 					*autotags = 1;
@@ -110,11 +116,13 @@ static struct ref *get_ref_map(struct transport *transport,
 			 * as given in branch.<name>.remote, we add the
 			 * ref given in branch.<name>.merge, too.
 			 */
-			if (has_merge && !strcmp(branch->remote_name,
-						remote->name))
+			if (has_merge &&
+			    !strcmp(branch->remote_name, remote->name))
 				add_merge_config(&ref_map, remote_refs, branch, &tail);
 		} else {
 			ref_map = get_remote_ref(remote_refs, "HEAD");
+			if (!ref_map)
+				die("Couldn't find remote ref HEAD");
 			ref_map->merge = 1;
 		}
 	}
diff --git a/remote.c b/remote.c
index 170015a..bec2ba1 100644
--- a/remote.c
+++ b/remote.c
@@ -857,7 +857,7 @@ struct ref *get_remote_ref(struct ref *remote_refs, const char *name)
 	struct ref *ref = find_ref_by_name_abbrev(remote_refs, name);
 
 	if (!ref)
-		die("Couldn't find remote ref %s\n", name);
+		return NULL;
 
 	return copy_ref(ref);
 }
@@ -889,20 +889,24 @@ static struct ref *get_local_ref(const char *name)
 
 int get_fetch_map(struct ref *remote_refs,
 		  const struct refspec *refspec,
-		  struct ref ***tail)
+		  struct ref ***tail,
+		  int missing_ok)
 {
 	struct ref *ref_map, *rm;
 
 	if (refspec->pattern) {
 		ref_map = get_expanded_map(remote_refs, refspec);
 	} else {
-		ref_map = get_remote_ref(remote_refs,
-					 refspec->src[0] ?
-					 refspec->src : "HEAD");
-
-		ref_map->peer_ref = get_local_ref(refspec->dst);
-		if (ref_map->peer_ref && refspec->force)
-			ref_map->peer_ref->force = 1;
+		const char *name = refspec->src[0] ? refspec->src : "HEAD";
+
+		ref_map = get_remote_ref(remote_refs, name);
+		if (!missing_ok && !ref_map)
+			die("Couldn't find remote ref %s", name);
+		if (ref_map) {
+			ref_map->peer_ref = get_local_ref(refspec->dst);
+			if (ref_map->peer_ref && refspec->force)
+				ref_map->peer_ref->force = 1;
+		}
 	}
 
 	for (rm = ref_map; rm; rm = rm->next) {
diff --git a/remote.h b/remote.h
index c62636d..878b4ec 100644
--- a/remote.h
+++ b/remote.h
@@ -67,9 +67,12 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
  * *tail is the pointer to the tail pointer of the list of results
  * beforehand, and will be set to the tail pointer of the list of
  * results afterward.
+ *
+ * missing_ok is usually false, but when we are adding branch.$name.merge
+ * it is Ok if the branch is not at the remote anymore.
  */
 int get_fetch_map(struct ref *remote_refs, const struct refspec *refspec,
-		  struct ref ***tail);
+		  struct ref ***tail, int missing_ok);
 
 struct ref *get_remote_ref(struct ref *remote_refs, const char *name);
 
