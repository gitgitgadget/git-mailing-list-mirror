From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 w/prune index] remote.c: avoid O(m*n) behavior in match_push_refs
Date: Mon,  8 Jul 2013 01:58:39 -0700
Message-ID: <1373273919-32005-1-git-send-email-drafnel@gmail.com>
References: <20130708075007.GB25072@sigill.intra.peff.net>
Cc: gitster@pobox.com, git@vger.kernel.org, mfick@codeaurora.org,
	bcasey@nvidia.com, Brandon Casey <drafnel@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Mon Jul 08 10:58:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw7Hc-0002BU-BG
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 10:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab3GHI6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 04:58:50 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44464 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab3GHI6t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 04:58:49 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so3867744pdj.26
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bKuX9T1N7Rh7t2Vo6Fx5DYptM0NfwCe1oGlgRkwBX4o=;
        b=KWExr+ZvQxXZqfNKhVzyL8uWy041r3KoItr4zmzT8MGLjjNOZffE1Bj27vW3xL7CqP
         gqOClexd9oT7a0fctJmqJbKNgtkJ7KD1g1xC47wISclcGmy7Dq5XKm5x75MffURiS2SW
         AOXDvw6nmj1u1J6B92yox8csbJKu0w2RnZ5Z3KP0B4rkevk5eYUKHJRzoK7vuRdeAZQR
         bQxp9OVUcbHUM7lgqTm0zOZtmFxirRnp5DClHnxzZq18K+w1wF6aKFdNLb3URc6bDS3T
         WGX/Y6AAmZi1kFZbqC0Vx7n+dZUR6H/jxT37fGN4au4iLLI1hDA7QVRp/z97xhWdElSR
         9GFg==
X-Received: by 10.68.52.10 with SMTP id p10mr20527722pbo.92.1373273928685;
        Mon, 08 Jul 2013 01:58:48 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPSA id cx3sm21339362pbb.30.2013.07.08.01.58.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 01:58:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <20130708075007.GB25072@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229831>

When pushing using a matching refspec or a pattern refspec, each ref
in the local repository must be paired with a ref advertised by the
remote server.  This is accomplished by using the refspec to transform
the name of the local ref into the name it should have in the remote
repository, and then performing a linear search through the list of
remote refs to see if the remote ref was advertised by the remote
system.

Each of these lookups has O(n) complexity and makes match_push_refs()
be an O(m*n) operation, where m is the number of local refs and n is
the number of remote refs.  If there are many refs 100,000+, then this
ref matching can take a significant amount of time.  Let's prepare an
index of the remote refs to allow searching in O(log n) time and
reduce the complexity of match_push_refs() to O(m log n).

We prepare the index lazily so that it is only created when necessary.
So, there should be no impact when _not_ using a matching or pattern
refspec, i.e. when pushing using only explicit refspecs.

Dry-run push of a repository with 121,913 local and remote refs:

        before     after
real    1m40.582s  0m0.804s
user    1m39.914s  0m0.515s
sys     0m0.125s   0m0.106s

The creation of the index has overhead.  So, if there are very few
local refs, then it could take longer to create the index than it
would have taken to just perform n linear lookups into the remote
ref space.  Using the index should provide some improvement when
the number of local refs is roughly greater than the log of the
number of remote refs (i.e. m >= log n).  The pathological case is
when there is a single local ref and very many remote refs.

Dry-run push of a repository with 121,913 remote refs and a single
local ref:

        before    after
real    0m0.525s  0m0.566s
user    0m0.243s  0m0.279s
sys     0m0.075s  0m0.099s

Using an index takes 41 ms longer, or roughly 7.8% longer.

Jeff King measured a no-op push of a single ref into a remote repo
with 370,000 refs:

        before    after
real    0m1.087s  0m1.156s
user    0m1.344s  0m1.412s
sys     0m0.288s  0m0.284s

Using an index takes 69 ms longer, or roughly 6.3% longer.

None of the measurements above required transferring any objects to
the remote repository.  If the push required transferring objects and
updating the refs in the remote repository, the impact of preparing
the search index would be even smaller.

A similar operation is performed in the reverse direction when pruning
using a matching or pattern refspec.  Let's avoid O(m*n) behavior in
the same way by lazily preparing an index on the local refs.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---

