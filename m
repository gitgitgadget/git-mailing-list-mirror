From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2] remote.c: avoid O(m*n) behavior in match_push_refs
Date: Mon,  8 Jul 2013 00:02:11 -0700
Message-ID: <1373266931-30391-1-git-send-email-drafnel@gmail.com>
References: <7v7gh7e6mh.fsf@alter.siamese.dyndns.org>
Cc: peff@peff.net, git@vger.kernel.org, mfick@codeaurora.org,
	bcasey@nvidia.com, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 08 09:02:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw5Sz-0003V3-LA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 09:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab3GHHC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 03:02:27 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:60085 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab3GHHCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 03:02:25 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so3936471pbc.23
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 00:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Q1JTSNOj9iYDmXBZ7/A8+proDLsyNBA6c1MasM1TahQ=;
        b=edF1am4EKWXTdxt0UkOJzioxGP4/3SapOLNgqYZF9/s4qAREPwJXx2ixDG4LL6OUQq
         /r2MHzIlwRRr8OJyGxMt09FCv+wOAfjz3eDfoH8Cd0iXAhr6U0r1W73CUHaX7gNHWUgr
         fy6rJMGqylZXXzaI7Zztn+HxRroW3husa/VCM5l5Zqlr+pnbeyDaBiDT69rnOgasA/7K
         wTWpuvk5OrVtBzYc3TyFEybhqdO6NM0x3IZ46S0yDflBDH2sl+1mwlxuJ1gSdaIr5AOE
         rXQ/yWmMLoEINPyO//CHFdCTlMhHz+0vhpKqKsgHfdf8vMdNgfsFZvK/KYw4Jw6Z3TE0
         RAwg==
X-Received: by 10.68.175.228 with SMTP id cd4mr20264834pbc.40.1373266945001;
        Mon, 08 Jul 2013 00:02:25 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPSA id wr9sm20829201pbc.7.2013.07.08.00.02.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 00:02:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <7v7gh7e6mh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229825>

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

Note, we refrain from using an index in the send_prune block since it
is expected that the number of refs that are being pruned is more
commonly much smaller than the number of local refs (i.e. m << n,
and particularly m < log(n), where m is the number of refs that
should be pruned and n is the number of local refs), so the overhead
of creating the search index would likely exceed the benefit of using
it.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---

Here is the reroll with an updated commit message that hopefully
provides a little more detail to justify this change.  I removed
the use of the search index in the send_prune block since I think
that pruning many refs is an uncommon operation and the overhead
of creating the index will more commonly exceed the benefit of
using it.

This version now lazily builds the search index in the first loop,
so there should be no impact when pushing using explicit refspecs.

e.g. pushing a change for review to Gerrit

   $ git push origin HEAD:refs/for/master

I suspect that this is the most common form of pushing and furthermore
will become the default once push.default defaults to 'current'.

The remaining push cases can be distilled into the following:

  ref-count    impact
  m >= log n   improved with this patch
  m < log n    regressed with this patch roughly ~6-7%

So, I think what we have to consider is whether the improvement to
something like 'git push --mirror' is worth the impact to an asymmetric
push where the number of local refs is much smaller than the number of
remote refs.  I'm not sure how common the latter really is though.
Gerrit does produce repositories with many refs on the remote end in
the refs/changes/ namespace, but do people commonly push to Gerrit
using matching or pattern refspecs?  Not sure, but I'd tend to think
that they don't.

-Brandon

 remote.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 6f57830..8bca65a 100644
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
@@ -1362,6 +1378,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		free(dst_name);
 	}
 
+	string_list_clear(&dst_ref_index, 0);
+
 	if (flags & MATCH_REFS_FOLLOW_TAGS)
 		add_missing_tags(src, dst, &dst_tail);
 
-- 
1.8.1.1.252.gdb33759
