From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 3/6] Teach "git remote" about remote.default.
Date: Fri, 13 Jul 2012 15:54:00 -0400
Message-ID: <50007CD8.3040802@xiplink.com>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com> <1342020841-24368-4-git-send-email-marcnarc@xiplink.com> <7vk3yaduh1.fsf@alter.siamese.dyndns.org> <4FFDE4ED.8020502@xiplink.com> <7vd342dku3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 21:54:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Splwl-0006lu-A3
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 21:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781Ab2GMTxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 15:53:53 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:33360 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab2GMTxw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 15:53:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id EB7BF198182;
	Fri, 13 Jul 2012 15:53:51 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp24.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 407D1198177;
	Fri, 13 Jul 2012 15:53:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7vd342dku3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201420>

On 12-07-11 05:55 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> What about a warning displayed if "remote.default" is not set?  Something like:
>>
>> 	This repository does not have an explicitly configured default
>> 	remote.  Selecting "origin" as the default remote repository.
>> 	To suppress this warning, or if you wish to have a different
>> 	default remote repository, run "git remote default <name>".
>> 	In git X.Y, the default remote will be automatically configured
>> 	as the first remote added to the repository.
> 
> When do you plan to issue the above message?  Any time we default to
> 'origin' without remote.default?  
> 
> I do not see a value to it---if the user has been happily using
> 'origin' as the default remote, there is no reason to give such a
> noise.  We will keep defaulting to 'origin' even in the version of
> Git with this series in it.
> 
> A warning is necessary if we plan to _later_ add the "first remote
> created either by 'git clone' or 'git remote add' is automatically
> set as the value for remote.default configuration" feature, and the
> place to do so is "git clone" and "git remote add" that creates the
> first remote for the repository.  If the name of the remote created
> by them is 'origin', then there is no need for warning, but if the
> user called that first remote with a name that is _not_ 'origin',
> later versions of Git will change the behaviour.
> 
> I can see a transition plan that goes like this:

I like your plan -- thanks for working it out in such detail!

I'll re-roll the series to work like your plan's Step 0, and I'll post a
separate RFC patch on top of it that initiates the transition, so folks can
discuss it specifically.

> Step 0.  With this series but without the "first one becomes default"
> 
>     $ git init
>     $ git remote add upstream git://over.there.xz/git.git/
>     hint: You may want to run "git remote default upstream" now so that
>     hint: a lazy 'git push' and 'git fetch' defaults to this 'upstream'
>     hint: repository, instead of 'origin' (which you do not yet have).
> 
>     $ git config --global advice.settingDefaultRemote false
>     $ git remote rm upstream
>     $ git remote add upstream git://over.there.xz/git.git/
>     ... nothing, as the user declined the advice ...
> 
> Step 1.  "First one becomes default" as an opt-in feature
> 
>     $ git config --global --unset advice.settingDefaultRemote
>     $ git init
>     $ git remote add upstream git://over.there.xz/git.git/
>     hint: You may want to run "git remote default upstream" now so that
>     hint: a lazy 'git push' and 'git fetch' defaults to this 'upstream'
>     hint: repository, instead of 'origin' (which you do not yet have).
>     hint: "git config --global remote.firstRemoteBecomesDefault true" can be
>     hint: used to make the first remote added to the repository the default
>     hint: remote automatically.
>     $ git remote default
>     origin
> 
>     $ git config --global remote.firstRemoteBecomesDefault true
>     $ git remote rm upstream
>     $ git remote add upstream git://over.there.xz/git.git/
>     ... nothing; user already knows about remote.firstRemoteBecomesDefault
>     $ git remote default
>     upstream
> 
> Step 2.  Start warning the default change for "First one becomes default"
> 
>     $ git config --global --unset advice.settingDefaultRemote
>     $ git config --global --unset remote.firstRemoteBecomesDefault
>     $ git init
>     $ git remote add upstream git://over.there.xz/git.git/
>     hint: You may want to run "git remote default upstream" now so that
>     hint: a lazy 'git push' and 'git fetch' defaults to this 'upstream'
>     hint: repository, instead of 'origin' (which you do not yet have).
>     hint: "git config --global remote.firstRemoteBecomesDefault true" can be
>     hint: used to make the first remote added to the repository the default
>     hint: remote automatically.
>     hint:
>     hint: In future versions of Git, this will happen automatically.
>     hint: If you do not want the first remote to become default, run
>     hint: "git config --global remote.firstRemoteBecomesDefault false" now.
> 
> Step 3. "First one becomes default" is now default
> 
>     $ git config --global --unset advice.settingDefaultRemote
>     $ git config --global --unset remote.firstRemoteBecomesDefault
>     $ git init
>     $ git remote add upstream git://over.there.xz/git.git/
>     warning: Made 'upstream' the default remote for this repository.
>     $ git remote default
>     upstream
> 
>     $ git remote rm upstream
>     $ git config --global remote.firstRemoteBecomesDefault true
>     $ git init
>     $ git remote add upstream git://over.there.xz/git.git/
>     ... nothing; the user explicitly told us what to do
>     $ git remote default
>     upstream
> 
>     $ git remote rm upstream
>     $ git config --global remote.firstRemoteBecomesDefault false
>     $ git init
>     $ git remote add upstream git://over.there.xz/git.git/
>     ... nothing; the user explicitly told us what to do
>     $ git remote default
>     origin
> 
>> Since the "cmd_" prefix is already used for the main commands, perhaps
>> another prefix for subcommands?  Maybe "sub_"?  Some of the shell-based
>> commands use the main command itself as a prefix (e.g. bisect_start()).
>> Doing that here would mean "remote_default()" etc.  Any preference?
> 
> No strong preference for file-scope-statics.
> 
>>>> +{
>>>> +	if (argc < 2)
>>>> +		printf_ln("%s", remote_get_default_name());
>>>
>>> Good.  If somebody anal cares about the vanilla hardcoded default
>>> 'origin' and 'remote.default' having 'origin' as a configured value,
>>> he should be using "git config" to ask the difference.  Users of
>>> "remote default" interface should not have to care.
>>>
>>>> +	else {
>>>> +		const char *name = argv[1];
>>>> +		if (remote_is_configured(name)) {
>>>> +			git_config_set("remote.default", name);
>>>> +			printf_ln(_("Default remote set to '%s'."), name);
>>>> +		} else
>>>> +			return error(_("No remote named '%s'."), name);
>>>> +	}
>>>
>>> I am not sure if this is a good idea.  Shouldn't "git remote default
>>> frotz" followed by "git remote add frotz" work?
>>
>> To me it feels wrong to allow the user to set the default remote to something
>> that doesn't actually exist.  It's like trying to add a non-existent file.
> 
> Every few weeks, I do this:
> 
> 	ln -f -s Documentation/RelNotes/$new_version.txt RelNotes
>         edit Documentation/RelNotes/$new_version.txt
> 
>> And what if the user forgets the second step?
> 
> That is why we warn on an unusual order.  A lazy "git push" will
> fail and that would be sufficient clue.
> 
> And another reason for the warning (with "you do not yet have") is
> to prevent this:
> 
>         git remote add frotz git://over.there.xz/git.git
>         git remote default frozt

See, to me an error in this case makes more sense.  But I feel I'm splitting
hairs now, and I'm happy to go with the warning instead.

>> It seems saner for a command to fail if it knows a change it's about to make
>> will cause problems.
> 
> The point is that you do *NOT* know it will cause problems.  People
> who want to do things in an unusual order *know* what they are doing
> a lot better than you do.  Don't get in their way.

I'll aim to post a revised series next week.

		M.
