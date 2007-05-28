From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Tue, 29 May 2007 01:41:03 +0200
Message-ID: <20070528234103.GV4489@pasky.or.cz>
References: <87bqg724gp.fsf@rho.meyering.net> <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org> <87odk6y6cd.fsf@rho.meyering.net> <alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org> <87sl9hw0o0.fsf@rho.meyering.net> <20070528154630.GA9176@fiberbit.xs4all.nl> <87646cx13d.fsf@rho.meyering.net> <20070528190529.GA10656@fiberbit.xs4all.nl> <87veecvgsn.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue May 29 01:41:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsops-0002On-4x
	for gcvg-git@gmane.org; Tue, 29 May 2007 01:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbXE1XlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 19:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756002AbXE1XlI
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 19:41:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34888 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbXE1XlH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 19:41:07 -0400
Received: (qmail 16470 invoked by uid 2001); 29 May 2007 01:41:03 +0200
Content-Disposition: inline
In-Reply-To: <87veecvgsn.fsf@rho.meyering.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48654>

  (I think that funnily enough, Linus is to a degree to the Git
community something like Al Viro and Chris Hellwig are to the Linux
kernel community. Don't get too derailed by his blunt^Whonest criticism,
which is however usually quite valid. ;-)

On Mon, May 28, 2007 at 10:23:20PM CEST, Jim Meyering wrote:
> Marco Roeland <marco.roeland@xs4all.nl> wrote:
> > On monday May 28th 2007 at 20:19 Jim Meyering wrote:
> >> Also, to be consistent, don't ignore EPIPE write failures.
> >
> > In practice I agree with someone else on this thread that EPIPE _is_
> > different. In a way the responsibility doesn't lie with the writer but
> > with the reader.
> 
> Do you think it's ok for git-rev-list _not_ to diagnose an erroneous
> command like this (i.e., to exit(0)):
> 
>     git-rev-list HEAD | sync
> 
> where "sync" could be any command that exits successfully
> without reading any input?
> 
> Is it ok that it is currently *impossible* to diagnose that
> failure by looking at exit codes?

  Actually, yes!

  Because there's no "failure" per se. The command we piped the output
into just decided that he isn't actually interested in any (for whatever
reason; it might decide dynamically based on some parameters etc.). I
can't think of why it could be considered a failure for git-rev-list if
its customer doesn't happily eat all the output it generates. It's the
customer's job to report any real trouble that happenned and might be
cause of the premature end (or maybe the premature end was totally
valid).

  Maybe it could expose some (IMHO contrived) error scenarios, but in
most cases I think it will end up just spitting out bogus error
messages. And what will people do? They won't bother to filter out this
particular one (which isn't even that easy if the strerror() is
localized, furthermore). They will just 2>/dev/null it. And cause the
*real* error messages go to the land of void as well. There's enough of
impossible-to-diagnose-error-conditions-because-stderr-goes-to-null
scripts in the land of UNIX already and this patch, while actually
well-meant to do the opposite, might well actually increase their number
because of this.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
