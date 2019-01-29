Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CFA91F453
	for <e@80x24.org>; Tue, 29 Jan 2019 01:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfA2Bj4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 20:39:56 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37300 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726848AbfA2Bjz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jan 2019 20:39:55 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T1be0B007205;
        Mon, 28 Jan 2019 17:39:50 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2q8nartuhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 28 Jan 2019 17:39:50 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 28 Jan 2019 17:39:45 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 28 Jan 2019 17:39:45 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id F14FB220F6F1;
        Mon, 28 Jan 2019 17:39:47 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 7/8] rebase: define linearization ordering and enforce it
Date:   Mon, 28 Jan 2019 17:39:44 -0800
Message-ID: <20190129013945.17336-8-newren@gmail.com>
X-Mailer: git-send-email 2.20.1.310.g17ca096f17
In-Reply-To: <20190129013945.17336-1-newren@gmail.com>
References: <20181211161139.31686-1-newren@gmail.com>
 <20190129013945.17336-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since commit 3f213981e44a ("add tests for rebasing merged history",
2013-06-06), t3425 has had tests which included the rebasing of merged
history and whose order of applied commits was checked.  Unfortunately,
the tests expected different behavior depending on which backend was in
use.  Implementing these checks was the following four lines (including
the TODO message) which were repeated verbatim three times in t3425:

    #TODO: make order consistent across all flavors of rebase
    test_run_rebase success 'e n o' ''
    test_run_rebase success 'e n o' -m
    test_run_rebase success 'n o e' -i

As part of the effort to reduce differences between the rebase backends
so that users get more uniform behavior, let's define the correct
behavior and modify the different backends so they all get the right
answer.  It turns out that the difference in behavior here is entirely
due to topological sorting; since some backends require topological
sorting (particularly when --rebase-merges is specified), require it for
all modes.  Modify the am and merge backends to implement this.

Performance Considerations:

I was unable to measure any appreciable performance difference with this
change.  Trying to control the run-to-run variation was difficult; I
eventually found a headless beefy box that I could ssh into, which
seemed to help.  Using git.git, I ran the following testcase:
    $ git reset --hard v2.20.0-rc1~2
    $ time git rebase --quiet v2.20.0-rc0~16

I first ran once to warm any disk caches, then ran five subsequent runs
and recorded the times of those five.  I observed the following results
for the average time:

     Before this change:
       "real" timing: 1.340s (standard deviation: 0.040s)
       "user" timing: 1.050s (standard deviation: 0.041s)
       "sys"  timing: 0.270s (standard deviation: 0.011s)
     After  this change:
       "real" timing: 1.327s (standard deviation: 0.065s)
       "user" timing: 1.031s (standard deviation: 0.061s)
       "sys"  timing: 0.280s (standard deviation: 0.014s)

Measurements aside, I would expect the timing for walking revisions to
be dwarfed by the work involved in creating and applying patches, so
this isn't too surprising.  Further, while somewhat counter-intuitive,
it is possible that turning on topological sorting is actually a
performance improvement: by way of comparison, turning on --topo-order
made fast-export faster (see
https://public-inbox.org/git/20090211135640.GA19600@coredump.intra.peff.net/).

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-rebase--am.sh                 |  2 +-
 git-rebase--merge.sh              |  2 +-
 t/t3425-rebase-topology-merges.sh | 15 ++++++---------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 99b8c17787..6416716ee6 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -36,7 +36,7 @@ rm -f "$GIT_DIR/rebased-patches"
 
 git format-patch -k --stdout --full-index --cherry-pick --right-only \
 	--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
-	--pretty=mboxrd \
+	--pretty=mboxrd --topo-order \
 	$git_format_patch_opt \
 	"$revisions" ${restrict_revision+^$restrict_revision} \
 	>"$GIT_DIR/rebased-patches"
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index 91250cbaed..ced38bb3a6 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -143,7 +143,7 @@ write_basic_state
 rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
 msgnum=0
-for cmt in $(git rev-list --reverse --no-merges "$revisions")
+for cmt in $(git rev-list --topo-order --reverse --no-merges "$revisions")
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$state_dir/cmt.$msgnum"
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 5f892e33d7..fd8efe84fe 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -70,9 +70,8 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" d..
 	"
 }
-#TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'e n o' ''
-test_run_rebase success 'e n o' -m
+test_run_rebase success 'n o e' ''
+test_run_rebase success 'n o e' -m
 test_run_rebase success 'n o e' -i
 
 test_run_rebase () {
@@ -87,9 +86,8 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" c..
 	"
 }
-#TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'd e n o' ''
-test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' ''
+test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
 test_run_rebase () {
@@ -104,9 +102,8 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" c..
 	"
 }
-#TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'd e n o' ''
-test_run_rebase success 'd e n o' -m
+test_run_rebase success 'd n o e' ''
+test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
 if ! test_have_prereq REBASE_P; then
-- 
2.20.1.310.g17ca096f17

