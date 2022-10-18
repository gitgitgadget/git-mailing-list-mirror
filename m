Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917C2C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 20:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJRUxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 16:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJRUx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 16:53:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC572BEF9C
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 13:53:27 -0700 (PDT)
Received: (qmail 796 invoked by uid 109); 18 Oct 2022 20:53:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 20:53:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23352 invoked by uid 111); 18 Oct 2022 20:53:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Oct 2022 16:53:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Oct 2022 16:53:26 -0400
From:   Jeff King <peff@peff.net>
To:     Elsie Hupp <git@elsiehupp.com>
Cc:     Junio C Hamano <gitster@pobox.com>, reto@labrat.space,
        philipoakley@iee.email, git@vger.kernel.org
Subject: Re: Multiple --global config workspaces?
Message-ID: <Y08SRgwIvDcsWF0Z@coredump.intra.peff.net>
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
 <xmqqwn96x61t.fsf@gitster.g>
 <Y0Vr/4IeA236nxzF@coredump.intra.peff.net>
 <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com>
 <Y0m64fHWIjZoXoTQ@coredump.intra.peff.net>
 <ACFF4036-3DD1-4647-90BB-77F029326715@elsiehupp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ACFF4036-3DD1-4647-90BB-77F029326715@elsiehupp.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2022 at 12:02:30AM -0400, Elsie Hupp wrote:

> > Right, the value of an include path expands to a single file, and we do
> > not do any globbing. I suppose it would be possible to do, and we'd read
> > each file in sequence. But I'm not sure I'm convinced of the utility of
> > that (and again, it doesn't help the discoverability problem you had).
> 
> My thought is that globbing (I’m not sure of the terminology) should
> be supported to the extent that it’s valid bash syntax, and breaking
> consistency with bash could cause more confusion than just letting the
> user do weird or inadvisable things with the path variable that
> nonetheless have entirely predictable outcomes.

I'm not sure I buy this. We are not otherwise consistent with bash for
value expansion. For instance, we don't allow variable expansion like
$HOME. The only thing we share is the "~" magic.

Moreover, you are thinking of include.path as "cat":

> So, because, e.g., the following works:
> 
> > elsiehupp@Alpha:~$ cat ./**/github/.gitconfig
> > [user]
> > 	email = github@elsiehupp.com
> 
> …one would expect, e.g., this gitconfig line to work, as well:
> 
> > [include] path = ./**/github/.gitconfig

The expansion of the glob is done by the shell. But it is "cat" which is
happy to receive multiple files as input. But many other commands are
not, and include.path is not.

None of which is to say you're wrong to think of it this way. It's a
perfectly valid mental model. It just happens not to be the mental model
we used when implementing it.

I'm not entirely opposed to expanding globs in include.path values if
somebody wants to go to the trouble to implement it, but:

  1. I'd be more convinced by a concrete use case. It sounds like
     conditional includes were the real sticking point for yours. Maybe
     somebody wants to do include.path on ".gitconfig.d/*" or something?
     I dunno.

  2. It does involve breaking backwards compatibility slightly, in that
     glob metacharacters do not currently need to be quoted. It's
     somewhat unlikely somebody would have included them literally,
     though.

     But having include.dir or similar would extend the system without
     breaking compatibility.

> > elsiehupp@Alpha:~$ git config --get-all user.email
> > github@elsiehupp.com
> > gitlab@elsiehupp.com
> > gnome@elsiehupp.com
> > launchpad@elsiehupp.com
> > github@elsiehupp.com
> > xdg@elsiehupp.com
> 
> I don’t know off the top of my head what happens when a single
> variable is defined multiple times. I do get the following output,
> though:

It depends on the variable. Most single-value options in Git are "last
one wins", but some are lists (e.g., remote.*.fetch). We also hold
config values for other porcelain scripts whose semantics we may not
even know ourselves. There are options to "git config" for specifying
how to handle these (e.g., --get-all).

-Peff
