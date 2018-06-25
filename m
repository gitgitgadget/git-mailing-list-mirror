Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4007D1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeFYQNY (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:13:24 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39944 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752161AbeFYQNW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Jun 2018 12:13:22 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PGCj9U000782;
        Mon, 25 Jun 2018 09:13:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jt01t2c69-1;
        Mon, 25 Jun 2018 09:13:10 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 74A9F226FB3C;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 6ABEA2CDE65;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 5/9] git-rebase.txt: address confusion between --no-ff vs --force-rebase
Date:   Mon, 25 Jun 2018 09:12:56 -0700
Message-Id: <20180625161300.26060-6-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180625161300.26060-1-newren@gmail.com>
References: <20180621150023.23533-1-newren@gmail.com>
 <20180625161300.26060-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=40 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250188
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase was taught the --force-rebase option in commit b2f82e05de ("Teach
rebase to rebase even if upstream is up to date", 2009-02-13).  This flag
worked for the am and merge backends, but wasn't a valid option for the
interactive backend.

rebase was taught the --no-ff option for interactive rebases in commit
b499549401cb ("Teach rebase the --no-ff option.", 2010-03-24), to do the
exact same thing as --force-rebase does for non-interactive rebases.  This
commit explicitly documented the fact that --force-rebase was incompatible
with --interactive, though it made --no-ff a synonym for --force-rebase
for non-interactive rebases.  The choice of a new option was based on the
fact that "force rebase" didn't sound like an appropriate term for the
interactive machinery.

In commit 6bb4e485cff8 ("rebase: align variable names", 2011-02-06), the
separate parsing of command line options in the different rebase scripts
was removed, and whether on accident or because the author noticed that
these options did the same thing, the options became synonyms and both
were accepted by all three rebase types.

In commit 2d26d533a012 ("Documentation/git-rebase.txt: -f forces a rebase
that would otherwise be a no-op", 2014-08-12), which reworded the
description of the --force-rebase option, the (no-longer correct) sentence
stating that --force-rebase was incompatible with --interactive was
finally removed.

Finally, as explained at
https://public-inbox.org/git/98279912-0f52-969d-44a6-22242039387f@xiplink.com

    In the original discussion around this option [1], at one point I
    proposed teaching rebase--interactive to respect --force-rebase
    instead of adding a new option [2].  Ultimately --no-ff was chosen as
    the better user interface design [3], because an interactive rebase
    can't be "forced" to run.

We have accepted both --no-ff and --force-rebase as full synonyms for all
three rebase types for over seven years.  Documenting them differently
and in ways that suggest they might not be quite synonyms simply leads to
confusion.  Adjust the documentation to match reality.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index b2d95e3fb9..2f47495a4d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -337,16 +337,18 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
--f::
+--no-ff::
 --force-rebase::
-	Force a rebase even if the current branch is up to date and
-	the command without `--force` would return without doing anything.
+-f::
+	Individually replay all rebased commits instead of fast-forwarding
+	over the unchanged ones.  This ensures that the entire history of
+	the rebased branch is composed of new commits.
 +
-You may find this (or --no-ff with an interactive rebase) helpful after
-reverting a topic branch merge, as this option recreates the topic branch with
-fresh commits so it can be remerged successfully without needing to "revert
-the reversion" (see the
-link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
+You may find this helpful after reverting a topic branch merge, as this option
+recreates the topic branch with fresh commits so it can be remerged
+successfully without needing to "revert the reversion" (see the
+link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for
+details).
 
 --fork-point::
 --no-fork-point::
@@ -498,18 +500,6 @@ See also INCOMPATIBLE OPTIONS below.
 	with care: the final stash application after a successful
 	rebase might result in non-trivial conflicts.
 
---no-ff::
-	With --interactive, cherry-pick all rebased commits instead of
-	fast-forwarding over the unchanged ones.  This ensures that the
-	entire history of the rebased branch is composed of new commits.
-+
-Without --interactive, this is a synonym for --force-rebase.
-+
-You may find this helpful after reverting a topic branch merge, as this option
-recreates the topic branch with fresh commits so it can be remerged
-successfully without needing to "revert the reversion" (see the
-link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
-
 INCOMPATIBLE OPTIONS
 --------------------
 
-- 
2.18.0.9.g678597d97e

