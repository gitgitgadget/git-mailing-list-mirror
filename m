From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 2/2] git submodule: Fix adding of submodules at paths
 with ./, .. and //
Date: Tue, 03 Mar 2009 16:48:41 +0100
Message-ID: <49AD5159.8060605@drmicha.warpmail.net>
References: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org> <1236083989-20526-1-git-send-email-git@drmicha.warpmail.net> <1236083989-20526-2-git-send-email-git@drmicha.warpmail.net> <1236083989-20526-3-git-send-email-git@drmicha.warpmail.net> <49AD2BE6.1000105@viscovery.net> <7v3aduehz2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Andrei Thorp <garoth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 16:50:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWsx-0006JX-Ka
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbZCCPsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 10:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757278AbZCCPsz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:48:55 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42105 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757212AbZCCPsw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 10:48:52 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 709E42D3AD8;
	Tue,  3 Mar 2009 10:48:50 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 03 Mar 2009 10:48:50 -0500
X-Sasl-enc: gq++L/x8UciBfvBss6T/OUUDnuG7YzFHxBE0liH8etVc 1236095330
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 85BC435D0B;
	Tue,  3 Mar 2009 10:48:49 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090303 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7v3aduehz2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112092>

Junio C Hamano venit, vidit, dixit 03.03.2009 16:36:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> Michael J Gruber schrieb:
>>> +	# normalize path:
>>> +	# multiple //; leading ./; /./; /../; trailing /
>>> +	path=$(printf '%s/\n' "$path" |
>>> +		sed -e '
>>> +			s|//*|/|g
>>> +			s|^\(\./\)*||
>>> +			s|/\./|/|g
>>> +			:start
>>> +			s|\([^/]*\)/\.\./||g
>> Sorry to say: not yet. This turns "a/b/c/d/../../../d" into "a/b/c/d"
>> instead of "a/d". Drop the 'g'.
>>
>> Once this is fixed, I have to ask what should happen with path names like
>> "../a/b", "../../a/b"? Should there be a warning or error?
>>
>> Other than that, this expression works on AIX 4.3.3! Note in particular
>> that '\n' in the printf format string is essential!
>>
>>> +			tstart
>>> +			s|/*$||
>>> +		')
> 
> At some point you should wonder if all of this complication is worth it,
> or it makes sense to reject when you see // or /\.\./ in the input.

I surely do wonder now! This started off treating merely leading ./ as
reported problematic by AT. Then the "do it really right" competition
started, and I think J6t and I came out as clear winners. There were no
other contenders.

Seriously, "git submodule init" does that normalization (by using
ls-files), so I think it does make sense to have it for add as well. git
submodule itself may have semi-porc/semi-plumb character, but if someone
wants to add submodules programmatically there is no simple way around
using "git submodule add", and paths may very well be constructed
relatively.

Michael
