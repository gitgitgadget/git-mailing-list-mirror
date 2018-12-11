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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC1720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 16:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbeLKQLy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 11:11:54 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48346 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729311AbeLKQLw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Dec 2018 11:11:52 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBG8wKL000913;
        Tue, 11 Dec 2018 08:11:44 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2p8cpp3qxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Dec 2018 08:11:43 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 11 Dec 2018 08:11:41 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 11 Dec 2018 08:11:41 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 11AD5220ED5E;
        Tue, 11 Dec 2018 08:11:42 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <Johannes.Schindelin@gmx.de>,
        <predatoramigo@gmail.com>, <phillip.wood@talktalk.net>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 2/8] rebase: fix incompatible options error message
Date:   Tue, 11 Dec 2018 08:11:33 -0800
Message-ID: <20181211161139.31686-3-newren@gmail.com>
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
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110146
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit f57696802c30 ("rebase: really just passthru the `git am`
options", 2018-11-14), the handling of `git am` options was simplified
dramatically (and an option parsing bug was fixed), but it introduced
a small regression in the error message shown when options only
understood by separate backends were used:

$ git rebase --keep --ignore-whitespace
fatal: cannot combine interactive options (--interactive, --exec,
--rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with
am options (.git/rebase-apply/applying)

$ git rebase --merge --ignore-whitespace
fatal: cannot combine merge options (--merge, --strategy,
--strategy-option) with am options (.git/rebase-apply/applying)

Note that in both cases, the list of "am options" is
".git/rebase-apply/applying", which makes no sense.  Since the lists of
backend-specific options is documented pretty thoroughly in the rebase
man page (in the "Incompatible Options" section, with multiple links
throughout the document), and since I expect this list to change over
time, just simplify the error message.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c     | 10 +++-------
 git-legacy-rebase.sh |  4 ++--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 85f980bdce..78e982298f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1223,14 +1223,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				break;
 
 		if (is_interactive(&options) && i >= 0)
-			die(_("cannot combine interactive options "
-			      "(--interactive, --exec, --rebase-merges, "
-			      "--preserve-merges, --keep-empty, --root + "
-			      "--onto) with am options (%s)"), buf.buf);
+			die(_("cannot combine am options "
+			      "with interactive options"));
 		if (options.type == REBASE_MERGE && i >= 0)
-			die(_("cannot combine merge options (--merge, "
-			      "--strategy, --strategy-option) with am options "
-			      "(%s)"), buf.buf);
+			die(_("cannot combine am options with merge options "));
 	}
 
 	if (options.signoff) {
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index 11548e927c..fccb33b959 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -508,13 +508,13 @@ if test -n "$git_am_opt"; then
 	then
 		if test -n "$incompatible_opts"
 		then
-			die "$(gettext "fatal: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
+			die "$(gettext "fatal: cannot combine am options with interactive options")"
 		fi
 	fi
 	if test -n "$do_merge"; then
 		if test -n "$incompatible_opts"
 		then
-			die "$(gettext "fatal: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
+			die "$(gettext "fatal: cannot combine am options with merge options")"
 		fi
 	fi
 fi
-- 
2.20.0.8.g5de428d695

