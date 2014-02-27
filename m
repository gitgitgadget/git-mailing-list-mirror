From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fetch: handle overlaping refspecs on --prune
Date: Thu, 27 Feb 2014 12:41:21 -0800
Message-ID: <xmqqbnxsxp8u.fsf@gitster.dls.corp.google.com>
References: <1393491610-19476-1-git-send-email-cmn@elego.de>
	<1393491610-19476-2-git-send-email-cmn@elego.de>
	<xmqqob1sxq8v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Feb 27 21:41:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ7lp-0003cC-Bn
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 21:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbaB0UlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 15:41:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbaB0UlY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 15:41:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6D2A6D157;
	Thu, 27 Feb 2014 15:41:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=micQjxBM25+g
	esrIdWrxBRYlVuQ=; b=H+G/TqIwhk1PbubhdtfuShSxvuA2eCHNb0THMiYFjXyY
	Y8GG3nm72eioic6mSlt2DJYC0gYuo4ePsbg4QfgQmHfEm9D97R+Ky4iKizqjGDLG
	Ki6dt4LAMkhDhGlW9xumlsidkKoll5psdMuPocj3U8F6pN6nQcnRBSV+0o5fyAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Nxo2t+
	M7J7t84kS3pF/JLG3mCnzyGYrInxUPL+UqQ0KTF8XO2dWQrqRhXYvmUMSyzO6wzo
	yWwZEJcrpwCudyYtJsVQyDHTwz2A4BvQSVoHJTRyISeGzvchbkgv38ufZD7Go60D
	44VnFXsJmmMCy5mf3u79u4o7WUVHhYa2URCBA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D64D86D155;
	Thu, 27 Feb 2014 15:41:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 107D66D152;
	Thu, 27 Feb 2014 15:41:22 -0500 (EST)
In-Reply-To: <xmqqob1sxq8v.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 27 Feb 2014 12:19:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8520E366-9FEF-11E3-873F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242856>

Junio C Hamano <gitster@pobox.com> writes:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>
>> From: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
>>
>> We need to consider that a remote-tracking branch may match more tha=
n
>> one rhs of a fetch refspec.
>
> Hmph, do we *need* to, really?
>
> Do you mean fetching one ref on the remote side and storing that in
> multiple remote-tracking refs on our side?  What benefit does such
> an arrangement give the user?  When we "git fetch $there $that_ref"
> to obtain that single ref, do we update both remote-tracking refs?
> When the user asks "git log $that_ref@{upstream}", which one of two
> or more remote-tracking refs should we consult?  Should we report
> an error if these remote-tracking refs that are supposed to track
> the same remote ref not all match?  Does "git push $there $that_ref"
> to update that remote ref update all of these remote-tracking refs
> on our side?  Should it?
>
> My knee-jerk reaction is that it may not be worth supporting such an
> arrangement as broken (we may even want to diagnose it as an error),
> but assuming we do need to, the approach to solve it, i.e. this...
>
>> In such a case, it is not enough to stop at
>> the first match but look at all of the matches in order to determine
>> whether a head is stale.
>
> ... sounds sensible.

Having said that, if we need to support such a configuration, I
would not be surprised if there are many other corner case bugs
coming from the same root cause---query_refspecs() does not allow us
to see more than one destination.  It would be prudent to squash
them before we officially say we do support such a configuration.

Thanks.
