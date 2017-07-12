Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D32202AC
	for <e@80x24.org>; Wed, 12 Jul 2017 08:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933465AbdGLIZE (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 04:25:04 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33207 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933243AbdGLIZC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 04:25:02 -0400
Received: by mail-qk0-f172.google.com with SMTP id v143so13046276qkb.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RL+fHPqP/Ar360BYp28ezrUoQWm96bESqg9qGyv/p7U=;
        b=F42kqoHKlmWRmR2HC50PXiJoPIugPkF4lUEtjIc8O8nBUbLKJpKbqSaD7hZsUgfje2
         zaflS86QPdTTgpHptbPU66y+QICzDtQ3S/8KLJ21mzBlsz6jnf9hOR4eA4GlPl2QGgQd
         9vRPMLrhceoEdoxl1wP4sask79v6HerI/4o4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RL+fHPqP/Ar360BYp28ezrUoQWm96bESqg9qGyv/p7U=;
        b=K4cA0/JNG5G+yMVtHLLm9mpdo28B01/UbaBSJo0nbJok/ffZncMnOzF2/aUBxWtmJM
         txF4XERsfa0OInvXDDNzLv1h22mBfyJmRKhQ2pEginjN4RE49qBX/oP7evslzMJAivoP
         LRPN16qj6rusdBGM6xNjUeWvj3v2chSZi0cUVPml56cR+AqtRW9N7FYKUbJdb/uAUDn4
         pGbwYTz/OIfuEqH266mFOvIAFDHvxyFeSqEYwXk1rBtVyh/4INhSuhK2dQGQvfU2ZlCC
         aZwUnNU54zHH5PkHc8AfreOJPEccXax+XaKWJ2ZxArr5ss6NuVbCoOxvjXWfBNzG6hPH
         wklw==
X-Gm-Message-State: AIVw113J3J0411v732HR9NhXJBreXTVIPv7mrolr4QrbTzHnMcuIs+HW
        LOmeiZRFYNEY6wTgzIZ4lR8plS14wsgr
X-Received: by 10.55.7.139 with SMTP id 133mr4660119qkh.165.1499847901773;
 Wed, 12 Jul 2017 01:25:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.56.170 with HTTP; Wed, 12 Jul 2017 01:25:01 -0700 (PDT)
In-Reply-To: <20170711225316.10608-1-miguel.torroja@gmail.com>
References: <CAE5ih7-Sy9YmGbLs=wzfxXCSFLkEotqLRuu_xNz9x=7BhvrvnA@mail.gmail.com>
 <20170711225316.10608-1-miguel.torroja@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 12 Jul 2017 09:25:01 +0100
Message-ID: <CAE5ih78mrTz1sfJbRSuPTNojxWyH_1JFDY2pe7GMAZdPhzcvpA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Miguel Torroja <miguel.torroja@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 July 2017 at 23:53, Miguel Torroja <miguel.torroja@gmail.com> wrote:
> The option -G of p4 (python marshal output) gives more context about the
> data being output. That's useful when using the command "change -o" as
> we can distinguish between warning/error line and real change description.
>
> Some p4 triggers in the server side generate some warnings when
> executed. Unfortunately those messages are mixed with the output of
> "p4 change -o". Those extra warning lines are reported as {'code':'info'}
> in python marshal output (-G). The real change output is reported as
> {'code':'stat'}
>
> the function p4CmdList accepts a new argument: skip_info. When set to
> True it ignores any 'code':'info' entry (skip_info=True by default).
>
> A new test has been created in t9807-git-p4-submit.sh adding a p4 trigger
> that outputs extra lines with "p4 change -o" and "p4 changes"
>
> Signed-off-by: Miguel Torroja <miguel.torroja@gmail.com>
> ---
>  git-p4.py                | 92 ++++++++++++++++++++++++++++++++----------------
>  t/t9807-git-p4-submit.sh | 30 ++++++++++++++++
>  2 files changed, 92 insertions(+), 30 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 8d151da91..1facf32db 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -509,7 +509,7 @@ def isModeExec(mode):
>  def isModeExecChanged(src_mode, dst_mode):
>      return isModeExec(src_mode) != isModeExec(dst_mode)
>
> -def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
> +def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=True):
>
>      if isinstance(cmd,basestring):
>          cmd = "-G " + cmd
> @@ -545,6 +545,9 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
>      try:
>          while True:
>              entry = marshal.load(p4.stdout)
> +            if skip_info:
> +                if 'code' in entry and entry['code'] == 'info':
> +                    continue
>              if cb is not None:
>                  cb(entry)
>              else:
> @@ -879,8 +882,12 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
>              cmd += ["%s...@%s" % (p, revisionRange)]
>
>          # Insert changes in chronological order
> -        for line in reversed(p4_read_pipe_lines(cmd)):
> -            changes.add(int(line.split(" ")[1]))
> +        for entry in reversed(p4CmdList(cmd)):
> +            if entry.has_key('p4ExitCode'):
> +                die('Error retrieving changes descriptions ({})'.format(entry['p4ExitCode']))
> +            if not entry.has_key('change'):
> +                continue
> +            changes.add(int(entry['change']))
>
>          if not block_size:
>              break
> @@ -1494,7 +1501,7 @@ class P4Submit(Command, P4UserMap):
>          c['User'] = newUser
>          input = marshal.dumps(c)
>
> -        result = p4CmdList("change -f -i", stdin=input)
> +        result = p4CmdList("change -f -i", stdin=input,skip_info=False)

Is there any reason this change sets skip_info to False in this one
place, rather than defaulting to False (the original behavior) and
setting it to True where it's needed?

I worry that there might be other unexpected side effects in places
not covered by the tests.

Thanks
Luke
