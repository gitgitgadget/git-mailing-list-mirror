From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/4] git submodule: Fix handling of // and /.. in paths
 for added submodules
Date: Thu, 26 Feb 2009 10:05:16 +0100
Message-ID: <49A65B4C.305@drmicha.warpmail.net>
References: <49A541D3.4030001@viscovery.net> <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-3-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-4-git-send-email-git@drmicha.warpmail.net> <1235568392-19705-5-git-send-email-git@drmicha.warpmail.net> <49A55056.8020504@viscovery.net> <49A556D5.7020806@drmicha.warpmail.net> <49A55DAD.2000309@viscovery.net> <7v1vtm1a6b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Andrei Thorp <garoth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 10:07:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LccCn-0005lf-R6
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 10:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZBZJFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 04:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbZBZJFd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 04:05:33 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33773 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752720AbZBZJF0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 04:05:26 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6B0DE2A5B16;
	Thu, 26 Feb 2009 04:05:24 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Feb 2009 04:05:24 -0500
X-Sasl-enc: gdizg3G1+pfUgEoFrhvMChJzU4c9grB5MwTbFWU5E4Tl 1235639124
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 88902126A0;
	Thu, 26 Feb 2009 04:05:23 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090226 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7v1vtm1a6b.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111541>

Junio C Hamano venit, vidit, dixit 25.02.2009 22:25:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Michael J Gruber schrieb:
>>> Johannes Sixt venit, vidit, dixit 25.02.2009 15:06:
>>>> I think we have so far avoided \+ in sed expressions for portability reasons.
>>> Hmmpf. Is it that new, or gnu specific? I'm always afraid of portability
>>> issues with bash but wasn't aware of sed being an issue as well.
>>>
>>> In any case, would 's|\\*|/|g' be better (more portable) then?
>> You mean 's|//*|/|g'; yes, that is definitly portable.
>>
>>> Well, how is
>>>
>>> echo a/b/c/../../d | sed -e ':start;s|\([^/]*\)/\.\./||g;tstart'
>>> a/d
>>>
>>> I meant: how portable is...
>> I don't know... Let's see: My AIX 4.3.3 sed understands it if it is not
>> all on a single line, and that says a lot. Specifically, I tried this:
>>
>> echo a/b/c/../../d | sed -e ':start
>>              s|\([^/]*\)/\.\./||
>>              tstart
>> '
>>
>> and got the desired result:
>>
>> a/d
>>
>> Note that the 'g' flag is not necessary in this case.
>>
>> OTOH, this sed doesn't understand #comments :-/
> 
> Historically, sed was much worse than the shell when it came to the
> portability issues, especially before people started to use bash, which
> tipped the balance a bit by worsening the situation for the shell side.
> 
> The sed scripts in the more important parts of scripted Porcelains avoid
> multiple commands on a single line concatenated with ";" mostly by inertia
> on my side, but it was acquired exactly from this kind of portability
> mess.  IIRC, AIX's was the worst offender. It also got "/A/../B/ { ... }"
> wrong in earlier versions.

I'm a bit confused now. Are you saying that "git-submodule.sh" should
avoid the multiple lines in sed (which work in AIX 4.3.3)? I don't know
how to simplify a/b/c/../../ easily then. Of course one could loop
around in shell rather than using sed's "goto", but that looks ugly.

I think that's my only question before doing a v3 which will be a good
"cd citizen" in tests and test for more idiosyncracies.

Oh wait: Would it be worthwhile to have that shell version of
normalize_path_copy() in git-sh-setup instead?

Michael
