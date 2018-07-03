Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A747C1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 22:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbeGCWag (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 18:30:36 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:44050 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753076AbeGCWag (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 18:30:36 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <mh@glandium.org>)
        id 1faToc-00066c-RE; Wed, 04 Jul 2018 07:30:30 +0900
Date:   Wed, 4 Jul 2018 07:30:30 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Checks added for CVE-2018-11235 too restrictive?
Message-ID: <20180703223030.xds2bfgeuaa35isj@glandium.org>
References: <20180703070650.b3drk5a6kb4k4tnp@glandium.org>
 <20180703141518.GA21629@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703141518.GA21629@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 03, 2018 at 10:15:19AM -0400, Jeff King wrote:
> On Tue, Jul 03, 2018 at 04:06:50PM +0900, Mike Hommey wrote:
> 
> > I had a first shot at that a few months ago, but the format of the
> > metadata branch made it impossible to push to github, hitting its push
> > size limit. With some pre-processing work, I was able to push the data
> > to github, with the intent to come back with a new metadata branch
> > format that would make the push directly possible.
> 
> This is sort of tangential to your email here, but I'm curious which
> limit you hit. Too-big blob, tree, or commit?

Too-big pack, iirc.

> > Fast forward to this week, where I was trying to upload a new metadata
> > branch, and failed in a rather interesting way: multiple lines looking
> > like:
> > 
> > remote: error: object 81eae74b046d284c47e788143bbbcc681cb53418: gitmodulesMissing: unable to read .gitmodules blob
> > 
> > which, apart from the fact that they have some formatting issue, appear
> > to be new from the fixes for CVE-2018-11235.
> 
> Also tangential to your main point (I promise I'll get to it ;) ), but
> what formatting issue do you mean? Are you referring to
> "gitmodulesMissing"? That's a machine-readable tag which means you can
> set "fsck.gitmodulesMissing" to "ignore".

Oh, I was reading it as something finishing with "gitmodules", and
another message starting with "Missing". The fact the error is so
long and on one line made me think that, I guess.

> > I can see what those fixes are trying to prevent, but they seem to be
> > overly restrictive, at least in the context of transfer.fsckObjects.
> > 
> > The core problem is that the mercurial repository has some .gitmodules
> > files in some subdirectories. As a consequence, the git objects storing
> > the info for those mercurial files contain trees with .gitmodules files
> > with a commit ref, and that's what the remote is complaining about.
> > 
> > (Surpringly, it doesn't hit the "non-blob found at .gitmodules" case
> > first, which is weird).
> 
> The reason it doesn't hit the "non-blob" case is that we are trying to
> analyze the object itself. So we don't pay any attention to the mode in
> the containing tree, but instead literally look for 81eae74b0. If it
> were a non-blob we'd complain then, but in fact we don't have it at all
> (which is otherwise OK because it's a gitlink).
> 
> > A small testcase to reproduce looks like this:
> > 
> > $ git init bar; cd bar
> > $ git fast-import <<EOF
> > commit refs/heads/bar
> > committer Bar <bar@bar> 0 +0000
> > data 0
> >                                                                  
> > M 160000 81eae74b046d284c47e788143bbbcc681cb53418 bar/.gitmodules
> >                                                                  
> > EOF
> >
> > [...]
> > 
> > Would it be reasonable to make the transfer.fsckObject checks ignore
> > non-blob .gitmodules?
> 
> I'm open to the idea that the new checks are too restrictive (both this
> and the gitmodulesParse error we're discussing in [1]). They definitely
> outlaw things that _used_ to be OK. And the security benefit is a little
> hand-wavy. They're not strictly needed to block the recent
> vulnerability[2].  However, they _could_ protect us from future problems
> (e.g., an overflow in the config-parsing code, which is not accessible
> to attackers outside of .gitmodules). So there is some value in being
> restrictive, but it's mostly hypothetical for now.
> 
> So I think we could simply loosen these cases without immediate effect.
> That said, I'm not sure that having a gitlink .gitmodules is sane in the
> first place. Attempting to "git submodule init" there is going to cause
> errors. Well, sort of -- your example actually includes it in a
> subdirectory of the repository, so technically we wouldn't use it for
> real submodules. That fudging (finding .gitmodules anywhere instead of
> just at the root) was a conscious decision to reduce the complexity and
> cost of the check.
> 
> It sounds like in this case you don't have existing history that does
> this with .gitmodules, but are rather looking into designing a new
> feature that stuffs data into git trees. I'd be interested to hear a bit
> more about that feature to see if there are other alternatives.

Yes, in fact, this history is not even meant to be checked out. It's
internal stuff, stuck in a ref in a non-traditional ref namespace (that
is, it's not under refs/heads, refs/tags, etc., it's under
refs/cinnabar)

I'd rather avoid using entirely new features that wouldn't work with
widely used git versions. I can actually work around the current problem
by adding a prefix to all file names. That doesn't sound great, but is
probably good enough. In fact, it might even avoid future similar problems.

That being said, I'm not even sure this particular use case is worth a
new feature. I'm not storing random stuff as gitlinks, I'm storing
sha1s. Well, maybe a mode that makes the distinction between "git oid"
and "external oid" might make things clearer for git itself, especially
for fsck.

Mike
