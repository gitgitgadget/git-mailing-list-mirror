Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1100920248
	for <e@80x24.org>; Mon,  1 Apr 2019 16:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfDAQAx (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:00:53 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53104 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727190AbfDAQAw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Apr 2019 12:00:52 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31Frtf1021178;
        Mon, 1 Apr 2019 09:00:20 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rkfhxgh6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 01 Apr 2019 09:00:19 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 1 Apr 2019 09:00:14 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 1 Apr 2019 09:00:14 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 230DA22595F9;
        Mon,  1 Apr 2019 09:00:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        David Barr <david.barr@cordelta.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/5] t9300: demonstrate bug with get-mark and empty orphan commits
Date:   Mon, 1 Apr 2019 09:00:07 -0700
Message-ID: <20190401160011.20678-2-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.5.gde71272ddd
In-Reply-To: <20190401160011.20678-1-newren@gmail.com>
References: <20190220225846.10658-1-newren@gmail.com>
 <20190401160011.20678-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010106
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-import.txt |  7 +++++-
 t/t9300-fast-import.sh            | 37 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 43ab3b1637..339b6e7e98 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -422,7 +422,12 @@ However it is recommended that a `filedeleteall` command precede
 all `filemodify`, `filecopy`, `filerename` and `notemodify` commands in
 the same commit, as `filedeleteall` wipes the branch clean (see below).
 
-The `LF` after the command is optional (it used to be required).
+The `LF` after the command is optional (it used to be required).  Note
+that for reasons of backward compatibility, if the commit ends with a
+`data` command (i.e. it has has no `from`, `merge`, `filemodify`,
+`filedelete`, `filecopy`, `filerename`, `filedeleteall` or
+`notemodify` commands) then two `LF` commands may appear at the end of
+the command instead of just one.
 
 `author`
 ^^^^^^^^
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 59a13b6a77..c304c8c47c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3262,4 +3262,41 @@ test_expect_success PIPE 'V: checkpoint updates tags after tag' '
 	background_import_still_running
 '
 
+###
+### series W (get-mark and empty orphan commits)
+###
+
+cat >>W-input <<-W_INPUT_END
+	commit refs/heads/W-branch
+	mark :1
+	author Full Name <user@company.tld> 1000000000 +0100
+	committer Full Name <user@company.tld> 1000000000 +0100
+	data 27
+	Intentionally empty commit
+	LFsget-mark :1
+	W_INPUT_END
+
+test_expect_failure !MINGW 'W: get-mark & empty orphan commit with no newlines' '
+	sed -e s/LFs// W-input | tr L "\n" | git fast-import
+'
+
+test_expect_failure !MINGW 'W: get-mark & empty orphan commit with one newline' '
+	sed -e s/LFs/L/ W-input | tr L "\n" | git fast-import
+'
+
+test_expect_success !MINGW 'W: get-mark & empty orphan commit with ugly second newline' '
+	# Technically, this should fail as it has too many linefeeds
+	# according to the grammar in fast-import.txt.  But, for whatever
+	# reason, it works.  Since using the correct number of newlines
+	# does not work with older (pre-2.22) versions of git, allow apps
+	# that used this second-newline workaround to keep working by
+	# checking it with this test...
+	sed -e s/LFs/LL/ W-input | tr L "\n" | git fast-import
+'
+
+test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous third newline' '
+	# ...but do NOT allow more empty lines than that (see previous test).
+	sed -e s/LFs/LLL/ W-input | tr L "\n" | test_must_fail git fast-import
+'
+
 test_done
-- 
2.21.0.1.g0a561c1dbd

