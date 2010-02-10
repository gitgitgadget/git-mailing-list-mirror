From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC PATCHv2 04/10] gitweb: Use Cache::Cache compatibile (get,
 set) output caching
Date: Wed, 10 Feb 2010 13:02:57 +0100
Message-ID: <20100210120257.GP4159@machine.or.cz>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com>
 <201002100212.26157.jnareb@gmail.com>
 <20100210012343.GS9553@machine.or.cz>
 <201002101228.15732.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 13:03:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfBHi-0002qs-PO
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 13:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab0BJMDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 07:03:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:36802 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877Ab0BJMDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 07:03:01 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id E929986209A; Wed, 10 Feb 2010 13:02:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201002101228.15732.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139507>

On Wed, Feb 10, 2010 at 12:28:14PM +0100, Jakub Narebski wrote:
> On Wed, 10 Feb 2010, Petr Baudis wrote:
> > On Wed, Feb 10, 2010 at 02:12:24AM +0100, Jakub Narebski wrote:
> > > On Tue, 9 Feb 2010 at 11:30 +0100, Jakub Narebski wrote:
> > > 
> > > > The cache_fetch subroutine captures output (from STDOUT only, as
> > > > STDERR is usually logged) using either ->push_layer()/->pop_layer()
> > > > from PerlIO::Util submodule (if it is available), or by setting and
> > > > restoring *STDOUT.  Note that only the former could be tested reliably
> > > > to be reliable in t9503 test!
> > > 
> > > Scratch that, I have just checked that (at least for Apache + mod_cgi,
> > > but I don't think that it matters) the latter solution, with setting
> > > and restoring *STDOUT doesn't work: I would get data in cache (so it
> > > can be restored later), but instead of output I would get Internal Server
> > > Error ("The server encountered an internal error or misconfiguration and
> > > was unable to complete your request.") without even a hint what the
> > > problem was.  Sprinkling "die ...: $!" didn't help to catch this error:
> > > I suspect that the problem is with capturing.
> > > 
> > > So we either would have to live with non-core PerlIO::Util or (pure Perl)
> > > Capture::Tiny, or do the 'print -> print $out' patch...
> > 
> > All the magic methods seem to be troublesome, but in that case I'd
> > really prefer a level of indirection instead of filehandle - as is,
> > 'print (...) -> output (...)' ins. of 'print (...) -> print $out (...)'
> > (or whatever). That should be really flexible and completely
> > futureproof, and I don't think the level of indirection would incur any
> > measurable overhead, would it?
> 
> First, it is not only 'print (...) -> print $out (...)'; you need to
> do all those:
> 
>    print  <sth>            ->  print  $out <sth>
>    printf <sth>            ->  printf $out <sth>
>    binmode STDOUT, <mode>  ->  binmode $out, <mode>
> 
> Second, using "tie" on filehandle (on *STDOUT) can be used also for 
> just capturing output, not only for "tee"-ing; what's more to print
> while capturing one has to do extra work.  It is quite similar to
> replacing 'print (...)' with 'output (...)' etc., but using
> tie/untie doesn't require large patch to gitweb.
> 
> Third, as you can see below tie-ing is about 1% slower than using
> 'output (...)', which in turn is less than 10% slower than explicit
> filehandle solution i.e. 'print $out (...)'... and is almost twice
> slower than solution using PerlIO::Util
> 
> Benchmark: timing 50000 iterations of output, perlio, print \$out, tie *STDOUT...
>      output: 1.81462 wallclock secs ( 1.77 usr +  0.00 sys =  1.77 CPU) @ 28248.59/s (n=50000)
>      perlio: 1.05585 wallclock secs ( 1.03 usr +  0.00 sys =  1.03 CPU) @ 48543.69/s (n=50000)
> print \$out: 1.70027 wallclock secs ( 1.66 usr +  0.00 sys =  1.66 CPU) @ 30120.48/s (n=50000)
> tie *STDOUT: 1.82248 wallclock secs ( 1.79 usr +  0.00 sys =  1.79 CPU) @ 27932.96/s (n=50000)
>                Rate tie *STDOUT      output print \$out      perlio
> tie *STDOUT 27933/s          --         -1%         -7%        -42%
> output      28249/s          1%          --         -6%        -42%
> print \$out 30120/s          8%          7%          --        -38%
> perlio      48544/s         74%         72%         61%          --
> 
> Benchmark: running output, perlio, print \$out, tie *STDOUT for at least 10 CPU seconds...
>      output: 10.7199 wallclock secs (10.53 usr +  0.00 sys = 10.53 CPU) @ 28029.63/s (n=295152)
>      perlio: 11.2884 wallclock secs (10.46 usr +  0.00 sys = 10.46 CPU) @ 49967.11/s (n=522656)
> print \$out: 10.5978 wallclock secs (10.43 usr +  0.00 sys = 10.43 CPU) @ 30318.79/s (n=316225)
> tie *STDOUT: 11.3525 wallclock secs (10.68 usr +  0.00 sys = 10.68 CPU) @ 27635.96/s (n=295152)
>                Rate tie *STDOUT      output print \$out      perlio
> tie *STDOUT 27636/s          --         -1%         -9%        -45%
> output      28030/s          1%          --         -8%        -44%
> print \$out 30319/s         10%          8%          --        -39%
> perlio      49967/s         81%         78%         65%          --
> need
> 
> Attached there is script that was used to produce those results.

Ok, on my machine it's similar:

                Rate      output tie *STDOUT print \$out
output      150962/s          --         -1%         -7%
tie *STDOUT 152769/s          1%          --         -6%
print \$out 162604/s          8%          6%          --

is roughly consistent image coming out of it.

I guess the time spent here is generally negligible in gitweb anyway...
I suggested using output() because I think hacking it would be _very_
_slightly_ easier than tied filehandle, but you are right that doing
that is also really easy; having the possibility to use PerlIO::Util if
available would be non-essentially nice, but requiring it by stock
gitweb is not reasonable, especially seeing that it's not packaged even
for Debian. ;-)

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
