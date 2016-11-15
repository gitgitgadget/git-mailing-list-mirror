Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329BF2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 20:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbcKOU2y (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 15:28:54 -0500
Received: from avasout03.plus.net ([84.93.230.244]:33568 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbcKOU2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 15:28:53 -0500
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id 8LUp1u0040zhorE01LUq7y; Tue, 15 Nov 2016 20:28:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=owyyWa96KqsFo542HpEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] worktree: fix a sparse 'Using plain integer as NULL pointer'
 warning
Message-ID: <5b7d7d0b-8a6c-d516-4eb9-4e4ea13dce73@ramsayjones.plus.com>
Date:   Tue, 15 Nov 2016 20:28:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Duy,

If you need to re-roll your 'nd/worktree-move' branch, could you
please squash this into the relevant patch [commit c49e92f5c
("worktree move: refuse to move worktrees with submodules", 12-11-2016)].

Also, one of the new tests introduced by commit 31a8f3066 ("worktree move:
new command", 12-11-2016), fails for me, thus:

  $ ./t2028-worktree-move.sh -i -v
  ...
  --- expected	2016-11-15 20:22:50.647241458 +0000
  +++ actual	2016-11-15 20:22:50.647241458 +0000
  @@ -1,3 +1,3 @@
   worktree /home/ramsay/git/t/trash directory.t2028-worktree-move
  -worktree /home/ramsay/git/t/trash directory.t2028-worktree-move/destination
   worktree /home/ramsay/git/t/trash directory.t2028-worktree-move/elsewhere
  +worktree /home/ramsay/git/t/trash directory.t2028-worktree-move/destination
  not ok 12 - move worktree
  #	
  #		git worktree move source destination &&
  #		test_path_is_missing source &&
  #		git worktree list --porcelain | grep "^worktree" >actual &&
  #		cat <<-EOF >expected &&
  #		worktree $TRASH_DIRECTORY
  #		worktree $TRASH_DIRECTORY/destination
  #		worktree $TRASH_DIRECTORY/elsewhere
  #		EOF
  #		test_cmp expected actual &&
  #		git -C destination log --format=%s >actual2 &&
  #		echo init >expected2 &&
  #		test_cmp expected2 actual2
  #	
  $ 

Is there an expectation that the submodules will be listed in
any particular order by 'git worktree list --porcelain' ?

Thanks!

ATB,
Ramsay Jones

 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index e738142..abdf462 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -526,7 +526,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 
 static void validate_no_submodules(const struct worktree *wt)
 {
-	struct index_state istate = {0};
+	struct index_state istate = { NULL };
 	int i, found_submodules = 0;
 
 	if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0) {
-- 
2.10.0
