From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH v2 1/2] perl: redirect stderr to /dev/null instead of
 closing
Date: Sat, 6 Apr 2013 01:34:51 +0200
Message-ID: <20130405233450.GA6137@machine.or.cz>
References: <20130404011653.GA28492@dcvr.yhbt.net>
 <801ebb2a75d7cddfeee70eb86e8854c78d22eb3e.1365107899.git.trast@inf.ethz.ch>
 <20130405144828.GX6137@machine.or.cz>
 <7vsj34byb4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Marcin Owsiany <marcin@owsiany.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:02:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWRB-0001b9-VN
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390Ab3DEXe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 19:34:56 -0400
Received: from pasky.or.cz ([84.242.80.195]:46452 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760311Ab3DEXez (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 19:34:55 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4F0521700058; Sat,  6 Apr 2013 01:34:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsj34byb4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220251>

On Fri, Apr 05, 2013 at 11:57:19AM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@ucw.cz> writes:
> >> > -			if (defined $opts{STDERR}) {
> >> > -				close STDERR;
> >> > -			}
> >> >  			if ($opts{STDERR}) {
> >> >  				open (STDERR, '>&', $opts{STDERR})
> >
> >   I'm sorry, I don't follow. Doesn't this just break the STDERR option
> > altogether as we will try to dup2() over an already open file
> > descriptor? We do need to close STDERR if we are going to reopen it,
> > I think.
> 
> When $opts{STDERR} is 2, what the three lines the proposed patch
> removes did is actively wrong, because you dup2 the fd you just
> closed.

Indeed, though $opts{STDERR} == 2 is something weird to do, it is a case
to consider.

> When $opts{STDERR} is 1, it seems to do the right thing with or
> without the "close STDERR" in front.  Isn't this because the usual
> "open($fd, <<<anything>>>) closes $fd as necessary" applies to this
> case as well?

I never actually tried that and was always happy to go with perldoc
maxim

	To (re)open "STDOUT" or "STDERR" as an in-memory file, close it first:
	           close STDOUT;
	           open(STDOUT, ">", \$variable)
	               or die "Can't open STDOUT: $!";

but my assumption that this generalizes to other kinds of open was
apparently invalid; an example further down the page proves me wrong
completely, moreover.

  The thing is, I was confused about dup2() all along as my old UNIX
masters taught me that I must close() the original descriptor first
and since that's what's commonly done anyway, I never thought to
double-check. Now I did and I learned something new, thanks!

I guess Acked-by: Petr Baudis <pasky@ucw.cz> then. :-)

-- 
				Petr "Pasky" Baudis
	For every complex problem there is an answer that is clear,
	simple, and wrong.  -- H. L. Mencken
