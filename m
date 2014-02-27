From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fetch: handle overlaping refspecs on --prune
Date: Thu, 27 Feb 2014 12:19:44 -0800
Message-ID: <xmqqob1sxq8v.fsf@gitster.dls.corp.google.com>
References: <1393491610-19476-1-git-send-email-cmn@elego.de>
	<1393491610-19476-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Feb 27 21:20:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ7R8-0001yW-Of
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 21:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbaB0UTv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 15:19:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57234 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbaB0UTu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 15:19:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26B627070A;
	Thu, 27 Feb 2014 15:19:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LAJwepjNST40
	cwYtPo59rbBPFpQ=; b=p5lXHC/CzEGYuQOQArVrUl9dWi/iXG2a3JCpoO9zQNMY
	VfvT+LAMbzMEdSigwOd4O3S/hojxdmFShvYyRx/PH4/aZHtB1+3BP0IAjTFIiTIX
	Sth7NOXTl6Qak0xmR2NTguQW8TN5JkSRZvs3avO+t++kvzoH1jFigEAXM7OKPjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pdziX8
	kyCrfn6l/gLhtaXcPAdRI4YiKV7/oqpmss/VmfdkekojeouOCRRxy9izxgtz2VXx
	gKGf9mxNGE+xRPmMyn4x6qY6tHHCQMxOWduM9vYmgiWdKihW/t7wZwM9ec9dp/A/
	muvKYNS9dit5n0ncDTg2lu4dyfuc2tnBRV0wg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 041C870707;
	Thu, 27 Feb 2014 15:19:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74400706FC;
	Thu, 27 Feb 2014 15:19:48 -0500 (EST)
In-Reply-To: <1393491610-19476-2-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Thu, 27 Feb 2014 10:00:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 817E23A2-9FEC-11E3-A5C8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242848>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> From: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
>
> We need to consider that a remote-tracking branch may match more than
> one rhs of a fetch refspec.

Hmph, do we *need* to, really?

Do you mean fetching one ref on the remote side and storing that in
multiple remote-tracking refs on our side?  What benefit does such
an arrangement give the user?  When we "git fetch $there $that_ref"
to obtain that single ref, do we update both remote-tracking refs?
When the user asks "git log $that_ref@{upstream}", which one of two
or more remote-tracking refs should we consult?  Should we report
an error if these remote-tracking refs that are supposed to track
the same remote ref not all match?  Does "git push $there $that_ref"
to update that remote ref update all of these remote-tracking refs
on our side?  Should it?

My knee-jerk reaction is that it may not be worth supporting such an
arrangement as broken (we may even want to diagnose it as an error),
but assuming we do need to, the approach to solve it, i.e. this...

> In such a case, it is not enough to stop at
> the first match but look at all of the matches in order to determine
> whether a head is stale.

=2E.. sounds sensible.
