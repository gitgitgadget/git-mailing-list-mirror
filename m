Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BBB7208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 22:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbeHGA7F (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 20:59:05 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37044 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732862AbeHGA7E (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Aug 2018 20:59:04 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76MiHZX027627;
        Mon, 6 Aug 2018 15:47:48 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kna0jbwsk-1;
        Mon, 06 Aug 2018 15:47:47 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id A9ED5228A02B;
        Mon,  6 Aug 2018 15:47:47 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id A05622CDE73;
        Mon,  6 Aug 2018 15:47:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC/WIP PATCH 0/3] Modifications to handling of non-textual file merge conflicts
Date:   Mon,  6 Aug 2018 15:47:42 -0700
Message-Id: <20180806224745.8681-1-newren@gmail.com>
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

=3D=3D Summary =3D=3D

For non-textual conflicts, I would like to provide additional information
in the working copy in the form of additional conflict markers and
explanatory text stating what type of non-textual conflict was involved.
This should
  * Make it clearer to users what conflicts they are dealing with and why
  * Enable new features like Thomas Rast' old remerge-diff proposal[1]

[1] https://public-inbox.org/git/cover.1409860234.git.tr@thomasrast.ch/

If this sounds rather imprecise, concrete examples are provided in the
next section of this email.  If this change sounds surprising or
non-intuitive, more detailed rationale motivating this change (which is
admittedly slightly non-obvious) can be found in the remainder of this
email.  It may be the more of the information below needs to be moved int=
o
the commit message for patch 3.

=3D=3D Examples of Proposal =3D=3D

There are two basic types of changes at play here, each best shown with a
representative example:

1) Representative example: A modify/delete conflict; the path in question
in the working tree would have conflict information at the top of the fil=
e
followed by the normal file contents; thus it could be of the form:

    <<<<<<<< HEAD
    Conflict hint: This block of text was not part of the original
    branch; it serves instead to hint about non-textual conflicts:
      MODIFY/DELETE: path foo modified in HEAD and deleted in BRANCH
    =3D=3D=3D=3D=3D=3D=3D=3D
    Conflict hint: This block of text was not part of the original
    branch; it serves instead to hint about non-textual conflicts:
      MODIFY/DELETE: path foo modified in HEAD and deleted in BRANCH
    >>>>>>>> BRANCH
    Lorem ipsum dolor sit amet, consectetuer sadipscing elitr,
    sed diam nonumy eirmod tempor invidunt ut labore et dolore
    magna aliquyam erat, sed diam voluptua. At vero eos et
    accusam et justo duo dolores et ea rebum. Stet clita kasd
    gubergren, no sea takimata sanctus est Lorem ipsum dolor
    sit amet.

Alternative ideas for handling the explanatory text here are welcome.  I
chose to use identical text on both sides of the conflict in an attempt
to highlight that this isn't a normal textual conflict and the text isn't
meant to be part of the file.

This type of example could apply for each of the following types of
conflicts:
  * modify/delete
  * rename/delete
  * directory/file
  * submodule/file
  * symlink/file
  * rename/rename(1to2)
  * executable mode conflict (i.e. 100644 vs. 100755 mode; could come
    from add/add or modify/delete or rename/delete)

It could also be used for the following types of conflicts to help
differentiate between it and other conflict types:
  * add/add
  * rename/add[/delete]
  * rename/rename(2to1)[/delete[/delete]]
  * rename/rename(1to2)/add[/add]

However, any of the types above would be inappropriate if the regular
file(s) in question were binary; in those cases, they'd actually fall
into category two:


2) Representative example: A binary edit/edit conflict.  In this case,
it would be inappropriate to put the conflict markers inside the
binary file.  Instead, we create another file (e.g. path~CONFLICTS)
and put conflict markers in it:

    <<<<<<<< HEAD
    Conflict hint: This block of text was not part of the original
    branch; it serves instead to hint about non-textual conflicts:
      BINARY conflict: path foo modified in both branches
    =3D=3D=3D=3D=3D=3D=3D=3D
    Conflict hint: This block of text was not part of the original
    branch; it serves instead to hint about non-textual conflicts:
      BINARY conflict: path foo modified in both branches
    >>>>>>>> BRANCH

