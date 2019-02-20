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
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6291F463
	for <e@80x24.org>; Wed, 20 Feb 2019 22:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfBTW7B (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 17:59:01 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53376 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbfBTW67 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Feb 2019 17:58:59 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KMqt0d004444;
        Wed, 20 Feb 2019 14:58:51 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2qsc6x0bje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 20 Feb 2019 14:58:51 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 20 Feb 2019 14:58:31 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 20 Feb 2019 14:58:31 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 252F22216327;
        Wed, 20 Feb 2019 14:58:49 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        David Barr <david.barr@cordelta.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 5/5] fast-import: fix erroneous handling of get-mark with empty orphan commits
Date:   Wed, 20 Feb 2019 14:58:46 -0800
Message-ID: <20190220225846.10658-6-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.5.g8f70af2367
In-Reply-To: <20190220225846.10658-1-newren@gmail.com>
References: <20190220225846.10658-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_18:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When get-mark was introduced in commit 28c7b1f7b7b7 ("fast-import: add a
get-mark command", 2015-07-01), it followed the precedent of the
cat-blob command to be allowed on any line other than in the middle of a
data directive; see commit 777f80d7429b ("fast-import: Allow cat-blob
requests at arbitrary points in stream", 2010-11-28).  It was useful to
allow cat-blob directives in the middle of a commit to get more data
that would be used in writing the current commit object.  get-mark is
not similarly useful since fast-import can already use either object id
or mark.  Further, trying to allow this command anywhere caused parsing
bugs.  Fix the parsing problems by only allowing get-mark commands to
appear when other commands have completed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-import.txt | 4 ----
 fast-import.c                     | 8 ++------
 t/t9300-fast-import.sh            | 4 ++--
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 982f82b0b3..33cce1e150 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -971,10 +971,6 @@ might want to refer to in their commit messages.
 	'get-mark' SP ':' <idnum> LF
 ....
 
-This command can be used anywhere in the stream that comments are
-accepted.  In particular, the `get-mark` command can be used in the
-middle of a commit but not in the middle of a `data` command.
-
 See ``Responses To Commands'' below for details about how to read
 this output safely.
 
diff --git a/fast-import.c b/fast-import.c
index 338db61e6e..064c55e8be 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1748,8 +1748,6 @@ static int read_next_command(void)
 	}
 
 	for (;;) {
-		const char *p;
-
 		if (unread_command_buf) {
 			unread_command_buf = 0;
 		} else {
@@ -1782,10 +1780,6 @@ static int read_next_command(void)
 			rc->prev->next = rc;
 			cmd_tail = rc;
 		}
-		if (skip_prefix(command_buf.buf, "get-mark ", &p)) {
-			parse_get_mark(p);
-			continue;
-		}
 		if (command_buf.buf[0] == '#')
 			continue;
 		return 0;
@@ -3318,6 +3312,8 @@ int cmd_main(int argc, const char **argv)
 			parse_ls(v, NULL);
 		else if (skip_prefix(command_buf.buf, "cat-blob ", &v))
 			parse_cat_blob(v);
+		else if (skip_prefix(command_buf.buf, "get-mark ", &v))
+			parse_get_mark(v);
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
 		else if (!strcmp("done", command_buf.buf))
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index c304c8c47c..3668263c40 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3276,11 +3276,11 @@ cat >>W-input <<-W_INPUT_END
 	LFsget-mark :1
 	W_INPUT_END
 
-test_expect_failure !MINGW 'W: get-mark & empty orphan commit with no newlines' '
+test_expect_success !MINGW 'W: get-mark & empty orphan commit with no newlines' '
 	sed -e s/LFs// W-input | tr L "\n" | git fast-import
 '
 
-test_expect_failure !MINGW 'W: get-mark & empty orphan commit with one newline' '
+test_expect_success !MINGW 'W: get-mark & empty orphan commit with one newline' '
 	sed -e s/LFs/L/ W-input | tr L "\n" | git fast-import
 '
 
-- 
2.21.0.rc2.5.g8f70af2367

