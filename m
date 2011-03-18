From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFD 0/2] revision.c: --merges, --no-merges and --merges-only
Date: Fri, 18 Mar 2011 08:56:51 +0100
Message-ID: <4D831043.1060709@drmicha.warpmail.net>
References: <cover.1300359256.git.git@drmicha.warpmail.net> <20110317195905.GG20508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 18 09:00:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Ubs-0001cr-HL
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 09:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab1CRIAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 04:00:31 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60653 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753812Ab1CRIA3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 04:00:29 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7FC2820CB5;
	Fri, 18 Mar 2011 04:00:28 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 18 Mar 2011 04:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LKAOTit+e2re1EVroMEl5Z88//A=; b=HVdADCj16Nda7wVdMCMT5YcR7Bc03og15jWy4nGECwK496BT1Ps+P+52iY9/v016TtZf2XCSa9LJN8GDxwxvZ4623eEQFlTjWZxaviytxVGIQz1Lm40CO6yixhGHEYmoftaKQ9iEEtwaeGs7T/Yogc/jbtiEouaU+1oisZGzVjA=
X-Sasl-enc: dhMPVxisU0BkBsOKRfb3tJOrykZ3z0akD/blTDCTLgv2 1300435228
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D0F04441BB9;
	Fri, 18 Mar 2011 04:00:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110317195905.GG20508@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169299>

Jeff King venit, vidit, dixit 17.03.2011 20:59:
> On Thu, Mar 17, 2011 at 12:33:56PM +0100, Michael J Gruber wrote:
> 
>> This mini series makes it so that --no-merges undoes --merges
>> and vice versa, as the user should be able to expect,
>> and that --merges-only is a separate option.
> 
> Having recently been confused by this (and frustrated at the lack of an
> equivalent to your new "--merges"), I do think the result is better.
> 
> However, this is totally changing the meaning of an option to plumbing
> like rev-list (among others). Is it worth the breakage? If so, what's
> the migration plan? Did I miss a discussion somewhere?

You missed only the "D" in RFD :)

The meaning of a plumbing option can't be changed light-heartedly, of
course. OTOH, the current design is *really bad* from the ui point of
view. The expectation that

"cmd --no-foo --foo" is eq. to "cmd --foo"

and

"cmd --foo --no-foo" is eq. to "cmd --no-foo"

should be valid universally. In the long run, we might even try and
convert revision.c to parse_options, thereby gaining --no-foo for every
--foo.

So, my RFD really consists of two things:

- provide a way to override --no-merges/no_merges
- sane naming

The first step + half of the second could be achieved by:

- provide "--merges-also" which does "no_merges = 0"
- provide "--merges-only" which does "merges_only = 1", i.e. an alias
for current "--merges"

"--merges-also --no-merges" would be "--no-merges" and vice versa.
"--merges-also --merges-only" would be "--merges-only"
"--merges-only --merges-also" would be "--merges-only"
which all make sense sematically

"--merges-only --no-merges" would be no commits with the current
implementation (just like "--merges --no-merges"), but we could catch
this case easily and make it do "--no-merges".

I don't think we need to care about keeping the current behavior of
"--merges --no-merges", do we?

So, no breakage here. Along with it we could issue deprecation notices
in doc and relnotes for "--merges" or just make them less visible. That
is, it would serve the same purpose as Junio's tri-state option.

In 2.0 or so, we could change "--merges" to be an alias for
"--merges-also" rather than "--merges-only" (but don't have to).

>From the ui perspective I'm somehow not a big fan of tri-state options
but can't give hard reasons why; maybe because they force you to use
option arguments. Also, the only reasonable name for a tri-state option
would be "--merges". Can a tri-state have a default? Then we could
default "--merges" to the current behavior, i.e. "--merges=only"
(assuming we have "--merges=only/also/no").

Junio: Sorry for making you explain "D" more rather than doing it myself
upfront.

Michael
