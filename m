From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git lock files
Date: Wed, 10 Jun 2015 09:32:16 -0700
Message-ID: <xmqqbngnmsmn.fsf@gitster.dls.corp.google.com>
References: <5576F02B.4040002@gmail.com>
	<1433870383-7631-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, kostix+git@007spb.ru, hackerp@suddenlink.net,
	sitaramc@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 18:32:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ivc-0003Mf-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933960AbbFJQc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:32:26 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33685 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933941AbbFJQcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 12:32:19 -0400
Received: by igbpi8 with SMTP id pi8so39545512igb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NCPGKD5MuxY3ZCmXWA4ep/Xuy0GYwAqVfGyXCJl9HhA=;
        b=WNFQ7QUeq0B3ph3aUphxAZ72NuA1BkE/BYlABBpRuSlyb3AVdGwm4SfflpNZ79dSzd
         quY0vq7YgKBJp9ykbYuGmnULkGxcDgUGwaDZKkjXvFk4Cg5J6lxGwrJtPu/WEAu4q2mY
         nc4AkamErLZFq/w0orjpE1JJ2noZaCHtkpgQ7d1FrBQRqSsJeDziuCocKS9pOyKBZrKX
         PM/d4d5A6kEUiNP9ovPNmVhoWEtUwWReTuUwP3OxEu379h1ZO5JVTIYpB5dh15cezLGw
         u/fiKrTAMh1LBXrBTkXFsvxUuYSjcsImFgZ8BRUJcOzf4UziKVI/S8iJoaTRZ4Pov7Ej
         37Yg==
X-Received: by 10.42.85.207 with SMTP id r15mr5844076icl.94.1433953938283;
        Wed, 10 Jun 2015 09:32:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id o19sm3550436igs.18.2015.06.10.09.32.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 09:32:17 -0700 (PDT)
In-Reply-To: <1433870383-7631-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 9 Jun 2015 10:19:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271326>

Stefan Beller <sbeller@google.com> writes:

> I could imagine a "git lock" command which looks like this:
>
>     git config lock.centralServer origin
>     git config lock.defaultBranch master
>
>     git lock add [branch]  [--] <path/to/file>
>     git lock remove [branch] [--] <path/to/file>
>     git lock ls [<branch>]
>
> And the way this is implemented is roughly (unoptimized, just showing
> how you would achieve this with todays command set):
> ...
>     git fetch --depth=1 $(git config --get lock.centralServer) refs/locks/$(git config --get lock.defaultBranch)
>     git checkout refs/locks/$(git config --get lock.centralServer)/$(git config --get lock.defaultBranch)
>     switch(option) {
>     case add:
>         if exist <path/to/file>
>             return -1
>         else
>             echo $(git config --get user.name) $(date) > <path/to/file>
>             git add <path/to/file> && git commit "add new lock"
>         fi
>     case remove:
>         if exist <path/to/file>
>             # todo: check if the same user locked it before
>             rm  <path/to/file>
>         else
>             return -1
>         fi
>     case ls:
>         ls -R .
>     }
>     git push $(git config --get lock.centralServer) refs/locks/$(git config --get lock.defaultBranch)
>     git <restore working tree, branch>
>
> That said you could just manipulate the git objects directly, no need
> to check out to the working dir.
>
> The server would only need to allow pushes to a refs/locks directory and be done.
> the client side would need to have a plumbing command, so you could easily integrate
> a git locking to your application if you don't want to provide a merge driver.

I do not think that would be very useful nor even be a good starting
point, even though I think it is a good tangent to think about how
to improve the support for the centralized workflow.

You cannot afford to force clients keep polling the central server
for the refs/locks/my-branch, if you want a good "everybody relies
on central-server to coordinate" workflow experience.

And even without "file locking", once you start assuming "everybody
relies on central-server to coordinate" workflow (which is common in
corporate settings), you would be better off introducing a mechanism
to push notification from the server side to the clients to improve
support for other things, like "the client watches these branches,
doing a hanging Get or whatever, waiting for the server to notify"
anyway.  The kind of notification that distributed use of Git can do
without.

And once that kind of mechanism is there, "the client is notified
not to touch these paths on this branch", "the client is notified
that it is now OK to touch these paths on this branch after
updating", etc., would be a natural addition.

I highly doubt that exchanging data via the "git fetch" and "git
push" will be a good vehicle to implement such an async notification
mechanism.
