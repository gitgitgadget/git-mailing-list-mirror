Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525A22021E
	for <e@80x24.org>; Fri, 19 May 2017 17:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbdESReo (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 13:34:44 -0400
Received: from fau.xxx ([94.23.43.98]:48654 "EHLO blind.goeswhere.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbdESReo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 13:34:44 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 May 2017 13:34:43 EDT
Received: by blind.goeswhere.com (Postfix, from userid 1000)
        id 8C3B1E0C1A; Fri, 19 May 2017 18:28:56 +0100 (BST)
Date:   Fri, 19 May 2017 18:28:56 +0100
From:   Chris West <solo-git-vger@goeswhere.com>
To:     git@vger.kernel.org
Subject: die("bad object.. for duplicate tagged tag in remote
Message-ID: <20170519172856.GA14673@blind.goeswhere.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bear with me here, I hit this in a real repo.

If you have an annotated tag of an annotated tag, and `remote update`
elects not to fetch this tag (perhaps because it has a name collision
locally), then the repo ends up corrupt: you can't gc it, but fsck
doesn't notice.

Two repos, named "bad" and "good":

bad$ git tag -a inner
bad$ git tag -a outer inner
bad$ git tag -d inner
bad$ git show outer
tag outer
Tagger: ...
Date:   ...

This is the outer tag.

tag inner
Tagger: ...
Date:   ...

This is the inner tag.

commit 826365dcfec304a80b227a990f7d5c805bce3dd9
Author: ...
...

bad$ git rev-parse outer
070707..
bad$ git cat-file tag outer
object 03030303...


good$ git tag -a outer # create a colliding tag
good$ git remote add bad ../bad

good$ git remote update
warning: no common commits
remote: Counting objects: 4, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (4/4), done.
From ../bad
 * [new branch]      master     -> bad/master


Note how it has not fetched the tag ref, but it has fetched one of the
tag objects:

$ git show 07070
error: Could not read object 0303030..
tag outer
Tagger: ...

$ git fsck
...
dangling tag 07070...

I actually don't get that on the real repo, but do on this testcase. Hmm.
`git fsck` exits with success here. This is bad, as the object graph is
incomplete?


$ git gc
fatal: bad object 03030303...
error: failed to run repack

`git gc` fails with this meaningless error. The attached patch improves
the error.

I don't know where the rest of the problem lies. What's the expected
behaviour when a tag already exists locally, but is different? Fetch
the object anyway, but ignore it?


--oyUTqETQ0mS9luUI
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-print-tag-id-when-tagged-object-is-bad.patch"

From aa861789077012f78605431e1a1f191292693325 Mon Sep 17 00:00:00 2001
From: "Chris West (Faux)" <git@goeswhere.com>
Date: Fri, 19 May 2017 19:24:03 +0200
Subject: [PATCH] print tag id when tagged object is bad

---
 revision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 8a8c178..22b6021 100644
--- a/revision.c
+++ b/revision.c
@@ -232,7 +232,8 @@ static struct commit *handle_commit(struct rev_info *revs,
 		if (!object) {
 			if (flags & UNINTERESTING)
 				return NULL;
-			die("bad object %s", oid_to_hex(&tag->tagged->oid));
+			die("bad tagged object %s in %s", oid_to_hex(&tag->tagged->oid),
+						oid_to_hex(&tag->object.oid));
 		}
 		object->flags |= flags;
 		/*
-- 
2.7.4


--oyUTqETQ0mS9luUI--
