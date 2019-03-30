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
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E5020248
	for <e@80x24.org>; Sat, 30 Mar 2019 00:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfC3AeQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 20:34:16 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36364 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729771AbfC3AeQ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Mar 2019 20:34:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0XVDl015420;
        Fri, 29 Mar 2019 17:34:00 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rht7wrarh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 29 Mar 2019 17:34:00 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Mar 2019 17:33:58 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 29 Mar 2019 17:33:55 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id A99A6220CB1E;
        Fri, 29 Mar 2019 17:33:55 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 00/15] Switch directory rename detection default
Date:   Fri, 29 Mar 2019 17:33:21 -0700
Message-ID: <20190330003336.21940-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g078f4bef79.dirty
In-Reply-To: <20190306002744.14418-1-newren@gmail.com>
References: <20190306002744.14418-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=835 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903300002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I know this is kinda big, but it's mostly simple mechanical cleanups.
Stuff I'd like reviewers to focus on:
  * Patch 15, particularly looking over the new testcases (13a-13d) in
    t6043 and the documentation.
  * Should I have switched 'unsigned short' to 'unsigned' instead of
    vice-versa in patch 1?
  * Similarly, does anyone have a reason to prefer oid,mode pair over
    using a diff_filespec as I did in patch 11?

The crux of this series is in patch 15, changing the default for
directory rename detection to treat it as a conflict.  It is similar
to the patch Junio previously reviewed; changes:

  * It now also handles files renamed into directories on one side
    where the other side renamed the directory away.  (Previously, it
    only handled new files added into such directories.)
    
  * As suggested by Junio, even if merge.directoryRenames=true is set
    in config (to accept directory rename heuristics as correct
    without reporting conflicts), messages will now be printed about
    the paths being changed by directory renames.
    
  * Error and info messages updated based in part on Junio's
    suggestions, a second check that the messages make sense would be
    useful.
  
  * There are now testcases testing the conflict and information
    message output (testcases 13[abcd] in t6043)


The reason this series exploded from one patch to fifteen was the need
to handle transitive renames (renames into directories on one side
while the other side renamed that directory away).  For that, I needed
to plumb more information through...but quickly got frustrated with
various ugly code bits and went down a rabbit hole.

The first 12 patches are solely cleanups

Patches 13 & 14 are simple changes to make additional information
available.

Patch 15 is primary purpose of the series, described above.


Elijah Newren (15):
  Use 'unsigned short' for mode, like diff_filespec does
  merge-recursive: rename merge_options argument from 'o' to 'opt'
  merge-recursive: rename diff_filespec 'one' to 'o'
  merge-recursive: rename locals 'o' and 'a' to 'obuf' and 'abuf'
  merge-recursive: use 'ci' for rename_conflict_info variable name
  merge-recursive: move some struct declarations together
  merge-recursive: shrink rename_conflict_info
  merge-recursive: remove ren[12]_other fields from rename_conflict_info
  merge-recursive: track branch where rename occurred in rename struct
  merge-recursive: cleanup handle_rename_* function signatures
  merge-recursive: switch from (oid,mode) pairs to a diff_filespec
  t6043: fix copied test description to match its purpose
  merge-recursive: track information associated with directory renames
  merge-recursive: give callers of handle_content_merge() access to
    contents
  merge-recursive: switch directory rename detection default

 Documentation/config/merge.txt         |   19 +-
 archive.c                              |    2 +-
 blame.c                                |    2 +-
 blame.h                                |    2 +-
 builtin/rm.c                           |    2 +-
 builtin/update-index.c                 |    2 +-
 cache.h                                |    2 +-
 fsck.c                                 |    2 +-
 line-log.c                             |    2 +-
 match-trees.c                          |    8 +-
 merge-recursive.c                      | 1853 ++++++++++++------------
 notes.c                                |    2 +-
 sha1-name.c                            |    2 +-
 t/t3401-rebase-and-am-rename.sh        |    8 +-
 t/t6043-merge-rename-directories.sh    |  462 +++++-
 t/t6046-merge-skip-unneeded-updates.sh |    8 +-
 tree-diff.c                            |    2 +-
 tree-walk.c                            |    6 +-
 tree-walk.h                            |    6 +-
 19 files changed, 1367 insertions(+), 1025 deletions(-)

-- 
2.21.0.211.gb523892db9

