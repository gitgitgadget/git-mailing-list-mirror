From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Fri, 21 Nov 2014 10:31:16 -0800
Message-ID: <xmqq1tow1k3v.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<546F0284.7050904@alum.mit.edu> <546F033F.7030201@alum.mit.edu>
	<xmqqa93k1m3g.fsf@gitster.dls.corp.google.com>
	<20141121175446.GA26650@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 19:31:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrszQ-0000kd-P7
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 19:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbaKUSbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 13:31:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751913AbaKUSbU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 13:31:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE9A12007C;
	Fri, 21 Nov 2014 13:31:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6T7HHG4/kbcb7LVx/brmQwRybLE=; b=YmCY6W
	3nPCzo0xLvJ/Xqu+1r7aMXErsRRDJBes7E+SHV2UmNEnfowF9y1UmNgyknj+z2kl
	L9A3/xLw4e9oP9TdXAIIm+Edb3dEXyDC1fP8Ujy5XfQ/P9GAjDKbnve4/l8z+nwp
	RbC00e6cwUJR2+lxeI40vba9bJkFH1T/AgP8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EAi2g/Mk9q7SaKkAMniFpbbQjOItJn/L
	x9H/WDloT5cg386EdXFwPFeVGFheKdZFdbl/dJ23PmIIo60h/AYtzDxGm5fewf38
	mK/u/g6XqR0HthBh4bdUFZ7kl7xiHFT7bASIH9sQ11dHPh2JsP6woXE07/7pDDVH
	7ZPkrlYDZ/E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C55442007B;
	Fri, 21 Nov 2014 13:31:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E9052007A;
	Fri, 21 Nov 2014 13:31:18 -0500 (EST)
In-Reply-To: <20141121175446.GA26650@peff.net> (Jeff King's message of "Fri,
	21 Nov 2014 12:54:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 95665064-71AC-11E4-9FE8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 21, 2014 at 09:48:19AM -0800, Junio C Hamano wrote:
>
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>> > On 11/21/2014 10:14 AM, Michael Haggerty wrote:
>> >> Couldn't we save ourselves a lot of this "save_errno" boilerplate by
>> >> making error() and warning() preserve errno? [...]
>> >
>> > Never mind; I see that Peff already submitted a patch to this effect.
>> 
>> My understanding of the conclusion of those four patches was that
>> only a single updated one is needed, and "moving save/restore inside
>> error()" did not have to survive.
>> 
>>   http://article.gmane.org/gmane.comp.version-control.git/259911
>
> Yeah, the callsite I had intended ended up needing to save it across
> more than just error(). And I think that is probably why we have never
> done any errno-handling inside error() before (it is certainly not the
> first time I thought of doing such a thing): real-world cases tend to be
> a little more complicated.
>
> That being said, if this copy() case is one that could benefit, I do not
> have any problem with picking up (or just reusing the concept of) my
> 1/4 from that series. It probably does not _hurt_ anything, and if it
> can help in even a few cases, it may be worth it.

Yeah, I agree.  My summary was "did not have to survive", not "had
to die".  Like you, I do not mind the change as long as other code
paths benefit from it.
