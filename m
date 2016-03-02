From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 01/33] setup: call setup_git_directory_gently before
 accessing refs
Date: Tue, 1 Mar 2016 21:45:09 -0500
Message-ID: <20160302024509.GA20625@sigill.intra.peff.net>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-2-git-send-email-dturner@twopensource.com>
 <20160301083535.GA4952@sigill.intra.peff.net>
 <1456876072.5981.5.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 03:45:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aawmv-0002Nb-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 03:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbcCBCpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 21:45:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:52930 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751849AbcCBCpM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 21:45:12 -0500
Received: (qmail 27995 invoked by uid 102); 2 Mar 2016 02:45:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 21:45:12 -0500
Received: (qmail 19364 invoked by uid 107); 2 Mar 2016 02:45:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 21:45:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 21:45:09 -0500
Content-Disposition: inline
In-Reply-To: <1456876072.5981.5.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288092>

On Tue, Mar 01, 2016 at 06:47:52PM -0500, David Turner wrote:

> > My fix for this was to teach read_mailmap to avoid looking for
> > HEAD:.mailmap if we are not in a repository, but to continue with the
> > others (.mailmap in the cwd, and the mailmap.file config variable).
> > ...
> > But I do think your patch is a potential regression there, if anybody
> > does do that.
> 
> Your version sounds better.  But I don't see it in the patch set you
> sent earlier? 

It's not. Sorry to be unclear. There were _two_ cleanups I was talking
about (cases where we don't check whether we're in a repo, and fact that
the repo startup code is unreliable), and I got sucked into the second
one. I'll try to work up and share my startup_info one today.

> When writing my patch, I had assumed that the issue was the resolve_ref
> on the HEAD that's an argument -- but it's not.  The actual traceback
> is:
> [...]
> #2  resolve_ref_unsafe (refname=refname@entry=0x550b3b "HEAD", 
>     resolve_flags=resolve_flags@entry=0, 
>     sha1=sha1@entry=0x7fffffffd100 "\b\326\377\377\377\177", 
>     flags=flags@entry=0x7fffffffd0fc) at refs/files-backend.c:1600
> #3  0x00000000004ffe69 in read_config () at remote.c:471

Oh, right. I did see problems here but missed them when comparing my
patch to yours. I ended up in remote.c:read_config, having it check
whether startup_info->have_repository is set; if it isn't, there is no
point in looking at HEAD.

That covers this case, and several others I happened across. Thanks for
clarifying.

> I'm not sure what the right way to fix this is -- in read_config, we're
> about to access some stuff in a repo (config, HEAD).  It's OK to skip
> that stuff if we're not in a repo, but we don't want to run
> setup_git_directory twice (that breaks some stuff), and some of the
> other callers have already called it.  On top of your earlier
> repo_initialized patch, we could add the following to read_config:
> 
> +       if (!repo_initialized) {
> +               int nongit = 0;
> +               setup_git_directory_gently(&nongit);
> +               if (nongit)
> +                       return;
> +       }
> 
> But that patch I think was not intended to be permanent.  Still, it
> does seem odd that there's no straightforward way to know if the repo
> is initialized. Am I missing something? 

No, there isn't a straightforward way; I think we'll have to add one.
I'll polish up my series which does this.

-Peff
