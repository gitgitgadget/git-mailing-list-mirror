Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F11E2018E
	for <e@80x24.org>; Sat, 13 Aug 2016 12:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbcHMMQ1 (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 08:16:27 -0400
Received: from mout.web.de ([212.227.15.3]:57238 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbcHMMQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 08:16:25 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MFvnC-1bSXaa3mIo-00Etuo; Sat, 13 Aug 2016 14:16:06
 +0200
Subject: [PATCH v2 3/4] merge-recursive: fix verbose output for multiple base
 trees
To:	Jeff King <peff@peff.net>
References: <57AEE4F7.7090804@web.de>
 <20160813092330.vmy2hip4papyuula@sigill.intra.peff.net>
 <57AF0D8E.6040309@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <57AF0F84.9040206@web.de>
Date:	Sat, 13 Aug 2016 14:16:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <57AF0D8E.6040309@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:6jO5BemHq1/JCtjq/3iYCVs8ZbvfdEM2N7QnPW33gy5DlMqp7G/
 SUIj6cKaukL2ox28Zm/91BjknWOaEInuhpW80L0OFhPeDeDbltOtkAvkqakDntdNltN7U+i
 VCxVnCTwO4BDzzCpYvO2s3SlHbNX/NUqXVtj7Ba5yHwy89L7QIckVocWt2Bm2KIA3jje2cf
 cky5DAS1j8aVYk9XvIOUw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:k36ja0ZWwWo=:2sXLOfRsbcpPo2JT2/TvfT
 e448rm6CwFFu8L4mZQcsDHvqk11KIusJ3roMm93M42yz0kHJVUcMQBQTh9Dl2FPObL0FcxNS3
 I9s4SLbVwB1amN5IkOgArxvl6uTNVsXwqORdE0GH4MZaPswhg1uFK5UY+d3UfDo1oaHzSoWCJ
 WvI1QKtD9pTpEV7pQqWkKAuLByY8z7xKCUWkuLpAF3GxDflhpqbrNdRb0+15kY+YnMIsffyTF
 MYri0GjsjH0v9kxnb+7Tig84CdwEddBq3VF1eplIFrPXQww0oFhAmhdegNGgM9IaG//AFj0Vn
 H5tN3SURqaTIyzFXx8cY+PMkkQWloB16Y06hBSJ1rWbqZhuu1mO+Qji6Nbx7K+FEtnivB6UJi
 xcqRpc+zhGyBayd0qw4KsK8+aZ+KiX788tBmDT9CnxTiW7KiNs0s+U7t6SPCundqAi8BNq6Lb
 Glb7xlM692d9mDvEDJfX8sAr413yM5mt048DQ2xvq/1ye3SPPotul1JOqzyX5cun8QF9hjR7f
 yvdoU3SLBFu5nZeBggA2fQSl8adfYQhdqc4oJAa2ZqLll2ilw801pwXfxhPMxpudSZkoXcTcS
 eeeV+yIVuMnrHb1fj8WrBjIYiJrje3Ty6ftrN5Q+69jw8C3/LsJw6XvGLiEBcBqXIg9MDoMWy
 MybfJaxMfrxZr+XmmkmmBeJCHQFEonycOfDvjPRfWFdEaknI6fyXUfHS42u1VurZdCSVMHklL
 SzTtk1F+rnZbA7B1SO6mRcLlNhR42xQVM5D+HjbjPW34hicBO5qAKNuclfaInZyESxMigbH4g
 my40Ej0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

One of the indirect callers of make_virtual_commit() passes the result of
oid_to_hex() as the name, i.e. a pointer to a static buffer.  Since the
function uses that string pointer directly in building a struct
merge_remote_desc, multiple entries can end up sharing the same name
inadvertently.

Fix that by calling set_merge_remote_desc(), which creates a copy of the
string, instead of building the struct by hand.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 merge-recursive.c          |  5 +----
 t/t3030-merge-recursive.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

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
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index f7b0e59..470f334 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -660,4 +660,22 @@ test_expect_success 'merging with triple rename across D/F conflict' '
 	git merge other
 '
 
+test_expect_success 'merge-recursive remembers the names of all base trees' '
+	git reset --hard HEAD &&
+
+	# more trees than static slots used by oid_to_hex()
+	for commit in $c0 $c2 $c4 $c5 $c6 $c7
+	do
+		git rev-parse "$commit^{tree}"
+	done >trees &&
+
+	# ignore the return code -- it only fails because the input is weird
+	test_must_fail git -c merge.verbosity=5 merge-recursive $(cat trees) -- $c1 $c3 >out &&
+
+	# merge-recursive prints in reverse order, but we do not care
+	sort <trees >expect &&
+	sed -n "s/^virtual //p" out | sort >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.9.3

