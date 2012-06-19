From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 14:58:38 -0700
Message-ID: <7vsjdrx8tt.fsf@alter.siamese.dyndns.org>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
 <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com>
 <7vmx402rru.fsf@alter.siamese.dyndns.org> <4FE08797.50509@xiplink.com>
 <7vipen191a.fsf@alter.siamese.dyndns.org>
 <20120619201259.GB14692@sigill.intra.peff.net> <4FE0F267.5070803@xiplink.com>
 <20120619214646.GA22436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:58:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh6Rh-0006fU-SO
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab2FSV6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:58:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754994Ab2FSV6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:58:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90F8F8B58;
	Tue, 19 Jun 2012 17:58:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CQ9TzixChGppYKwRWAvlGGNG8fw=; b=HM4zDR
	iE3A+X95oDzEs/BupIvr9F6JHDI6g4Ytpst1huymVFXwnZNurKshRHE6+Ffu6fhn
	M+tyH4v8+OZxwNgzuUGC3WIA8pPmlTOZv2CsHfIRbnNei1SJ0Iw4l9N2/DvfX2ox
	3YXuLZlDbMr0R6WzAgQtoxYBXLCXIOcloVXZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bu0//AA9Kkn+YwnP2Go5srpGie4jNbnx
	Q24iXfwNqaB+YtL33HuxqVS/QozSZV8jDbgJZinPNtm37wYiYfcuzuwEMMwjhBwt
	SRnjZjGUDyP7UXwHkrxkC7RCBmHlM9V1Nq4PDvlEdDg0/sFI5Vn0X8E5FBq1QIx2
	rlRdrrF7o2A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85B388B57;
	Tue, 19 Jun 2012 17:58:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BCAE8B55; Tue, 19 Jun 2012
 17:58:40 -0400 (EDT)
In-Reply-To: <20120619214646.GA22436@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jun 2012 17:46:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDBCC1CE-BA59-11E1-843B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200257>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 19, 2012 at 05:43:03PM -0400, Marc Branchaud wrote:
>
>> I suggest git would be better off changing the way it finds the default
>> remote to:
>> 
>> 	Use the currently checked-out branch's remote;
>> 	or Use the remote specified in the original clone command[*];
>> 	or use "origin".
>> 
>> [*] With some strong mechanism for identifying this remote.
>
> Yes, that sounds like a much saner path. I think your [*] is just
> "record the different name in remote.default during the clone".
>
> Then we continue to use "origin" when that is not set (so existing repos
> without "-o" see no change at all). New repos cloned with "-o" would be
> fixed. Old repos cloned with "-o" are still broken, but there is at
> least a simple one-time workaround ("git config remote.default foo").

Yeah, I can certainly buy that.
