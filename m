From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-daemon memory usage, disconnection.
Date: Wed, 19 Apr 2006 08:49:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604190839380.3701@g5.osdl.org>
References: <1145452967.13200.92.camel@pmac.infradead.org> 
 <Pine.LNX.4.64.0604190749160.3701@g5.osdl.org> <1145460469.11909.25.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 17:51:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWExr-0005b5-O5
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 17:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWDSPvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 11:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWDSPvd
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 11:51:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750925AbWDSPvc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 11:51:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3JFnAtH026380
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Apr 2006 08:49:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3JFn9r4024466;
	Wed, 19 Apr 2006 08:49:10 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1145460469.11909.25.camel@pmac.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18930>



On Wed, 19 Apr 2006, David Woodhouse wrote:

> On Wed, 2006-04-19 at 07:59 -0700, Linus Torvalds wrote:
> > Well, you've probably got two issues: 
> > 
> >  - it looks like you aren't packing your archives (which explains why the 
> >    disk accesses are horrid, which in turn explains the "D" part).
> 
> Hm, good point. They're fairly new trees -- I had foolishly assumed that
> they would at least start off packed. That isn't the case though --
> perhaps it should be? Did the original clone receive a pack on the wire
> and then _split_ it?

For old versions of git, yes.

> If the tools would automatically pack when the number of unpacked
> objects reaches a threshold, that would be useful.

Well, packing is still best done in the background: you don't generally 
want the tools to just stop for a minute to repack while you're doing 
something. You'd normally want to do a cron run at 4AM or something, see 
if there is lots to pack, and repack that.

The one exception is probably a large conversion process (from CVS, SVN, 
whatever). The conversion process itself probably takes ages, and it will 
be even slower if it were to keep the potentially huge result unpacked all 
the time.

But for normal ops, you really don't want to repack synchronously.

> Since this repo is only available through git:// and git+ssh:// URLs, I
> can safely use git-repack's '-a -d' options, right?

Yes.

> I'll do 'git-repack -l' nightly and 'git-repack -a -d -l' weekly -- does
> that seem sane?

Absolutely. The one exception might be trees that really don't change very 
much (which is quite common), so you might make it conditional on seeing 
if there are _any_ objects at all in .git/objects/00/, for example. Not 
that repack will be very expensive, but still..

> Well, it does that with SIGALRM happening periodically, theoretically
> for the purpose of providing progress output. Perhaps we could do a
> getpeername() or something else to check on the output fd each time?

Yes, that's possibly a good idea. Of course, for git-rev-list, it's just a 
pipe, and it's hard to do that check at least portably. On Linux, doing a 
"poll()" on a pipe for writing, with newer kernels you'll get a POLLERR if 
the other side has hung up, but that's by no means portable.

(On some other systems, doing a zero-sized write() _might_ do it, but at 
least Linux will happily say "ok, wrote 0 bytes" even if the other end 
isn't listening).

And git-rev-list isn't doing the SIGALARM anyway.

In other words, to do this, we'd have to change send-pack to use the 
revision library. Which, as mentioned, is worth-while anyway, but it's not 
totally trivial.

		Linus
