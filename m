Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50CF1208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 22:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbeHGA5G (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 20:57:06 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:36860 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729712AbeHGA5G (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Aug 2018 20:57:06 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76Mi4nn027614;
        Mon, 6 Aug 2018 15:45:50 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kna0jbwqt-1;
        Mon, 06 Aug 2018 15:45:50 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id D50B7226E7F2;
        Mon,  6 Aug 2018 15:45:49 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id CB6822CDE73;
        Mon,  6 Aug 2018 15:45:49 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC/WIP PATCH 0/1] Simplify handling of directory/file conflicts
Date:   Mon,  6 Aug 2018 15:45:46 -0700
Message-Id: <20180806224547.8619-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.550.g44d6daf40a.dirty
In-Reply-To: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060237
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Directory/file conflicts are more difficult than they need to be for user=
s
to resolve (and to un-resolve).  Simplify that process by doing to the
index what we do to the working tree: renaming the file in the
directory/file conflict to a different location.  This also avoids leavin=
g
cruft untracked files around if the user decides to abort the merge.

From one angle this proposal might appear surprising, so extended rationa=
le
for this change can be found below (and if it seems surprising, some of t=
he
below may need to be moved into the commit message for the patch).


=3D=3D What git does, prior to this series =3D=3D

Let's say there's a directory/file conflict for path 'foo'.  One might se=
e
git report:
  CONFLICT (file/directory): There is a directory with name foo in
  BRANCH2. Adding foo as foo~BRANCH
Further, at this point, git will record:
  * foo~BRANCH in the working tree
  * foo/ in the working tree
  * foo at higher order stage in the index
  * foo/* entries found in the index (at stage 0)

=3D=3D User experience resolving directory/file conflicts =3D=3D

Let's say the user wants to resolve by just moving 'foo' (the file) to
somewhere else.  Here's five different things a user might try at this
point (not sequentially, but rather competing ideas they might try),
along with commentary about how each fails to resolve the conflict:

$ git mv foo other
  # Moves the directory instead, oops

$ mv foo~BRANCH other
$ git add other
  # Still leaves 'foo' conflicted in the index

$ git mv foo~BRANCH other
  # Error: "Not under source control"

$ git add -u
  # Removes conflict entry for 'foo' from index, but doesn't add
  # new one and leaves foo~BRANCH around untracked

$ git rm foo
  # Doesn't work ("foo: needs merge...fatal: git rm: 'foo': Is a director=
y)

=3D=3D User experience un-resolving directory/file conflict =3D=3D

If the user decides they don't like the merge and run 'git merge --abort'=
,
the abort fails due to a separate bug being fixed here:

  https://public-inbox.org/git/20180713163331.22446-1-newren@gmail.com/

However, even once the fixes there are part of git, a 'git merge --abort'
will leave behind new untracked files that were created by the merge
attempt (in the case above, one named foo~BRANCH).  This is suboptimal.

=3D=3D Correct solution; old and new =3D=3D

Currently, this is what a user needs to run to resolve this conflict:

$ mv foo~BRANCH other
$ git add other
$ git rm --cached foo

If git would record foo~BRANCH at a higher stage in the index instead
of recording foo there, then we could shorten this to:

$ git add foo~BRANCH
$ git mv foo~BRANCH other

If we could also teach git-mv to quit reporting "not under version
control" for index entries with higher order stages (and instead rename
them while keeping them as higher order stages), then we could also allow
those two commands to be reversed:

$ git mv foo~BRANCH other
$ git add other

While this change to what git records in the index might feel like a lie,
it does make it easier for the user and we already have a precedent for
treating user convience as more important than trying to represent how we
got to the current state, as shown in the following analogy:

=3D=3D Rename analogy =3D=3D

If one side of history renames A->B but there are content conflicts, one
choice for the contents for the index would be:
  <mode> <original sha> 1    A
  <mode> <side-one sha> 2    A
  <mode> <side-two sha> 3    B
However, that's not what git does.  In particular, this choice would requ=
ire
the user to run both 'git add B' and 'git rm --cached A' to resolve the
conflict.  Further, it prevents the user from running commands such as
  git checkout [--ours|--theirs|--conflict|-m] B
  git diff [--ours|--theirs|--base] B
This would also make it harder to pair up entries from 'git ls-files -u'
(especially if there are many entries between A and B), since nothing
marks them as related anymore.  So, instead, git records the following in
the index:
  <mode> <original sha> 1    B
  <mode> <side-one sha> 2    B
  <mode> <side-two sha> 3    B
This might seem like a lie if you view the index as a place to record how
we got to the current state rather than a way to help users resolve
conflicts and update state, but it is certainly far more convenient for
the user to work with.  Follow suit with directory/file conflicts.


Elijah Newren (1):
  merge-recursive: make file/directory conflicts easier to resolve

 merge-recursive.c                    | 38 ++++++++++++++++++++++------
 t/t3030-merge-recursive.sh           | 16 ++++++------
 t/t6020-merge-df.sh                  |  4 +--
 t/t6022-merge-rename.sh              |  4 +--
 t/t6036-recursive-corner-cases.sh    |  5 ++--
 t/t6042-merge-rename-corner-cases.sh |  4 +--
 t/t6043-merge-rename-directories.sh  |  4 +--
 7 files changed, 49 insertions(+), 26 deletions(-)

--=20
2.18.0.550.g44d6daf40a.dirty
