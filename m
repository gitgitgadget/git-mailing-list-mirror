From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
Date: Wed, 04 Jun 2014 21:06:58 +0200
Message-ID: <538F6E52.9000009@web.de>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>	<1401874256-13332-1-git-send-email-judge.packham@gmail.com> <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mara.kim@vanderbilt.edu,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>,
	Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 21:07:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGWy-0006SL-7s
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 21:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbaFDTHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 15:07:20 -0400
Received: from mout.web.de ([212.227.15.4]:58637 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaFDTHS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 15:07:18 -0400
Received: from [192.168.178.41] ([79.193.71.10]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MBCBN-1WzeWU1QaD-00AITe; Wed, 04 Jun 2014 21:06:59
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:5I0muZJHtlkk/LD32Z51sQ82Gz5W2S8MjsBJDi2RvyVNZotpHPt
 wzaLPn7PcPyoPxTT2Du69CV5B0E1TbhAOls2pI8ydgMtKb7r9ICHL8SSZSqmiEO3SzFDcAV
 1HPPBjB/0avTWGOD3YWIKBBgUjqLIZXNJm0ItufpZugygAYjJs/H25uTgovS+a4ZfVcxw4q
 f+V8JI57SKEzueosQFCpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250772>

Am 04.06.2014 19:24, schrieb Junio C Hamano:
> Chris Packham <judge.packham@gmail.com> writes:
> 
>> On 04/06/14 09:05, Junio C Hamano wrote:
>>>> Also, going --recursive when the user did not want is a lot more
>>>> expensive mistake to fix than not being --recursive when the user
>>>> wanted to.
>>>
>>> Having said all that, I do not mean to say that I am opposed to
>>> introduce some mechanism to let the users express their preference
>>> between recursive and non-recursive better, so that "git clone"
>>> without an explicit --recursive (or --no-recursive) can work to
>>> their taste.  A configuration in $HOME/.gitconfig might be a place
>>> to start, even though that has the downside of assuming that the
>>> given user would want to use the same settings for all his projects,
>>> which may not be the case in practice.
>>
>> And here's a quick proof of concept. Not sure about the config variable name
>> and it could probably do with a negative test as well.
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

Yes, but maybe we can define how the user wants to set the global or
per-repo default (that is honored as long as upstream or local
config doesn't provide more specific settings, e.g. via tags) and
implement that for clone as a first step, even when we do not now
how e.g. the tags setting might look like in the end. I believe we
should have one or two switches telling Git "I want my submodules be
updated without having to use the 'git submodule' command". And
after that submodule specific overrides can kick in, e.g. when
"submodule.<name>.update" is set to "none" the submodule won't be
updated no matter how the default is.

We had two settings in mind, first "submodule.autoinit" (which would
automate the "git submodule --init" step and also control that a
new submodule is fetched into .git/modules; it'd be fetched there
soon as the fetch in the superproject sees a commit introducing it).
That would kick in on clone, fetch and pull, as the underlying fetch
honors it. And the "submodule.autoupdate" setting which will make
running "git submodule update" obsolete by updating all init'ed
submodules on each clone, checkout, merge, reset etc.. Together
they'd achieve for all relevant commands what Chris' proposed option
would only do for clone.

So what if clone would just do an "git submodule init" for now when
"submodule.autoinit" is set but "submodule.autoupdate" isn't (and as
soon as fetch learns to honor autoinit we could remove that one
again). And if both are set it'd do a "git submodule update --init
--recursive", just like it does when the --recurse-submodules option
is used. As soon as we also have recursive submodule update, we could
remove the latter from clone.

But maybe we are to close to the implementation side of things (where
fetch and checkout just like init and update are two separate things)
and a single "submodule.auto" setting would be what users really want?

Comments welcome.
