From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] trace: add GIT_TRACE_STDIN
Date: Thu, 18 Jun 2015 17:20:13 +0700
Message-ID: <CACsJy8Bh=GAaY0g3+Don5Cop_zAii0MF-y-bEkVP+NSrgKdKAg@mail.gmail.com>
References: <20150616193102.GA15856@peff.net> <20150616193716.GC15931@peff.net>
 <20150616194907.GA15988@peff.net> <20150616212039.GA11353@peff.net>
 <CACsJy8DaJOOu7PA8jL+Mu3HQua-TRmzN378Mek1HuWVmRzT+ww@mail.gmail.com> <20150617191023.GA25304@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Augie Fackler <augie@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 12:21:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5WwE-0003mW-1I
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083AbbFRKUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:20:46 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33482 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbbFRKUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:20:44 -0400
Received: by igbqq3 with SMTP id qq3so11546329igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uX3L3xtpciccfozmlCqzNfygBzAM5ewfTkju1oERe/0=;
        b=hZNuJyKZfdLjiVwlY2gpwrMaZN3yII8lY+gIQ9bTGazr/PLnYDOIGw0kbGdeO9otAP
         lgTvWHE7O30heDXkjeTcmr/bdVHyYsP12uzzAlhx1MCda9Jy8d6hCLC7U/tTzstB6X4N
         F40FyqsEyD0KXi3PI+QVWYQHIYP/f5iX3NRJGlGdCC9jR8MvlXyGG6ZApKDAdn/MEwAg
         uxQtEpccNn3yssxC93BOPhXVqOxDXJ/myjubPkiR6HjxEnBSYa59Z0hJc4GEaspZhPzA
         rwv5HzLu7YwRTb/66CNbwXEo+j1Nu6rtogkQ3fZLO/2ClPc/uysIgrWH5KIyUFH0pGQ9
         Zgbw==
X-Received: by 10.107.15.153 with SMTP id 25mr12146129iop.44.1434622844084;
 Thu, 18 Jun 2015 03:20:44 -0700 (PDT)
Received: by 10.107.6.226 with HTTP; Thu, 18 Jun 2015 03:20:13 -0700 (PDT)
In-Reply-To: <20150617191023.GA25304@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271942>

On Thu, Jun 18, 2015 at 2:10 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 17, 2015 at 05:04:04PM +0700, Duy Nguyen wrote:
>
>> I wonder if we could do it a bit differently. Instead of
>> GIT_TRACE_STDIN, I would add GIT_TRACE_HOOK that points to a script.
>> Whenever a command is run via run-command interface, the actual
>> command line to be executed would be "<hook script> <command>
>> <arguments>".
>
> Hmm, yeah, I like that. It's even more flexible, and it is much more
> obvious why it works only for run-command. If we feed the resulting
> "hooked" command to the shell, I think you could do:
>
>   GIT_TRACE_HOOK='
>     f() {
>       case "$1 $2" in
>       git pack-objects)
>         tee /tmp/foo.out | "$@"
>         ;;
>       esac
>     }; f
>   '
>
> That is not 100% correct (you would miss "git --some-arg pack-objects"),

Yeah, flexibility always comes with traps and pitfalls.

> but it is probably fine in practice for debugging sessions. It is a bit
> more complicated to use, but I really like the flexibility (I can
> imagine that "GIT_TRACE_HOOK=gdbserver localhost:1234" would come in
> handy).
>
>> Because this script is given full command line, it can decide to trace
>> something if the command name is matched (or arguments are matched) or
>> just execute the original command. It's more flexible that trace.*
>> config keys. We also have an opportunity to replace builtin commands,
>> like pack-objects, in command pipeline in fetch or push with something
>> else, to inject errors or whatever. It can be done manually, but it's
>> not easy or convenient.
>
> My other motive for trace.* was that we could have something like
> "trace.prune", and have git-prune provide verbose debugging information.
> We have custom patches like that on GitHub servers, which we've used to
> debug occasional weirdness (e.g., you find that an object is missing
> from a repo, but you have no clue why it went away; was it never there,
> did somebody prune it, did it get dropped from a pack?).
>
> I can send those upstream, but it would be nice not to introduce a
> totally separate tracing facility when trace_* is so close. But it
> needs:
>
>   1. To be enabled by config, not environment.
>
>   2. To support some basic output filename flexibility so the output can
>      be organized (we write the equivalent of GIT_TRACE_FOO to
>      $GIT_DIR/ghlog_foo/YYYY-MM-DD/YYYY-MM-DDTHH:MM:SS.PID).
>
> For (1), we could just load trace.* in git_default_config; you couldn't
> use it with any "early" tracing that happens before then, but I think in
> practice it would be fine for most traces.
>
> For (2), I think we could accomplish that with %-placeholders (like my
> earlier patch), and the ability to write relative paths into $GIT_DIR
> (again, you couldn't do this for "early" traces, but you could for other
> stuff).
>
> Or we could just do nothing. I'm not sure if anybody else is actually
> interested in verbose-logging patches like these.

I'm not stopping you from doing this, just to be clear. I was just
trying to convince you to do something extra that I wanted to use ;)
-- 
Duy
