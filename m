From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related
	subroutines
Date: Sat, 12 Jul 2008 03:47:08 +0200
Message-ID: <20080712014708.GB10151@machine.or.cz>
References: <200807031824.55958.jnareb@gmail.com> <20080709160303.GL10151@machine.or.cz> <200807100133.38163.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 03:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHUDb-0001qg-7f
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 03:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628AbYGLBrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 21:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755388AbYGLBrM
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 21:47:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50125 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385AbYGLBrM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 21:47:12 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id AE2A0393B60B; Sat, 12 Jul 2008 03:47:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807100133.38163.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88215>

On Thu, Jul 10, 2008 at 01:33:36AM +0200, Jakub Narebski wrote:
> On Wed, Jul 09, 2008, Petr "Pasky" Baudis wrote:
> > On Thu, Jul 03, 2008 at 06:24:53PM +0200, Jakub Narebski wrote:
> > >  * Should config_val_to_bool and config_val_to_int throw error or
> > >    just return 'undef' on invalid values?  One can check if variable
> > >    is defined using "exists($config_hash{'varname'})".
> > 
> >   I think that it's more reasonable to throw an error here (as long as
> > you don't throw an error on undef argument). This particular case is
> > clearly a misconfiguration by the user and you rarely need to handle
> > this more gracefully, I believe.
> 
> If we follow git-config convention (and I guess we should), it would be
> value of appropriate type if variable value is of appropriate type,
> 'undef' (no output in the case of git-config) when variable does not 
> exists, and throwing error (status and "fatal: ..." message on STDERR
> in the case of git-config) if variable is not of given type.

Yes, this seems to be in agreement with what I suggested.

> > >  * What should ->get_config() have as an optional parameter:
> > >    PREFIX (/^$prefix/o), or simply SECTION (/^(?:$section)\./o)?
> > 
> >   Do we even _need_ a parameter like that? I don't understand what is
> > this interface trying to address.
> 
> For example if one wants to access _all_ variables in gitweb.* section
> (or in gitcvs.* section), and _only_ config variables in given section.

But what is the practical benefit? Does anyone use a config file long
enough that this makes any difference?

Or if you mean foreach use, it's trivial to

	foreach (grep { /^gitweb\./ } keys %$config)

or provide a method of Git::Config that will return this list, but it
does not seem appropriate to have specific Git::Config instances for
this. (Besides, if the script also needs to access a single variable
from a different section, it will need to re-parse the config again.)

So I think your approach would be good only if there are multiple
methods of Git::Config that would operate on the whole config and needed
a way to be restricted; is that the case?

> BTW. what should non-typecasting should be named? $c->get(<VAR>), 
> $c->value(<VAR>), $c->param(<VAR>), or something yet different?

I would prefer 'get' since it's the shortest and most clear, but 'value'
would be fine too, I suppose (and more in line with bool etc.).

> > Also, having accessors for special types lets you return undef when
> > the type really isn't defined, instead of e.g. true with current
> > config_val_bool, which is clearly bogus and requires complicated code
> > on the user side. 
>  
> I don't follow you.  Didn't we agree on casting an error when variable
> is not of given type?

Sorry, s/type really/variable really/. According to your original code,

	config_val_bool(undef)

would return true, while the undef could be from both non-existent and
unassigned variable. (This 'unassigned variables' case is really
annoying to handle.)

> > -- 
> > 				Petr "Pasky" Baudis
> > The last good thing written in C++ was the Pachelbel Canon. 
> >                                                  -- J. Olson 
> 
> Eh? Isn't it written C# rather?

Well, the quote is a bit dated and changing it would be too problematic.
;-)

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
