From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add two grep config options
Date: Mon, 28 Mar 2011 14:00:58 +0200
Message-ID: <4D90787A.8010403@drmicha.warpmail.net>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com> <7vlj024wal.fsf@alter.siamese.dyndns.org> <4D9037AA.9090601@drmicha.warpmail.net> <20110328115421.GA9232@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 14:04:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4BBa-0000vC-GE
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 14:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab1C1MEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 08:04:36 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37216 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753589Ab1C1MEg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 08:04:36 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5BFB220769;
	Mon, 28 Mar 2011 08:04:35 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 28 Mar 2011 08:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=zFKuQGfoYKDPU/l++/0W8R6/maI=; b=ER3U6l8cNv44JLo0c6CnhLzEhCBBB9cjyyNcD9Y/sk8a4Bcnt7DfDwDqPbOsNXHye6KuAkYvRyh++awVX6+a0jGj8wqq5YY9AQ+5J34SC0Pv33epdgyDo7pmI6vEea1+/wrAvDZWqQDe0+Tms1VEk3PenKUpQXPx6BwGGdWJSGY=
X-Sasl-enc: sdfleZ892/ZnyRqWd4yfdIsmmuvKJY9iXS2begzbYocS 1301313875
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 870E5403DDA;
	Mon, 28 Mar 2011 08:04:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110328115421.GA9232@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170117>

Jeff King venit, vidit, dixit 28.03.2011 13:54:
> On Mon, Mar 28, 2011 at 09:24:26AM +0200, Michael J Gruber wrote:
> 
>>>  - This will break scripts people have written, knowing that they can rely
>>>    on "grep" they wrote without giving "-E" from their command line will
>>>    use BRE, and force them to update the script with --no-extended-regexp
>>>    for no good reason.  Worse yet, there isn't even --no-line-numbers
>>>    supported to defeat grep.linenumbers configuration to protect such
>>>    scripts.
>>>
>>>    I understand that some people would feel that the convenience would
>>>    outweigh the risk of script breakage in this particular case, and I am
>>>    sympathetic to the cause, but I still have to point it out.  Is there
>>>    anything we can do to mitigate the risk somehow?
>>
>> This comes up again and again, and I feel that rather than adding config
>> options one by one, we should either allow aliases for standard commands
>> and/or setting default options depending on the mode (ui use vs.
>> scripting use), so to say a companion to "git -c n=v" which allows
>>
>> git config ui.grep "-E -n"
>>
>> I.e. just like "git -c n=v <cmd>" sets up pseudo config before running
>> cmd, our wrapper could augment argv from "ui.<cmd>".
>>
>> We could safeguard scripts from this by
>>
>> - checking istty and
>> - checking env for GIT_PLUMBING
>>
>> and setting the latter in git-sh-setup.sh. After a long migration phase,
>> we could skip the first (fragile) check.
> 
> I like the idea of a GIT_PLUMBING variable. It is something that has
> come up as a solution to similar problems many times in the past, but it
> never ends up getting implemented, because it never solves the problem
> at hand. It is something that we would introduce now, and would solve
> problems several versions down the road, after people adjusted their
> scripts. So nobody ends up doing it.
> 
> And probably we would want something like --no-plumbing to switch back
> to porcelain mode for a specific command.  Because often scripts do a
> bunch of work, and then want to show the user their output in their
> favorite format.  Something like:
> 
>   . git-sh-setup ;# or manually GIT_PLUMBING=1
>   # get list of "interesting" files containing some pattern
>   files=`git grep -le "$1"`
>   # and then show them
>   git --no-plumbing log $files
> 
> One shortcoming of such a scheme, though, is that it is an
> all-or-nothing proposal; a script has no way to say "it's OK to take the
> user's default for _this_ option, but not for others". For example, in
> the script above, it would make sense for the grep call to respect the
> user's choice of "-E". So it is tempting to use --no-plumbing there,
> too. But we don't necessarily want to respect whatever cruft the user
> put into ui.grep, because we care what the output looks like (something
> like "-O" would not be helpful).
> 
> So what we really want is to let the script "allow" certain options from
> the user's preferences. This could be done easily with individual config
> options, like:
> 
>   git --allow=grep.extended grep ...
> 
> where the config code would respect a variable if GIT_PLUMBING is unset,
> or if the key is in the allowed list. You could probably also adapt it
> to something like:
> 
>   git --allow="-E --foo" grep ...
> 
> which would allow "-E" and "--foo" in ui.grep, but nothing else.
> 
> Now, obviously my script is a toy (it's not a real script I use). In
> particular, "-O" would probably be suppressed by the lack of a tty,
> anyway. But:
> 
>   1. I used a toy to have something readable. Look at something more
>      complex, like "git pull". It calls "git merge". Should it be
>      respecting "-n" and "--log" from the user's config? Probably.
>      Should it respect "--no-ff" or "-s"? I'm not sure. And there are
>      lots more examples just in the git.git scripts.
> 
>   2. It's not just about safeguarding versus the current set of grep
>      options. It's about safeguarding the script against any _future_
>      options that don't exist yet.
> 
>   3. This might be overengineering a little bit. Most invocations
>      probably do fall into either the "run command to get its output"
>      category (where you want pure plumbing) or the "run command to show
>      things to the user" category (where you will take whatever options
>      the user wants). But because the deployment of whatever scheme is
>      chosen is going to be so annoying (because it will take many
>      versions before we're clear to assume that people are setting
>      GIT_PLUMBING), I would rather over-engineer than find out 2 years
>      into the process that the flexibility we provide is not sufficient
>      and have to start again.
> 
>> We could safeguard scripts from this by
>>
>> - checking istty and
>> - checking env for GIT_PLUMBING
> 
> I'm not sure isatty is a good check. In the example above, grep's output
> was not going to a tty, but I did want to respect the user's choice of
> "-E".

I'm not saying it's good either, but it is something that a new git
(i.e. between the time we introduce ui.* and GIT_PLUMBING/--no-plum and
the time we rely on the latter) could do to make use of (and promote)
the new ui.* options.

Michael
