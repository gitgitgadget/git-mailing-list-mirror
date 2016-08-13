Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4CCF20193
	for <e@80x24.org>; Sat, 13 Aug 2016 09:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbcHMJOl (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 05:14:41 -0400
Received: from mout.web.de ([212.227.15.4]:63269 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbcHMJOk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 05:14:40 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MeBVG-1bqbQs3v2M-00PteT; Sat, 13 Aug 2016 11:14:33
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:	Git List <git@vger.kernel.org>
Cc:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit: introduce set_merge_remote_desc()
Message-ID: <57AEE4F7.7090804@web.de>
Date:	Sat, 13 Aug 2016 11:14:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ZadDRy49uP+p9VMijLm6jsTq0v9MruGhaNNBjFST7356HNgLVp/
 dk1xDGbUX+FUwYW50KSbxg2phKNsRNkCtk26iaw5CESxrVCQiuCBw42bfV+XqJR8JV4cV40
 hZCIrRfYGzeGtiL7wTvikZ+ghFctHuxIJKN/2zWv3cwiLwhTqfwMMkq/0BbiQWMbghKRbC9
 Sccd44wG3RPh0QBJS/T+w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:V+Lxn42ned0=:t80jrfizlunGUYeEDNVk7p
 6eOjeoJLhFapaYT8zgXXdSzmTi6ZRHLKePpvdNF1Y2I3lM49QB56cWPNmtNKqmO7DnHi3wU58
 BofaamQiPzYiDgPRZgV9XFKZ90EhotU+P9sJv+U3i7OMM/EecOKIdNk5qUMfks250WAY5Rf9x
 7xQVeUCO1Vj0KouVfW0zIia0s/40oc6/h29oTB3jBG7Vm+hbEo54wiIsryPvzW1oew4CoUVv/
 RWISiT9/7sltnHQmMGfA5dw5ttx5aWSV6V2wL+jKweFrros0WsVMi1pJ5SF46M90G05D6Ki3x
 aUKSNo2c50AvSgT/UPPB/4UlX5cyBVQLO7YjTZ0cjkIX/NLFdmSG3ypmYEVN3NbY+R7fKcK7r
 SfDXPi+gNGMgSdXSgENoKd5g5xsNBtM1wx+zSC4liUzzRDE9RIkozTBLd0mCoqxsTRHaT8ear
 SjalVRKweykC953rB7oZ9sTN2V6bUQ5VdqrghUA9ezrVei5KJa0q8wRFcpP3sDN8D3n+/ghiD
 ++bWVsUSfjBKITqpfyLbq06LKmUnusN0ljaAVOPUC5frBA0hpH/OFaPVZp39/fv9Qmc/Uzu8K
 sfx2xtOcG71Ke6D6nNlv5fffSbN9aZFFI1LR3zcVmCvOO5dAqhpXkTy055TouOoZ4Lj6w9INu
 UVyPoLxUFf+ne2cVvqBXrq80VVTFad/8XmlXxfEBHouja3Sz8X/WI0DxgrHEwKNKfjoMtZjdo
 oRrhNtDjd5sryDfsBWrtrPd8+dz1Ok0QOl8I/rMda6aA7jH74qmAuG1jhAHtGjNbw19/KItZ8
 KWdphPF
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add a helper function for allocating, populating and attaching struct
merge_remote_desc to a commit and use it consistently.  It allocates the
necessary memory in a single block.

commit.c::get_merge_parent() forgot to check for memory allocation
failures of strdup(3).

merge-recursive.c::make_virtual_commit() didn't duplicate the string for
the name member, even though one of it's callers (indirectly through
get_ref()) may pass the result of oid_to_hex(), i.e. a static buffer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c          | 18 +++++++++++-------
 commit.h          |  2 ++
 merge-recursive.c |  5 +----
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index 71a360d..372b200 100644
--- a/commit.c
+++ b/commit.c
@@ -1576,6 +1576,15 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	return result;
 }
 
+void set_merge_remote_desc(struct commit *commit,
+			   const char *name, struct object *obj)
+{
+	struct merge_remote_desc *desc;
+	FLEXPTR_ALLOC_STR(desc, name, name);
+	desc->obj = obj;
+	commit->util = desc;
+}
+
 struct commit *get_merge_parent(const char *name)
 {
 	struct object *obj;
@@ -1585,13 +1594,8 @@ struct commit *get_merge_parent(const char *name)
 		return NULL;
 	obj = parse_object(oid.hash);
 	commit = (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
-	if (commit && !commit->util) {
-		struct merge_remote_desc *desc;
-		desc = xmalloc(sizeof(*desc));
-		desc->obj = obj;
-		desc->name = strdup(name);
-		commit->util = desc;
-	}
+	if (commit && !commit->util)
+		set_merge_remote_desc(commit, name, obj);
 	return commit;
 }
 
diff --git a/commit.h b/commit.h
index 23ae0c1..84bb507 100644
--- a/commit.h
+++ b/commit.h
@@ -365,6 +365,8 @@ struct merge_remote_desc {
 	const char *name;
 };
 #define merge_remote_util(commit) ((struct merge_remote_desc *)((commit)->util))
+extern void set_merge_remote_desc(struct commit *commit,
+				  const char *name, struct object *obj);
 
 /*
  * Given "name" from the command line to merge, find the commit object
diff --git a/merge-recursive.c b/merge-recursive.c
index e5243c2..e349126 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -73,12 +73,9 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
 	struct commit *commit = alloc_commit_node();
-	struct merge_remote_desc *desc = xmalloc(sizeof(*desc));
 
-	desc->name = comment;
-	desc->obj = (struct object *)commit;
+	set_merge_remote_desc(commit, comment, (struct object *)commit);
 	commit->tree = tree;
-	commit->util = desc;
 	commit->object.parsed = 1;
 	return commit;
 }
-- 
2.9.3

