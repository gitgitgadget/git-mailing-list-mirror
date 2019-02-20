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
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC8C1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 22:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfBTW7I (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 17:59:08 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:60126 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbfBTW7G (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Feb 2019 17:59:06 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KMrM55026544;
        Wed, 20 Feb 2019 14:58:51 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2qph8rdyur-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 20 Feb 2019 14:58:51 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 20 Feb 2019 14:58:31 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 20 Feb 2019 14:58:46 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 1E27C2216326;
        Wed, 20 Feb 2019 14:58:49 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        David Barr <david.barr@cordelta.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 4/5] fast-import: only allow cat-blob requests where it makes sense
Date:   Wed, 20 Feb 2019 14:58:45 -0800
Message-ID: <20190220225846.10658-5-newren@gmail.com>
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

In commit 777f80d7429b ("fast-import: Allow cat-blob requests at
arbitrary points in stream", 2010-11-28), fast-import started allowing
cat-blob commands to appear on the start of any line except in the
middle of a "data" command.  It could be in the middle of various
directives that were part of a tag command, or in the middle of
checkpoints or progresses (each of which allow an optional second empty
newline), or even immediately after the mark command of a blob before
the data directive appeared (raising the question of what if it used the
mark for the blob that just barely appeared in the stream that we do not
yet have the data for).  None of these locations make any sense as
places to put cat-blob requests.

The purpose of this change as stated in that commit message was to

   [save] frontends from having to loop over everything they want to
   commit in the next commit and cat-ing the necessary objects in
   advance.

However, that can be achieved by simply allowing cat-blob requests to
appear whenever a filemodify directive is allowed.  Further, it avoids
setting a bad precedent for other commands to follow (e.g. get-mark); a
precedent which caused parsing problems in corner cases.

Technically, inline filemodify directives add a slight wrinkle in that
frontends might want to have cat-blob directives appear after the start
of the filemodify and before the data directive contained within it.  I
think it would have been better to disallow such a case (it would be
trivial to use cat-blob before the filemodify instead), but since there
is evidence this was used, for backwards compatibility let's support
that case too.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-import.txt |  7 ++++---
 fast-import.c                     | 19 +++++++++++++------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index f7e2d330b1..982f82b0b3 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1001,9 +1001,10 @@ Output uses the same format as `git cat-file --batch`:
 	<contents> LF
 ====
 
-This command can be used anywhere in the stream that comments are
-accepted.  In particular, the `cat-blob` command can be used in the
-middle of a commit but not in the middle of a `data` command.
+This command can be used where a `filemodify` directive can appear,
+allowing it to be used in the middle of a commit.  For a `filemodify`
+using an inline directive, it can also appear right before the `data`
+directive.
 
 See ``Responses To Commands'' below for details about how to read
 this output safely.
diff --git a/fast-import.c b/fast-import.c
index 3114ce17f1..338db61e6e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1786,10 +1786,6 @@ static int read_next_command(void)
 			parse_get_mark(p);
 			continue;
 		}
-		if (skip_prefix(command_buf.buf, "cat-blob ", &p)) {
-			parse_cat_blob(p);
-			continue;
-		}
 		if (command_buf.buf[0] == '#')
 			continue;
 		return 0;
@@ -2254,8 +2250,15 @@ static void file_change_m(const char *p, struct branch *b)
 			strbuf_addstr(&uq, p);
 			p = uq.buf;
 		}
-		read_next_command();
-		parse_and_store_blob(&last_blob, &oid, 0);
+		while (read_next_command() != EOF) {
+			const char *v;
+			if (skip_prefix(command_buf.buf, "cat-blob ", &v))
+				parse_cat_blob(v);
+			else {
+				parse_and_store_blob(&last_blob, &oid, 0);
+				break;
+			}
+		}
 	} else {
 		enum object_type expected = S_ISDIR(mode) ?
 						OBJ_TREE: OBJ_BLOB;
@@ -2627,6 +2630,8 @@ static void parse_new_commit(const char *arg)
 			file_change_deleteall(b);
 		else if (skip_prefix(command_buf.buf, "ls ", &v))
 			parse_ls(v, b);
+		else if (skip_prefix(command_buf.buf, "cat-blob ", &v))
+			parse_cat_blob(v);
 		else {
 			unread_command_buf = 1;
 			break;
@@ -3311,6 +3316,8 @@ int cmd_main(int argc, const char **argv)
 			parse_reset_branch(v);
 		else if (skip_prefix(command_buf.buf, "ls ", &v))
 			parse_ls(v, NULL);
+		else if (skip_prefix(command_buf.buf, "cat-blob ", &v))
+			parse_cat_blob(v);
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
 		else if (!strcmp("done", command_buf.buf))
-- 
2.21.0.rc2.5.g8f70af2367

