From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: On fetch refspecs and wildcards
Date: Sun, 16 Mar 2008 19:03:14 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803161831330.19665@iabervon.org>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se> <1205604534.7589.20.camel@gentoo-jocke.transmode.se> <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org> <200803161921.49274.tlikonen@iki.fi> <7v8x0igvdp.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 00:03:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb1tU-00044e-Lj
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 00:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbYCPXDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 19:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbYCPXDQ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 19:03:16 -0400
Received: from iabervon.org ([66.92.72.58]:50305 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171AbYCPXDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 19:03:15 -0400
Received: (qmail 15575 invoked by uid 1000); 16 Mar 2008 23:03:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Mar 2008 23:03:14 -0000
In-Reply-To: <7v8x0igvdp.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77400>

On Sun, 16 Mar 2008, Junio C Hamano wrote:

> I was looking at t5505 tests and noticed something funny.
> 
> This is a design level question, so I am cc'ing Daniel whose remote.c is
> heavily involved in the new implementation.
> 
> What should this config do:
> 
>     [remote "origin"]
>         url = ../one/.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         fetch = refs/heads/master:refs/heads/upstream
> 
> when the other repository (../one/.git) has branches "master" and "side2"?
> 
> I am not sure if the original implementation used to copy master to both
> refs/remotes/origin/master and refs/heads/upstream, but I think that is
> what the users would expect.  
> 
> I think the current one excludes any source that has an explicit
> destination from the wildcard matches.  It is probably Ok as long as we
> reject if the same source has more than one destinations (or matches more
> than one wildcards, for that matter) like this as a configuration error:
> 
>     [remote "origin"]
>         url = ../one/.git
>         fetch = refs/heads/master:refs/heads/upstream
>         fetch = refs/heads/master:refs/heads/another
> 
> If it doesn't, it does feel somewhat inconsistent.
> 
> Fortunately or unfortunately, Documentation/pull-fetch-param.txt does not
> talk about wildcard refspecs (not even the syntax, let alone the
> semantics), so we can define whatever we want right now, and I think both
> 
>     (1) allow duplicated destinations, including wildcard matches; and
> 
>     (2) refuse duplicated destinations for explicit ones, and more than
>         one wildcard patterns that match the same ref, but omit explicitly
>         specified ones from wildcard matches;
> 
> are viable options.  I suspect the current code does not do either.  We
> should pick one semantics, make sure the implementation matches that, and
> document it.

Actually, I think the current code is close to (2). get_fetch_map() 
returns everything, ref_remove_duplicates() removes any exact matches and 
gives errors if there's the same destination for two different sources.

(Upon further consideration, there's one slight issue:

[remote "origin"]
	fetch = refs/heads/*:refs/remotes/origin/*
	fetch = +refs/heads/pu:refs/remotes/origin/pu

is not quite the same as:

[remote "origin"]
	fetch = +refs/heads/pu:refs/remotes/origin/pu
	fetch = refs/heads/*:refs/remotes/origin/*

in whether pu will be forced; the forcing flag on the first matching 
refspec is what matters.)

In any case, the implementation should be easy enough with any of these 
combinations.

> Another topic is what the semantics should be for mirroring configuration,
> like this:
> 
>     [remote "origin"]
>         url = ../one/.git
>         fetch = refs/*:refs/*
> 
> or
> 
>     [remote "origin"]
>         url = ../one/.git
>         fetch = refs/*:refs/remotes/one/*
> 
> The issues are:
> 
>  (1) get_fetch_map() currently insists on refname to be check_ref_format()
>      clean; it even rejects CHECK_REF_FORMAT_ONELEVEL, which means that
>      refs/stash would not be considered Ok and the code will die().

Yes, that's probably wrong. We probably do want to reject people whose 
servers send us "refs/heads/../../heads/master", but not "refs/stash".

>  (2) "git remote prune" seems to cull refs/remotes/one/HEAD if exists.
> 
> Currently we do not have a way to determine where HEAD at the remote
> points at at the protocol level (I've sent a patch to the list earlier for
> the necessary protocol extension on the upload-pack side, but receiver
> side never got implemented in remotes.c).  So we cannot propagate
> refs/HEAD information correctly right now, but when we accept the protocol
> extension to do so, issue (1) will matter also for HEAD.

There's the issue that "HEAD" isn't "refs/HEAD". I'm not at all sure how 
the user should communicate the desire to update things to match the 
remote HEAD. FWIW, I was considering moving the code to guess where the 
remote HEAD points from builtin-clone to remotes.c, until I realized that 
it's not clear what configuration should control this. I think it'd be 
necessary to have a special option to say "write HEAD here", but I may be 
wrong.

The implementation of whatever handles it is slightly non-trivial, since 
struct ref can't currently represent a symref, but that shouldn't be a 
major issue.

	-Daniel
*This .sig left intentionally blank*
