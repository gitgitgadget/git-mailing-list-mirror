From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFC proposal: set git defaults options from config
Date: Mon, 16 May 2011 14:54:14 +0200
Message-ID: <4DD11E76.1010707@drmicha.warpmail.net>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com> <4DCB88C1.20105@drmicha.warpmail.net> <20110512080425.GA11870@sigill.intra.peff.net> <4DCB96F9.2020700@drmicha.warpmail.net> <20110512082210.GA16813@sigill.intra.peff.net> <4DCBF01F.9040009@warpmail.net> <20110516110256.GB23889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Pisoni <dpisoni@gmail.com>,
	GIt Mailing List <git@vger.kernel.org>,
	Git Maintainer <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 14:54:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLxJZ-0000MN-EM
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 14:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab1EPMyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 08:54:18 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36869 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755068Ab1EPMyR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 08:54:17 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EB3CA2091D;
	Mon, 16 May 2011 08:54:16 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 16 May 2011 08:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=h03nedYHIalFfQZJ/uTflC6Je+U=; b=qQdv/GwnTm+3edmloFoHpsDney/mJHEMYsv5PTfNrehWcPlgcToGdPAcOUMdq/Cv3bOjUSf85DlHsrDkQXtv3otl2StfIt32cEA9Ap9MMe4OhqKzgHq2hhMfF88Y7iar6N0PswVhiUiknaWf/auHBWw/z9psfrgeZVkKv5/XA8k=
X-Sasl-enc: Uj8mZhUKc/lo3bk1Zy/Qzfom5NMcsWgMxExORatL9hmr 1305550456
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0B687440FDC;
	Mon, 16 May 2011 08:54:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110516110256.GB23889@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173732>

Jeff King venit, vidit, dixit 16.05.2011 13:02:
> On Thu, May 12, 2011 at 04:35:11PM +0200, Michael J Gruber wrote:
> 
>> Mechanism
>> =========
>>
>> I propose the following mechanism for setting default command line
>> options from the config:
>>
>> options.<cmd> = <value>
>>
>> is a "multivar" in git-config speak, i.e. it can appear multiple times.
>> When running "git <cmd> <opts>", our wrapper executes
>>
>> git <cmd> <values> <opt>
>>
>> where <values> is determined by the following rule in pseudocode:
>>
>> if $GIT_OPTIONS_<cmd> is unset:
>>   <values> := empty
>> else:
>>   for <value> in $(git config --get-all options.cmd):
>>     if <value> matches the regexp in $GIT_OPTIONS_<CMD>:
>>       append <value> to <values>
> 
> As a user, how would I active this for all commands when not running a
> script? I see why you defensively say "if unset, don't enable this
> feature at all".  As a user, should I have to set GIT_OPTIONS_CMD for
> everything that I want to configure? I hope not.

Yeah, sorry, I was a bit dense. I meant to activate it by default and
shut it off from git-sh-setup by default so that scripts are not
affected (but can choose to enable it selevtively).

> I think we need one extra variable to say generally "I am in strict
> plumbing mode" or "I am in user mode". So you would want something like:

> 
>   if $GIT_STRICT is unset:
>     <values> := $(git config --get-all options.cmd)
>   else if $GIT_OPTIONS_<cmd> is unset:
>     <values> := empty
>   else:
>     [match values by regex as you do]
> 
> But then you have a question of when GIT_STRICT gets set. An obvious
> place is to set it in the git wrapper, so that "git foo" will have its
> subcommands properly strict.

Yep.

> But that doesn't help scripts which are not called from the git wrapper;
> they need to set GIT_STRICT themselves, so we need a phase-in period for
> them to do so.

git-sh-setup

The phase-in is still needed for scripts which do use sh-setup, of course.

>> NOTES
>> =====
>>
>> * This can be done by commit_pager_choice() or by a call right after
>> that in those places.
> 
> Ah, so reading this, I have a sense that you were intending to make the
> equivalent of GIT_STRICT be "am I running a pager" (or "am I outputting
> to a terminal)?

As a default for the phase-in-phase I was hoping that would be safe enough.

> Which is somewhat safer, as it is purely something for programs to opt
> into. And as a heuristic, it's mostly good. I can come up with examples
> where a script might not want to allow some options to be passed, even
> though output is to the user, but they are probably stretching (e.g.,
> something like "--allow-textconv" in a script that is meant to restrict
> the users rights).
> 
>> * regexp notation/version to be decided
> 
> I think I would just as soon have a list of allowed options. We're
> hopefully not doing the regex over the value of the option, like
> "--pretty=foo is OK, but --pretty=bar is not". It seems like this
> unnecessarily complicate the common case (you don't care what the value
> is, but you have to tack on (|=.*) to every option matcher), and the
> added flexibility is probably not going to be useful.
> 
> So I expect options regex are just going to look like:
> 
>   --(foo|bar|baz|bleep)
> 
> at which point we might as well just make it a list. And for the sake of
> sanity, we may want to provide some default lists for scripts to OK,
> like some minimal set of rev limiting options or something, so that
> scripts don't end up specifying the same sets over and over.
> 
>> * We should probably do this for long options only (and insert
>> "--<value>" rather than "<value>" to spare the "--" in config).
> 
> Yeah. Anything that doesn't have a long option and is useful enough to
> be used in this way should probably get one.

Agreed!

>> Taking cover...
> 
> I dunno. It's not so bad. But I think we probably want to start with an
> environment variable to say "I am a script, be strict", let scripts
> start picking that up, and then phase in the ability to turn on options
> selectively.

GIT_BE_STRICT_I_AM_BRITISH

Michael
