From: Jeff King <peff@peff.net>
Subject: Re: Feature Request: gitignore recursion
Date: Thu, 10 Oct 2013 12:22:44 -0400
Message-ID: <20131010162244.GA21489@sigill.intra.peff.net>
References: <20131007134141.GA23026@lanh>
 <52565E6A.2020907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pclouds@gmail.com, Git List <git@vger.kernel.org>,
	alljeep@gmail.com
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 10 18:22:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUJ0n-00066T-8s
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 18:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756425Ab3JJQWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 12:22:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:47000 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756093Ab3JJQWs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 12:22:48 -0400
Received: (qmail 1605 invoked by uid 102); 10 Oct 2013 16:22:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Oct 2013 11:22:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Oct 2013 12:22:44 -0400
Content-Disposition: inline
In-Reply-To: <52565E6A.2020907@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235868>

On Thu, Oct 10, 2013 at 09:59:38AM +0200, Karsten Blees wrote:

> > On Mon, Oct 07, 2013 at 07:24:11AM -0400, Jeff King wrote:
> >> However, one thing I expected to work but didn't is:
> >> 
> >>   echo '*' >.gitignore
> >>   echo '!*' >my_dir/.gitignore
> >> 
> >> That _does_ work for attributes, like:
> >> 
> >>   echo '* foo=one' >.gitattributes
> >>   echo '* foo=two' >my_dir/.gitattributes
> >> 
> >> where the more-specific file takes precedence. It works because we keep
> >> an attribute stack, and look from most-specific directory to least.
> 
> Note that this doesn't work either:
> 
>   echo '*' >.gitignore
>   echo '!my_dir/*' >>.gitignore
> 
> The problem isn't that git doesn't read 'my_dir/.gitignore'. Git
> simply doesn't recurse into excluded directories, so patterns on
> excluded content have no effect.

Good point. To make it work you need to un-ignore the subdir, like:

  *
  !my_dir/

at which point "!my_dir/*" will work. But then so will a child
.gitignore in subdir. In fact, I think the only reason that "!my_dir/**"
is needed in the first place is that the "*" is too over-reaching; it
ignores both the top-level directories _and_ all of the individual files
in included directories.

So I think the best solution for the original problem, which is to
ignore everything except for a particular directory, is:

  # ignore everything at the top-level...
  /*
  # ...but specifically include one directory
  !/my_dir/

and then we do not even need to use "**" matching at all (which was
really about overriding the over-reaching "*").

> IMO this behavior is reasonable, as there is no way to check whether a
> negative pattern will match within an excluded untracked directory
> without scanning the directory.

Right. I was focused on not reading the .gitignore, but not descending
into the ignore subdir affects patterns we already know about, too.

> --- 8< ---
> Subject: [PATCH] gitignore.txt: clarify recursive nature of excluded directories
> 
> Additionally, precedence of negated patterns is exactly as outlined in
> the description, we don't need to repeat this.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>

Yeah, I think your update improves things.

I wonder if it is worth adding the "exclude everything except one
directory" case above to the EXAMPLES section, too.

-Peff
