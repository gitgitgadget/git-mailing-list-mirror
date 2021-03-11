Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E95C433E6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 20:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1590C64F8B
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 20:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCKUMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 15:12:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50497 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCKULc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 15:11:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24AA312B888;
        Thu, 11 Mar 2021 15:11:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=PXMu61Eqlns4rQi0xR6EW3r1B
        zc=; b=lcBRQaKyhk20/y3pDrkGN4AVRMiF0tSSHcmDMSxJodZ3B2GfxfoVqs/GN
        s68Unylff5X7xajStvnHMMIij4/eWaPWwA6SgYyTEdUJ4PEJlxD2xICnMoeRmQhJ
        k5lByP4fzEbnCSpTgD8qexJemcR2zj8AULA3GXgPcvguwWBNsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=sZX8F98j+GKg41MQv18
        qsQj/XvK9N+M2YcidLb+kOadxczllavOreJXij5O+/IOcOWPVpXcyikBPngBz8dQ
        w5q617HCOPj8hDhhs/9ZXYTuVqJMaKXk3ZBCYDHWDbyxVaa4OtThLEbztJUHcsNP
        pJ8zk3idxuuzgCwrFVYxWfO8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A78D12B886;
        Thu, 11 Mar 2021 15:11:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3CC7C12B885;
        Thu, 11 Mar 2021 15:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [BUG] cmd given to "rebase -x cmd" cannot see the original HEAD?
Date:   Thu, 11 Mar 2021 12:11:27 -0800
Message-ID: <xmqq8s6tcuxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F7264EBA-82A5-11EB-B524-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was trying to figure out why I am losing the amlog note that
maps each commit on topics to the message ID after amending them
with extra trailers (e.g. Reviewed-by).  I use a script that runs
"git commit --amend" to do this and give it to "rebase -x".

It seems that when the command given to "rebase -x" is run, HEAD is
already updated to a commit with tree and log message identical to
the original, with updated committer information.  However, the
note attached to the original commit is *not* copied to this
intermediate HEAD that is shown to the external command.

Hence, even if I try to read the existing note from HEAD that is
given to the script spawned via "rebase -x cmd" mechanism, the
script cannot copy the note to the resulting commit after it adds
extra trailers.  Also, there is no mechansim for the external
command to learn where the original HEAD was.

I see a few possible avenues to fix this.

