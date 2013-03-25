From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Run git status in the background.
Date: Mon, 25 Mar 2013 14:42:29 +0530
Message-ID: <CALkWK0magR+9BsFRZYYmNAXTvV8Y-6reLOC1YCUm2fCBRrzFNA@mail.gmail.com>
References: <1363868968-19553-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: spearce@spearce.org, git@vger.kernel.org, peff@peff.net,
	pclouds@gmail.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 10:13:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK3Sw-0001gA-5M
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 10:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757755Ab3CYJMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 05:12:50 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43126 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900Ab3CYJMt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 05:12:49 -0400
Received: by mail-ie0-f171.google.com with SMTP id e14so5257909iej.16
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7Vlld5+CpUkaGwVQsT5duu9aD2rgIrOAHsDUJd9a/uw=;
        b=LXvQxlZVA5c/LEMte0XfHyD9XIL3hBCPvE8QlwsNtwmYD+SC6JVn/yAImj/HcAhsBA
         xovzOldMlcl/MT2BLrCVOnQ9iqUJCInge27lsZNZaPEXuUImtoqIuPS7kugILNsVWsIC
         M9LVYNj0z4oe2Q1tkTcvMTBqhLTrqC4HhP77po1dzXhbQaY/NxH3Rj87Cpos86WZr24G
         7qYM7CKN+8gkYmaSb2Mva8LHaor8jJLC2t4A00nrINrp2yn8GI3ilz93Gy5Ory5bim70
         moCzVDPYwgd425tD6Jjz5FNKZq0+MQ9z9FgdLUyQ4n5OtCOwAPZ+X38siZBbCdFGZ52/
         MfzQ==
X-Received: by 10.42.204.79 with SMTP id fl15mr6192136icb.57.1364202769231;
 Mon, 25 Mar 2013 02:12:49 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 25 Mar 2013 02:12:29 -0700 (PDT)
In-Reply-To: <1363868968-19553-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219020>

Fredrik Gustafsson wrote:
> If core.preload is set to a non-zero value, every time a git command is
> executed, git status will be runned in the background if the value of
> core.preload is lower than the number of seconds since last run.

Counting the number of seconds since the last run is gross.  This kind
of setting makes sense in the credential-helper, where you specify how
long to cache your password.  I don't think you should use a
time-based trigger for this feature.

> Please see this thread:
> http://article.gmane.org/gmane.comp.version-control.git/218587
>
> This solution solves many of the problems discussed there, but
> introduces new ones. For example, it does have a bigger impact.
>
> With this solution beeing functional but a bit gross, it's not sure that
> it should be placed here at all. However, it's a good place to place it
> for all git-tools to be able to use it without knowing about it. (It
> would speed up all git wrappers and not just bash-prompt like the
> previous solution).

Yes, but you're proposing including a very gross feature in core git.
I'm sorry, but this is a non-starter.

> There's a few more things to address before shipping this if this is
> considered a good approach. Such as:
>         * Don't run if a "git status"-like git command has been runned. Or a
>           non-repo git command (lite git status or git help) is runned.
>         * Better names for settings and files.
>         * Better(?) invokation of git status (a forked internal call instead
>           of a system call?).
>
> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
> ---
>  git.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

I would argue that git.c is the wrong place to implement this feature.
 You're essentially doing fopen(), fclose(), stat(), and system():
shouldn't this be a shell script?  I earlier suggested making it
something we can hook to chpwd() in zsh, and I think this is the most
sane suggestion.  This is what z() [1] uses, and I would argue that
your feature shares many similarities with it.

[1]: https://github.com/rupa/z
