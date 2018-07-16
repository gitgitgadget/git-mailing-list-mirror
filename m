Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA161F597
	for <e@80x24.org>; Mon, 16 Jul 2018 19:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeGPToQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:44:16 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:55296 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728787AbeGPToP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Jul 2018 15:44:15 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GJDNre013373;
        Mon, 16 Jul 2018 12:15:07 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2k7f1gkn2d-1;
        Mon, 16 Jul 2018 12:15:07 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 56568228A02B;
        Mon, 16 Jul 2018 12:15:07 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 402E72CDE60;
        Mon, 16 Jul 2018 12:15:07 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Date:   Mon, 16 Jul 2018 12:15:05 -0700
Message-Id: <20180716191505.857-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.136.g317db268d9
In-Reply-To: <20180716172717.237373-1-jonathantanmy@google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160217
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 16, 2018 at 10:27 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> In a087cc9819 ("git-gc --auto: protect ourselves from accumulated
> cruft", 2007-09-17), the user was warned if there were too many
> unreachable loose objects. This made sense at the time, because gc
> couldn't prune them safely. But subsequently, git prune learned the
> ability to not prune recently created loose objects, making pruning able
> to be done more safely, and gc was made to automatically prune old
> unreachable loose objects in 25ee9731c1 ("gc: call "prune --expire
> 2.weeks.ago" by default", 2008-03-12).
...
>
> ---
> This was noticed when a daemonized gc run wrote this warning to the log
> file, and returned 0; but a subsequent run merely read the log file, saw
> that it is non-empty and returned -1 (which is inconsistent in that such
> a run should return 0, as it did the first time).

Yeah, we've hit this several times too.  I even created a testcase and a
workaround, though I never got it into proper submission form.

The basic problem here, at least for us, is that gc has enough
information to know it could expunge some objects, but because of how
it is structured in terms of several substeps (reflog expiration,
repack, prune), the information is lost between the steps and it
instead writes them out as unreachable objects.  If we could prune (or
avoid exploding) loose objects that are only reachable from reflog
entries that we are expiring, then the problem goes away for us.  (I
totally understand that other repos may have enough unreachable
objects for other reasons that Peff's suggestion to just pack up
unreachable objects is still a really good idea.  But on its own, it
seems like a waste since it's packing stuff that we know we could just
expunge.)

Anyway, my very rough testcase is below.  The workaround is the
git_actual_garbage_collect() function (minus the call to
wait_for_background_gc_to_finish).

Elijah

---


wait_for_background_gc_to_finish() {
    while ( ps -ef | grep -v grep | grep --quiet git.gc.--auto ); do
        sleep 1;
    done
}

git_standard_garbage_collect() {
    # Current git gc sprays unreachable objects back in loose form; this is
    # fine in many cases, but is annoying when done with objects which
    # newly become unreachable because of something else git-gc does and
    # git-gc doesn't clean them up.
    git gc --auto
    wait_for_background_gc_to_finish
}

git_actual_garbage_collect() {
    GITDIR=$(git rev-parse --git-dir)

    # Record all revisions stored in reflog before and after gc
    git rev-list --no-walk --reflog >$GITDIR/gc.original-refs
    git gc --auto
    wait_for_background_gc_to_finish
    git rev-list --no-walk --reflog >$GITDIR/gc.final-refs

    # Find out which reflog entries were removed
    DELETED_REFS=$(comm -23 <(sort $GITDIR/gc.original-refs) <(sort $GITDIR/gc.final-refs))

    # Get the list of objects which used to be reachable, but were made
    # unreachable due to gc's reflog expiration.  To get these, I need
    # the intersection of things reachable from $DELETED_REFS and things
    # which are unreachable now.
    git rev-list --objects $DELETED_REFS --not --all --reflog | awk '{print $1}' >$GITDIR/gc.previously-reachable-objects
    git prune --expire=now --dry-run | awk '{print $1}' > $GITDIR/gc.unreachable-objects

    # Delete all the previously-reachable-objects made unreachable by the
    # reflog expiration done by git gc
    comm -12 <(sort $GITDIR/gc.unreachable-objects) <(sort $GITDIR/gc.previously-reachable-objects) | sed -e "s#^\(..\)#$GITDIR/objects/\1/#" | xargs rm
}


test -d testcase && { echo "testcase exists; exiting"; exit 1; }
git init testcase/
cd testcase

# Create a basic commit
echo hello >world
git add world
git commit -q -m "Initial"

# Create a commit with lots of files
for i in {0000..9999}; do echo $i >$i; done
git add [0-9]*
git commit --quiet -m "Lots of numbers"

# Pack it all up
git gc --quiet

# Stop referencing the garbage
git reset --quiet --hard HEAD~1

# Pretend we did all the above stuff 30 days ago
for rlog in $(find .git/logs -type f); do
  # Subtract 3E6 (just over 30 days) from every date (assuming dates have
  # exactly 10 digits, which just happens to be valid...right now at least)
  perl -i -ne '/(.*?)(\b[0-9]{10}\b)(.*)/ && print $1,$2-3000000,$3,"\n"' $rlog
done

# HOWEVER: note that the pack is new; if we make the pack old, the old objects
# will get pruned for us.  But it is quite common to have new packfiles with
# old-and-soon-to-be-unreferenced-objects because frequent gc's mean moving
# the objects to new packfiles often, and eventually the reflog is expired.
# If you want to test them being part of an old packfile, uncomment this:
#   find .git/objects/pack -type f | xargs touch -t 200001010101

# Create 50 packfiles in the current repo so that 'git gc --auto' will
# trigger `git repack -A -d -l` instead of just `git repack -d -l`
for i in {01..50}; do
  git fast-export master | sed -e s/Initial/Initi$i/ | git -c fastimport.unpacklimit=0 fast-import --quiet |& grep -v "Not updating refs/heads/master"
done

echo "*** Before gc, reflog refers to garbage-collectible commits: ***"
git rev-list --no-walk --all --reflog
cat .git/logs/refs/heads/master
echo "*** Before gc, everything is packed with no loose objects: ***"
git count-objects -v

git_standard_garbage_collect  # Just `git gc --auto`
#git_actual_garbage_collect    # What I really want from `git gc --auto`

echo -e "\n\n*** After gc, commit garbage collected and objects made loose: ***"
git rev-list --no-walk --all --reflog
cat .git/logs/refs/heads/master
git count-objects -v

echo -e "\n\n*** Now we can trigger the 'too many unreachable' error: ***"
git gc --auto
