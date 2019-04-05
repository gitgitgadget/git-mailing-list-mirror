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
	by dcvr.yhbt.net (Postfix) with ESMTP id 85ABD20248
	for <e@80x24.org>; Fri,  5 Apr 2019 15:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfDEPA6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 11:00:58 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40156 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729269AbfDEPA5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Apr 2019 11:00:57 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x35EwSnr001751;
        Fri, 5 Apr 2019 08:00:40 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rmg324g4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 05 Apr 2019 08:00:40 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 5 Apr 2019 08:00:38 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 5 Apr 2019 08:00:41 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id DA1FF220A45C;
        Fri,  5 Apr 2019 08:00:38 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 00/15] Switch directory rename detection default
Date:   Fri, 5 Apr 2019 08:00:11 -0700
Message-ID: <20190405150026.5260-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.211.g719c25afaf.dirty
In-Reply-To: <20190330003336.21940-1-newren@gmail.com>
References: <20190330003336.21940-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904050102
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a new configuration option, merge.directoryRenames,
for setting how to make use of directory rename detection heuristics.
The default becomes "conflict", meaning that conflicts are reported
instead of silently moving paths according to the heuristics.  Also,
even when merge.directoryRenames config setting is "true", this series
changes behavior in that it now prints informational messages about
paths that are adjusted by the directory rename detection heuristics.

Changes since v2 (range-diff below):
  * Made use of git_parse_maybe_bool() as suggested by Ævar, and made
    the parsing of the merge.directoryRenames setting look more like
    that for merge.ff.

I didn't get much review of round 2, which maybe means everyone is
happy with what they see.  If anyone would like to take a look at just
part of the series, the pieces I'd most like folks to look at are:
  * Patch 15, particularly looking over the new testcases (13a-13d) in
    t6043 and the documentation.
  * Should I have switched the type of "mode" from 'unsigned short' to
    'unsigned' instead of vice-versa in patch 1?
  * Similarly, does anyone have a reason to prefer oid,mode pair over
    using a diff_filespec (in patch 11 I convert half the sites to the
    latter)?


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

Range-diff:
 1:  bb5b410a61 =  1:  bb5b410a61 Use 'unsigned short' for mode, like diff_filespec does
 2:  f91c28257e =  2:  f91c28257e merge-recursive: rename merge_options argument from 'o' to 'opt'
 3:  e3fe8baa15 =  3:  e3fe8baa15 merge-recursive: rename diff_filespec 'one' to 'o'
 4:  c6bd963ffb =  4:  c6bd963ffb merge-recursive: rename locals 'o' and 'a' to 'obuf' and 'abuf'
 5:  eca30e7571 =  5:  eca30e7571 merge-recursive: use 'ci' for rename_conflict_info variable name
 6:  07f0d5fa8e =  6:  07f0d5fa8e merge-recursive: move some struct declarations together
 7:  4cdd1ecbcb =  7:  4cdd1ecbcb merge-recursive: shrink rename_conflict_info
 8:  3490324bdd =  8:  3490324bdd merge-recursive: remove ren[12]_other fields from rename_conflict_info
 9:  fb73a2c55d =  9:  fb73a2c55d merge-recursive: track branch where rename occurred in rename struct
10:  124ee08ed8 = 10:  124ee08ed8 merge-recursive: cleanup handle_rename_* function signatures
11:  78a5916efe = 11:  78a5916efe merge-recursive: switch from (oid,mode) pairs to a diff_filespec
12:  a8309326c1 = 12:  a8309326c1 t6043: fix copied test description to match its purpose
13:  b362f4db1e = 13:  b362f4db1e merge-recursive: track information associated with directory renames
14:  2e0258a358 = 14:  2e0258a358 merge-recursive: give callers of handle_content_merge() access to contents
15:  719c25afaf ! 15:  428cdf62b3 merge-recursive: switch directory rename detection default
    @@ -262,17 +262,12 @@
      		free(value);
      	}
     +	if (!git_config_get_string("merge.directoryrenames", &value)) {
    -+		if (!strcasecmp(value, "true"))
    -+			opt->detect_directory_renames = 2;
    -+		else if (!strcasecmp(value, "false"))
    -+			opt->detect_directory_renames = 0;
    -+		else if (!strcasecmp(value, "conflict"))
    ++		int boolval = git_parse_maybe_bool(value);
    ++		if (0 <= boolval) {
    ++			opt->detect_directory_renames = boolval ? 2 : 0;
    ++		} else if (!strcasecmp(value, "conflict")) {
     +			opt->detect_directory_renames = 1;
    -+		else {
    -+			error(_("Invalid value for merge.directoryRenames: %s"),
    -+			      value);
    -+			opt->detect_directory_renames = 1;
    -+		}
    ++		} /* avoid erroring on values from future versions of git */
     +		free(value);
     +	}
      	git_config(git_xmerge_config, NULL);
-- 
2.21.0.211.g719c25afaf.dirty

