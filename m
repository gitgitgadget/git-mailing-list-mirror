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
	by dcvr.yhbt.net (Postfix) with ESMTP id AF21720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 16:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbeLKQL5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 11:11:57 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48394 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729586AbeLKQL4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Dec 2018 11:11:56 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBG8wKR000913;
        Tue, 11 Dec 2018 08:11:47 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2p8cpp3qxq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Dec 2018 08:11:46 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 11 Dec 2018 08:11:42 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 11 Dec 2018 08:11:42 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 3AD6F220F600;
        Tue, 11 Dec 2018 08:11:42 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <Johannes.Schindelin@gmx.de>,
        <predatoramigo@gmail.com>, <phillip.wood@talktalk.net>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 6/8] git-legacy-rebase: simplify unnecessary triply-nested if
Date:   Tue, 11 Dec 2018 08:11:37 -0800
Message-ID: <20181211161139.31686-7-newren@gmail.com>
X-Mailer: git-send-email 2.20.0.8.g5de428d695
In-Reply-To: <20181211161139.31686-1-newren@gmail.com>
References: <20181122044841.20993-1-newren@gmail.com>
 <20181211161139.31686-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=585 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110146
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-legacy-rebase.sh script previously had code of the form:

if git_am_opt:
  if interactive:
    if incompatible_opts:
      show_error_about_interactive_and_am_incompatibilities
  if rebase-merge:
    if incompatible_opts
      show_error_about_merge_and_am_incompatibilities

which was a triply nested if.  However, the first conditional
(git_am_opt) and third (incompatible_opts) were somewhat redundant: the
latter condition was a strict subset of the former.  Simplify this by
moving the innermost conditional to the outside, allowing us to remove
the test on git_am_opt entirely and giving us the following form:

if incompatible_opts:
  if interactive:
    show_error_about_interactive_and_am_incompatibilities
  if rebase-merge:
    show_error_about_merge_and_am_incompatibilities

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-legacy-rebase.sh | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index f4088b7bda..6baf10192d 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -501,21 +501,17 @@ then
 	git_format_patch_opt="$git_format_patch_opt --progress"
 fi
 
-if test -n "$git_am_opt"; then
-	incompatible_opts=$(echo " $git_am_opt " | \
-			    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
+incompatible_opts=$(echo " $git_am_opt " | \
+		    sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
+if test -n "$incompatible_opts"
+then
 	if test -n "$interactive_rebase"
 	then
-		if test -n "$incompatible_opts"
-		then
-			die "$(gettext "fatal: cannot combine am options with interactive options")"
-		fi
+		die "$(gettext "fatal: cannot combine am options with interactive options")"
 	fi
-	if test -n "$do_merge"; then
-		if test -n "$incompatible_opts"
-		then
-			die "$(gettext "fatal: cannot combine am options with merge options")"
-		fi
+	if test -n "$do_merge"
+	then
+		die "$(gettext "fatal: cannot combine am options with merge options")"
 	fi
 fi
 
-- 
2.20.0.8.g5de428d695

