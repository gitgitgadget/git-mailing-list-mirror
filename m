Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B3D1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeGMQtB (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 12:49:01 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47164 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729214AbeGMQtB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 12:49:01 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DGS2BU024515;
        Fri, 13 Jul 2018 09:33:34 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2k2tdhk8bx-1;
        Fri, 13 Jul 2018 09:33:34 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 32512225F28D;
        Fri, 13 Jul 2018 09:33:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 28D2A2CDEB1;
        Fri, 13 Jul 2018 09:33:34 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/2] Address recovery failures with directory/file conflicts
Date:   Fri, 13 Jul 2018 09:33:29 -0700
Message-Id: <20180713163331.22446-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.645.g72fe132ec2
In-Reply-To: <20180711051834.28181-1-newren@gmail.com>
References: <20180711051834.28181-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130143
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes several "recovery" commands that outright fail
or do not fully recover when directory-file conflicts are present.
This includes:
   * git read-tree --reset HEAD
   * git am --skip
   * git am --abort
   * git merge --abort (or git reset --merge)
   * git reset --hard

Changes since v1 (full range-diff below):
  - Make use of test_write_lines, as suggested by Eric.
  - Provide a little more explanation in one of the commit messages, as
    suggested by Junio.

Elijah Newren (2):
  t1015: demonstrate directory/file conflict recovery failures
  read-cache: fix directory/file conflict handling in
    read_index_unmerged()

 read-cache.c                         |  13 +--
 t/t1015-read-index-unmerged.sh       | 123 +++++++++++++++++++++++++++
 t/t6020-merge-df.sh                  |   3 -
 t/t6042-merge-rename-corner-cases.sh |   1 -
 4 files changed, 131 insertions(+), 9 deletions(-)
 create mode 100755 t/t1015-read-index-unmerged.sh

1:  a85e462914 ! 1:  8f53327a8d t1015: demonstrate directory/file conflic=
t recovery failures
    @@ -29,7 +29,7 @@
     +	(
     +		cd df_plus_modify_delete &&
     +
    -+		printf "a\nb\nc\nd\ne\nf\ng\nh\n" >letters &&
    ++		test_write_lines a b c d e f g h >letters &&
     +		git add letters &&
     +		git commit -m initial &&
     +
2:  43d5b0a5ae ! 2:  990a469d44 read-cache: fix directory/file conflict h=
andling in read_index_unmerged()
    @@ -53,7 +53,9 @@
         we can just skip the DFCHECK and allow both the file and directo=
ry to
         appear in the index.  The temporary simultaneous appearance of t=
he
         directory and file entries in the index will be removed by the c=
allers
    -    before they attempt to write the index anywhere.
    +    by calling unpack_trees(), which excludes these unmerged entries=
 marked
    +    with CE_CONFLICTED flag from the resulting index, before they at=
tempt to
    +    write the index anywhere.
    =20
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
--=20
2.18.0.645.g72fe132ec2
