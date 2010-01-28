From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..."
 page when regenerating cache (WIP)
Date: Thu, 28 Jan 2010 18:39:50 +0100
Message-ID: <20100128173950.GH9553@machine.or.cz>
References: <cover.1264198194.git.jnareb@gmail.com>
 <201001251246.40237.jnareb@gmail.com>
 <20100125130230.GE9553@machine.or.cz>
 <201001251448.27513.jnareb@gmail.com>
 <20100125135653.GN4159@machine.or.cz>
 <4B5DFFE5.6060908@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Jan 28 18:54:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaYLY-0001Vv-To
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 18:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319Ab0A1Rjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 12:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756314Ab0A1Rjy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 12:39:54 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59763 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756310Ab0A1Rjy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 12:39:54 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 5E67186202A; Thu, 28 Jan 2010 18:39:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B5DFFE5.6060908@eaglescrag.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138260>

On Mon, Jan 25, 2010 at 12:32:37PM -0800, J.H. wrote:
> This does 2 things in the end:
> 
> 1) means there's only 1 copy of the page ever being generated, thus
> meaning there isn't extraneous and dangerous disk i/o going on on the system

But this has nothing to do with what you _do_ when there are multiple
requests, whether you do the same as if caching was disabled (hang until
content is generated) or doing something novel (creating redirects
through "Generating..." page).

> 2) prevents a user from reporting to the website that it's broken by
> giving them a visual que that things aren't broken.

But this has nothing to do with caching per se, right? I think it
actually makes _no difference_ if caching is enabled or not to this
problem, or am I missing something?


My point is, I guess, that showing the Generating page doesn't seem to
have actually anything to do with the caching itself?

> > So, I wonder about two things:
> > 
> > (i) How often does it happen that two requests for the same page are
> > received? Has anyone measured it? Or is at least able to make
> > a minimally educated guess? IOW, isn't this premature optimization?
> 
> For most pages, not many but it happens more often than you think.  The
> data I have is much too old to be useful now but the front page could,
> at times, have up to 30 people waiting for it without caching.  This is
> a very important patch believe it or not.  For a site the size of
> kernel.org it cannot exist without this.
..snip numbers..

Ok, I think you convinced me here (even if I think the front page is
kind of special case).

> > (ii) Can't the locked gitwebs do the equivalent of tail -f?
> 
> Not really going to help much, most of the gitweb operations won't
> output much of anything beyond the header until it's collected all of
> the data it needs anyway and then there will be a flurry of output.  It
> also means that this 'Generating...' page will only work for caching
> schemes that tail can read out of, which I'm not sure it would work all
> that well with things like memcached or a non-custom caching layer where
> we don't necessarily have direct access to the file being written to.
> 
> At least the way I had it (and I'll admit I haven't read through Jakub's
> re-working of my patches so I don't know if it's still there) is that
> with background caching you only get the 'Generating...' page if it's
> new or the content is grossly out of data.  If it's a popular page and
> it's not grossly out of date it shows you the 'stale' data while it
> generates the new content in the background anyway, only locking you out
> when the new file is being written.  Or at least that's how I had it.

Well, my user experience with gitweb on kernel.org is that I get
Generating... page all the time when I dive deep enough to the object
tree. I just find it really distracting and sometimes troublesome when
I want to wget some final object.

I think it's fine to take in the caching support with the Generating...
page in the bundle, but I do want to declare my intention to get rid of
it later, at least for caching backends that could do without it - for
pages where content appears incrementally, tail -f, for pages where
content appears all at once, show at least the header and some "I'm
busy" notification without redirects.

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
