From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [1.8.0] Don't copy "submodule.<name>.update" to .git/config on
 submodule init
Date: Wed, 23 Feb 2011 23:43:27 +0100
Message-ID: <4D658D8F.2040203@web.de>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org> <4D65660D.3040501@web.de> <7v7hcq8pil.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 23:44:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsNRR-0005sj-Lo
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 23:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab1BWWoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 17:44:12 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:33325 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab1BWWoL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 17:44:11 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate03.web.de (Postfix) with ESMTP id 3EB21189346DE;
	Wed, 23 Feb 2011 23:43:28 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsNQe-0004Kq-00; Wed, 23 Feb 2011 23:43:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7v7hcq8pil.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19FX2a8fH/fCHOTukNSdXZ6Odq16EiXPdc+mgbG
	UP59K2iiVoCTXIJ2IiLZJVvM6JyBQVRzPaGYL/DN62gCC297dw
	5dwLuCxYbFBrd94PN/MQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167730>

Am 23.02.2011 21:28, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Proposal:
>>
>> Stop copying the "submodule.<name>.update" entries into .git/config
>> on "git submodule init". The current behavior makes it impossible
>> for upstream to change defaults later, as this value can only be
>> altered through user intervention when it resides in .git/config.
>> This is a good thing when he chose to copy it there, but it doesn't
>> seem to make much sense doing it by default.
> 
> Doesn't it just come from the usual "upstream can give a sane default as
> recommendation to users who may not bother to set up .git/config, and the
> user can tweak that if that doesn't suit his/her needs" convention?

Yup, but when *copying* it locally upstream won't be able to change that
default ever again. Wouldn't it suffice to copy that *only* if the user
really wants to tweak it?

And now I read that again I notice that I forgot to add a very important
sentence, sorry about that:

"Take the setting from .gitmodules if submodule.<name>.update is not
configured by the user in .git/config."

> I have a feeling that the correct fix (not limited to "update" but all the
> submodule related configuration that share the same "give default, allow
> tweak" philosophy) is to:

I agree that all should behave the same way for consistency reasons.

>  (1) record submodule.<name>.update at initialization time, to allow the
>      upstream a chance to give a sensible default, as we do now;
> 
>  (2) in addition to that, record the fact that the value came as upstream
>      default.  You could do so in multiple ways:
> 
>      a) record the commit that gave the suggested default to .git/config,
>      perhaps submodule.<name>.defaultedFrom (notice that this is
>      independent from "update", and covers all such configuration
>      variables with a single value); or
> 
>      b) record the value the upstream gave to .git/config in a separate
>      variable, perhaps submodule.<name>.updateSuggested; or
> 
>      c) some other clever way you can think of, as long as it lets us do
>      the next step.

My proposal uses the values in .gitmodules for those proposed by upstream
and those in .git/config as those tweaked by the user. Isn't that simpler
than 1) and 2) while giving us the same functionality? And additionally it
is not setting the upstream default in stone (which is rather arbitrary as
it just happened to be present in our .gitmodules when we did the "git
submodule init" and might be different at another point in the history)?

>  (3) when updating from the upstream results in a change in .gitmodules
>      file that changes the previously suggested default the user
>      considered, tell that to the user and have him/her choose.  If you
>      took (a) in the previous step, you can use "git diff" to determine if
>      the suggested default has changed; if you took (b) in the previous
>      step, you can compare submodule.<name>.update in .gitmodules with
>      submodule.<name>.updateSuggested to do so; if you did (c), you are on
>      your own ;-).  After the user updates (or chooses to keep the current
>      setting), record the current suggested default just like you did at
>      the init time in step (2).
> 
> One thing to be careful is in (3) you should not bother users who chose to
> ignore the upstream default (i.e. has submodule.<name>.update set
> differently from what is suggested by the .gitmodules at the time of
> initialization).  The reason (3) updates the "current suggested default"
> is exactly for that purpose---the user has seen what the last suggested
> default was, and decided to either go with it or have his/her own setting.

Consider the following situation: The .git directories of the submodules
reside in the .git directory of the superproject so their work trees can
be safely deleted and we have means to let upstream configure which
submodules should be populated on clone. (Hopefully this is the future ;-)

What happens when we fetch a commit which records a new submodule marked
to be populated on clone in the .gitmodules of that commit? I assume we
would want to fetch the bare submodule into a subdirectory of the .git
directory of the superproject so that we have it present so we can
populate it when the superproject's commit is checked out later, no?

Should we ask the user if he wants to fetch the bare submodule into the
.git directory of the superproject or to ignore the clone setting while
fetching? Should we ask him again on checkout time if he wants to use the
upstream setting of checking out the submodule? Or should we just let it
happen and when the user decides that he never wanted this submodule he
says so in his .git/config while everybody who is happy with the default
just moves on? (And of course we would honor any configurations the user
did beforehand, like e.g. ignoring all upstream clone defaults)

I have the impression that using submodules won't work smoothly unless
we honor the defaults set by upstream until told otherwise by the user.
If we copy the settings into .git/config right away we take away much of
the flexibility that I believe is needed here, and I can't really see
the upsides of that. But the downside is that the setting is copied at
an random point in time and therefore is rather arbitrary.

Another example is the repo where submodules normally use the on-demand
fetch mode (so everybody only gets those submodule commits he really
needs) while having topic branches where certain submodules are always
fetched in full to be able to record new commits of those in the
superproject. Depending on what branch you were when the copy into
.git/config occurred you would be stuck with either setting, which I
think is suboptimal.

What am I missing?
