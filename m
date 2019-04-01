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
	by dcvr.yhbt.net (Postfix) with ESMTP id F320C20248
	for <e@80x24.org>; Mon,  1 Apr 2019 16:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfDAQAv (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:00:51 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53096 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbfDAQAv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Apr 2019 12:00:51 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31Frtf2021178;
        Mon, 1 Apr 2019 09:00:22 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rkfhxgh6j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 01 Apr 2019 09:00:21 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 1 Apr 2019 09:00:14 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 1 Apr 2019 09:00:17 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 1288622595F5;
        Mon,  1 Apr 2019 09:00:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        David Barr <david.barr@cordelta.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/5] Fix some fast-import parsing issues
Date:   Mon, 1 Apr 2019 09:00:06 -0700
Message-ID: <20190401160011.20678-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.5.gde71272ddd
In-Reply-To: <20190220225846.10658-1-newren@gmail.com>
References: <20190220225846.10658-1-newren@gmail.com>
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

This series fixes a few issues with parsing in fast-import, dating back to
git-2.6.0.  The only change since v1 is removing the RFC label; sadly, no
one commented on the first round.

Text from my original submission:

The point behind this series is that fast-import somehow mishandled
get-mark directives after empty orphan commits.  Digging into it, I
think it was caused by following a precedent set by a somewhat unsafe
implementation of trying to allow cat-blob directives to appear in the
middle of a commit.  My spelunking showed the following commits seemed
to be the most relevant as to how we got to the current state:

    777f80d7429b ("fast-import: Allow cat-blob requests at arbitrary
                 points in stream", 2010-11-28)
    8dc6a373d201 ("fast-import: add 'ls' command", 2010-12-02)
    97313bef2a16 ("fast-import: use skip_prefix for parsing input",
                  2014-06-18)
    28c7b1f7b7b7 ("fast-import: add a get-mark command", 2015-07-01)

I have a few patches that fix the issue and I think make the parser
more robust against future issues in a way that I think is safe enough
for backward compatibility, but "backward compatible enough" might
concern some folks; if so, please take a look at patches 4 and 5.

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
2.21.0.1.g0a561c1dbd

