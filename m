From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-submodule.sh: Support 'checkout' as a valid update command
Date: Mon, 06 Jan 2014 09:42:14 -0800
Message-ID: <xmqq8uutj9c9.fsf@gitster.dls.corp.google.com>
References: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
	<1388890249-3577-1-git-send-email-ceztko@gmail.com>
	<20140105204423.GF3156@odin.tremily.us>
	<xmqq7gadkroa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Francesco Pretto <ceztko@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Jan 06 18:42:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0EC4-0002Ei-6m
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 18:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbaAFRmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 12:42:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754899AbaAFRmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 12:42:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E9D15F378;
	Mon,  6 Jan 2014 12:42:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/IFa1cPFHQSJx8fw5yiDjykqo6I=; b=darKSc
	lUoIqqpR4LPsMJ6ma2Le5I/b0mI4Na8l2Dvy8xZZ8S+/7LoXmxTL8IWyOVgxn6iC
	LUx3vmm12w+ciiQqlfm8j2dvhzuvAVe10kKcvRvBWdn+Fx0cQKzcEsKz4Hqyw4U/
	AVr4l379Knf9NZsMdHfGquYTSnEhLR7tdnOT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vb9ZCKT1bLwVPufyyD6bmfHFuOxUySYf
	GQ2K5qF8uqKX2Odwncpk0iENOtjdRzI4lBxtAr9lh3PolIEVgnrI1R4Niqc/MNdY
	GblfcC681H5cm0YkEejGeH8AapyxJFHUEWSRoiuA5O3Niaw5VxGIXTHiL5D3MTgy
	jotlkqEbVig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4E375F377;
	Mon,  6 Jan 2014 12:42:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B92E5F372;
	Mon,  6 Jan 2014 12:42:18 -0500 (EST)
In-Reply-To: <xmqq7gadkroa.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 06 Jan 2014 08:20:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E34FDCB8-76F9-11E3-AA03-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240036>

Junio C Hamano <gitster@pobox.com> writes:

> "W. Trevor King" <wking@tremily.us> writes:
>
>> On Sun, Jan 05, 2014 at 03:50:48AM +0100, Francesco Pretto wrote:
>>> +			case "$update_module" in
>>> +			'')
>>> +				;; # Unset update mode
>>> +			checkout | rebase | merge | none)
>>> +				;; # Known update modes
>>> +			!*)
>>> +				;; # Custom update command
>>> +			*)
>>> +				update_module=
>>> +				echo >&2 "warning: invalid update mode for submodule '$name'"
>>> +				;;
>>> +			esac
>>
>> I'd prefer `die "…"` to `echo >&2 "…"`.  It's hard to know if mapping
>> the user's preferred (unknown) update mechanism to 'checkout' is
>> serious or not.
>>
>> This commit also makes me think that --rebase, --merge, and --checkout
>> should be replaced with a single --update={rebase|merge|checkout|!…}
>> option, but that's probably food for another commit (and a long
>> finger-breaking deprecation period).
>
> All of the above points sound sensible to me.

I'll tentatively queue this on 'pu' (with the suggested "die"
update), with some rewording of the log message.  The patch needs to
be signed-off, though.

Thanks.
