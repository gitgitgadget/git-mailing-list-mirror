From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 2/6] Teach remote.c about the remote.default configuration
 setting.
Date: Fri, 13 Jul 2012 15:37:08 -0400
Message-ID: <500078E4.3000901@xiplink.com>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com> <1342020841-24368-3-git-send-email-marcnarc@xiplink.com> <7vr4siduq3.fsf@alter.siamese.dyndns.org> <4FFDE4EB.3060100@xiplink.com> <7v8veqdkfd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 21:37:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Splga-0003u3-2e
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 21:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab2GMThB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 15:37:01 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:33660 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab2GMThA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 15:37:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id C6965198328;
	Fri, 13 Jul 2012 15:36:59 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp24.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 0783819829A;
	Fri, 13 Jul 2012 15:36:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7v8veqdkfd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201418>

On 12-07-11 06:04 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> On 12-07-11 02:21 PM, Junio C Hamano wrote:
>>> marcnarc@xiplink.com writes:
>>>
>>>> From: Marc Branchaud <marcnarc@xiplink.com>
>>>>
>>>> The code now has a default_remote_name and an effective_remote_name:
>>>>
>>>>  - default_remote_name is set by remote.default in the config, or is "origin"
>>>>    if remote.default doesn't exist ("origin" was the fallback value before
>>>>    this change).
>>>>
>>>>  - effective_remote_name is the name of the remote tracked by the current
>>>>    branch, or is default_remote_name if the current branch doesn't have a
>>>>    remote.
>>>>
>>>> This has a minor side effect on the default behavior of "git push"....
>>>
>>> Hrm, is this a _minor_ side effect?
>>
>> Well, I thought so...  :)
>>
>> It's minor because of what you say:
>>
>>> Isn't that a natural and direct consequence of "now you can set
>>> remote.default configuration to name the remote you want to use in
>>> place of traditional 'origin'" feature?  I think changing the
>>> behaviour of "git push" in such a way is the point (may not be the
>>> only but one of the important points) of this series.
>>
>> I agree.  Phil Hord pointed out the change in behaviour and felt the commit
>> message should explain it.
>>
>> Should I just remove "minor"?
> 
> Is it even a _side effect_?  Isn't this one of the primary points of
> the series?  I do not think this patch makes sense if we did not
> want that change to happen.
> 
> Or am I missing something?

No, you're not -- I agree that this change in behaviour makes sense.  I
simply hadn't anticipated this effect when I first did the work.

So should the commit message simply say "This changes the default behavior of
'git push' ..."?  Or are you suggesting the message needn't mention it at all?

>>>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>>>> index cb97cc1..fc17d39 100644
>>>> --- a/Documentation/git-push.txt
>>>> +++ b/Documentation/git-push.txt
>>>> @@ -27,10 +27,16 @@ documentation for linkgit:git-receive-pack[1].
>>>>  OPTIONS[[OPTIONS]]
>>>>  ------------------
>>>>  <repository>::
>>>> -	The "remote" repository that is destination of a push
>>>> +	The "remote" repository that is the destination of the push
>>>>  	operation.  This parameter can be either a URL
>>>>  	(see the section <<URLS,GIT URLS>> below) or the name
>>>>  	of a remote (see the section <<REMOTES,REMOTES>> below).
>>>> +	If this parameter is omitted, git tries to use the remote
>>>> +	associated with the currently checked-out branch.  If there
>>>> +	is no remote associated with the current branch, git uses
>>>> +	the remote named by the "remote.default" configuration variable.
>>>> +	If "remote.default" is not set, git uses the name "origin" even
>>>> +	if there is no actual remote named "origin".
>>>
>>> This comment applies to other changes to the documentation in this
>>> patch I didn't quote, but I think the phrasing 'even if there is no
>>> acutual remote named "origin"' needs to be rethought, because "we
>>> use it even if there is no such remote determined with this logic"
>>> applies equally to branch.$name.remote, remote.default or built-in
>>> default value of remote.default which happens to be "origin".
>>
>> I'm sorry, but I'm having trouble understanding what you mean.  I don't see
>> how the "because ..." part of your sentence suggests what aspect needs
>> rephrasing.
> 
> You say the remote is taken from three places (branch.$name.remote,
> remote.default, or 'origin').
> 
> Imagine there is remote.origin.url at all.  If remote.default is set
> to 'origin', or branch.$name.remote for the current branch is set to
> 'origin', the repository you will try to use is 'origin'.  And you
> will fail the same way if you try to push there.  It does not matter
> if the hardcoded default gave you 'origin' or configuration variable
> gave it to you.  The name is used regardless, even if there is no
> actual remote under such name.
> 
> So "If 'remote.default' is not set, git uses the name "origin" even
> if there is no actual remote", while is not untrue, is misleading.
> Even if there is no actual remote 'origin', if 'remote.default' is
> set to 'origin', git will use that name, and will fail the same way.
> 
> Just saying "If 'remote.default' is not set, git uses 'origin'" or
> even "'remote.default', if unset, defaults to 'origin'" would be
> sufficient.

Thanks, I understand you now.

I feel it's rather surprising that git defaults to "origin".  I think the
docs should explain that git in fact ignores whatever remotes are actually
configured in the repository, that git only looks in specific places for a
remote name.  That's what I was trying to convey with the "even if" clause.

I'll try to rephrase.

		M.
