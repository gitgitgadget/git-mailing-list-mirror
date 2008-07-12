From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related
	subroutines
Date: Sat, 12 Jul 2008 15:45:53 +0200
Message-ID: <20080712134553.GC10151@machine.or.cz>
References: <200807031824.55958.jnareb@gmail.com> <200807100133.38163.jnareb@gmail.com> <20080712014708.GB10151@machine.or.cz> <200807121435.49151.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 15:47:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHfRB-00033y-9o
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 15:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbYGLNp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 09:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbYGLNp6
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 09:45:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53966 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbYGLNp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 09:45:57 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 33F04393B928; Sat, 12 Jul 2008 15:45:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807121435.49151.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88240>

On Sat, Jul 12, 2008 at 02:35:48PM +0200, Jakub Narebski wrote:
> On Sat, Jul 12, 2008, Petr Baudis wrote:
> > Or if you mean foreach use, it's trivial to
> > 
> > 	foreach (grep { /^gitweb\./ } keys %$config)
> > 
> > or provide a method of Git::Config that will return this list, but it
> > does not seem appropriate to have specific Git::Config instances for
> > this. (Besides, if the script also needs to access a single variable
> > from a different section, it will need to re-parse the config again.)
> > 
> > So I think your approach would be good only if there are multiple
> > methods of Git::Config that would operate on the whole config and needed
> > a way to be restricted; is that the case?
> 
> On the other hand if one uses (assuming now Git::Config object API)
> 
>   $conf = $repo->get_config('section');
> 
> one could access configuration variable values _without_ prefixing
> them with subsection name, i.e.
> 
>   $conf->get('variable');
> 
> and not
> 
>   $conf->get('section.variable');
> 
> 
> I'm not sure if it is much of an improvement.

I would propose not to go with this feature yet and add it only when
justified by accompanied cleanups of real code using this.

> We can have $c->value(<VAR>), $c->bool(<VAR>), $c->int(<VAR>) and
> (in the future) $c->color(<VAR>) and $c->colorbool(<VAR>)... or we can
> have $c->get(<VAR>), $c->get_bool(<VAR>) etc.

I think I prefer the terser approach of value/bool/int now since it is
shorter and seems to stay pretty unambiguous. Besides, this way we can
easily make mutators by just adding second optional argument to these
methods.

> The former plays better with
> 
>   $r->get_config()->bool('gitweb.blame');
> 
> but this is nevertheless not recommended workflow; you can use
> 
>   $r->config_bool('gitweb.blame');
> 
> and it would be faster (unless some Perl/OO trickery with singletons
> and the like).
> 
>  Recommended workflow (code) is
> 
>   $c = $r->get_config();
>   ...
>   $c->get_bool('gitweb.blame');
> 
> or something like that.

I thought that the get_config() method would be reusing existing
Git::Config instances no-matter-what? (Otherwise, you can get into
rather tricky issues like one part of the code modifying the config and
the other not noticing the change, etc. And I can se no benefit. If you
want to reload the config, we might have method like reload(), but I
don't think that would be very useful except perhaps in some kind of
mod_perl'd gitweb scenario.)

> >>> Also, having accessors for special types lets you return undef when
> >>> the type really isn't defined, instead of e.g. true with current
> >>> config_val_bool, which is clearly bogus and requires complicated code
> >>> on the user side. 
> >>  
> >> I don't follow you.  Didn't we agree on casting an error when variable
> >> is not of given type?
> > 
> > Sorry, s/type really/variable really/. According to your original code,
> > 
> > 	config_val_bool(undef)
> > 
> > would return true, while the undef could be from both non-existent and
> > unassigned variable. (This 'unassigned variables' case is really
> > annoying to handle.)
> 
> That is why you should check exists($config{<VAR>}) first.

And that was my point when I talked about complicated code on the user
side.

But we're arguing about nothing, really, except the exact amount of
coolness of the Git::Config approach. :-)

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
