From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Wed, 23 Dec 2015 11:17:57 -0500
Message-ID: <CAPig+cRndwJ-W1Tz8j7Bk8cFxsmDfv+e3xjbosNvON=+fKOVXg@mail.gmail.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
	<1450597819-26278-1-git-send-email-pclouds@gmail.com>
	<xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
	<CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
	<xmqqd1tye4i8.fsf@gitster.mtv.corp.google.com>
	<20151223093700.GA13386@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 17:18:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBm72-0002mX-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 17:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbbLWQR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 11:17:59 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35236 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbbLWQR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 11:17:58 -0500
Received: by mail-vk0-f47.google.com with SMTP id k1so8706929vkb.2
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 08:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DtMV6ZpeIpUmmqbdysuhSd3aIpq/QLbShClsWZsiG90=;
        b=AQloYRMWD9c526pTRMxAor05TmtpxjllCVdO0pCGnr7+48gLkqH+vJ+Gl9vJEzK+5m
         JY5C3mUmoAzbmBffqrgtEqaQ9XKxuyplJtbTfLf4N0y4TY+LsOrf3NDQbu8zcayCPIK5
         Rzh/KjIpvYwCtZ5Sb6wmggxzMqusA8GzJj4fcHWMCk6HVwtoAYfu+FK8fY2nC0d3OnGF
         c+3Gq1L8oQHTVWPWjW93ZH3SWpCF4d1kgBUJ+ycA4g5llyr5Rta8VPc0pjQQqP9fyrKJ
         zMO8q0pKm51X62yUFaLXvWJVWyF07A6rLkVJLDANUauyS8Iav4bw8BkhucX8ygxO0vFF
         s3Bg==
X-Received: by 10.31.128.138 with SMTP id b132mr20433054vkd.14.1450887477720;
 Wed, 23 Dec 2015 08:17:57 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 23 Dec 2015 08:17:57 -0800 (PST)
In-Reply-To: <20151223093700.GA13386@sigill.intra.peff.net>
X-Google-Sender-Auth: k0IKZl2w-mONKaidX5rIMWnrV_Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282949>

On Wed, Dec 23, 2015 at 4:37 AM, Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] avoid SIGPIPE warnings for aliases
>
> When git executes an alias that specifies an external
> command, it will complain if the alias dies due to a signal.
> This is usually a good thing, as signal deaths are
> unexpected. However, SIGPIPE is not unexpected for many
> commands which produce a lot of output; it is intended that
> the user closing the pager would kill them them via SIGPIPE.

s/them them/them/

> As a result, the user might see annoying messages in a
> scenario like this:
>
>   $ cat ~/.gitconfig
>   [alias]
>   lgbase = log --some-options
>   lg = !git lgbase --more-options
>   lg2 = !git lgbase --other-options
>
>   $ git lg -p
>   [user hits 'q' to exit pager]
>   error: git lgbase --more-options died of signal 13
>   fatal: While expanding alias 'lg': 'git lgbase --more-options': Success
>
> Many users won't see this, because we execute the external
> command with the shell, and a POSIX shell will silently
> rewrite the signal-death exit code into 128+signal, and we
> will treat it like a normal exit code. However, this does
> not always happen:
>
>   1. If the sub-command does not have shell metacharacters,
>      we will skip the shell and exec it directly, getting
>      the signal code.
>
>   2. Some shells do not do this rewriting; for example,
>      setting SHELL_PATH set to zsh will reveal this problem.
>
> This patch squelches the message, and lets git exit silently
> (with the same exit code that a shell would use in case of a
> signal).
>
> The first line of the message comes from run-command's
> wait_or_whine. To silence that message, we remain quiet
> anytime we see SIGPIPE.
>
> The second line comes from handle_alias itself. It calls
> die_errno whenever run_command returns a negative value.
> However, only -1 indicates a syscall error where errno has
> something useful (note that it says the useless "success"
> above). Instead, we treat negative returns from run_command
> (except for -1) as a normal code to be passed to exit.
>
> Signed-off-by: Jeff King <peff@peff.net>
