Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D7F21F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 18:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934465AbeGCSe0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 14:34:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:57946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934381AbeGCSeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 14:34:25 -0400
Received: (qmail 30457 invoked by uid 109); 3 Jul 2018 18:34:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Jul 2018 18:34:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3844 invoked by uid 111); 3 Jul 2018 18:34:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Jul 2018 14:34:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2018 14:34:23 -0400
Date:   Tue, 3 Jul 2018 14:34:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Checks added for CVE-2018-11235 too restrictive?
Message-ID: <20180703183423.GA14371@sigill.intra.peff.net>
References: <20180703070650.b3drk5a6kb4k4tnp@glandium.org>
 <20180703141518.GA21629@sigill.intra.peff.net>
 <xmqqh8lgrz5c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8lgrz5c.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 03, 2018 at 10:45:51AM -0700, Junio C Hamano wrote:

> > I'm open to the idea that the new checks are too restrictive (both this
> > and the gitmodulesParse error we're discussing in [1]). They definitely
> > outlaw things that _used_ to be OK. And the security benefit is a little
> > hand-wavy. They're not strictly needed to block the recent
> > vulnerability[2].  However, they _could_ protect us from future problems
> > (e.g., an overflow in the config-parsing code, which is not accessible
> > to attackers outside of .gitmodules). So there is some value in being
> > restrictive, but it's mostly hypothetical for now.
> 
> As you said elsewhere, the above example would probably not cause
> harm to the production use of .gitmodules (as opposed to what fsck
> checks) as it is not at the top of the working tree, but does the
> production code do a wrong thing if a directory, a symbolic link or
> a gitlink appear at ".gitmodules" at the top level?
> 
> If so, we probably need to tighten code in submodules.c and
> elsewhere to ignore such ".gitmodules" directory etc [*1*].

I tried it when writing my earlier message, and I couldn't convince it
to do anything too terrible (these both have one true submodule and a
gitlink .gitmodules):

  $ git status
  warning: unable to access '/home/peff/tmp/.gitmodules': Is a directory
  On branch master
  nothing to commit, working tree clean

  $ git submodule update --init
  warning: unable to access '/home/peff/tmp/.gitmodules': Is a directory
  fatal: No url found for submodule path '.gitmodules' in .gitmodules

Obviously the setup is broken, but I think most code paths would hit
that fopen() failure. Possibly something that reads directly from the
index might not check the object type carefully and could read cruft
from a non-blob (though my understanding from past discussions is that
we don't actually do direct from-index reading yet).

> And if not, I think it is OK to loosen fsck to exclude ".gitmodules"
> that are not regular files, e.g. in fsck.c::fsck_tree(), we have
> this for each entry we encounter in a tree:
> 
> 		...
> 		has_zero_pad |= *(char *)desc.buffer == '0';
> 
> 		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
> 			if (!S_ISLNK(mode))
> 				oidset_insert(&gitmodules_found, oid);
> 			else
> 				retval += report(options, &item->object,
> 						 FSCK_MSG_GITMODULES_SYMLINK,
> 						 ".gitmodules is a symbolic link");
> 		}
> 
> Can mode be 160000 or 40000 here?  The code seems to assume that, as
> long as the thing is named ".gitmodules", we are looking at a blob,
> so symlinks are worth reporting immediately and all others are worth
> investigating later by marking them in the gitmodules_found oidset.

Right, that's more or less how the logic works now. Which actually
brings up another philosophical issue. We wouldn't want to loosen the
symlink check here, since it is serving an actual security purpose.  So
if we were to loosen the other bits (say, allowing .gitmodules to be a
non-blob), we still could not say "...and there is no regression with
respect to all old .gitmodules tree entries". Some would work, and some.
would not. Is it better to be consistent ("we assume .gitmodules entries
are well-formed, and do not use that name if you are not") or to try to
be as permissive as possible?

> I think it is a good idea to be tighter than necessary by default,
> so rejecting a gitlink ".gitmodules" unless the user tells us with
> some configuration knob is a good thing to do, but it probably makes
> sense to have users a way to opt-out of this "There is .gitmodules
> but it is not a readable blob" sanity check.

That already exists using the fsck "ignore" config and skiplist. I think
the question is just whether it is an undue burden to have to deal with
those. Setting a config option is not too bad, but quite often you are
crossing an administrative boundary (convincing a hoster to loosen fsck,
or convincing users who fetch from you that they need to set a certain
config variable).

> *1* A quick scan of the code there looking for GITMODULES_FILE did
> not give me a very good feeling---it seems that the code trusts what
> is in the index and in the working tree to be non-hostile a bit too
> much.

I won't be surprised if there is a way to cause mischief there. The
extent of my probing was the two commands I showed above. :)

-Peff
