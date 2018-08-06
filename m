Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFCE208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 22:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbeHGA7E (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 20:59:04 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37042 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732832AbeHGA7E (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Aug 2018 20:59:04 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76Mi4EC027609;
        Mon, 6 Aug 2018 15:47:48 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kna0jbwsm-1;
        Mon, 06 Aug 2018 15:47:47 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id BC940228A032;
        Mon,  6 Aug 2018 15:47:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id B38292CDE73;
        Mon,  6 Aug 2018 15:47:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC/WIP PATCH 2/3] merge-recursive: fix handling of submodules in modify/delete conflicts
Date:   Mon,  6 Aug 2018 15:47:44 -0700
Message-Id: <20180806224745.8681-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.550.g44d6daf40a.dirty
In-Reply-To: <20180806224745.8681-1-newren@gmail.com>
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
 <20180806224745.8681-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060237
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to commit c641ca670729 ("merge-recursive: handle addition of
submodule on our side of history", 2017-11-14) a submodule can be
confused for a D/F conflict for modify/delete and rename/delete
conflicts.  (To the code, it appears there is a directory in the way of
us writing our expected path to the working tree, because our path is a
submodule; i.e. the submodule is itself the directory and any directory
is assumed to be a D/F conflict that is in the way.)  So, when we are
dealing with a submodule, avoid checking the working copy for a
directory being in the way.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

It might be better to first check that the submodule existed on the HEAD
side of the merge, because there could be a directory in the way of the
submodule.  But that's starting to get ugly quick, and the real fix to
make this cleaner is the rewrite of merge-recursive that does an index-on=
ly
merge first, then updates the working copy later...

 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1446e92bea..4832234073 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1466,7 +1466,7 @@ static int handle_change_delete(struct merge_option=
s *o,
 	const char *update_path =3D path;
 	int ret =3D 0;
=20
-	if (dir_in_way(path, !o->call_depth, 0) ||
+	if (dir_in_way(path, !o->call_depth && !S_ISGITLINK(changed_mode), 0) |=
|
 	    (!o->call_depth && would_lose_untracked(path))) {
 		update_path =3D alt_path =3D unique_path(o, path, change_branch);
 	}
--=20
2.18.0.550.g44d6daf40a.dirty