1. Before "rebase -x" mechanism spawns an external command, make
   sure that the "copy notes upon rewriting" logic has triggered, so
   that the HEAD observable by the command has the notes from the
   original.  It seems that the "copy notes" logic is only used at
   the end, but it does not seem to take the possibility into
   account that the external command might move HEAD to a different
   commit (i.e. it starts from HEAD0, creates HEAD1 that is
   different from HEAD0 only for committer info, hands HEAD1 to
   external command that may move HEAD to HEAD2, but then copies the
   note from HEAD0 to HEAD1 because it is unaware of HEAD2), so it
   only annotates HEAD1 that is immediately lost (nothing other than
   HEAD's reflog would be pointing at it). [*]

2. Make sure the "copy notes" logic copies the notes taken from the
   original HEAD to the HEAD _after_ "rebase -x" external command
   returns.

The first approach would still make the external command responsible
for copying notes from HEAD it sees (i.e. HEAD1) to the new commit
it creates and points HEAD at (i.e. HEAD2).  It _could_ be used as a
mechanism to allow the external command to modify/remove notes.

The second approach would forbid the external command from mucking
with notes at all.  "rebase" would first remember the original HEAD
(i.e. HEAD0), does its thing (i.e. creates HEAD1 and points HEAD at
it, and then lets the external command create HEAD2 and point HEAD
at it), and then figure out the latest HEAD and copy notes from the
original HEAD.  It is simpler, works with scripts that uses things
like "commit --amend" that do not copy notes, but less flexible.

Implementation-wise, it seems that the latter would require more
significant surgery to do_pick_commit() codepath, but somebody more
familiar with the sequencer codepath should research to find the
best approach.

I suspect that "post-commit" hook that is run from try_to_commit()
may have the same issue, here in sequencer.c

1539:	run_commit_hook(0, r->index_file, "post-commit", NULL);
1540:	if (flags & AMEND_MSG)
1541:		commit_post_rewrite(r, current_head, oid);

where oid is not adjusted by re-reading what the post-commit hook
did to our HEAD.

But the codepath to reach do_exec() (which is what spawns the
external command for "rebase -x cmd") is quite away from any
call to commit_post_rewrite(),=20



[footnote]

I have a 6-commit series with notes/amlog record on each commit, and
running:

$ git rebase -x '
	git rev-parse HEAD
	git notes --ref=3Dnotes/amlog show HEAD || :
' master $(git rev-parse ab/read-tree)

yields the following:

Executing: git rev-parse HEAD; git notes --ref=3Dnotes/amlog show HEAD ||=
 :
669950d7def2e849cb1ee6e7b3a1beac5c45ce1c
error: no note found for object 669950d7def2e849cb1ee6e7b3a1beac5c45ce1c.
Executing: git rev-parse HEAD; git notes --ref=3Dnotes/amlog show HEAD ||=
 :
0545e0a567f96eff14dfb93b44aecf9683b44803
error: no note found for object 0545e0a567f96eff14dfb93b44aecf9683b44803.
Executing: git rev-parse HEAD; git notes --ref=3Dnotes/amlog show HEAD ||=
 :
d9b4e77efe5e65952e05533ebf500b559408d436
error: no note found for object d9b4e77efe5e65952e05533ebf500b559408d436.
Executing: git rev-parse HEAD; git notes --ref=3Dnotes/amlog show HEAD ||=
 :
6d8735372c0c9b9d3793959157456cd445d025fa
error: no note found for object 6d8735372c0c9b9d3793959157456cd445d025fa.
Executing: git rev-parse HEAD; git notes --ref=3Dnotes/amlog show HEAD ||=
 :
b86c1305258a11f42927f924498a94b3ffb19472
error: no note found for object b86c1305258a11f42927f924498a94b3ffb19472.
Executing: git rev-parse HEAD; git notes --ref=3Dnotes/amlog show HEAD ||=
 :
7da85bae9f11ab14d616bcade1fb2a7b434aa716
error: no note found for object 7da85bae9f11ab14d616bcade1fb2a7b434aa716.
Successfully rebased and updated detached HEAD.

We can see each commit on ab/read-tree has notes/amlog entry that
records where it came from:

$ git log --notes=3Dnotes/amlog --oneline --reverse master..ab/read-tree
2e3e38a4ad ls-files tests: add meaningful --with-tree tests
Notes (amlog):
    Message-Id: <20210308022138.28166-2-avarab@gmail.com>

2371fda438 tree.c API: move read_tree() into builtin/ls-files.c
Notes (amlog):
    Message-Id: <20210308022138.28166-3-avarab@gmail.com>

32c718db53 ls-files: don't needlessly pass around stage variable
Notes (amlog):
    Message-Id: <20210308022138.28166-4-avarab@gmail.com>

2ebabd63f7 ls-files: refactor away read_tree()
Notes (amlog):
    Message-Id: <20210308022138.28166-5-avarab@gmail.com>

e98fb6ddc7 tree.h API: remove support for starting at prefix !=3D ""
Notes (amlog):
    Message-Id: <20210308022138.28166-6-avarab@gmail.com>

8e88702431 tree.h API: remove "stage" parameter from read_tree_recursive(=
)
Notes (amlog):
    Message-Id: <20210308022138.28166-7-avarab@gmail.com>


In the above transcript, 669950d7def2e8 (the first commit that the
"rebase -x" command saw) corresponds to 2e3e38a4ad (the first commit
in the series), and we can see the only difference between them is
the committer info.  As we already saw in the above, the original
has a note that is not copied to the new one when "rebase -x"
command runs.

$ git show --pretty=3Dfuller 2e3e38a4ad >old
$ git show --pretty=3Dfuller 669950d7def2e8 >new
$ diff -u old new
--- old	2021-03-11 12:06:33.259434213 -0800
+++ new	2021-03-11 12:06:33.259434213 -0800
@@ -1,8 +1,8 @@
-commit 2e3e38a4ad6d9d78381e90348289277acb4c6f8b
+commit 669950d7def2e849cb1ee6e7b3a1beac5c45ce1c
 Author:     =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
 AuthorDate: Mon Mar 8 03:21:33 2021 +0100
 Commit:     Junio C Hamano <gitster@pobox.com>
-CommitDate: Mon Mar 8 10:06:35 2021 -0800
+CommitDate: Thu Mar 11 12:01:11 2021 -0800
=20
     ls-files tests: add meaningful --with-tree tests
    =20

HOWEVER, after that failed "rebase -x" session, the note is copied
to these "intermediate" commits.  Using 7da85bae9f1 which is at the
tip of the history fed to "rebase -x" external command, we can see:

$ git log --notes=3Dnotes/amlog --oneline --reverse master..7da85bae9f1

669950d7de ls-files tests: add meaningful --with-tree tests
Notes (amlog):
    Message-Id: <20210308022138.28166-2-avarab@gmail.com>

0545e0a567 tree.c API: move read_tree() into builtin/ls-files.c
Notes (amlog):
    Message-Id: <20210308022138.28166-3-avarab@gmail.com>

d9b4e77efe ls-files: don't needlessly pass around stage variable
Notes (amlog):
    Message-Id: <20210308022138.28166-4-avarab@gmail.com>

6d8735372c ls-files: refactor away read_tree()
Notes (amlog):
    Message-Id: <20210308022138.28166-5-avarab@gmail.com>

b86c130525 tree.h API: remove support for starting at prefix !=3D ""
Notes (amlog):
    Message-Id: <20210308022138.28166-6-avarab@gmail.com>

7da85bae9f tree.h API: remove "stage" parameter from read_tree_recursive(=
)
Notes (amlog):
    Message-Id: <20210308022138.28166-7-avarab@gmail.com>


It is only that they seem to be added _after_ the external command
finishes, which is not a very useful behaviour.
