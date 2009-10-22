From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC] What to you think about a loose status for
	submodules?
Date: Thu, 22 Oct 2009 21:44:47 +0200
Message-ID: <20091022194446.GA3944@book.hvoigt.net>
References: <20091021160122.GA2067@book.hvoigt.net> <7vy6n4339k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 21:44:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N13ah-0000U5-0k
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 21:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbZJVTop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 15:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbZJVToo
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 15:44:44 -0400
Received: from darksea.de ([83.133.111.250]:41798 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752494AbZJVToo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 15:44:44 -0400
Received: (qmail 25654 invoked from network); 22 Oct 2009 21:44:47 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 22 Oct 2009 21:44:47 +0200
Content-Disposition: inline
In-Reply-To: <7vy6n4339k.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131048>

On Wed, Oct 21, 2009 at 01:23:19PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > For such a workflow I would like to implement what I call 'loose'
> > submodules. Where a
> >
> >   git clone project.git
> >   cd project
> >   git submodule init && git submodule update
> >
> > would omit the 'help' folder. But in case I specify it directly like
> 
> I thought a blanket "submodule init/update" wasn't even a recommended
> practice for this exact reason.  We tried to keep the default not to
> gratuitously populate and checkout all submodule repositories, but
> probably what you are trying to do was made more difficult by mistake
> because people who wanted the other behaviour pushed too hard?

Currently if a project has submodule its either use all submodules or
none. There is nothing in between.

> Defaulting to "do not populate and checkout unless explicitly asked"
> sounds like the right thing to do, and if we broke it, it should be
> corrected, I think.  Shouldn't it be a simple matter of teaching "--all"
> option to "submodule init" (and "update") to let them blindly affect all
> submodules, while making the default not to do anything?

Not completely. As said above I want something 'in between' because some
small submodule might be necessary to compile the project. And they are
submodules because they are shared code, so more than one project is
using them. And then there are optional submodules like pugins or
documentation which are not needed for compilation.

> >   git config submodule."name".relation tight
> 
> I do not think this should be a project-wide configuration that is
> recorded in .gitmodules; if you are "help documentation" participant to
> the project you would want "help" submodule, and other people will want
> different submodules.
> 
> It would probably make more sense to introduce the notion of "module
> groups", similar to the way "remote update <group>" can name a group of
> remotes to affect.  Then documentation people can say
> 
>     submodule init doc && submodule update

That makes sense. If I understand it correctly the group definitions
would then be stored in .gitmodules ?

Thinking further we could also name the group definition 'view'. In the
notion of different kind of views for a project. That way a doc
developer would get a set of options which make more sense for him
(thinking about extending this to sparse checkout). But first lets
consider submodules.

> if .gitmodules file records the mapping from "doc" to one or more
> submodules (e.g. "help" and "doc").  If we are going to take this route,
> it would still make sense to teach "--all" to "submodule init" and perhaps
> default to init the "default" group if one exists, instead of making the
> parameterless "init" a no-op as I suggested earlier.

I like this idea.

> But it is quite a long time since I looked at git-submodule.sh so please
> take the above with a healthy dose of salt.

I am not sure what is the best way to create such a group mapping using
our config files though. I would like to allow multiple groups/views to
have the submodules like:

[submodule "doc"]
	path = Documentation
	views = doc

[submodule "help"]
	path = help
	views = doc

[submodule "core"]
	path = core
	views = doc default

[submodule "app"]
	path = app
	views = default

What do you think?

cheers Heiko
