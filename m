From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Fri, 26 Aug 2011 18:14:49 +0200
Message-ID: <4E57C679.9080406@web.de>
References: <cover.1312923673.git.hvoigt@hvoigt.net> <7v8vqzreeo.fsf@alter.siamese.dyndns.org> <20110811195955.GA21185@book.hvoigt.net> <7vy5yujtr2.fsf@alter.siamese.dyndns.org> <20110822200052.GC11745@sandbox-rc> <7v62lpuky8.fsf@alter.siamese.dyndns.org> <20110823194350.GA57187@book.hvoigt.net> <4E540B03.2030909@web.de> <7vpqjvrebk.fsf@alter.siamese.dyndns.org> <20110824193007.GC45292@book.hvoigt.net> <7vbovcg00u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 18:15:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwz3b-00023x-Ck
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 18:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab1HZQOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 12:14:54 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:53398 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab1HZQOx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 12:14:53 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7FE10197F1A8B;
	Fri, 26 Aug 2011 18:14:52 +0200 (CEST)
Received: from [79.247.251.157] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qwz3U-0002U0-00; Fri, 26 Aug 2011 18:14:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <7vbovcg00u.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/r+zDEkoBiIorj23X/OoZQvmGLGWBeqgjJKPl/
	oTEYmRrE+ma29FLN3GnWqDvZIKgAtGQKTOxSUCtpVTRdd+BIis
	FUbeFRoHqcj6tmKXzNNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180176>

Am 26.08.2011 08:27, schrieb Junio C Hamano:
> Thinking about it more, I am starting to think that this backwardness may
> be an indication that we are describing a wrong solution to a wrong
> problem.

I Agree, I see two related topics mingled here.

> Isn't the root cause of the issue that a "submodule init" without pathspec
> limit adds everything to .git/config, ending up with all submodules fully
> instantiated, and it is too easy to run such a lazy "submodule init"?

Yes. And that upstream has no option (yet) to tell which submodules should
be automatically initialized on clone, which would get rid of the need to
run "git submodule init" in the first place for the average user.

To me Heiko's change fixes that issue `accidentally` because "update=none"
implies "even when it is initialized I never want to update its work tree,
so don't even clone it". Which is correct but not quite the meaning of the
update config.

> If we allowed the project managers (i.e. the ones who write .gitmodules)
> to specify the default set of submodules to be initialized with such a
> "submodule init", omitting some submodules from even getting registered to
> the recipients' .git/config in the first place, wouldn't that solve the
> issue you are trying to address equally well, without anything to worry
> about this semantic change at all? I am trying to see if we can come up
> with a solution with which we do not even have to add any entry for a
> submodule to .git/config of the superproject, if it is "don't care" kind
> of submodule for the copy of the superproject repository the user has.

I really think we need such an option. I imagine enabling it to even
initialize the submodules on clone or when checking out a branch
introducing a new submodule (and fetch should proactively fetch such
submodules so they can be checked out when disconnected later). Working
title: "init=[auto|no]", with "auto" initializing it on clone and "none"
never initializing it unless the submodule is given on the command line.

> The way in which the project managers specify that a module is not meant
> to be "init"ed by default may be to have "submodule.$name.update = none"
> in the .gitmodules file they ship, so externally there may not be huge
> difference from the behaviour (but not the implementation) of your patch,
> even though submodule.$name.update probably is not a good variable name to
> be used for this purpose.

IMO the update option is about what should happen to an initialized
submodule when a the commit recorded in the superproject changes: Shall it
be checked out, rebased, merged or left alone. Heiko's proposal adds the
missing fourth case, so I think his patch is going in the right direction.
But we should have another config option to state "not to be initialized".

> Another thing we may want to consider is to make .gitmodules describe
> submodule dependencies. If your hypothetical superproject is about a
> library, which consists of doc/, include/, and libsrc/ submodules, with
> pre-built binary perhaps shipped as part of the superproject itself, those
> who work on documentation may want to populate only doc/, those who are
> interested in using the library may want to populate only include/ and
> possibly doc/, and those who work on the library itself would populate
> include/ and libsrc/, possibly with doc/ submodules. It wouldn't make any
> sense to populate libsrc/ without populating include/ submodule, as the
> source would not be buildable without the includes.

Yes, it would be cool having a "git submodule init libsrc"  initializing
submodule "include" too.

> Now if we imagine that much more people are interested in using the
> library than working on it, it is plausible that the project may want to
> suggest:
> 
>  - Majority of people may want to omit libsrc/ submodule; and
> 
>  - If you populate libsrc/, then you would definitely want to populate
>    include/ submodule.
> 
> Your "submodule.libsrc.update = none" in .gitmodules can express the
> former, and I think it is natural to express the latter (i.e. submodule
> dependency) in the same file, to be propagated in the same way to the
> consumers.

As I said above, I think "submodule.libsrc.update = none" only does the
trick because "git submodule update" is used to both clone an update a
submodule. I vote for a separate option to express the first condition.

For me this is thread covers three different issues:

1) What submodules should be initialized?
   I think we need to add a new option ("init"?) to control that.

2) How should initialized submodules be updated when the SHA1 changes?
   This is what "update" should control, and Heiko's patch adds the
   missing "none" case.

3) What dependencies do submodules have?
   This is slightly orthogonal but should honor the settings in 1) and 2).

And I believe there are use cases where you want the submodule to be
initialized but never updated (and I expect "ignore=all" to be set in
that case too, as the user should not be bothered if the submodule is out
of sync). Imagine large intro movies of a gaming project separated into a
submodule which each developer should have to start the application but
doesn't care if he doesn't have the most up-to-date version.

So before people start (mis-)using the "update=none" option because they
can't use "init=none" yet, I vote for an additional patch implementing
that config option (per submodule and globally). Then we can document each
option properly.

Does that make sense?
