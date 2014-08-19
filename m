From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Relative submodule URLs
Date: Tue, 19 Aug 2014 11:07:08 -0500
Message-ID: <CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 18:07:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJlwO-0005dY-NL
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbaHSQHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:07:13 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:42295 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbaHSQHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:07:12 -0400
Received: by mail-vc0-f173.google.com with SMTP id hy10so7697533vcb.32
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VGcxr/zDFXPwfUfY9LrLZSxqhJvlm3mpVesPDy2ASt8=;
        b=aYs+tFuCor8SP8dmiMn+bAp0OdFbrDBjOVEJUu0Tn2YHNzZRwyp0s4ZZSOs/F+tDMW
         JP2g8tSrlmQ7fyb758iAgboRlwwWLFiiZUVfhSHiOSH4i//BbPTNCw5greYTX6GmSYqD
         0JG11Wb88mf79kArYnhmKZJnlweKjeQ/cmhLzzpLvbAWQ0OZBmeL+YqXHnKDu1/IOyxl
         NJC313/DWY7w3mo07SocdgjNYE+lulzlhOWYE3LBKoSs43CH67vhxDeQvlXsTy8cIemw
         +oW/vbo5tHiQeomyXOKQf2usjWSpKn3Ll9nLY2nbLHJFCK4FrZo1ZwGHHKqduFIAax3g
         7x5A==
X-Received: by 10.52.243.10 with SMTP id wu10mr1637182vdc.45.1408464428384;
 Tue, 19 Aug 2014 09:07:08 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Tue, 19 Aug 2014 09:07:08 -0700 (PDT)
In-Reply-To: <20140818205505.GA20185@google.com>
X-Google-Sender-Auth: Zw335ySmhksktrZl4hxfIBgfnso
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255462>

On Mon, Aug 18, 2014 at 3:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Thanks for reporting.  The remote used is the default remote that "git
> fetch" without further arguments would use:
>
>         get_default_remote () {
>                 curr_branch=$(git symbolic-ref -q HEAD)
>                 curr_branch="${curr_branch#refs/heads/}"
>                 origin=$(git config --get "branch.$curr_branch.remote")
>                 echo ${origin:-origin}
>         }
>
> The documentation is wrong.  git-fetch(1) doesn't provide a name for
> this thing.  Any ideas for wording?

I guess a good start would be to call it the "tracked remote" instead
of "remote origin". The word "tracked" here makes it very obvious that
if I have a remote tracking branch setup, it will use the remote
portion of that configuration.

The real question is, how will `git submodule update` function if a
tracking remote is not configured? Will it fail with some useful error
message? I don't like the idea of it defaulting to "self remote" mode,
where it will be relative to my repo directory. That seems like it
would fail is subtle ways in a worst-case scenario (if I did by
happenstance have a bare repository cloned up one directory level for
other reasons).

> Currently there isn't, short of reconfiguring the remote used by
> default by "git fetch".

I wish there was a way to specify the remote on a per-branch basis
separately from the tracking branch. I read a while back that someone
proposed some changes to git to support decentralized tracking
(concept of an upstream tracking branch and a separate one for origin,
i think). If that were implemented, then relative submodules could
utilize the 'upstream' remote by default for each branch, which would
provide more predictable default behavior. Right now most people on my
team would not be aware that if they tracked a branch on their fork,
they would subsequently need to fork the submodules to that same
remote.

>> Various co-workers use the remote named "central" instead of
>> "upstream" and "fork" instead of "origin" (because that just makes
>> more sense to them and it's perfectly valid).
>>
>> However if relative submodules require 'origin' to exist AND also
>> represent the upstream repository (in triangle workflow), then this
>> breaks on several levels.
>
> Can you explain further?  In a triangle workflow, "git fetch" will
> pull from the 'origin' remote by default and will push to the remote
> named in the '[remote] pushdefault' setting (see "remote.pushdefault"
> in git-config(1)).  So you can do
>
>         [remote]
>                 pushDefault = whereishouldpush
>
> and then 'git fetch' and 'git fetch --recurse-submodules' will fetch
> from "origin" and 'git push' will push to the whereishouldpush remote.

I didn't know about this option, seems useful.

A common workflow that we use on my team is to set the tracking branch
to 'upstream' for convenient pulls with rebase. This means a feature
branch of mine can track its parent branch on 'upstream', so that when
other pull requests get merged in on the remote repo branch, I can
just do `git pull` and my feature branch rebases onto the latest of
that parent branch.

Cases like these would work with relative submodules because
'upstream' is the tracked remote (and most of the time we don't want
to fork submodules). However sometimes I like to track the same pushed
branch on origin (my fork), especially when it is up for pull request.
In these cases, my submodule update will fail because I didn't fork my
submodules when I changed my tracking branch. Is this correct?

"breaks on several levels" was basically my way of saying that various
workflow choices will break when you introduce submodules. One of the
beautiful things about Git is that it allows everyone to choose their
own workflow. But submodules seem to prevent that to some degree. I
think addressing relative submodule usability issues is the best
approach for the long term as they feel more sustainable and scalable.
It's an absolute pain to move a submodule URL, I think we've all
experienced it. It's even harder for me because I'm the go-to at work
for help with Git. Most people that aren't advanced with Git will not
know what to do without a ton of reading & such.

> It might make sense to introduce a new
>
>         [remote]
>                 default = whereishouldfetch
>
> setting to allow the name "origin" above to be replaced, too.  Is that
> what you mean?

I think you're on the right path. However I'd suggest something like
the following:

[submodule]
    remote = <remote_for_relative_submodules> (e.g. `upstream`)

[branch.<name>]
    submoduleRemote = <remote_for_relative_submodule>

Above, `submodule.remote` is the 'default' remote used by all relative
submodules on all branches. If unspecified, it defaults to
`branch.<name>.remote` as it currently behaves.

`branch.<name>.submoduleRemote` is an override for `submodule.remote`.

Basically if you consider this scenario:

[branch.myfoo]
   remote = origin
   submoduleRemote = upstream

I can track an origin branch, but the submodule will refer to 'upstream'.

I can optionally set `submodule.remote` in my global config so I don't
need to set the submodule remote on each branch. This is useful if
most branches I track are on origin instead of upstream.

I'm sure I'm missing other important aspects of Git that these options
conflict with, and perhaps 2 additional options may be too redundant.
It's just some food for thought.

> Meanwhile it is hard to fork a project that uses relative submodule
> URLs without also forking the submodules (or, conversely, to fork some
> of the submodules of a project that uses absolute submodule URLs).
> That's a real and serious problem but I'm not sure how it relates to
> the names of remotes.  My preferred fix involves teaching git to read
> a refs/meta/git (or similarly named) ref when cloning a project with
> submodules and let settings from .gitmodules in that ref override
> .gitmodules in other branches.  Is that what you were referring to?

Could you explain this a bit more? What is refs/meta/git? Never heard
of that one. Does that have to be done while cloning or can an
existing repository be configured? I'm interested in your idea but it
sounds confusing to me.

Thanks for taking the time to brainstorm with me.
