Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713F41F597
	for <e@80x24.org>; Wed, 18 Jul 2018 22:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeGRXbU convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 18 Jul 2018 19:31:20 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55380 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbeGRXbU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Jul 2018 19:31:20 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IMjU7G023148;
        Wed, 18 Jul 2018 15:51:14 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ka270h9rk-1;
        Wed, 18 Jul 2018 15:51:13 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id DF79E22378E3;
        Wed, 18 Jul 2018 15:51:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D82972CDF10;
        Wed, 18 Jul 2018 15:51:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Elijah Newren <newren@gmail.com>
Subject: 2.18.0 Regression: packing performance and effectiveness
Date:   Wed, 18 Jul 2018 15:51:08 -0700
Message-Id: <20180718225110.17639-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.1.gd83e732e4e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=917 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180247
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had a user report some poor behavior of 'git gc --aggressive' on a
certain repo (which I sadly cannot share).  Turns out that on this
repo, this operation takes about 60% longer and produces a pack
roughly twice the expected size.

Naturally, bisecting takes a while but it points to this commit:

0aca34e8269514ebb67676e0470a314615494ae8 is the first bad commit
commit 0aca34e8269514ebb67676e0470a314615494ae8
Author: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Date:   Sat Apr 14 17:35:11 2018 +0200

    pack-objects: shrink delta_size field in struct object_entry

    Allowing a delta size of 64 bits is crazy. Shrink this field down to
    20 bits with one overflow bit.

    If we find an existing delta larger than 1MB, we do not cache
    delta_size at all and will get the value from oe_size(), potentially
    from disk if it's larger than 4GB.

    Note, since DELTA_SIZE() is used in try_delta() code, it must be
    thread-safe. Luckily oe_size() does guarantee this so we it is
    thread-safe.

    Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

To put some numbers behind this, I got on a very beefy box (40 cores,
160GB RAM) and ran some comparisons:

Version  Pack (MB)  MaxRSS(kB)  Time (s)
-------  ---------  ----------  --------
 2.17.0     5498     43513628    2494.85
 2.18.0    10531     40449596    4168.94
 fix-v1     5509     42509784    2480.74
 fiv-v2     5509     41644104    2468.25

where fix-v1 and fix-v2 are different patches on top of git-2.18.0
that I'll follow up to this email with.  The patches are just meant as
discussion starters.  I'll add signoffs and proper commit messages if
folks actually want those fixes, but I suspect they're just starting
points for discussion.
