Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D631FD99
	for <e@80x24.org>; Sun, 21 Aug 2016 02:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbcHUCFr (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 22:05:47 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36656 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbcHUCFq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 22:05:46 -0400
Received: from mfilter15-d.gandi.net (mfilter15-d.gandi.net [217.70.178.143])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id 52ADFC5A4F;
        Sun, 21 Aug 2016 04:05:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter15-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter15-d.gandi.net (mfilter15-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id CdGtQQ0x37sL; Sun, 21 Aug 2016 04:05:42 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A5131C5A49;
        Sun, 21 Aug 2016 04:05:41 +0200 (CEST)
Date:   Sat, 20 Aug 2016 19:05:39 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Richard <richard.maw@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Adding more namespace support to git
Message-ID: <20160821020537.eiyh4vnhmnuctgtz@x>
References: <CAB2VqoZh6zZV3Lk2B7dBPVE5h6H1LCwyxWrUo4yJFhqB=hAjig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB2VqoZh6zZV3Lk2B7dBPVE5h6H1LCwyxWrUo4yJFhqB=hAjig@mail.gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2016 at 08:07:00PM +0100, Richard wrote:
> I work on a git server called gitano.
> We've been using and recommending cgit for the web UI.
> 
> I've been working on adding git namespace support to both,
> so that we can separate administrative branches from code branches.
> 
> Because git is not namespace aware for anything but git-upload-pack
> and git-receive-pack,
> I've had to implement namespace parsing in cgit
> for listing branches, showing logs, displaying notes and commit decorations.
> It might be more useful if this support was added to git itself,
> so other git servers could make use of it so there's less duplicated code.
> 
> I think the way to do this would be to make the low-level ref reading functions,
> read_raw_ref, for_each_reflog_ent*, reflog_exists etc.,
> interpret the ref they are passed as being relative to the current git
> namespace.
> 
> Since when upload-pack and receive-pack run hooks they leave GIT_NAMESPACE set
> there are hook scripts that expect that the current namespace is ignored,
> so commands that now want to be namespace aware would have to opt-in.

That seems really unfortunate.  While at the time we wanted to start
with namespace support in upload-pack and receive-pack (and
http-backend) because those would allow using it as a server-side
storage format, I don't think we realized that leaving GIT_NAMESPACE in
the hook environment would completely prevent other git commands from
automatically handling namespaces.

And conversely, we can't just have upload-pack and receive-pack start
removing it from the hook environment, because a hook might expect to
read the current namespace from it (and then run git commands that the
hook expects will ignore it).

(This also affects libgit2; I recently added a function to libgit2 to
interpret various git environment variables, including GIT_NAMESPACE.
If git commands can't just use that automatically, that'll need to
change too, to avoid unexpected behavior in hooks.)

For that matter, someone could run "GIT_NAMESPACE=foo git push
remotename branchname" or
"GIT_NAMESPACE=foo git clone remotename", and based on the current
behavior, they'd expect to have the namespace apply to the remote end,
but not the local end.

Unfortunately, I think at this point, GIT_NAMESPACE has to exclusively
refer to the namespace for the remote end, to avoid breakage.  Which
means any automatic pervasive support for namespaces on the local side
would need to use a different mechanism.  (In addition to applying to
ref enumeration, this would also need to apply to the local end of
refspecs.)  And this new mechanism would need to not affect the remote
end, to allow remapping the local end while accessing an un-namespaced
(or differently namespaced) remote.
