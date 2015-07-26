From: Paul Tan <pyokagan@gmail.com>
Subject: Re: "git am" and then "git am -3" regression?
Date: Sun, 26 Jul 2015 13:03:59 +0800
Message-ID: <CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
	<20150724180921.GA17730@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 07:04:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJE6l-00084J-7r
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 07:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbbGZFED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 01:04:03 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36596 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbbGZFEB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 01:04:01 -0400
Received: by wicgb10 with SMTP id gb10so71616487wic.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 22:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5Gl/l9AsKclwuYZyRY/PrWfFSkIPwsp8vSBJHaQLXp8=;
        b=tdTna3TckoF+3gXnpJranJGImuuQdUC2+DwBud3bsqsJ4xVq1KhcENZfCqSyEMl22l
         MKjB9Mr08lW//vP+zsQmc99PwEWd9fntOxOlI0Tg8YdAUhNL0qaCTUmdimVTQZY8sBgq
         pBQG5OKDcTCzqey8HZ4toLXW/p2CgnEsyeVnvQ9qM0VZAYL5aC5yxfdScgGipecbVYlV
         2AZpWshOQLiVM8FYRUVmb6tAGvC+vkiLVQ51yier2IbikfwSLiRBsBXAzg/jM2eTBY3f
         m6d8TMxKQpi44zNkqU6ikRy9382ZHPfJLHlvEfhnl6Fu0l1/bambKSR0K2zymd1zzCzs
         eUpg==
X-Received: by 10.194.77.97 with SMTP id r1mr40257012wjw.98.1437887039864;
 Sat, 25 Jul 2015 22:03:59 -0700 (PDT)
Received: by 10.194.85.82 with HTTP; Sat, 25 Jul 2015 22:03:59 -0700 (PDT)
In-Reply-To: <20150724180921.GA17730@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274631>

On Sat, Jul 25, 2015 at 2:09 AM, Jeff King <peff@peff.net> wrote:
> Yeah, I think this hunk is to blame (though I just read the code and did not
> test):
>
> @@ -658,6 +665,8 @@ fi
>  if test "$(cat "$dotest/threeway")" = t
>  then
>         threeway=t
> +else
> +       threeway=f
>  fi
>
> It comes after the command-line option parsing, so it overrides our option (I
> think that running "git am -3" followed by "git am --no-3way" would have the
> same problem). It cannot just check whether $threeway is unset, though, as it
> may have come from the config.

Thanks for the detailed analysis, I completely agree. Note that the
code that handles the --message-id option somewhat handles the case
where $messageid is unset:

case "$(cat "$dotest/messageid")" in
t)
    messageid=-m ;;
f)
    messageid= ;;
esac

However, it still does not handle "git am --no-message-id" followed by
"git am --message-id", or "git -c am.messageid=true am" followed by
"git am --no-message-id". I think the same thing occurs for
--scissors/--no-scissors, as well as the git-apply options as well.

The real problem is that the state directory loading code comes after
the config loading and option parsing code, and thus overrides any
variables set.

> We'd need a separate variable, the way the code
> is ordered now.

If we are just fixing --3way, adding one extra variable won't be that
bad. However, I think that if we are using this approach to fix all of
the options, then it would introduce too much code complexity.

> Ideally the code would just be ordered as:
>
>   - load config from git-config
>
>   - override that with defaults inherited from a previous run
>
>   - override that with command-line parsing

So I'm more in favor of this solution. It's feels much more natural to
me, rather than attempting to workaround the existing code structure.

> but I don't know if there are other ordering gotchas that would break.

For the C code, there won't be any problem, but yeah, fixing it in
git-am.sh might need a bit more effort.

> It does look like that is how Paul's builtin/am.c does it, which makes
> me think it might not be broken. It's also possibly I've horribly
> misdiagnosed the bug. ;)

Nah, it follows the same structure as git-am.sh and so will exhibit
the same behavior. It currently does something like this:

1. am_state_init() (config settings are loaded)
2. parse_options()
3. if (am_in_progress()) am_load(); else am_setup();

So it would be quite trivial to change the control flow such that it is:

1. am_state_init()
2. if (am_in_progress()) am_load()
3. parse_options();
4 if (!am_in_progress()) am_setup()

The next question is, should any options set on the command-line
affect subsequent invocations? If yes, then the control flow will be
like:

1. am_state_init();
2. if (am_in_progress()) am_load();
3. parse_options();
4. if (am_in_progress()) am_save_opts(); else am_setup();

where am_save_opts() will write the updated variables back to the
state directory. What do you think?

Since the builtin-am series is in 'next' already, and the fix in C is
straightforward, to save time and effort I'm wondering if we could
just do "am.threeWay patch -> builtin-am series -> bugfix patch in C".
My university term is starting soon so I may not have so much time,
but I'll see what I can do :-/

Junio, how do you want to proceed?

Thanks,
Paul
