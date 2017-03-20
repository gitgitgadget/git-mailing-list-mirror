Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E87D20958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755525AbdCTQdn (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:33:43 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48508 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755380AbdCTQdj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:33:39 -0400
X-AuditID: 1207440d-041ff70000003721-32-58d004602473
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 80.2E.14113.06400D85; Mon, 20 Mar 2017 12:33:37 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9B010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:33:35 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/20] get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
Date:   Mon, 20 Mar 2017 17:33:06 +0100
Message-Id: <53e0eed5e13a04f502dcaeda83b2cbb3035f1396.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqJvIciHC4HiTpEXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgd2Dz+vv/A5LFz1l12j672I2wez3r3MHpcvKTs8XmTXABb
        FJdNSmpOZllqkb5dAldG790HLAVPBCq6p95namC8ztvFyMkhIWAisXrCTNYuRi4OIYEdTBKn
        Jp5mgXBOMUn0Tn/ECFLFJqArsainmQnEFhFQk5jYdgisiFngEaPE1fl32UESwgIhEh3NJ5lB
        bBYBVYkpT2exgdi8AlESn7ZfYYNYJy+xq+0iK4jNKWAh8eV+IwuILSRgLtG5oJd9AiPPAkaG
        VYxyiTmlubq5iZk5xanJusXJiXl5qUW6Rnq5mSV6qSmlmxghAcW7g/H/OplDjAIcjEo8vCuu
        nI8QYk0sK67MPcQoycGkJMr79DZQiC8pP6UyI7E4I76oNCe1+BCjBAezkghv1UugHG9KYmVV
        alE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgleU6UKEkGBRanpqRVpmTglCmomD
        E2Q4D9DwOpAa3uKCxNzizHSI/ClGRSlx3u//gbYKgCQySvPgemER/4pRHOgVYd6830BVPMBk
        Adf9CmgwE9DgZTfOgAwuSURISTUwtuw0+f3m65zCCuWFnPvvHuG8WLhidtn2W7f8Qm2mN5wT
        45+1wbfEPrKr9cdVjt9lx/7NNzifuPQLJ4vr/U6tCTO6z10/8KWa/0oCT5HXJt6tAZNYWfa2
        famYe3XWc73gtH0XGBRjTOVc+35Ovv+Gf9FznxDHHK0pM+XVauq/z3ErORa2p356mBJLcUai
        oRZzUXEiAOpGzO7TAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since references under "refs/bisect/" are per-worktree, they have to
be sought in the worktree rather than in the main repository. But
since loose references are found by traversing directories, the
reference iterator won't even get the idea to look for a
"refs/bisect/" directory in the worktree if there is not a directory
with that name in the main repository. Thus `get_ref_dir()` manually
inserts a dir_entry for "refs/bisect/" whenever it reads the entry for
"refs/".

The current code then immediately calls `read_loose_refs()` on that
directory. But since the dir_entry is created with its `incomplete`
flag set, any traversal that gets to this point will read the
directory automatically. So there is no need to call
`read_loose_refs()` explicitly; the lazy mechanism suffices.

And in fact, the attempt to `read_loose_refs()` was broken anyway.
That function needs its `dirname` argument to have a trailing `/`
character, but the invocation here was passing it "refs/bisect"
without a trailing slash. So `read_loose_refs()` would read
`$GIT_DIR/refs/bisect" correctly, but if it found an entry "foo" in
that directory, it would try to read "$GIT_DIR/refs/bisectfoo".
Normally it wouldn't find anything at that path, but the failure was
canceled out because `get_ref_dir()` *also* forgot to reset the
`REF_INCOMPLETE` bit on the dir_entry. So the read was attempted again
when it was accessed, via the lazy mechanism, and this time the read
was done correctly.

This code has been broken since it was first introduced.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4242486118..e7a075e864 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -191,8 +191,6 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 							       "refs/bisect/",
 							       12, 1);
 				add_entry_to_dir(dir, child_entry);
-				read_loose_refs("refs/bisect",
-						&child_entry->u.subdir);
 			}
 		}
 		entry->flag &= ~REF_INCOMPLETE;
-- 
2.11.0