On Mon, Jul 8, 2013 at 12:50 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jul 08, 2013 at 12:02:11AM -0700, Brandon Casey wrote:
> 
> > Here is the reroll with an updated commit message that hopefully
> > provides a little more detail to justify this change.  I removed
> > the use of the search index in the send_prune block since I think
> > that pruning many refs is an uncommon operation and the overhead
> > of creating the index will more commonly exceed the benefit of
> > using it.
> 
> I don't know. I'd think that if you are using pruning, you might delete
> a large chunk at one time (e.g., rearranging your ref hierarchy,
> followed by "git push --mirror"). But that is just my gut feeling. I
> haven't actually run into this slow-down in the real world (we typically
> fetch from our giant repositories rather than push into them).

Firstly, why are you still awake?!?! :)

Secondly, fair enough.  I don't think the change to the pruning block
will have much impact in real repos either way.  In this block, the
search is being performed on the local refs.  There would have to be
many refs on the local side for the generation of the index to be
significant enough to notice.

So, I'm fine with using the index when pruning too to avoid worst-case
behavior when there are many local refs and many deletions.

-Brandon

 remote.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 6f57830..efcba93 100644
--- a/remote.c
+++ b/remote.c
@@ -1302,6 +1302,14 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 	free(sent_tips.tip);
 }
 
+static void prepare_ref_index(struct string_list *ref_index, struct ref *ref)
+{
+	for ( ; ref; ref = ref->next)
+		string_list_append_nodup(ref_index, ref->name)->util = ref;
+
+	sort_string_list(ref_index);
+}
+
 /*
  * Given the set of refs the local repository has, the set of refs the
  * remote repository has, and the refspec used for push, determine
@@ -1320,6 +1328,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	int errs;
 	static const char *default_refspec[] = { ":", NULL };
 	struct ref *ref, **dst_tail = tail_ref(dst);
+	struct string_list dst_ref_index = STRING_LIST_INIT_NODUP;
 
 	if (!nr_refspec) {
 		nr_refspec = 1;
@@ -1330,6 +1339,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 
 	/* pick the remainder */
 	for (ref = src; ref; ref = ref->next) {
+		struct string_list_item *dst_item;
 		struct ref *dst_peer;
 		const struct refspec *pat = NULL;
 		char *dst_name;
@@ -1338,7 +1348,11 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		if (!dst_name)
 			continue;
 
-		dst_peer = find_ref_by_name(*dst, dst_name);
+		if (!dst_ref_index.nr)
+			prepare_ref_index(&dst_ref_index, *dst);
+
+		dst_item = string_list_lookup(&dst_ref_index, dst_name);
+		dst_peer = dst_item ? dst_item->util : NULL;
 		if (dst_peer) {
 			if (dst_peer->peer_ref)
 				/* We're already sending something to this ref. */
@@ -1355,6 +1369,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
 			/* Create a new one and link it */
 			dst_peer = make_linked_ref(dst_name, &dst_tail);
 			hashcpy(dst_peer->new_sha1, ref->new_sha1);
+			string_list_insert(&dst_ref_index,
+				dst_peer->name)->util = dst_peer;
 		}
 		dst_peer->peer_ref = copy_ref(ref);
 		dst_peer->force = pat->force;
@@ -1362,10 +1378,13 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		free(dst_name);
 	}
 
+	string_list_clear(&dst_ref_index, 0);
+
 	if (flags & MATCH_REFS_FOLLOW_TAGS)
 		add_missing_tags(src, dst, &dst_tail);
 
 	if (send_prune) {
+		struct string_list src_ref_index = STRING_LIST_INIT_NODUP;
 		/* check for missing refs on the remote */
 		for (ref = *dst; ref; ref = ref->next) {
 			char *src_name;
@@ -1376,11 +1395,15 @@ int match_push_refs(struct ref *src, struct ref **dst,
 
 			src_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_DST, NULL);
 			if (src_name) {
-				if (!find_ref_by_name(src, src_name))
+				if (!src_ref_index.nr)
+					prepare_ref_index(&src_ref_index, src);
+				if (!string_list_has_string(&src_ref_index,
+					    src_name))
 					ref->peer_ref = alloc_delete_ref();
 				free(src_name);
 			}
 		}
+		string_list_clear(&src_ref_index, 0);
 	}
 	if (errs)
 		return -1;
-- 
1.8.1.1.252.gdb33759
