From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 07 Feb 2011 09:27:14 +0100
Message-ID: <4D4FACE2.4060206@drmicha.warpmail.net>
References: <4D4DEDC4.4080708@hartwork.org>	<20110206051333.GA3458@sigill.intra.peff.net>	<4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>	<7vwrlcv1ea.fsf@alter.siamese.dyndns.org>	<20110207055314.GA5511@sigill.intra.peff.net> <vpqbp2ojq5x.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 07 09:30:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmMUL-000492-FS
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 09:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab1BGIaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 03:30:19 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46478 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752694Ab1BGIaS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 03:30:18 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C54B820AAE;
	Mon,  7 Feb 2011 03:30:17 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 07 Feb 2011 03:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Ni9nuqV8psHPBlLNX4pU8GaAptE=; b=iTe/ZNKi64pUZlZibmWf6j+e3DnD0ktJT3vo/XSnuFRtsfsgLzqtj9dsBOfczqQT6anSuwHYn9AMmucEJHwsrtX4Q6DMOgGMXu3msB3z4jmlYtRukC9yiNZL38GgYD2We2bZ6CHJE9EMQlTVPvuAmA1+sz+nZ3/B1GYGq3Ada/U=
X-Sasl-enc: cCLvE74cSAi1t9OuYKSQjkN0570whpzldqkQlpo5spsf 1297067417
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0396544858C;
	Mon,  7 Feb 2011 03:30:16 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <vpqbp2ojq5x.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166241>

Matthieu Moy venit, vidit, dixit 07.02.2011 07:48:
> Jeff King <peff@peff.net> writes:
> 
>> On Sun, Feb 06, 2011 at 09:50:37PM -0800, Junio C Hamano wrote:
>>
>>> As it takes pathspecs (think "git add -u this-file"), it fundamentally
>>> shouldn't be tree-wide.  I think the original implementation didn't take
>>> pathspecs and was mistakenly done as tree-wide operation, but I think it
>>> was fixed rather quickly.
>>
>> Is "git add -p" broken, then? It takes pathspecs relative to the current
>> directory, but "git add -p" without arguments operates from the root,
>> not from the current subdirectory.
> 
> It's not just "git add -p". Take "git log", "git status", "git
> commit", "git diff" ... well, most Git commands taking pathspecs
> optionally:
> 
> git foo   => tree-wide
> git foo . => the . acts as a path limiter
> 
> and this is the right thing to do. Making "git foo" equivalent to "git
> foo ." makes it hard to recover the tree-wide behavior from a
> subdirectory (git foo ../../../).
> 

First of all, I'd vote for having this work the same way across all
commands - as Junio explained, the destinction we currently have is not
easy to grasp, and is violated by add -p.

Second, we have an established, natural syntax for "base on cwd", namely
".", but we do not have any for "base on worktree root". (I think we
discussed and discarded "/" at some point.)

So, if we go for "relative to cwd by default" we would need a simple way
to specify the root - and by simple I mean taking at most 2 chars in the
pathspec, not a long option!

In summary, I think going for "relative to worktree root by default" is
more in line with git's overall philosophy (so it teaches the right
concept), something the user is exposed to already in most places (but
not all), and limiting to "." already works in most (all?) places, even
with "status" and "status -s". We would only need to change the few
places where we still default to cwd, and make sure they accept "." when
we change their default to repo root.

Cheers,
Michael