This file would also be added to the index at stage 1 (so that 'git merge
--abort' would clean this file out instead of leaving it around untracked=
,
and also because 'git status' would report "deleted in both" which seems
reasonable).

This type of example could apply for each of the following types of
conflicts:
  * binary edit/edit
  * any of the conflicts from type 1 when binary files are involved
  * symlink edit/edit (or add/add)
  * symlink/submodule
  * symlink/directory
  * directory/submodule
  * submodule/submodule

It could also apply to the following new corner case conflict types from
directory rename detection:
  * N-way colliding paths (N>=3D2) due to directory renames
  * directory rename split; half renamed to one directory and half to ano=
ther


=3D=3D Motivation, part 1: Problem statement =3D=3D

When conflicts arise we need ways to inform the user of the existence of
the conflicts and their nature.  For textual conflicts with regular files=
,
we have a simple way of doing this: inserting conflict markers into the
relevant region of the file with both conflicting versions present.
Importantly, this representation of the conflict is present in the workin=
g
copy.

For other types of conflicts (path-based or non-regular files), we often
provide no hint in the working copy about either the existence or the
nature of the conflict.  I think this is suboptimal from a users'
point-of-view, and is also limiting some feature development.

=3D=3D Motivation, part 2: Current non-textual conflict hints =3D=3D

For non-textual conflicts, the hints git currently gives the user come in
two forms: messages printed during the merge, and higher order stages in
the index.  Both have some downsides.

For large repos, conflict messages ("e.g. CONFLICT(modify/delete): ...")
printed during the merge can easily be "lost in the noise" and might even
be inaccessible depending on the terminal scrollback buffer size.
Further, as the user begins resolving conflicts in that terminal, it
becomes harder and harder to find the original conflict messages for the
remaining paths.

While higher order stages in the index can be helpful, there are many mor=
e
conflict types than there are permutations of higher order stages.  To
name just one example, if all three higher order stages exist, what type
of conflict is it?  It could be an edit/edit conflict, or a
rename/add/delete conflict, or even a file from a directory/file conflict
if that file was involved in a rename.

=3D=3D Motivation, part 3: Disappearing conflict hints =3D=3D

I want to revive Thomas Rast' remerge-diff feature proposal.  To implemen=
t
that feature, he essentially does an auto-merge of the parent commits and
records a resulting tree.  That tree includes conflict information, namel=
y
in the form of files that have conflict markers in them.  He then diffs
this auto-merged tree to the actual tree of the merge commit.

I like the idea of an auto-merge tree with conflict information, but note
that this means printed conflict messages and higher order index entries
will be _completely_ lost, making it important that there be a way of
storing hints about conflicts in the working tree.

(Side note: Thomas' old proposal partially address this; he takes paths
that only had either a stage 2 or 3 entry and does a two-way diff with an
empty file.  That is a very reasonable first cut, but it misses lots of
information.  For example, binary conflicts and mode conflicts would
essentially be ignored.  Differentation between conflict types -- which
may be important or helpful to users trying to understand what happened -=
-
would be lost.)


Elijah Newren (3):
  rerere: avoid buffer overrun
  merge-recursive: fix handling of submodules in modify/delete conflicts
  merge-recursive: provide more conflict hints for non-textual conflicts

 merge-recursive.c                   | 135 +++++++++++++++++++++++++++-
 rerere.c                            |   2 +-
 t/t3031-merge-criscross.sh          |   2 +
 t/t6022-merge-rename.sh             |  39 ++------
 t/t6043-merge-rename-directories.sh |   4 +-
 t/t7610-mergetool.sh                |   4 +
 6 files changed, 146 insertions(+), 40 deletions(-)

--=20
2.18.0.550.g44d6daf40a.dirty

