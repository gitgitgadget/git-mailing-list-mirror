From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sun, 20 Jan 2008 13:15:48 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801201300190.5731@racer.site>
References: <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org> <alpine.LSU.1.00.0801192256480.5731@racer.site>
 <20080120061419.GL14871@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:16:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGa2X-0000Hv-6w
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 14:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYATNQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 08:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbYATNQL
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 08:16:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:46901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751936AbYATNQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 08:16:10 -0500
Received: (qmail invoked by alias); 20 Jan 2008 13:16:07 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 20 Jan 2008 14:16:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tYsQ+ohPt2gYZBy07Vsz6jtBdXEft6HzrmJFTgH
	pt9/oMyBbcQXzL
X-X-Sender: gene099@racer.site
In-Reply-To: <20080120061419.GL14871@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71174>

Hi,

On Sun, 20 Jan 2008, Dmitry Potapov wrote:

> On Sat, Jan 19, 2008 at 10:58:08PM +0000, Johannes Schindelin wrote:
> > 
> > I think a better approach would be to try to match the name to what we 
> > have in the index.  Then we could implement case-insensitivity and 
> > MacOSX workaround at the same time.
> 
> I thought about that, but the problem is that HFS+ _already_ mangled 
> names from what the user entered (and what is used by anyone else) to 
> some sub-standard form, which no one outside of Mac likes or uses.

So?  That's why I said "match", not "compare for identity".

To be a little bit more precise: I think a viable plan would be to

- have a config switch which determines what type of filename mangling we
  allow the host OS to perform (Unicode "normalisation", case mongering),
  and leave _everybody_ alone who left that switch unset,

- "overload" readdir() (by the famous git_X(); #define X git_X trick),

- have the overloaded readdir() _know_ which is the current prefix, and
  load the index if it has not yet been loaded (but probably into a static
  variable to avoid reloading, and to avoid interfering with the global
  "cache" instance).

It _could_ be wise to store the "normalised" forms at one stage (instead 
of the index) to speed up comparison -- the prefix has to be normalised 
for readdir()s purposes, too, then.

This is possible with the HFS+ problem, since we know exactly how HFS+ 
tries to "help", and for case insensitivity too, I think.  But it may be 
restricting ourselves for other filename "equivalences" we might want to 
handle one day.

BTW: I cannot think of anything else than readdir() which should have the 
"problem" of reading back a name that the user did not specify.  What am I 
missing?

> Thus, bringing filenames back to the NFC form (which is what almost 
> anyone uses) is the only sane thing do, because no one outside of Mac 
> really needs to know about this HFS+ specific craziness.

No.  I think that would be a serious mistake.  If you add a file on MacOSX 
(with a _mangled_ filename, think of "git add ."), git should not try to 
be as clever as HFS+ and "remangle" it.

> So I really dislike the idea that due to some HFS+ specific conversion, 
> we may end up having some strangely encoded names in a Git repository.

It _is_ UTF-8, so what's the problem?

As for the HFS+ specfic conversion: like the CRLF issue, I am opposed to 
have a "solution" affecting other people than those on broken system.  So 
I very much _want_ it to be an HFS+ specific conversion.

> Besides, writing a wrapper around readdir() is not difficult. We already 
> have git-compat-util.h, which redefines some functions for some 
> platforms, so I don't see any problem with writing a wrapper around 
> readdir().

Exactly.

Ciao,
Dscho
