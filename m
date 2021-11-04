Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F645C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 21:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D8C61106
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 21:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhKDVIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 17:08:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46465 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230162AbhKDVIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 17:08:43 -0400
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A4L5tgG027642
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 4 Nov 2021 17:05:57 -0400
Message-ID: <9dfca5ec-4426-d3d4-988e-b81ebb087584@mit.edu>
Date:   Thu, 4 Nov 2021 14:05:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
From:   Anders Kaseorg <andersk@mit.edu>
Subject: [PATCH] fetch: Protect branches checked out in all worktrees
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refuse to fetch into the currently checked out branch of any working

tree, not just the current one.



Fixes this previously reported bug:



https://public-inbox.org/git/cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathema.de



Signed-off-by: Anders Kaseorg <andersk@mit.edu>

---

 builtin/fetch.c       | 22 +++++++++-------------

 t/t5516-fetch-push.sh | 10 ++++++++++

 2 files changed, 19 insertions(+), 13 deletions(-)



diff --git a/builtin/fetch.c b/builtin/fetch.c

index f7abbc31ff..a6549c2ab6 100644

--- a/builtin/fetch.c

+++ b/builtin/fetch.c

@@ -28,6 +28,7 @@

 #include "promisor-remote.h"

 #include "commit-graph.h"

 #include "shallow.h"

+#include "worktree.h"

 

 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)

 

@@ -854,7 +855,6 @@ static int update_local_ref(struct ref *ref,

 			    int summary_width)

 {

 	struct commit *current = NULL, *updated;

-	struct branch *current_branch = branch_get(NULL);

 	const char *pretty_ref = prettify_refname(ref->name);

 	int fast_forward = 0;

 

@@ -868,9 +868,8 @@ static int update_local_ref(struct ref *ref,

 		return 0;

 	}

 

-	if (current_branch &&

-	    !strcmp(ref->name, current_branch->name) &&

-	    !(update_head_ok || is_bare_repository()) &&

+	if (!update_head_ok &&

+	    find_shared_symref("HEAD", ref->name) &&

 	    !is_null_oid(&ref->old_oid)) {

 		/*

 		 * If this is the head, and it's not okay to update

@@ -1387,16 +1386,13 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,

 

 static void check_not_current_branch(struct ref *ref_map)

 {

-	struct branch *current_branch = branch_get(NULL);

-

-	if (is_bare_repository() || !current_branch)

-		return;

-

+	const struct worktree *wt;

 	for (; ref_map; ref_map = ref_map->next)

-		if (ref_map->peer_ref && !strcmp(current_branch->refname,

-					ref_map->peer_ref->name))

-			die(_("Refusing to fetch into current branch %s "

-			    "of non-bare repository"), current_branch->refname);

+		if (ref_map->peer_ref &&

+		    (wt = find_shared_symref("HEAD", ref_map->peer_ref->name)))

+			die(_("Refusing to fetch into branch '%s' "

+			      "checked out at '%s'"),

+			    ref_map->peer_ref->name, wt->path);

 }

 

 static int truncate_fetch_head(void)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh

index 8212ca56dc..c8cb62c05d 100755

--- a/t/t5516-fetch-push.sh

+++ b/t/t5516-fetch-push.sh

@@ -1771,4 +1771,14 @@ test_expect_success 'denyCurrentBranch and worktrees' '

 	git -C cloned push origin HEAD:new-wt &&

 	test_must_fail git -C cloned push --delete origin new-wt

 '

+

+test_expect_success 'refuse fetch to current branch of worktree' '

+	test_commit -C cloned second &&

+	test_must_fail git fetch cloned HEAD:new-wt &&

+	git clone --bare . bare.git &&

+	git -C bare.git worktree add bare-wt &&

+	test_must_fail git -C bare.git fetch ../cloned HEAD:bare-wt &&

+	git fetch -u cloned HEAD:new-wt &&

+	git -C bare.git fetch -u ../cloned HEAD:bare-wt

+'

 test_done

-- 

2.33.0

