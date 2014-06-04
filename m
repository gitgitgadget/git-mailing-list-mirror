From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
Date: Wed, 4 Jun 2014 21:42:16 +0200
Message-ID: <20140604194216.GA4636@sandbox-ub>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
 <1401874256-13332-1-git-send-email-judge.packham@gmail.com>
 <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	mara.kim@vanderbilt.edu, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:42:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsH4x-00077A-QG
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 21:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbaFDTm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 15:42:27 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:57639 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaFDTm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 15:42:27 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WsH4o-0006RP-FZ; Wed, 04 Jun 2014 21:42:22 +0200
Content-Disposition: inline
In-Reply-To: <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250775>

On Wed, Jun 04, 2014 at 10:24:06AM -0700, Junio C Hamano wrote:
> Chris Packham <judge.packham@gmail.com> writes:
> 
> > On 04/06/14 09:05, Junio C Hamano wrote:
> >>> Also, going --recursive when the user did not want is a lot more
> >>> expensive mistake to fix than not being --recursive when the user
> >>> wanted to.
> >> 
> >> Having said all that, I do not mean to say that I am opposed to
> >> introduce some mechanism to let the users express their preference
> >> between recursive and non-recursive better, so that "git clone"
> >> without an explicit --recursive (or --no-recursive) can work to
> >> their taste.  A configuration in $HOME/.gitconfig might be a place
> >> to start, even though that has the downside of assuming that the
> >> given user would want to use the same settings for all his projects,
> >> which may not be the case in practice.
> >
> > And here's a quick proof of concept. Not sure about the config variable name
> > and it could probably do with a negative test as well.
> 
> I would be more worried about the semantics than the name, though;
> re-read the part you quoted with extra stress on "has the downside".
> 
> I think I heard the submodule folks (cc'ed) discuss an approach to
> allow various submodules to be marked with "tags" with a new type of
> entry in .gitmodules file in the superproject, and use these tags to
> signal "by default, a new clone will recurse into this submodule".
> 
> E.g. if projects standardized on "defaultClone" to mark such
> submodules, then $HOME/.gitconfig could say
> 
>     [clone]
>         recursesubmodules = defaultClone
> 
> Or the projects may mark platform specific submodules with tags,
> e.g. a .gitmodules in a typical superproject might say something
> like this:
> 
>     [submodule "posix"]
>     	path = ports/posix
>         tags = linux obsd fbsd osx
>     [submodule "windows"]
>         path = ports/windows
>         tags = win32
>     [submodule "doc"]
>     	path = documentation
>         tags = defaultClone
> 
> and then the user's $HOME/.gitconfig might say
> 
>     [clone]
>         recursesubmodules = defaultClone win32
> 
> to tell a "git clone" of such a superproject to clone the top-level,
> read its .gitmodules, and choose documentation/ and ports/windows
> submodules but not ports/posix submodule to be further cloned into
> the working tree of the superproject.
> 
> Of course, if this kind of project organization proves to be useful,
> we should try to standardize the set of tags early before people
> start coming up with random variations of the same thing, spelling
> the same concept in different ways only to be different, and if that
> happens, then we could even give a non-empty default value for the
> clone.recursesubmodules when $HOME/.gitconfig is missing one.
> 
> Just a random thought.

I like this idea of specifying different "views" by giving tags. But
does it rule out a boolean clone.recursesubmodules? For the simple case
some people might not want to worry about specifying tags but just want
to configure: "Yes give me everything". So if we were to do this I would
like it if we could have both. Also because the option for clone is
--recurse-submodules and our typical schema is that a configuration
option is named similar so clone.recursesubmodules would fit here.

So either we do this "magically" and all valid boolean values are
forbidden as tags or we would need a different config option. Further
thinking about it: Maybe a general option that does not only apply to
clone would suit the "views" use-case more. E.g. "submodule.tags" or
similar.

Also please note: We have been talking about adding two configurations
for submodules:

	submodule."name".autoclone (IIRC)

I am not sure whether that was the correct name, but this option should
tell recursive fetch / clone whether to automatically clone a submodule
when it appears on a fetch in the history.

	submodule."name".autoinit

And this one is for recursive checkout and tells whether an appearing
submodule should automatically be initialized.

These options fullfill a similar use-case and are planned for the future
when recursive fetch/clone and checkout are in place (which is not that
far away). We might need to rethink these to incoporate the "views from
tags" idea nicely and since we do not want a configuration nightmare.

Cheers Heiko
