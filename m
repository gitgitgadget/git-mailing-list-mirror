From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 11/19] pull: check if in unresolved merge state
Date: Sun, 14 Jun 2015 15:44:59 +0800
Message-ID: <CACRoPnTVXCGs6gwYxPLZfD-jK3qfjVzXhNSArsO-JA+a406SHg@mail.gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-12-git-send-email-pyokagan@gmail.com>
	<xmqqsia0uzaa.fsf@gitster.dls.corp.google.com>
	<xmqqr3pjocgm.fsf@gitster.dls.corp.google.com>
	<CACRoPnSQd_YEp4mNFbqDZtBJGztkHLXWbDojcAJRNvpynFRCew@mail.gmail.com>
	<xmqq381zmqon.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 09:45:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z42bU-0007yQ-V8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 09:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbbFNHpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 03:45:03 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35686 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbbFNHpB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 03:45:01 -0400
Received: by lbbtu8 with SMTP id tu8so37576470lbb.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gai/rWuZh2l8Pxy+ZqjJx8jbGu8gRQ729y+LYrwhyAI=;
        b=N/tsyga5uIs8WBLLXF8SUYnin14QaDPGkSL+wzE7oA8iqWlVUhYXM1RSJaOZEYizsp
         +DurguDAuOsrvxH1BBK52fqZsInkL0o0SBctu9+tvKu5J2OWyA1+1Biza7jNzZVvrExW
         +5CS2jZ0VskxHl/Hpcat9OOmUmjjvcU32m+38nhLgGPV+nG+lBHRd7dMUi9oaE/R35sj
         eFlgwcxAnfc4mVpaKHvN0SyD8NPs5ArQItOhWVUkGuwup74uOcbzCwOpRZjTMSosePFY
         zfguz6pMBcZKOXzOFFI8OlhGTcTZwDMYLVQOCBJsXap+P6/Z2SdWRlLm0dj/7rYL0pXQ
         UoBw==
X-Received: by 10.152.6.105 with SMTP id z9mr21688851laz.98.1434267899458;
 Sun, 14 Jun 2015 00:44:59 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sun, 14 Jun 2015 00:44:59 -0700 (PDT)
In-Reply-To: <xmqq381zmqon.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271608>

On Thu, Jun 11, 2015 at 1:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I (or at least some part of me) actually view git_config_get_*() as
> "if you are only going to peek a few variables, you do not have to
> do the looping yourself" convenience, which leads me (or at least
> that part of me) to say "if you are doing the looping anyway, you
> may be better off picking up the variables you care about yourself
> in that loop".

Not just a convenience, but I personally find that callback functions
usually leads to code that is harder to understand because of the use
of static/global variables to preserve state and the fact that it is
harder to break it up into smaller functions to reason about. This is
just a matter of taste though, so I don't have strong feelings about
it.

Besides, there is a greater technical reason why we should not use
git_config(): It essentially performs a linear search[1], while the
git_config_get_*() functions do a constant-time lookup. Ideally, we
should remove uses of git_config() for users that have no need to
iterate over all the configuration entries.

[1] Since we do a strcmp() for every supported config setting, for
every config entry.

I should emphasize that the call to git_config(git_default_config,
NULL) is just a workaround to load the advice.* settings. In fact,
git_default_config() only peeks at a few config settings anyway, and
can be re-written to not iterate over all the user's config entries.
As such, I don't see why the builtin/pull.c code should be written to
support the git_config() way of doing things, even if we have to use
the workaround of calling git_config(). It's like saying: we have a
bad solution, now let's make it worse ;-)

> By calling git_config() before calling any git_config_get_*()
> functions, you would be priming the cache layer with the entire
> contents of the configuration files anyway, so later calls to
> git_config_get_*() will read from that cache, so there is no
> performance penalty in mixing the two methods to access
> configuration data.  That is why I felt less certain that the
> suggestion to stick to one method (instead of mixing the two) is a
> good thing to do (hence "less certain 'might'").

Right, although I think that the performance penalty due to using
git_config() is greater, and switching all the git_config_get_*()
calls to use it would just make it worse.

By the way, I got the idea that git development was moving towards
replacing use of git_config() from 5801d3b (builtin/gc.c: replace
`git_config()` with `git_config_get_*()` family, 2014-08-07).

Thanks,
Paul
