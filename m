Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E24208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeHHSvm (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:51:42 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:56658 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727706AbeHHSvl (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 14:51:41 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78GMx1C011991;
        Wed, 8 Aug 2018 09:31:09 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kr3478386-1;
        Wed, 08 Aug 2018 09:31:09 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 377022290328;
        Wed,  8 Aug 2018 09:31:09 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 2CBDB2CDEB1;
        Wed,  8 Aug 2018 09:31:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        martin.agren@gmail.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 0/5] Simple fixes to t7406
Date:   Wed,  8 Aug 2018 09:31:02 -0700
Message-Id: <20180808163107.12329-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.556.g1604670984
In-Reply-To: <20180807164905.3859-1-newren@gmail.com>
References: <20180807164905.3859-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=931 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080167
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3, all suggested/endorsed by Junio (range-diff at the end)=
:
  - Moved the actual fix from being last patch in the series to the first
    (other patches in this series are just test code cleanups)
  - Anchored regexes to avoid matching another filename as a substring
  - Add test_path_exists() to test-lib-function.sh and use it (we had
    test_path_is_dir, test_path_is_file, and test_path_is_missing, but
    not simple test_path_exists)

Elijah Newren (5):
  t7406: fix call that was failing for the wrong reason
  t7406: simplify by using diff --name-only instead of diff --raw
  t7406: avoid having git commands upstream of a pipe
  t7406: prefer test_* helper functions to test -[feds]
  t7406: avoid using test_must_fail for commands other than git

 t/t7406-submodule-update.sh | 37 +++++++++++++++++++++++--------------
 t/test-lib-functions.sh     |  8 ++++++++
 2 files changed, 31 insertions(+), 14 deletions(-)

-:  ---------- > 1:  5f257af6c8 t7406: fix call that was failing for the =
wrong reason
1:  3c369bf73d ! 2:  9e5400a1ad t7406: simplify by using diff --name-only=
 instead of diff --raw
    @@ -16,10 +16,10 @@
      	  compare_head
      	 ) &&
     -	 git diff --raw | grep "	submodule" &&
    -+	 git diff --name-only | grep submodule &&
    ++	 git diff --name-only | grep ^submodule$ &&
      	 git submodule update &&
     -	 git diff --raw | grep "	submodule" &&
    -+	 git diff --name-only | grep submodule &&
    ++	 git diff --name-only | grep ^submodule$ &&
      	 (cd submodule &&
      	  compare_head
      	 ) &&
    @@ -28,10 +28,12 @@
      	  compare_head
      	 ) &&
     -	 git diff --raw | grep "	submodule" &&
    -+	 git diff --name-only | grep submodule &&
    ++	 git diff --name-only | grep ^submodule$ &&
      	 git submodule update --checkout &&
    --	 test_must_fail git diff --raw \| grep "	submodule" &&
    -+	 test_must_fail git diff --name-only \| grep submodule &&
    +-	 git diff --raw >out &&
    +-	 ! grep "	submodule" out &&
    ++	 git diff --name-only >out &&
    ++	 ! grep ^submodule$ out &&
      	 (cd submodule &&
      	  test_must_fail compare_head
      	 ) &&
2:  ba50d6b0f3 ! 3:  4e8cdf60f4 t7406: avoid having git commands upstream=
 of a pipe
    @@ -26,13 +26,13 @@
      	  git checkout master &&
      	  compare_head
      	 ) &&
    --	 git diff --name-only | grep submodule &&
    +-	 git diff --name-only | grep ^submodule$ &&
     +	 git diff --name-only >out &&
    -+	 grep submodule out &&
    ++	 grep ^submodule$ out &&
      	 git submodule update &&
    --	 git diff --name-only | grep submodule &&
    +-	 git diff --name-only | grep ^submodule$ &&
     +	 git diff --name-only >out &&
    -+	 grep submodule out &&
    ++	 grep ^submodule$ out &&
      	 (cd submodule &&
      	  compare_head
      	 ) &&
    @@ -40,12 +40,12 @@
      	  git checkout master &&
      	  compare_head
      	 ) &&
    --	 git diff --name-only | grep submodule &&
    +-	 git diff --name-only | grep ^submodule$ &&
     +	 git diff --name-only >out &&
    -+	 grep submodule out &&
    ++	 grep ^submodule$ out &&
      	 git submodule update --checkout &&
    - 	 test_must_fail git diff --name-only \| grep submodule &&
    - 	 (cd submodule &&
    +	 git diff --name-only >out &&
    +	 ! grep ^submodule$ out &&
     @@
      	 H=3D$(git rev-parse --short HEAD) &&
      	 git commit -am "pre move" &&
3:  42f7b7f225 ! 4:  f171cbcc9a t7406: prefer test_* helper functions to =
test -[feds]
    @@ -6,13 +6,12 @@
         test failures, so use the test_* helper functions from
         test-lib-functions.sh.
    =20
    -    Note: The use of 'test_path_is_file submodule/.git' may look odd=
, but
    -    it is a file which is populated with a
    +    Also, add test_path_exists() to test-lib-function.sh while at it=
, so
    +    that we don't need to worry whether submodule/.git is a file or =
a
    +    directory.  It currently is a file with contents of the form
            gitdir: ../.git/modules/submodule
    -    directive.  If, in the future, handling of the submodule is chan=
ged and
    -    submodule/.git becomes a directory we can change this to
    -    test_path_is_dir (or perhaps write a test_path_exists helper fun=
ction
    -    that doesn't care whether the path is a file or a directory).
    +    but it could be changed in the future to be a directory; this te=
st
    +    only really cares that it exists.
    =20
         Signed-off-by: Elijah Newren <newren@gmail.com>
    =20
    @@ -34,8 +33,27 @@
      	 git submodule update --init &&
     -	 test -e submodule/.git &&
     -	 test_must_fail test -e none/.git
    -+	 test_path_is_file submodule/.git &&
    ++	 test_path_exists submodule/.git &&
     +	 test_path_is_missing none/.git
      	)
      '
     =20
    +
    +diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
    +--- a/t/test-lib-functions.sh
    ++++ b/t/test-lib-functions.sh
    +@@
    +	fi
    + }
    +
    ++test_path_exists () {
    ++	if ! test -e "$1"
    ++	then
    ++		echo "Path $1 doesn't exist. $2"
    ++		false
    ++	fi
    ++}
    ++
    + # Check if the directory exists and is empty as expected, barf othe=
rwise.
    + test_dir_is_empty () {
    +	test_path_is_dir "$1" &&
4:  54cf6531ec ! 5:  a44c566321 t7406: avoid using test_must_fail for com=
mands other than git
    @@ -8,8 +8,8 @@
     --- a/t/t7406-submodule-update.sh
     +++ b/t/t7406-submodule-update.sh
     @@
    - 	 git submodule update --checkout &&
    - 	 test_must_fail git diff --name-only \| grep submodule &&
    +	 git diff --name-only >out &&
    +	 ! grep ^submodule$ out &&
      	 (cd submodule &&
     -	  test_must_fail compare_head
     +	  ! compare_head
5:  3019f2d01c < -:  ---------- t7406: fix call that was failing for the =
wrong reason

--=20
2.18.0.556.g1604670984
