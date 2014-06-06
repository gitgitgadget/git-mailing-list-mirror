From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC PATCH] clone: add clone.recursesubmodules config
	option
Date: Fri, 6 Jun 2014 07:54:30 +0200
Message-ID: <20140606055430.GC77405@book.hvoigt.net>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com> <1401874256-13332-1-git-send-email-judge.packham@gmail.com> <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com> <20140604194216.GA4636@sandbox-ub> <539020D1.1090601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mara.kim@vanderbilt.edu, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 07:54:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsn6v-0001mW-3x
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 07:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbaFFFyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 01:54:37 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:32910 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbaFFFyg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 01:54:36 -0400
Received: from [77.20.146.74] (helo=book.hvoigt.net)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Wsn6m-0004Vq-Eb; Fri, 06 Jun 2014 07:54:32 +0200
Content-Disposition: inline
In-Reply-To: <539020D1.1090601@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250891>

On Thu, Jun 05, 2014 at 07:48:33PM +1200, Chris Packham wrote:
> On 05/06/14 07:42, Heiko Voigt wrote:
> > I like this idea of specifying different "views" by giving tags. But
> > does it rule out a boolean clone.recursesubmodules? For the simple case
> > some people might not want to worry about specifying tags but just want
> > to configure: "Yes give me everything". So if we were to do this I would
> > like it if we could have both. Also because the option for clone is
> > --recurse-submodules and our typical schema is that a configuration
> > option is named similar so clone.recursesubmodules would fit here.
> 
> Maybe using a glob pattern would work.
> 
> The user might say
> 
>      [clone]
>          recursesubmodules = x86*
> 
> And .gitmodules might say
> 
>      [submodule "foo"]
>          tags = x86_64
>      [submodule "bar"]
>          tags = x86
>      [submodule "frotz"]
>          tags = powerpc
> 
> For the "Yes give me everything" case the user could say
> 
>      [clone]
>          recursesubmodules = *

Thats interesting. Lets me/us think about that a little more.

> > So either we do this "magically" and all valid boolean values are
> > forbidden as tags or we would need a different config option. Further
> > thinking about it: Maybe a general option that does not only apply to
> > clone would suit the "views" use-case more. E.g. "submodule.tags" or
> > similar.
> > 
> > Also please note: We have been talking about adding two configurations
> > for submodules:
> > 
> > 	submodule."name".autoclone (IIRC)
> > 
> > I am not sure whether that was the correct name, but this option should
> > tell recursive fetch / clone whether to automatically clone a submodule
> > when it appears on a fetch in the history.
> > 
> > 	submodule."name".autoinit
> > 
> > And this one is for recursive checkout and tells whether an appearing
> > submodule should automatically be initialized.
> > 
> > These options fullfill a similar use-case and are planned for the future
> > when recursive fetch/clone and checkout are in place (which is not that
> > far away). We might need to rethink these to incoporate the "views from
> > tags" idea nicely and since we do not want a configuration nightmare.
> 
> I'm a little confused at how autoclone and autoinit differ. Aren't they
> the same? i.e. when this module appears grab it by default. I see
> autoupdate as a little different meaning update it if it's been
> initialised. Also does autoinit imply autoupdate?

autoclone is about cloning the history of submodules. So e.g. when a
submodule first appears in the superprojects history whether it should
automatically be cloned to .git/modules.

autoinit is all about the checkout phase. When a commit with a new
submodule is checked out: Should that new submodule be automatically
initialised?

As far as autoupdate is concerned: Maybe autoinit can imply that it is
enabled, yes. But I guess we still need autoupdate for the case of big
submodules that cause to much performance trouble if updated by every
checkout.

So its actually three values: autoclone, autoinit, autoupdate. Damn,
these configurations become more complicated everytime. Maybe we should
try to clean them, up once we have everything, with Git 3.0 ;-) If
anyone has an idea how to get rid of some right now...

Radically different thinking: How about just one: submodule.auto =
true/false configuration and that means you opt in to doing everything
as automatic as possible. Since we are still implementing we could stick
a prominent warning in the documentation that the user should be
prepared for behavioral changes.

Once everybody is happy with that we could switch the default from false
to true.

> At $dayjob we have a superproject which devs clone this has submodules
> for the important and/or high touch repositories. We have other
> repositories that are normally build from a tarball (or not built at
> all) but we can build them from external repositories if needed. The
> latter case is painfully manual. If autoinit/autoupdate existed we'd
> probably setup out projects with.
> 
>     [submodule "linux"]
>         autoinit = true
> 	autoupdate = true
>     [submodule "userland"]
>         autoinit = true
> 	autoupdate = true
>     [submodule "not-used-that-much"]
> 	autoupdate = true
> 
> We probably wouldn't make use of tags because we're building complete
> embedded systems and generally want everything, even if we are doing
> most of our work on a particular target we need to do builds for other
> targets for sanity checks.

Yep thats exactly what we already do at $dayjob but with
submodule.*.update=none. Since that conveniently also disables the
initialisation, developers only get the basic code and not everyone
needs to have the media and some big external libs.

I would reuse 'update' in the long run. But I guess for the transition
we will need the extra autoupdate one to keep annoyance levels low.

We currently also do not have real use cases for the tags/views
scenario, but as repositories grow I can see that it could be useful so
I would like it if we could keep the configuration open to that.

Cheers Heiko
