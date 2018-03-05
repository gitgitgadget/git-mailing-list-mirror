Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97351F404
	for <e@80x24.org>; Mon,  5 Mar 2018 17:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeCERMC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 12:12:02 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:43278 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751779AbeCERLw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Mar 2018 12:11:52 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w25H2lTP032286;
        Mon, 5 Mar 2018 09:11:26 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2gfsfqk1w8-1;
        Mon, 05 Mar 2018 09:11:26 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 2252E2215E11;
        Mon,  5 Mar 2018 09:11:26 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 1B51A2CDEA7;
        Mon,  5 Mar 2018 09:11:26 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Somebody <somebody@ex.com>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/5] Improve path collision conflict resolutions
Date:   Mon,  5 Mar 2018 09:11:20 -0800
Message-Id: <20180305171125.22331-1-newren@gmail.com>
X-Mailer: git-send-email 2.16.0.41.g6a66043158
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803050199
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series improves conflict resolutions for conflict types that involve
two (possibly entirely unrelated) files colliding at the same path.  Thes=
e
conflict types are:
  * add/add
  * rename/add
  * rename/rename(2to1)

Improving these conflict types has some subtle (though significant)
performance ramifications, but for now, I am just concentrating on
providing the user with better information for their conflict resolution.
Performance considerations will be addressed in a future patch series.

Before mentioning the improvements, it may be worth noting that these thr=
ee
types are actually more similar than might at first be apparent: for the
cases involving renames, any trace of the rename-source path is deleted
from both the index and the working copy (modulo a small technicality
mentioned in patch 2), leaving just the question of how to represent two
colliding files in both the index and the working copy for all three case=
s.

There are three important changes this patch series introduces:

  1) Consolidating the code for these three types of conflict resolutions
     into a single function that all three code paths can call.

  2) Doing content merges for a rename before looking at the path collisi=
on
     between a rename and some other file.  In particular (in what I most
     suspect others might have an objection to from this series), record
     that content-merged file -- which may have conflict markers -- in th=
e
     index at the appropriate higher stage.

  3) Smarter behavior for recording the conflict in the working tree: fir=
st
     checking whether the two colliding files are similar, and then based
     on that, deciding whether to handle the path collision via a two-way
     merge of the different files or to instead record the two different
     files at separate temporary paths.

In more detail:

1)

The consolidation seems fairly self-explanatory, but it had a bigger effe=
ct
than you'd expect: it made it clear that the rename/add conflict resoluti=
on
is broken in multiple ways, and it also made it easier to reason about wh=
at
_should_ be done for rename/add conflicts (something I had struggled with
when I looked at that particular conflict type in the past).  See patch 3
for more details.

Sidenote: I was kind of surprised that rename/add could have been broken
for this long, unnoticed.  Does no one ever hit that conflict in real lif=
e?
It looks like we did not have very good test coverage for rename/add
conflicts; a brief search seems to show that we only had a few testcases
triggering that conflict type, and all of them were added by me.  Patch 1
tries to address the testcase problem by adding some tests that try to
check the index and working copy more strictly for all three conflict
types.

2)

Previously, rename/rename(2to1) conflict resolution for the colliding pat=
h
would just accept the index changes made by unpack_trees(), meaning that
each of the higher order stages in the index for the path collision would
implicitly ignore any changes to each renamed file from the other side of
history.  Since, as noted above, all traces of the rename-source path wer=
e
removed from both the index and the working tree, this meant that the ind=
ex
was missing information about changes to such files.  If the user tried t=
o
resolve the conflict using the index rather than the working copy, they
would end up with a silent loss of changes.

I "fixed" this by doing the three-way content merge for each renamed-file=
,
and then recorded THAT in the index at either stage 2 or 3 as appropriate=
.
Since that merge might have conflict markers, that could mean recording i=
n
the index a file with conflict markers as though it were a given side.
(See patch 2 for a more detailed explanation.)  I figure this might be th=
e
most controversial change I made.  I can think of a few alternatives, but=
 I
liked all of them less.  Opinions?

This change did not require any significant changes to the testsuite; the
difference between the old and new behavior was essentially untested.

(rename/add was even worse: not recording _any_ higher order stages in th=
e
index, and thus partially hiding the fact that the path was involved in a
conflict at all.)

3)

Given the similarity between the conflict types, the big question for
handling the conflict in the working tree was whether the two colliding
files should be two-way merged and recorded in place (as add/add does,
which seems to be preferable if the two files are similar), or whether th=
e
two files should be recorded into separate files (as rename/add and
rename/rename(2to1) do, which seems to be preferable if the two files are
dissimilar).  The code handling the different types of conflicts appear t=
o
have been written with different assumptions about whether the colliding
files would be similar.

But, rather than make an assumption about whether the two files will be
similar, why not just check and then make the best choice based on that?
Thus, this code makes use of estimate_similarity(), and uses that to deci=
de
whether to do a two-way content merge or writing unrelated files out to
differently named temporary files.

This logical change did require changing one to two dozen testcases in th=
e
testsuite; I think this is more logical behavior and that the testcases
were toy examples utilized to test other things, but maybe someone else h=
as
an argument for why add/add conflicts should always be two-way merged
regardless of file dissimilarity?


Other notes:

This series builds on en/rename-directory-detection; there are too many
conflicts to resolve if I tried to just base on master.


Elijah Newren (5):
  Add testcases for improved file collision conflict handling
  merge-recursive: new function for better colliding conflict
    resolutions
  merge-recursive: fix rename/add conflict handling
  merge-recursive: improve handling for rename/rename(2to1) conflicts
  merge-recursive: improve handling for add/add conflicts

 diff.h                               |   4 +
 diffcore-rename.c                    |   6 +-
 merge-recursive.c                    | 383 +++++++++++++++++++++++------=
------
 t/t2023-checkout-m.sh                |   2 +-
 t/t3418-rebase-continue.sh           |  27 ++-
 t/t3504-cherry-pick-rerere.sh        |  19 +-
 t/t4200-rerere.sh                    |  12 +-
 t/t6020-merge-df.sh                  |   4 +-
 t/t6024-recursive-merge.sh           |  35 ++--
 t/t6025-merge-symlinks.sh            |   9 +-
 t/t6031-merge-filemode.sh            |   4 +-
 t/t6036-recursive-corner-cases.sh    |  19 +-
 t/t6042-merge-rename-corner-cases.sh | 212 ++++++++++++++++++-
 t/t6043-merge-rename-directories.sh  |  15 +-
 t/t7060-wtstatus.sh                  |   1 +
 t/t7064-wtstatus-pv2.sh              |   4 +-
 t/t7506-status-submodule.sh          |  11 +-
 t/t7610-mergetool.sh                 |  28 +--
 18 files changed, 588 insertions(+), 207 deletions(-)

--=20
2.16.0.41.g7fdc8a0834

