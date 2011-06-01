From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] submodule add: improve message when resolving a relative
 url fails
Date: Wed, 01 Jun 2011 11:55:14 -0400
Message-ID: <4DE660E2.9080500@xiplink.com>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de> <4DE548C4.2010600@web.de> <4DE5561C.3010200@xiplink.com> <4DE565DF.7050207@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 17:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRnlX-0007NE-GD
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 17:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab1FAPzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 11:55:22 -0400
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:37886 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1FAPzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 11:55:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp41.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id ABF61298425;
	Wed,  1 Jun 2011 11:55:20 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp41.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EB40B298436;
	Wed,  1 Jun 2011 11:55:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <4DE565DF.7050207@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174870>

On 11-05-31 06:04 PM, Phil Hord wrote:
> On 05/31/2011 04:57 PM, Marc Branchaud wrote:
>> Thanks for the cogent explanation & patch.  I think the message could be
>> improved a bit:
>>
>> 	Cannot resolve "../sub" relative to this repository's "origin"
>> 	remote: The remote's URL is not set in .git/config
>>
>> However, overall I think this is a pretty fragile way to handle relative
>> paths.  Consider:
>>
>>  - The super-repo must be a clone in order for this to work at all.
> 
> Yes, but that constraint (mostly) makes sense to me.  But if 'git
> submodule add' did not initialize .git/config, this constraint could be
> dropped.
> 
>>  - The super-repo cannot be checked out on a detached HEAD.
> 
> Why do you think that?  I just tried this and it worked fine for me.  I
> can't think of a reason for it to fail.

Whoops, right.  I was confusing a different error with the fact that "git
symbolic-ref HEAD" fails on a detached HEAD.  The code defaults to "origin"
as the remote name in this case (perhaps that's not strictly the right thing
to do, but I'm sure this isn't the only part of git that assumes there's a
remote called "origin").

>>  - The current code rewrites the URL so that any relative path is either
>>    rejected or munged into an absolute remote URL.
> 
> I don't see the URL getting munged away from being relative.  Can you
> point to an example?

I reached this conclusion because if I go into my clone of git.git and do

	git submodule add ../MyThing

where ../MyThing is a regular git repo, I get

Cloning into MyThing...
fatal: The remote end hung up unexpectedly
Clone of 'git://git.kernel.org/pub/scm/git/MyThing' into submodule path
'MyThing' failed

So it seemed the relative URL became an absolute URL.

Looking more closely at a working example, I can see that (as you show below)
the URL in the super-repo's .gitmodules file retains the relative path, but
the submodule's remote.origin.url is an absolute path.

In any case, "submodule add" isn't doing what I expected: make my local
MyThing repo a submodule of my git.git clone.

>> It seems to me that this feature will only work in a fairly narrow set of
>> circumstances, and even when it does work it's likely to do something
>> unexpected (think of a super-repo with several remotes).
> 
> I use it this way with several remotes. 
> 
>> Back when Junio accepted the original patch, he said "If you maintain and
>> serve a set related projects you need to give the users a single URL (per
>> where the user is and how to reach the server)."  I'm not sure I understand
>> that:  Why would the users be adding their own submodules to the
>> superproject?  Wouldn't the superproject define the submodules in for them?
> I am a user.  I admin a super-project for other users.  This project
> lives at three remotes, remotes/public, remotes/shared and remotes/build. 
> 
> I add a new submodule to the superproject like this:
> 
>    mkdir sub && cd sub && git init
>    cd ..
>    git submodule add ../sub sub
> 
> This results in the new submodule being inserted into my .gitmodules
> file and my .git/config:
> 
>    tail -3 .gitmodules
>    [submodule "sub"]
>        path = sub
>        url = ../sub
> 
>    tail -2 .git/config
>    [submodule "sub"]
>        url = public:git/sub
> 
> I do have to make sure to push my submodule to the correct location on
> each remote before pushing my new .gitmodules.
> 
> But the exact same commands work for me if I do this first and then do
> 'git submodule add ../sub' afterwards. 
> 
> So, I don't understand your objections.  Do you understand my use case
> any better?

It's not so much an objection as confusion over how "submodule add" works.

I believe your case works smoothly only because in your super-project you're
careful to make sure you have checked out a branch that remotely tracks a
something in remotes/public.  If you checked out a branch that tracks a
different remote you'd get different results.  This seems fragile to me.

When you tried the detached-HEAD scenario, did you get URLs for
"public:git/sub" or "origin:git/sub"?  Does "origin" just happen to be the
remote you want to use in any case?

My fundamental point is that "git submodule add" seems to do confusing things
with relative paths.  Maybe all that's needed is to clarify the
documentation.  I'll post a patch.

		M.
