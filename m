From: Craig Silverstein <csilvers@khanacademy.org>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Tue, 23 Dec 2014 13:51:40 -0800
Message-ID: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
Reply-To: csilvers@khanacademy.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 22:51:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3XMo-00062r-9p
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 22:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbaLWVvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 16:51:42 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:62274 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbaLWVvl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 16:51:41 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so6173965igd.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 13:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:reply-to:date:message-id:subject:from:to:cc
         :content-type;
        bh=nDwzHC+Rx8kGiXSjHPl2/ZT5pgiVZag5GqiOvxP/9dk=;
        b=TxGJn6vO8obcMzkislpgijz1E8VbqvprbUKrGTGmRiscy4E+lzeBxFdrCzSRpfeany
         OZWxfcQm8lgiPtHrEZ7j20hfTSFfh89w3CLh7tYknF2cQ4eD66d2XGz9EGznAwpUA+j1
         CmcwyozufbjaPb99Fubb4ICGh9GfPtg77UVzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:date:message-id:subject
         :from:to:cc:content-type;
        bh=nDwzHC+Rx8kGiXSjHPl2/ZT5pgiVZag5GqiOvxP/9dk=;
        b=RpONbsZQMwjKcZo+w2ERpoYo/CwqG2nq/RI+eAuYOrtNj9M7esnXcfKRbSfnW+JUiJ
         8DJJg5DQKpiYV5tH/JOoUMUUgxne3EMmbp4iSRoZFbpdAgQPEmUxbtl4/2/lguOLfUg2
         TwECHgvHoKXKhhzHS7+UyVFj0yohejv3eHigSiNfBHc2ZA8hB0T5v3APSuWbJsfYJdlm
         uZzglpoIdtaQ7sbWCz99uLElad5GCHWzD597USX0wbnB4iNHoZx6snh30oSu+Kxs3rv9
         U4/2OBVwGPQnh+xP+Dz4xp9kTLq0PacthbHS4OgZd2HROcn/TcHRSWL8SHAgd1+vcjYR
         NNDw==
X-Gm-Message-State: ALoCoQm5Y8hSW5jcZ37SPmORZuVZX9wQERx3trr4KZa18lUhZ/GPqkKUWSqOVu7xukHNKVgB/50R
X-Received: by 10.43.154.138 with SMTP id le10mr23233384icc.50.1419371500618;
 Tue, 23 Dec 2014 13:51:40 -0800 (PST)
Received: by 10.107.7.159 with HTTP; Tue, 23 Dec 2014 13:51:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261778>

[Ack, I forgot to cc myself on the original patch so now I can't reply
to it normally.  Hopefully my workaround doesn't mess up the threading
too badly.]

Junio C Hamano <gitster <at> pobox.com> writes:
>
> Hmmmm, does that mean that the submodule S in the original
> repository O's working tree and its checkout in the secondary
> working tree W created from O using git-new-workdir share the same
> repository location?  More specifically:
>
>     O/.git/                 - original repository
>         O/.git/index            - worktree state in O
>         O/S                     - submodule S's checkout in O
>         O/S/.git                - a gitfile pointing to O/.git/modules/S
>     O/.git/modules/S        - submodule S's repository contents
>         O/.git/modules/S/config - submodule S's config
>
>     W/.git/                 - secondary working tree
>         W/.git/config           - symlink to O/.git/config
>         W/.git/index            - worktree state in W (independent of O)
>     W/S                     - submodule S's checkout in W (independent of O)
>     W/S/.git                - a gitfile pointing to O/.git/modules/S

Right until the last line.  The .git file holds a relative path (at
least, it always does in my experience), so W/S/.git will point to
W/.git/modules/S.

Also, to complete the story, my changes sets the following:

        W/.git/modules/S    - secondary working tree for S
             W/.git/modules/S/config   - symlink to O/.git/modules/S/config
             W/.git/modules/S/index    - worktree state in W's S
(independent of O and O's S)

> Doesn't a submodule checkout keep some state tied to the working
> tree in its repository configuration file?

Do you mean, in 'config' itself?  If so, I don't see it.  (Though it's
possible there are ways to use submodules that do keep working-tree
state in the config file, and we just happen not to use those ways.)
Here's what my webapp/.git/modules/khan-exercises/config looks like:
---
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        worktree = ../../../khan-exercises
[remote "origin"]
        url = http://github.com/Khan/khan-exercises.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
        rebase = true
[submodule "test/qunit"]
        url = https://github.com/jquery/qunit.git
--

The only thing that seems vaguely working-tree related is the
'worktree' field, which is the field that motivated me to set up my
patch the way it is.

> Wouldn't this change
> introduce problems by sharing O/.git/modules/S/config between the
> two checkouts?

It's true that this change does result in sharing that file, so if
that's problematic then you're right.  I'm afraid I don't know all the
things that can go into a submodule config file.

(There are other things I don't know as well, such as: do we see .git
files with 'gitdir: ...' contents only for submodules, or are there
other ways to create them as well?  Are 'gitdir' paths always
relative?  Are there special files in .git (or rather .git/modules/S)
that exist only for submodules and not for 'normal' repos, that we
need to worry about symlinking?  I apologize for not knowing all these
git internals, and hope you guys can help point out any gaps that
affect this patch!)

craig
