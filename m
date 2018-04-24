Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 635EC1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 16:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeDXQaI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 24 Apr 2018 12:30:08 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48658 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752395AbeDXQaE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Apr 2018 12:30:04 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3OGTGdA006062;
        Tue, 24 Apr 2018 09:29:44 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hg35h3xw1-1;
        Tue, 24 Apr 2018 09:29:43 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id C790022175A1;
        Tue, 24 Apr 2018 09:29:43 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id B7F392CDE67;
        Tue, 24 Apr 2018 09:29:43 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     martin.agren@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        igor.d.djordjevic@gmail.com, j6t@kdbg.org, jacob.keller@gmail.com,
        philipoakley@iee.org, phillip.wood@talktalk.net,
        sbeller@google.com, sorganov@gmail.com, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] unpack_trees_options: free messages when done 
Date:   Tue, 24 Apr 2018 09:29:39 -0700
Message-Id: <20180424162939.20956-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.295.g791b7256b2.dirty
In-Reply-To: <5cfb43fad88cfb14e77bb0febdac297b78500dc0.1524545557.git.martin.agren@gmail.com>
References: <5cfb43fad88cfb14e77bb0febdac297b78500dc0.1524545557.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804240158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 10:13 PM, Martin Ågren <martin.agren@gmail.com> wrote:
> The strings allocated in `setup_unpack_trees_porcelain()` are never
> freed. Provide a function `clear_unpack_trees_porcelain()` to do so and
> call it in the functions which use `setup_unpack_trees_porcelain()`.

This is awesome; thanks.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 0c0d48624d..8229b91e2f 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -301,6 +301,7 @@ static int git_merge_trees(int index_only,
>         init_tree_desc_from_tree(t+2, merge);
>
>         rc = unpack_trees(3, t, &opts);
> +       clear_unpack_trees_porcelain(&opts);
>         cache_tree_free(&active_cache_tree);
>         return rc;

Yeah, this could result in an evil merge.  In my series, I want to
continue to be able to call verify_uptodate() from unpack_trees.c in order
to check if files affected by renames are dirty and we need to avoid
overwriting them.  That can trigger error messages, so they need to not be
freed until later.  So, instead, I'd like to see something like the below
(built on top of my series):

-- >8 --

---
 merge-recursive.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f2cbad4f10..3491a27bf2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -337,10 +337,10 @@ static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
 	init_tree_desc(desc, tree->buffer, tree->size);
 }
 
-static int git_merge_trees(struct merge_options *o,
-			   struct tree *common,
-			   struct tree *head,
-			   struct tree *merge)
+static int unpack_trees_start(struct merge_options *o,
+			      struct tree *common,
+			      struct tree *head,
+			      struct tree *merge)
 {
 	int rc;
 	struct tree_desc t[3];
@@ -378,6 +378,12 @@ static int git_merge_trees(struct merge_options *o,
 	return rc;
 }
 
+static void unpack_trees_finish(struct merge_options *o)
+{
+	discard_index(&o->orig_index);
+	clear_unpack_trees_porcelain(&o->unpack_opts);
+}
+
 struct tree *write_tree_from_memory(struct merge_options *o)
 {
 	struct tree *result = NULL;
@@ -3079,7 +3085,7 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
 
-	code = git_merge_trees(o, common, head, merge);
+	code = unpack_trees_start(o, common, head, merge);
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
@@ -3144,14 +3150,7 @@ int merge_trees(struct merge_options *o,
 	else
 		clean = 1;
 
-	/* Free the extra index left from git_merge_trees() */
-	/*
-	 * FIXME: Need to also free data allocated by
-	 * setup_unpack_trees_porcelain() tucked away in o->unpack_opts.msgs,
-	 * but the problem is that only half of it refers to dynamically
-	 * allocated data, while the other half points at static strings.
-	 */
-	discard_index(&o->orig_index);
+	unpack_trees_finish(o);
 
 	if (o->call_depth && !(*result = write_tree_from_memory(o)))
 		return -1;
-- 
2.17.0.295.g791b7256b2.dirty

