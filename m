From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 13:52:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903101343530.14295@intel-tinevez-2-302>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302>
 <49B64ADC.2090406@viscovery.net> <49B64C3A.50909@viscovery.net> <alpine.DEB.1.00.0903101236480.14295@intel-tinevez-2-302> <49B659B4.5000705@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 13:53:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh1Su-0003ss-8B
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 13:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbZCJMwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 08:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbZCJMwS
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 08:52:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:34204 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752522AbZCJMwR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 08:52:17 -0400
Received: (qmail invoked by alias); 10 Mar 2009 12:52:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 10 Mar 2009 13:52:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SmOoB9VLSzPPpLRJTUiYxcljFUa6UDsZ3Qwk+Hz
	5PxSJvmeuN2HXf
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49B659B4.5000705@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112811>

Hi,

On Tue, 10 Mar 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > FWIW GitTorrent may be implemented as part of git-daemon, if Sam's 
> > ideas become reality.  And then, sideband transport is _the_ means to 
> > do asyncrounous communication while pushing bytes.
> 
> I do not see how recv_sideband() in its current form could be helpful 
> here (assuming that you really are thinking of sending binary data over 
> band #2).

I think it is a safe bet that the side band would be a good way to 
exchange updates to the mirror list as well as the refs list.

> > On Tue, 10 Mar 2009, Johannes Sixt wrote:
> >> Johannes Sixt schrieb:
> >>> For use-cases that you have in mind in GitTorrent, the *protocol* 
> >>> may be a good choice, but the current implementation is definitely a 
> >>> special case.
> >>
> >> And it really is: Did you notice that stuff that recv_sideband sends 
> >> over the channel named 'err' (before my patch) has "remote: " 
> >> prepended on every line? That's certainly not an implementation that 
> >> you want if you send binary data over that band!
> > 
> > Yes, that is unfortunate, but can be fixed easily.
> 
> I don't believe this. Every treatment of "remote: " that you take away
> from recv_sideband() you must insert somewhere else. Perhaps easy, but
> certainly not as trivial as my patch.

AFAICT it would be a matter of

	unsigned pf = isatty(err) ? strlen(PREFIX) : 0;

> Just a reminder: You proposed to override write() on Windows in a 
> non-trivial way, and we are discussing the topic above because I think 
> that is not a good idea. The reasons are:
> 
> - write() is a fundamental operation, and we should not mess with it out 
>   of caution.

But we do not mess with it!  We ask explicitely if we are talking about a 
tty.

> - Your proposal is not a catch-all. For example, combine-diff.c uses 
>   puts() in dump_quoted_path(). If your goal was to not touch code 
>   outside of compat/ then you need to override at least puts(), too.

>From compat/mingw.h:

-- snip --
/*
 * ANSI emulation wrappers
 */

int winansi_fputs(const char *str, FILE *stream);
[...]
#define fputs winansi_fputs
-- snap --

... added in c09df8a, SOBbed by yourself ;-)

> - All code that writes ANSI escapes should use fprintf() anyway.  
>   (Currently that is not the case, but all cases I'm aware of can be 
>   fixed trivially.)

I disagree that all ANSI escapes have to go through fprintf().  Sometimes 
you have a buffer, and I do not like doing extra work with %.*s there.

BTW I hope that you are not annoyed by the discussion; I think it is 
necessary and important.  I am certainly not married to my current POV; so 
far, I am still in favor of it, though.

Ciao,
Dscho
