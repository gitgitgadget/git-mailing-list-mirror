From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 2/5] check-ignore: allow incremental streaming of queries
 via --stdin
Date: Thu, 11 Apr 2013 11:55:14 +0100
Message-ID: <20130411105514.GA24296@pacific.linksys.moosehall>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
 <1365645575-11428-2-git-send-email-git@adamspiers.org>
 <20130411053145.GB28915@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 12:55:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQFA3-0002Kr-J1
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 12:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab3DKKzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 06:55:17 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:58954 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3DKKzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 06:55:16 -0400
Received: from localhost (2.d.c.d.2.5.f.b.c.0.4.8.0.1.4.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d410:840c:bf52:dcd2])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 1A56058EB3;
	Thu, 11 Apr 2013 11:55:15 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130411053145.GB28915@sigill.intra.peff.net>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220843>

On Thu, Apr 11, 2013 at 01:31:45AM -0400, Jeff King wrote:
> On Thu, Apr 11, 2013 at 02:59:32AM +0100, Adam Spiers wrote:
> 
> > @@ -111,14 +110,11 @@ static int check_ignore_stdin_paths(struct path_exclude_check check, const char
> >  				die("line is badly quoted");
> >  			strbuf_swap(&buf, &nbuf);
> >  		}
> > -		ALLOC_GROW(pathspec, nr + 1, alloc);
> > -		pathspec[nr] = xcalloc(strlen(buf.buf) + 1, sizeof(*buf.buf));
> > -		strcpy(pathspec[nr++], buf.buf);
> > +		pathspec[0] = xcalloc(strlen(buf.buf) + 1, sizeof(*buf.buf));
> > +		strcpy(pathspec[0], buf.buf);
> > +		num_ignored += check_ignore(check, prefix, (const char **)pathspec);
> > +		maybe_flush_or_die(stdout, "check-ignore to stdout");
> 
> Now that you are not storing the whole pathspec at once, the pathspec
> buffer only needs to be valid for the length of check_ignore, right?
> That means you can drop this extra copy and just pass in buf.buf:
> 
>   pathspec[0] = buf.buf;
>   num_ignored += check_ignore(check, prefix, pathspec);

Oops, good point - thanks.  I've made that change.

> > +test_expect_success 'setup: have stdbuf?' '
> > +	if which stdbuf >/dev/null 2>&1
> > +	then
> > +		test_set_prereq STDBUF
> > +	fi
> > +'
> 
> Hmm. Today I learned about stdbuf. :)

Yeah, it's a relatively recent addition to coreutils.
