Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03194C3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBAA7206CC
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgEEAII (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:08:08 -0400
Received: from sunset.tt-solutions.com ([82.240.17.225]:49333 "EHLO
        smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgEEAII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:08:08 -0400
Received: from [192.168.17.86] (helo=Twilight.zeitlins.org)
        by smtp.tt-solutions.com with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.92)
        (envelope-from <vz-git@zeitlins.org>)
        id 1jVl80-0002lI-D4; Tue, 05 May 2020 02:08:04 +0200
Date:   Tue, 5 May 2020 02:08:04 +0200
From:   Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re[2]: [PATCH] fetch: allow running as different users in shared repositories
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
References: <E1jHGdD-00079b-06@smtp.tt-solutions.com><nycvar.QRO.7.76.6.2003261538170.46@tvgsbejvaqbjf.bet><E1jUeoi-000205-RT@smtp.tt-solutions.com><xmqqr1vzhd8z.fsf@gitster.c.googlers.com><E1jVeWV-0006Sj-JC@smtp.tt-solutions.com> <xmqqlfm7fn8k.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfm7fn8k.fsf@gitster.c.googlers.com>
X-Mailer: Mahogany 0.68.0 'Cynthia', running under Windows 7 (build 7601, Service Pack 1), 64-bit edition
Message-Id: <E1jVl80-0002lI-D4@smtp.tt-solutions.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 04 May 2020 13:39:55 -0700 Junio C Hamano <gitster@pobox.com> wrote:

JCH> Vadim Zeitlin <vz-git@zeitlins.org> writes:
JCH> 
JCH> > From: Vadim Zeitlin <vz-git@zeitlins.org>
JCH> > Subject: [PATCH] fetch: allow running as different users in shared repositories

 Thanks for looking at this!

JCH> This pretends the change to affect ONLY "git fetch", but ...
JCH> 
JCH> > The function fopen_for_writing(), which was added in 79d7582e32 (commit:
JCH> > allow editing the commit message even in shared repos, 2016-01-06) and
JCH> > used for overwriting FETCH_HEAD since ea56518dfe (Handle more file
JCH> > writes correctly in shared repos, 2016-01-11), didn't do it correctly in
JCH> > shared repositories under Linux.
JCH> 
JCH> ... fopen_for_writing() is not only about FETCH_HEAD.  In fact, the
JCH> author of this patch knows "git fetch" was not the primary target.

 Right, sorry, I should have been more precise. FWIW I did look at the
other uses of this function, but I didn't think to mention this because I
only checked that the change was not going to break the other users of this
function: as all of them need a "write-only" file and just die in case of
an error, recreating it and returning successfully couldn't possibly make
things worse.

JCH> So, we need to make sure that (1) this change is beneficial to those
JCH> other codepaths that use the helper function, and (2) describe the
JCH> (good) effect of the patch on these other users in the log message.
JCH> We also need to retitle the commit.

 OK, will do.

JCH> > This happened because in this situation the file FETCH_HEAD has mode 644
JCH> > and attempting to overwrite it when running git-fetch under an account
JCH> > different from the one that was had originally created it, failed with
JCH> > EACCES, and not EPERM.
JCH> 
JCH> Isn't that because FETCH_HEAD and others are not concluded with
JCH> adjust_shared_perm()?

 I didn't know about this function, but looking at its uses elsewhere, it
seems indeed clear that it should be used here too.

JCH> The fopen_for_writing() that removes and recreates the target file
JCH> sounds like a band-aid to me.

 Definitely. I wondered how did we end up in a situation in which it became
necessary to do it, but didn't find the answer quickly and abandoned trying
to understand it.

JCH> The right fix we should have done when we did 79d7582e (commit: allow
JCH> editing the commit message even in shared repos, 2016-01-06) would
JCH> have been to open(2) with 0666 (and let the umask(2) adjust it), and
JCH> then use adjust_shared_perm() to give it the desired protection bits.
JCH> With the existing band-aid, we won't be able to fix incorrectly
JCH> created append-only files, for example, as the band-aid depends on the
JCH> contents in the existing file being expendable.

 Just to reiterate what you already know, right now the band-aid is only
used for expendable files, as indicated rather clearly by the name of
fopen_for_writing() function, so there is no real problem here, per se,
it's just a bit ugly.

JCH> I haven't looked at or analysed how fast-export will get affected.
JCH> I think it is used to create and leave a "marks" file, to be later
JCH> read by another instance of the fast-export process, which may (or
JCH> may not) further write new contents to the (same?) "marks" file, but
JCH> I do not know the ramifications of unlinking and recreating.  In any
JCH> case, even if that is broken, it is not a new breakage this patch is
JCH> introducing.  You may want to look at it further to make sure you
JCH> are not breaking things, though.

 OK, I will do it. But I also think that, in principle, you could imagine a
scenario in which the behaviour could change in case of multiple
concurrently running processes, e.g. if the group of the directory changed
while they're running. I'm pretty sure it shouldn't be a realistic problem
in practice, however, but I'll re-check it more carefully.

JCH> So, here are the things I would like to see in this area:
JCH> 
JCH>  - The same patch text, but with updated commit log message, to tell
JCH>    readers that we have looked at all the callers that are affected,
JCH>    and retitle it (e.g. "fopen_for_writing: detect the reason why fopen()
JCH>    failed correctly" or something like that, perhaps?).

 OK, I'll do this.

JCH>  - Audit other codepaths that create .git/ALL_CAPS_FILE (e.g.  I see
JCH>    that "git branch --edit-description" creates a temporary file to
JCH>    edit without fopen_for_writing() band-aid and it does not use
JCH>    adjust_shared_perm(), but I think it should) and fix them.

 This seems a bit more difficult. Do you have any hints about how could all
such places be found effectively?

JCH>  - The existing repositories have these files created and left whose
JCH>    permission bits were set according to the then-current umask
JCH>    without taking "core.sharedrepository" into account, so we have
JCH>    to keep the "if unable to open for writing, unlink and recreate"
JCH>    trick to salvage them.  But it does not mean we need to keep
JCH>    creating the files with wrong mode.  Update fopen_for_writing()
JCH>    and its users to leave the file created in the right mode by
JCH>    calling adjust_shared_perm().  I think fopen_for_writing() should
JCH>    switch from calling fopen(3) to calling open(2) and then fdopen(3)
JCH>    on the result as the first step.

 Sorry, I'm not sure I follow you here. Do you want to use fchmod() here
instead of just calling adjust_shared_perm()? I.e. what is the problem with
using fopen()?

JCH> The first one is better done by you to tie the loose ends for this
JCH> discussion.  

 I'll repost the patch after re-checking its effect on fast-export
(assuming I don't find anything wrong).

JCH> Other two items do not have to be done by you.  Anybody interested
JCH> can do them as a clean-up (only if people agree that it is a good
JCH> idea to do so---so I won't mark this as a left-over-bits yet).

 FWIW this does seem like a good idea to me, but it's also going to be much
less trivial than my patch and I'm not sure I can find the time needed to
make these changes and test them in the immediate future, so even though
I'll try to do it, please don't count on me.

 Thanks again for your review,
VZ
