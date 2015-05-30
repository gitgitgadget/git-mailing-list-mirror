From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 00/14] Make git-pull a builtin
Date: Sat, 30 May 2015 15:29:58 +0800
Message-ID: <CACRoPnThv97e+f3ymuRCFB_u7_dbcOUcCtxUh6BmwDcUZMPjmA@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<xmqqh9r9bsji.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 30 09:30:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YybDl-0007t2-AM
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 09:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbbE3HaC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 03:30:02 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:33516 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbbE3HaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 03:30:00 -0400
Received: by labpy14 with SMTP id py14so58582499lab.0
        for <git@vger.kernel.org>; Sat, 30 May 2015 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tZYoFvVXF8Ve8zKEig90KI2ptZX1dvMuxVnuhA0mRUE=;
        b=ukXGWNXn0/I6kHkoU/BEzJxG1oP8Xea1fnahpPki5g6bu/FuK3BDrSfQdX8dRF3sBn
         66qihRKU5P7QFgL84O58rSuucrEolNIMQgp4mVdr9X1MudM/mXURvd3Vl0bhJDuz5v03
         7/rmk4Dtx8lAuSPriL8EUqCu1oPV4fs+MLageXs9K2lc3ynZgjgueKxEcAzgwX/HUAlQ
         EmDQi8qLQ6oYjVae2XmM9tn05OTxeCJdcD++PeP22fMiaX2vu/+7M6h4sVzlYw8K5lw8
         7V30LWS+iqfqAWkR7wLMsh625f2zRxuoAEDTWvSCCOx9njQtMcm9yB2yfknBBbjsKSSo
         VzuQ==
X-Received: by 10.152.2.38 with SMTP id 6mr2703026lar.80.1432970998822; Sat,
 30 May 2015 00:29:58 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sat, 30 May 2015 00:29:58 -0700 (PDT)
In-Reply-To: <xmqqh9r9bsji.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270281>

Hi,

On Tue, May 19, 2015 at 3:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> This series rewrites git-pull.sh into a C builtin, thus improving its
>> performance and portability. It is part of my GSoC project to rewrite git-pull
>> and git-am into builtins[2].
>
> Earlier you were worried about 'git pull' being used in many tests
> for the purpose of testing other parts of the system and not testing
> 'pull' itself.  For a program as complex as 'git pull', you may want
> to take the 'competing implementations' approach.
>
> (1) write an empty cmd_pull() that relaunches "git pull" scripted
>     porcelain from the $GIT_EXEC_PATH with given parameters, and
>     wire all the necessary bits to git.c.
>
> (2) enhance cmd_pull() a bit by bit, but keep something like this
>
>         if (getenv(GIT_USE_BUILTIN_PULL)) {
>                 /* original run_command("git-pull.sh") code */
>                 exit $?
>         }
>
>         ... your "C" version ...
>
> (3) add "GIT_USE_BUILTIN_PULL=Yes; export GIT_USE_BUILTIN_PULL" at
>     the beginning of "t55??" test scripts (but not others that rely
>     on working pull and that are not interested in catching bugs in
>     pull).
>
> (4) once cmd_pull() becomes fully operational, drop (3) and also the
>     conditional one you added in (2), and retire the environment
>     variable.  Retire the git-pull.sh script to contrib/examples/
>     boneyard.
>
> That way, you will always have a reference you can use throughout
> the development.
>
> Just a suggestion, not a requirement.

Okay, I'm trying this out in the next re-roll. I do agree that this
patch series should not touch anything in t/ at all.

One problem(?) is that putting builtins/pull.o in the BUILTIN_OBJS and
leaving git-pull.sh in SCRIPT_SH in the Makefile will generate 2
targets to ./git-pull (they will clobber each other). For GNU Make,
the last defined target will win, so in this case it just happens that
git-pull.sh will win because the build targets for the shell scripts
are defined after the build targets for the builtins, so this works in
our favor I guess.

Regards,
Paul
