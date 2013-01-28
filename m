From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Mon, 28 Jan 2013 22:25:10 +0100
Message-ID: <5106ECB6.9010801@web.de>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com> <1359290777-5483-2-git-send-email-hjemli@gmail.com> <7vk3qywiqf.fsf@alter.siamese.dyndns.org> <CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com> <20130128081006.GA2434@elie.Belkin> <7vham1xktx.fsf@alter.siamese.dyndns.org> <CAFXTnz6xBMo42jWdqahYX-bnTBucVmQpFPN29X8tGRd7L=g2wQ@mail.gmail.com> <7vr4l5w385.fsf@alter.siamese.dyndns.org> <5106DBB7.70007@web.de> <7vlibdvyh3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 22:30:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzwHJ-0003vt-V7
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 22:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab3A1V3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 16:29:48 -0500
Received: from mout.web.de ([212.227.17.12]:65131 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074Ab3A1V3q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 16:29:46 -0500
Received: from [192.168.178.41] ([79.193.83.234]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MaJng-1UJewg25DU-00KWCH; Mon, 28 Jan 2013 22:25:10
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vlibdvyh3.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:98ASfHCQ4hcXSVbWgSW/w1zaZkBtBRzPxWZa/ZDrq0R
 JbRu6c/TLPW1eqK5DmdySC/riQNdf5Wg+gyfFRq60R4y8aiH5W
 tR/ppwjG6dhXQ72ftzgZYF1w2svT8/A72dhWbjAAIALe2pGAmx
 X3UsZQNs3xpiheOoUD4939a1W5HeA7hrYl/XfabsKOaTs4J56q
 ooBseAPZkrNJ/4gtKnANA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214876>

Am 28.01.2013 21:34, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 28.01.2013 19:51, schrieb Junio C Hamano:
>>> Lars Hjemli <hjemli@gmail.com> writes:
>>>
>>>>> Come to think of it, is there a reason why "for-each-repo" should
>>>>> not be an extention to "submodule foreach"?  We can view this as
>>>>> visiting repositories that _could_ be registered as a submodule, in
>>>>> addition to iterating over the registered submodules, no?
>>>>
>>>> Yes, but I see some possible problems with that approach:
>>>> -'git for-each-repo' does not need to be started from within a git worktree
>>>
>>> True, but "git submodule foreach --untracked" can be told that it is
>>> OK not (yet) to be in any superproject, no?
>>
>> Hmm, I'm not sure how that would work as it looks for gitlinks
>> in the index which point to work tree paths.
> 
> I was imagining that "foreach --untracked" could go something like this:
> 
>  * If you are inside an existing git repository, read its index to
>    learn the gitlinks in the directory and its subdirectories.
> 
>  * Start from the current directory and recursively apply the
>    procedure in this step:
> 
>    * Scan the directory and iterate over the ones that has ".git" in
>      it:
> 
>      * If it is a gitlinked one, show it, but do not descend into it
>        unless --recursive is given (e.g. you start from /home/jens,
>        find /home/jens/proj/ directory that has /home/jens/proj/.git
>        in it.  /home/jens/.git/index knows that it is a submodule of
>        the top-level superproject.  "proj" is handled, and it is up
>        to the --recursive option if its submodules are handled).
> 
>      * If it is _not_ a gitlinked one, show it and descend into it
>        (e.g. /home/jens/ is not a repository or /home/jens/proj is
>        not a tracked submodule) to apply this procedure recursively.
> 
> Of course, without --untracked, we have no need to iterate over the
> readdir() return values; instead we just scan the index of the
> top-level superproject.

Thanks for explaining, that makes tons of sense.

>>>> -'git for-each-repo' and 'git submodule foreach' have different
>>>> semantics for --dirty and --clean
>>
>> I'm confused, what semantics of --dirty and --clean does current
>> 'git submodule foreach' have? I can't find any sign of it in the
>> current code ... did I miss something while skimming through this
>> thread? Or are you talking about status and diff here?
> 
> I think Lars is hinting that "submodule foreach" could restrict its
> operation to a similar --dirty/--clean/--both option he has.  Of
> course, the command given to foreach can decide to become no-op by
> inspecting the submodule itself, so in that sense, --dirty/--clean
> can be done without, but I think it would make sense to have it in
> "submodule foreach" even without the "--untracked" option.

Nice idea. E.g. that would help submodule users to easily script
a workflow which descends only into modified submodules to create
branches and push them there. Or to remove branches which were
created everywhere only in those submodules that weren't changed.

>> But I think the current for-each-repo
>> proposal doesn't allow to traverse repos which contain untracked
>> content (and it would be nice if the user could somehow combine
>> that with the current --dirty flag to have both in one go).
> 
> Perhaps.  I personally felt it was really strange that submodule
> diff and status consider that it is a sin to have untracked and
> unignored cruft in the submodule working tree, though.

The VCS we used at work before Git didn't show us any untracked
files, which caused trouble on a regular basis as people were
breaking builds for others because they forgot to check in new
files. That didn't happen with Git anymore, which was very cool.
But the problem reappeared as we started using submodules. Since
I taught status and diff to show that we're happy again. So for
us it was everything but strange ;-)

But for for-each-repo I would rather propose that modifications of
tracked files can optionally and/or solely be used to pick the
repos. Maybe: --dirty=modified, --dirty=untracked and --dirty=both
with --dirty defaulting to modified?
