From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH] rebase: use reflog to find common base with upstream
Date: Sun, 20 Oct 2013 22:03:29 -0700
Message-ID: <CANiSa6gqGKAyLwwPVoZ_gzN85_06aTCfkdRRscNNZYs7g1rL0A@mail.gmail.com>
References: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Oct 21 07:03:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VY7eR-0004mn-6O
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 07:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab3JUFDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 01:03:31 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:57314 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab3JUFDa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 01:03:30 -0400
Received: by mail-wg0-f48.google.com with SMTP id b13so5980721wgh.15
        for <git@vger.kernel.org>; Sun, 20 Oct 2013 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2FmqCxbCxOEVUUpGC3wkrSEtJsL+TX6Ck9uL4mnqP0w=;
        b=QN+W+5DXnhaxSBpJYL6YsAzj7l9w6qQj3ILAxGOhS2VrPXrPqGCgrhKgqVFKDKEJZi
         BEXLsnow08sOfdhXm4d/8i0S3IOpdDDM3k149lATfSESJ3YtGjf8clgB6gIluVsFYfIs
         /h0C+tzoGvX5NK11XYWIWDD4ZahAFxiRxRZHXuxe0oqpyg3a4pgphg9+XLzarYQz8Lcz
         uZfMWek6mhPQYWQCX7d+oKZqoWf7RqMkff1voMLhTenGSBwY8//fJymfykDxnhT83zWV
         4E+EVP7xuwzBpknI1lFt7CuTkPrv+lX1ub88F/xbNNv8i4rNR72l15EzxtLPD5KrdV4Z
         K39g==
X-Received: by 10.180.10.8 with SMTP id e8mr8025144wib.65.1382331809114; Sun,
 20 Oct 2013 22:03:29 -0700 (PDT)
Received: by 10.180.12.69 with HTTP; Sun, 20 Oct 2013 22:03:29 -0700 (PDT)
In-Reply-To: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236424>

On Wed, Oct 16, 2013 at 11:53 AM, John Keeping <john@keeping.me.uk> wrote:
> Commit 15a147e (rebase: use @{upstream} if no upstream specified,
> 2011-02-09) says:
>
>         Make it default to 'git rebase @{upstream}'. That is also what
>         'git pull [--rebase]' defaults to, so it only makes sense that
>         'git rebase' defaults to the same thing.
>
> but that isn't actually the case.  Since commit d44e712 (pull: support
> rebased upstream + fetch + pull --rebase, 2009-07-19), pull has actually
> chosen the most recent reflog entry which is an ancestor of the current
> branch if it can find one.

It is exactly this inconsistency between "git rebase" and "git pull
--rebase" that confused me enough to make me send my first email to
this list almost 4 years ago [1], so thanks for working on this! I
finished that thread with:

  Would it make sense to teach "git rebase" the same tricks as "git
pull --rebase"?

Then it took me a year before I sent a patch not unlike this one [2].
To summarize, the patch did not get accepted then because it makes
rebase a little slower (or a lot slower in some cases). "git pull
--rebase" is of course at least as slow in the same cases, but because
it often involves connecting to a remote host, people would probably
blame the connection rather than git itself even in those rare (?)
cases.

I think

  git merge-base HEAD $(git rev-list -g "$upstream_name")

is roughly correct and hopefully fast enough. That can lead to too
long a command line, so I was planning on teaching merge-base a
--stdin option, but never got around to it.

Martin


[1] http://thread.gmane.org/gmane.comp.version-control.git/136339
[2] http://thread.gmane.org/gmane.comp.version-control.git/166710
