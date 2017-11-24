Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11882036D
	for <e@80x24.org>; Fri, 24 Nov 2017 19:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbdKXT7n (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 14:59:43 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39524 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751024AbdKXT7l (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2017 14:59:41 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAOJves8024956;
        Fri, 24 Nov 2017 11:59:02 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ecwkrvjy9-1;
        Fri, 24 Nov 2017 11:59:01 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id D5B3622F84B7;
        Fri, 24 Nov 2017 11:59:01 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id CBE5A2CDE60;
        Fri, 24 Nov 2017 11:59:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        David Turner <dturner@twitter.com>,
        David Turner <dturner@twopensource.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
Date:   Fri, 24 Nov 2017 11:59:01 -0800
Message-Id: <20171124195901.2581-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.311.gc9afee3a13
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711240269
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit ae352c7f3 (merge-recursive.c: fix case-changing merge bug,
2014-05-01), it was observed that removing files could be problematic on
case insensitive file systems, because we could end up removing files
that differed in case only rather than deleting the intended file --
something that happened when files were renamed on one branch in a way
that differed only in case.  To avoid that problem, that commit added
logic to avoid removing files other than the one intended, rejecting the
removal if the files differed only in case.

Unfortunately, the logic it used didn't fully implement that condition as
stated above; instead it merely checked that a case-insensitive lookup of
the file that was requested resulted in finding a file in the index at
stage 0, not that the file found in the index actually differed in case.
Alternatively, one could view the implementation as making an implicit
assumption that the file we actually wanted to remove would never appear
in the index with a stage of 0, and thus that if we found a file with our
lookup, that it had to be a different file (but different in case only).

The net result of this implementation is that it can ignore more requests
than it should, leaving a file around in the working copy that should
have been removed.  Make sure that the file found in the index actually
differs in case before silently ignoring the request to remove the file.

---

If that description leaves more questions than answers, we may need to
augment the above commit message with the following explanation...

But, you may ask, why didn't we ever discover this problem before?  And
why would we have a file at stage 0 in the index that we wanted to remove
from the working copy?  Great questions, both, but the answer is fairly
lengthy.  The short answer to the first question is that due to a myriad
of details, this bug is only currently triggerable:

    * on case insensitive filesystems
    * with rename/rename(2to1) conflicts
    * once one has taken care to avoid allowing renames to overwrite
      untracked or dirty files (see commit 30fd3a5 (merge overwrites
      unstaged changes in renamed file, 2012-04-15), which was fixed in
      my in-flight en/rename-directory-detection series currently sitting
      in pu)
    * AND where one of the renames is implicitly done (e.g. via
      directory rename detection).

Thus, this bug remained hidden/latent until those other conditions are
all triggered.  Luckily, testcase 7b of t6043 added in
en/rename-directory-detection was written to carefully check all details
of the index and working copy to ensure they had the right content,
giving us an early notification of this bug.  (I was worried when I wrote
those tests that I was being too laborious in checking all details, but I
apparently got lucky and the extra checks in one of them paid off.)

To explain why we would have a file at stage 0 in the index that we
wanted to remove from the working copy can be explained by four points
(most of which bring up further questions, but be patient and I'll try to
wrap up all the loose ends):

  * If we have two conflicting files at PATH, we will want the index to
    have two higher stage entries for PATH.  There are a few choices for
    the working copy, but one prominent choice is to remove PATH from the
    working copy, then create PATH~HEAD and PATH~$MERGE files.  This
    strategy for the working copy is currently used for
    rename/rename(2to1) conflicts, though it has also been proposed (in
    my pending rename-perf series I submitted this month) for some
    add/add and rename/add conflicts.

  * When unpack_trees() (called by merge-recursive) notices two paths at
    the same location (which could mean an add/add conflict, or after
    rename detection it might more precisely turn out to be a rename/add
    or rename/rename(2to1) conflict), unpack_trees() removes the stage 0
    index entry for the path and just creates higher stage entries.

    HOWEVER, if files can be implicitly renamed to a path that didn't
    exist on either side of the merge (such as from directory rename
    detection), then merge-recursive can see two conflicting files at the
    same location, despite unpack_trees() having left the path at stage
    0.

  * merge-recursive is traditionally thought of as doing a 3-way merge.
    But what it really is forced to do is more of a 4-way merge; a good
    chunk of its annoying complexity is based around this (undocumented
    and unfortunate) reality.  It derives from what I consider a simple
    design flaw.

  * In order to get the 4-way merge right (i.e. avoiding spurious error
    messages and taking care to not overwrite important dirty or
    untracked files), we MUST handle the working copy BEFORE updating the
    index.

The combination of these four items in aggregate answers how we get a
stage 0 file that we want to remove from the working copy, but leaves two
questions -- what do I mean by 4-way merge, and why does the working copy
have to be updated before the index to get that merge right?  Since those
are crucial to understanding this bug, let me begin by explaining the
4-way merge:

The recursive merge strategy is built on first running unpack_trees() and
then "fixing up" the parts it can't resolve.  unpack_trees() does three
things

  * Check whether any untracked or dirty (not-uptodate) files would be
    overwritten by the merge.
  * Update the index AND working tree for trivial cases
  * Store conflicts as higher order stages in the index for later steps
    (e.g. merge-recursive.c) to resolve.

Note that unpack_trees() doesn't understand renames, thus its checks for
whether a dirty or untracked file would be overwritten by the merge is
going to have both false positives and false negatives.  For false
positives, see testcase 10e of the new t6043 introduced in the in-flight
en/rename-directory-detection series.  For false negatives, see commit
30fd3a5 (merge overwrites unstaged changes in renamed file, 2012-04-15),
and most testcases in sections 10 and 11 of the new t6043 introduced in t=
he
en/rename-directory-detection series.

The false positive cannot be fixed with the current design; unpack_trees(=
)
simply aborts early in some highly uncommon cases.

The false negatives cannot be fixed either, but they can be worked around=
;
fundamentally, it is too late to "abort the merge early" with an error
message, because unpack_trees() already wrote lots of changes to the
working copy for all the trivial merge cases and thus aborting would mean
being left with a dirty working copy.  Since it can't abort early, the co=
de
instead needs to consider what untracked or dirty files might exist in th=
e
working copy and take care to not overwrite them, essentially forcing us =
to
not only consider HEAD, the merge branch, and the merge base, but also th=
e
working copy as a fourth set of content we need to interact with.  (It
could be worse, though.  If not for merge's check that the index matches
HEAD and aborting early if they don't, we could have been forced to deal
with a 5-way merge.)  The workarounds for false negatives take the form o=
f
calling the would_lose_untracked() and was_dirty() functions (the latter =
of
which was added in the en/rename-directory-detection series to fix
overwriting dirty files involved in both normal and directory renames).

That brings us to our final loose end -- why does the working copy have t=
o
be updated before the index?  The short answer is that
would_lose_untracked() and was_dirty() both rely on information in the
index in order to do their work.  The current index has information copie=
d
from the original index by unpack_trees() that we need in these functions=
.
Since unpack_trees() discards the original index before returning, the
current index is our one source for this information, so we need to be
careful not to discard it until after we have handled the working copy.

And it may be important to point out that discarding the information in t=
he
index before updating the working copy is an easy mistake to make that is
painful to debug.  This is evidenced by the existence of commit f53d39778
(merge-recursive: Fix spurious 'refusing to lose untracked file...'
messages, 2011-08-11), which added a big comment at the beginning of
update_stages() pointing out the perils of trying to update the stages in
the index before updating the working copy.  In fact, despite adding that
big comment, I hit the same kind of problem again later and added two mor=
e
very similar large warnings to the top of the conflict_rename_rename_2to1=
()
and apply_directory_rename_modifications() functions in the
en/rename-directory-detection series.

To try to recap, 4-way merge is a pain.  It has always been a pain as
evidenced by commits like
  * f53d39778 (merge-recursive: Fix spurious 'refusing to lose untracked
    file...' messages, 2011)
  * 30fd3a5 (merge overwrites unstaged changes in renamed file, 2012)
but it becomes even more so with additional features and requirements lik=
e
case-insensitive filesystems and directory rename detection.  4-way merge=
s
simply cause the complexity to increase with every new capability.

The cleanest fix would be to switch to a 3-way index-only merge (making
unpack_trees() completely ignore the working copy, and making most of
merge-recursive do the same), then checking for untracked or dirty
working tree files in the way of the merge, then adding code that allows
us to update the working copy from one index to a new index.  That new
update code would be very similar to checkout, except that the new index
might have conflicts, and the new update may need to be supplemented with
additional info in order to correctly report various special conflict
cases such as rename/rename(2to1) or rename/add).

But such a large rewrite is a big task.  In the mean time, fix the
ignore_case code.  Allow it to continue rejecting the removal of files
that differ in case only, but only allow it to reject such removals.


 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Sidenote: I built this commit on master, but it cleanly cherry-picks to
maint, to next, and to pu.

diff --git a/merge-recursive.c b/merge-recursive.c
index b48b15a6f..100fb913f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -646,7 +646,7 @@ static int remove_file(struct merge_options *o, int c=
lean,
 		if (ignore_case) {
 			struct cache_entry *ce;
 			ce =3D cache_file_exists(path, strlen(path), ignore_case);
-			if (ce && ce_stage(ce) =3D=3D 0)
+			if (ce && ce_stage(ce) =3D=3D 0 && strcmp(path, ce->name))
 				return 0;
 		}
 		if (remove_path(path))
--=20
2.11.0

