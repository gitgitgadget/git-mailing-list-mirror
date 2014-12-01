From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Mon, 01 Dec 2014 12:09:36 -0800
Message-ID: <xmqq7fybp1xb.fsf@gitster.dls.corp.google.com>
References: <87vblxl8ah.fsf@gmail.com>
	<CACsJy8CKEwOVcB_MUaK8mmSmQuKHC6R6K0YymjCrTP3aYFdbPg@mail.gmail.com>
	<CAEvUa7mhjG1xPoJedp4XYrxr39_EuzvGtONLv0B=uBw+vQB5pw@mail.gmail.com>
	<xmqqsigzp81v.fsf@gitster.dls.corp.google.com>
	<CAEvUa7nsz1UX5+qakPGW=wTR_VRJU3r+VkgVt9qiCDUz30MweA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Michael <fedora.dm0@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 21:09:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvXIB-0005R8-6L
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 21:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbaLAUJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 15:09:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932094AbaLAUJv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 15:09:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4792E20DF2;
	Mon,  1 Dec 2014 15:09:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kTmCRg2vhTOAi5f4wQFPT1gVfpc=; b=m7XQ87
	tFmc5ItvTjvphrFm16Y0b67JQVUiU07E0KQrnoWFyBKyLgDF8YhsTjf+1mcRtC75
	jEvMxKBD9RRvifApbWixeNvoTZuAT14xyXwNNmGy3fcC99AetQtxtrqC/WX5uFNv
	zInjxhoIyR1maJbjZ5U257byCR69zAcMHthLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDyBaiDcQKNhJGUViMMDm077RinhALYF
	cM5vCILiA0i2pRtHsJGdE9FjYoNkJ6niJyj5VfDx5m/OBu6sxRp2iUZE4Uh1Ou8x
	QximNm1nzPNQCL44wG8zb0k6/7dJrXJRFqGY+XG06S+YKAlk4piQBAH1PyMqbw3W
	xO0LJnWwQQ0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BBD720DF1;
	Mon,  1 Dec 2014 15:09:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE96020DE6;
	Mon,  1 Dec 2014 15:09:37 -0500 (EST)
In-Reply-To: <CAEvUa7nsz1UX5+qakPGW=wTR_VRJU3r+VkgVt9qiCDUz30MweA@mail.gmail.com>
	(David Michael's message of "Mon, 1 Dec 2014 14:10:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9E9FF7C-7995-11E4-99B5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260510>

David Michael <fedora.dm0@gmail.com> writes:

>> Huh?  I am confused.  Since when is it legal to give NULL as statbuf
>> to (l)stat(2)?
>>
>> Wouldn't something like this be sufficient and necessary?
>>
>>         int rc = stat(path, buf);
>>         if (rc)
>>                 return rc;
>>
>> That is, let the underlying stat(2) diagnose any and all problems
>> (and leave clues in errno) and parrot its return value to the caller
>> to signal the failure?
>
> Alright, it wasn't immediately clear to me from the OpenGroup page on
> stat() if that would always be safe.  I will just test the return code
> in v2.

It is irrelevant if that is safe or not.  As long as we are
emulating the underlying stat(), whether it is unsafe for stat(), we
should just throw whatever the user throws at us at the underlying
stat() and let it behave as if our emulation layer were not there.

Which is what the above snippet does.
