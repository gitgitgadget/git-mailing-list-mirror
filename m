From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Tue, 16 Apr 2013 13:43:33 +0530
Message-ID: <CALkWK0nUzbt6R=raWaxxVgAthcUo7E+_FS0rPDDfumgeecHiZg@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
 <CALkWK0n0y6OPJvYjNeEbUx_CC58vHRRLCsmJtws+RKyv3wRTwQ@mail.gmail.com> <20130415184347.GA21170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, marcnarc@xiplink.com,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 10:14:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US11z-0007YU-IN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab3DPIOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 04:14:16 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:59709 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab3DPION (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:14:13 -0400
Received: by mail-ia0-f182.google.com with SMTP id u20so170108iag.27
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=jHKXeWmst8R2Z7Jf3+cZecttA3O6Lp2IH33fqC4WzbQ=;
        b=AJw7b8chXF1mm/EfYiLpha4p2OXDRY/vaQxV7HzmTbHxE3WmYYx3PBYdXcS7wuKv4z
         kYAKnwdeFIFypsWpe9L2o0OTDk1ivwqqvFDUtq0byNycU/grsKcf0sMrcVMVAdqZypGr
         qrO+nBeC7eMd57XLH8cfT3JIcS8iNQl0FKz1fYCD5Z3417BwVLUX9dhWQfD76OMTC9VT
         CtAktiA/r3FkPabQbxiet6rbjjVREm5w6X9+SGEZCN0Ka29u1ZUSkevkZPdgjOVlWftO
         1LcsMYoKtBAt/hpIHNiptWRDt30FVItNg4woR59PvgWsxuPN1onnmKaHN0RS0bgDN6g/
         79AQ==
X-Received: by 10.50.50.71 with SMTP id a7mr7130158igo.14.1366100053386; Tue,
 16 Apr 2013 01:14:13 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 01:13:33 -0700 (PDT)
In-Reply-To: <20130415184347.GA21170@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221376>

Jeff King wrote:
> So there is some information that is per-clone (the objects, the remote
> tips), but there is some information that is per-submodule (where our
> local branches are, the index, the worktree). I can see why it is
> advantageous to share the per-clone information between similar clones
> (because it avoids disk space and network transfer). But I do not think
> you can escape having some form of per-submodule repo, even if it is a
> thin git-new-workdir-ish repo that points back to a parent repo for the
> clone.

I want the flexibility to do the following:

1. Do a "simple clone", where the clone contains the GITDIR embedded
in the worktree.  This is the most common case, and there is no reason
to complicate it.  I can optionally attach additional workdirs to this
clone.  I can also optionally relocate the GITDIR at a later date, if
I feel the need to do so.

2. Attach a worktree to any object store without having to write a
gitfile and set core.worktree by hand.  The limitation is that you
can't have two submodules from two different superprojects sharing the
same object store (since both of them are worktrees).  However, for
the purpose of working on the submodule repository as an independent
repository (this is a very common case for me), I can attach a new
"workdir" to the GITDIR very easily.

3. Attach multiple submodules to the same object store.  This will
require maintaining a separate index, HEAD and logs/HEAD (aka.
workdir) for each additional submodule (the first one doesn't need it)
in .git/modules of the superproject.

> Is there some part of your proposal that I am missing? It seems like you
> would still need one/.git/modules/foo for this "thin" repo.

You're talking about #3, while I'm still working on #2.  And why do
you want to use a hammer again if I don't want to share the same
object store with multiple submodules?  This .git/modules/<name> is
completely optional, and is only required for the _second_ submodule
onwards that I'm attaching to the same object store.

> And by the way, I am actually not sure that such a shared-object setup
> is a good idea, but only that _if_ you are going to do it with
> submodules, you might as well do it for all repos. In theory, it is not
> that hard to have a big per-user object-only repository (either for all
> repos, or for related ones). But we can do that already with "git clone
> -s", and people do not generally bother, because the maintenance is very
> tricky (especially dealing with reachability and pruning).

No, no. I'm against dumping objects  from all repositories into one
giant object store.  That's a sledgehammer solution, while I'm looking
for control and flexibility.  Moreover, it has lots of downsides, as
you already pointed out.

> I am open to the argument that solving it in a specific case
> (submodules) lets us make assumptions that simplify the problem from the
> general case, but I do not offhand see how it would be any easier in
> this case.

So my proposal is to build a new first-class tool to make
manipulations in #1, #2 and #3 easily possible.  The first step is to
formalize the names "bare worktree" (which refers to a worktree with a
gitfile), "worktree" (which refers to a worktree with a GITDIR
embedded in it), and "workdir" (which refers to a worktree with a
"thin" GITDIR).

The reason I want to build it for submodules first is because the
non-submodule case (#2) is simply a reduced case of the submodule case
(#3):

- When I attempt to attach a new worktree to an existing GITDIR with a
worktree attached, I will create a workdir instead.  This simply
involves creating a thin .git directory in the worktree in the
non-submodule case.  In the submodule case, it is more complicated: I
have to locate the superproject's .git directory, and put it there.
