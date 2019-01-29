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
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7D11F453
	for <e@80x24.org>; Tue, 29 Jan 2019 01:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfA2Bj4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 20:39:56 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50464 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726790AbfA2Bjz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jan 2019 20:39:55 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T1dFWI008899;
        Mon, 28 Jan 2019 17:39:51 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2q8p9rjrj8-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 28 Jan 2019 17:39:50 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 28 Jan 2019 17:39:33 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 28 Jan 2019 17:39:45 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id EB7D8220F6F0;
        Mon, 28 Jan 2019 17:39:47 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 6/8] git-legacy-rebase: simplify unnecessary triply-nested if
Date:   Mon, 28 Jan 2019 17:39:43 -0800
Message-ID: <20190129013945.17336-7-newren@gmail.com>
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
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=601 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290009
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

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
2.20.1.310.g17ca096f17

