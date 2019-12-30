Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526ACC2D0DD
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 04:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF53207FF
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 04:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfL3EPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 23:15:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53938 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727069AbfL3EPq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 23:15:46 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBU4FR53025049
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Dec 2019 23:15:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5E554420485; Sun, 29 Dec 2019 23:15:17 -0500 (EST)
Date:   Sun, 29 Dec 2019 23:15:17 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnaud Bertrand <xda@abalgo.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Feature request: add a metadata in the commit: the "commited in
 branch" information
Message-ID: <20191230041517.GA84036@mit.edu>
References: <CAEW0o+jV+r1UMZReRXa3g_fyqCYxHTVYVf6pWvjB7_isofbBaw@mail.gmail.com>
 <xmqqd0c6iuw0.fsf@gitster-ct.c.googlers.com>
 <CAEW0o+g7vXj841h+4nNK8iSoO758Uh9fLKMCN87RE2w2Nd=CRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEW0o+g7vXj841h+4nNK8iSoO758Uh9fLKMCN87RE2w2Nd=CRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 30, 2019 at 12:53:56AM +0100, Arnaud Bertrand wrote:
> Hi Junio,
> 
> It really depends how git is used. With big collaborative project
> (like git or linux kernel), you are totally right.
> for development limited to a company that has developments with team
> of 10-20 developers and that uses
> a correct SCM plan, the name of the branch is regulated and is
> meaningful, mostly  linked to a bug tracking system
> system. For audits and  traceability, the branch name is really
> important... certainly more than the email of the developer ;-)
> So the "contamination" is negligible compare to the bentefit in this context.
> It will also helps the graphical tools to have a comprehensive
> represeintation which can do git even better.

Why does it need to be the branch name?  You can add your own extra
metadata to the git description.  So for example, I might have a git
commit that looks like this:

    ext4: avoid declaring fs inconsistent due to invalid file handles

    If we receive a file handle, either from NFS or open_by_handle_at(2),
    and it points at an inode which has not been initialized, and the file
    system has metadata checksums enabled, we shouldn't try to get the
    inode, discover the checksum is invalid, and then declare the file
    system as being inconsistent.

    ... <details of repro omitted to keep this email short>

    Google-Bug-Id: 120690101
    Upstream-5.0-SHA1: 8a363970d1dc38c4ec4ad575c862f776f468d057
    Tested: used the repro to verify that open_by_handle_at(2)
       will not declare the fs inconsistent
    Effort: storage/ext4       
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Change-Id: Iafb6da7c360a4c34b882f7fd6a91e3bb

The tie-in to the bug tracking system is done via "Google-Bug-Id:".
The Effort tag is used to identify which subteam should be responsble
for rebasing the commit to a newer upstream kernel.  (E.g., how to
account for all of the patches made on top of 4.14.x when you are
rebasing to the newer 4.19 long-term-stable kernel, to make sure all
not-yet-usptreamed commits are carried over during the rebase
process.)

The Upstream-X.Y-SHA1: tag indicates that this is an upstream commit
that was backported to the internal kernel.  If the commit isn't an
upstream backport, we have a policy (which is enforced via an
automated bot when the commit goes through Gerritt for review) that
there must be an "Upstream-Plan: " tag indicating how the committer
plans to get the change upstream.

The automated review bot also enforces that a Tested: tag exists,
describing how the developer tested the change, and Change-Id: is used
to link the commit to Gerrit, which is how we enforce that all commits
have to be reviewed by a second engineer before it is allowed into the
production kernel sources.  We also maintain all of the Gerrit
comments as history and so we can have accountability as to who
reviewed a commit before it was submitted into the release repository.

We also have automated bots which will run checkpatch and note the
warnings from checkpatch as Gerrit commits; and if the kernel doesn't
build on a variety of architetures and configurations (e.g., debug,
installer, etc.) a bot can also report this and add -1 Gerrit review.

See?  You can do an awful lot without regulating and recording the
branch name used by the engineer.  We have full audit and traceability
through the Gerrit reviews, and we can use the Google-Bug-Id to track
which release versions of which kernels have which bugs fixed.

The bottom line is each company is going to have a different workflow
for doing reviews, linkage to bug tracking systems, auditability, etc.
If everybody were to demand their unique scheme was to be supported
directly in Git, it would be a mess.  The scheme that I've described
above needs no special git features.  It just uses some git hooks as a
convenience to to developers to help them fill in these required
fields, using Gerrit for commit review, and some bots which submit
reviews to Gerrit.

Cheers,

						- Ted
