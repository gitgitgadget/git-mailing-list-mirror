From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH] contrib: teach completion about git-worktree
 options and arguments
Date: Fri, 21 Aug 2015 22:49:18 +0200
Message-ID: <20150821224918.Horde.edB9u314lsP17FLUzwFsQA1@webmail.informatik.kit.edu>
References: <1437684550-21884-1-git-send-email-sunshine@sunshineco.com>
 <CAPig+cQhh7YCiirp4a1+R0bWh46JoFgVOVUCNidTWXK8uNL2Mg@mail.gmail.com>
 <xmqq37zc7e2o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:49:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZStFu-0003xl-GW
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 22:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbbHUUtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 16:49:32 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:48843 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752880AbbHUUt3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 16:49:29 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZStFe-0005tz-22; Fri, 21 Aug 2015 22:49:26 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZStFW-0000ZJ-4P; Fri, 21 Aug 2015 22:49:18 +0200
Received: from x4db19803.dyn.telefonica.de (x4db19803.dyn.telefonica.de
 [77.177.152.3]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 21 Aug 2015 22:49:18 +0200
In-Reply-To: <xmqq37zc7e2o.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1440190166.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276332>


Quoting Junio C Hamano <gitster@pobox.com>:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Thu, Jul 23, 2015 at 4:49 PM, Eric Sunshine  
>> <sunshine@sunshineco.com> wrote:
>>> Complete subcommands 'add' and 'prune', as well as their respective
>>> options --force, --detach, --dry-run, --verbose, and --expire. Also
>>> complete 'refname' in "git worktree add [-b <newbranch>] <path>
>>> <refname>".
>>
>> Ping[1]?
>>
>> [1]: http://article.gmane.org/gmane.comp.version-control.git/274526
>
> Ping indeed?
>

Yeah, right, sorry.  Non-subscribed occasional gmane-reader here amidst
job hunting, so thanks for the ping.  And the re-ping...

>>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>>> ---
>>>
>>> This is RFC since this is my first foray into the Git completion script,
>>> and there are likely better and more idiomatic ways to accomplish this.

Using __git_find_on_cmdline() to find subcommands and case
"$subcommand,$cur" to limit the number of nested case statements is as
idiomatic as you can get in the completion script.

And I hear you, that "<path> first, <refname> second" syntax makes it way
too complicated, especially since they can follow '-b <refname>'.
I wrote a completion function for 'git worktree' as well, turns out a week
or two before you posted this, but I never submitted it as it was way too
convoluted.  Anyway, will send it in reply to this, just for reference.

>>>
>>>  contrib/completion/git-completion.bash | 32  
>>> ++++++++++++++++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>> diff --git a/contrib/completion/git-completion.bash  
>>> b/contrib/completion/git-completion.bash
>>> index c97c648..07c34ef 100644
>>> --- a/contrib/completion/git-completion.bash
>>> +++ b/contrib/completion/git-completion.bash
>>> @@ -2564,6 +2564,38 @@ _git_whatchanged ()
>>>         _git_log
>>>  }
>>>
>>> +_git_worktree ()
>>> +{
>>> +       local subcommands='add prune'
>>> +       local subcommand="$(__git_find_on_cmdline "$subcommands")"
>>> +       local c=2 n=0 refpos=2

A more descriptive variable name for 'n' would be great.

>>> +       if [ -z "$subcommand" ]; then
>>> +               __gitcomp "$subcommands"
>>> +       else
>>> +               case "$subcommand,$cur" in
>>> +               add,--*)
>>> +                       __gitcomp "--force --detach"

We usually don't offer '--force', because that option must be
handled with care.

>>> +                       ;;
>>> +               add,*)
>>> +                       while [ $c -lt $cword ]; do
>>> +                               case "${words[c]}" in
>>> +                               --*) ;;
>>> +                               -[bB]) ((refpos++)) ;;
>>> +                               *) ((n++)) ;;
>>> +                               esac
>>> +                               ((c++))
>>> +                       done
>>> +                       if [ $n -eq $refpos ]; then

I suppose here you wanted to calculate where (i.e. at which word on
the command line) we should offer refs and fall back to bash builtin
filename completion otherwise.  It works well in the common cases,
but:

   - it doesn't offer refs after -b or -B

   - it gets fooled by options to the git command, e.g. 'git
     --git-dir=.git worktree add <TAB>' offers refs instead of files,
     'git --git-dir=.git worktree add ../some/path <TAB>' offers
     refs, etc.

>>> +                               __gitcomp_nl "$(__git_refs)"
>>> +                       fi
>>> +                       ;;
>>> +               prune,--*)
>>> +                       __gitcomp "--dry-run --verbose --expire"
>>> +                       ;;
>>> +               esac
>>> +       fi
>>> +}
>>> +
>>>  __git_main ()
>>>  {
>>>         local i c=1 command __git_dir
>>> --
>>> 2.5.0.rc3.407.g68aafd0
