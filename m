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
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E0E1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 22:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfBTW7F (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 17:59:05 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:60110 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbfBTW7F (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Feb 2019 17:59:05 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KMrM54026544;
        Wed, 20 Feb 2019 14:58:50 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2qph8rdyur-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 20 Feb 2019 14:58:50 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 20 Feb 2019 14:58:30 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 20 Feb 2019 14:58:30 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 031912216320;
        Wed, 20 Feb 2019 14:58:49 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        David Barr <david.barr@cordelta.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/5] Fix some fast-import parsing issues
Date:   Wed, 20 Feb 2019 14:58:41 -0800
Message-ID: <20190220225846.10658-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.5.g8f70af2367
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_18:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found a few issues with parsing in fast-import (dating back to
git-2.6.0).  I was thrown off track for a while by the fact that the
.git/fast_import_crash_$PID file erroneously claimed that the
penultimate command it read was somehow truncated; e.g. for input of
the form:

    commit refs/heads/master
    mark :1
    author Full Name <user@organization.tld> 1000000000 +0100
    committer Full Name <user@organization.tld> 1000000000 +0100
    data 53
    Commit message for intentionally empty orphan commit
    get-mark :1
    
the crash file was reporting

    Most Recent Commands Before Crash
    ---------------------------------
      commit refs/heads/master
      mark :1
      author Full Name <user@organization.tld> 1000000000 +0100
      committer Full Name <user@organization.tld> 1000000000 +0100
      data 53
    * get-mark :1
    
In other words, it dropped the commit message line entirely, which
made me wonder if I was having weird buffering or flushing issues
until I was able to narrow it down to the simple testcase above and
could duplicate with
    cat seven-line-test-file | git fast-import
I don't know if there are other ways to get fast-import to give a
corrupted "Most Recent Commands Before Crash" report, but this one
doesn't trigger after my other fixes below.

Switching gears from the bad reporting to the original parsing bug
though, it is clear fast-import somehow mishandled get-mark directives
after empty orphan commits.  Digging into it, I think it was caused by
following a precedent set by a somewhat unsafe implementation of
trying to allow cat-blob directives to appear in the middle of a
commit.  My spelunking showed the following commits seemed to be the
most relevant as to how we got to the current state:

    777f80d7429b ("fast-import: Allow cat-blob requests at arbitrary
                 points in stream", 2010-11-28)
    8dc6a373d201 ("fast-import: add 'ls' command", 2010-12-02)
    97313bef2a16 ("fast-import: use skip_prefix for parsing input",
                  2014-06-18)
    28c7b1f7b7b7 ("fast-import: add a get-mark command", 2015-07-01)

I've cc'ed the relevant folks, and have a few patches that fix the
issue and I think make the parser more robust against future issues in
a way that I think is safe enough for backward compatibility, but
"backward compatible enough" might concern some folks; if so, please
take a look at patches 4 and 5.

Elijah Newren (5):
  t9300: demonstrate bug with get-mark and empty orphan commits
  git-fast-import.txt: fix wording about where ls command can appear
  fast-import: check most prominent commands first
  fast-import: only allow cat-blob requests where it makes sense
  fast-import: fix erroneous handling of get-mark with empty orphan
    commits

 Documentation/git-fast-import.txt | 22 +++++++++---------
 fast-import.c                     | 31 ++++++++++++++------------
 t/t9300-fast-import.sh            | 37 +++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 24 deletions(-)

-- 
2.21.0.rc2.5.g8f70af2367
