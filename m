From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ewah: fix building with gcc < 3.4.0
Date: Tue, 03 Feb 2015 13:48:18 -0800
Message-ID: <xmqqlhkepsyl.fsf@gitster.dls.corp.google.com>
References: <1422959227-3046-1-git-send-email-tgc@statsbiblioteket.dk>
	<20150203163545.GB9325@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Tom G. Christensen" <tgc@statsbiblioteket.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 22:48:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIlKf-0007zU-SJ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 22:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161322AbbBCVsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 16:48:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161048AbbBCVsU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 16:48:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4000344A2;
	Tue,  3 Feb 2015 16:48:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NJGcAlV3RxUGMfczaHhVk0fOLP4=; b=vgXBlC
	QvZVjxBIeXMVOScAc+bCxQ+IR+cFSavLC0sUrlhQFQdogVb1gqqLRVp2mxTo/n2c
	xbcOrtifAbexXzv7idH1jByxRnlNHBxP9phPC1/cnHiLKDq6w+kfIwEBkzFyt4Fu
	hAfc7LuGYI7xXw56GcLunqa7C4xVBeOTfJjG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LscNlMX9/0JYmx45Hq+JaN7MNnj6aJMP
	nNIfEv8sWFENPq+V9PYferx8F7c2k5XeUBAsAqzNeGnx2jkmMCSxEJXOLI/DzBXd
	fizxDaAXgag+LF//s0vIGuJU/2fuOP6pL/PV/ng94vBsTlUjCox3aNtVsLOQ1D+z
	unubKtFniSM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB2CE344A1;
	Tue,  3 Feb 2015 16:48:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50260344A0;
	Tue,  3 Feb 2015 16:48:19 -0500 (EST)
In-Reply-To: <20150203163545.GB9325@peff.net> (Jeff King's message of "Tue, 3
	Feb 2015 11:35:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5DDE4BAC-ABEE-11E4-801D-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263337>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 03, 2015 at 11:27:07AM +0100, Tom G. Christensen wrote:
>
>> The __builtin_ctzll function was added in gcc 3.4.0.
>> This extends the check for gcc so that use of __builtin_ctzll is only
>> enabled if gcc >= 3.4.0.
>> ---
>> 
>> I noticed this on RHEL3 during 2.0.0rc phase but I see that the same
>> issue was noticed on Debian Sarge:
>> http://article.gmane.org/gmane.comp.version-control.git/255190
>> RHEL3 ships with gcc 3.2.3.
>> 
>> With this patch git can build on RHEL3 provided cURL support is disabled.
>
> Thanks. I built with some older gcc's at the time this was developed,
> but I don't think I went past what was in Debian stable, which was
> probably 4.something.
>
>> -#ifdef __GNUC__
>> +/* __builtin_ctzll was not available until 3.4.0 */
>> +#if defined(__GNUC__) && (__GNUC__ > 3 || (__GNUC__ == 3  && __GNUC_MINOR > 3))
>>  #define ewah_bit_ctz64(x) __builtin_ctzll(x)
>>  #else
>>  static inline int ewah_bit_ctz64(uint64_t x)
>
> We could turn this into a HAS_CTZLL Makefile knob (and auto-set it as
> above), but I don't think it is worth it. I don't expect anybody to need
> to tweak it. I double-checked that clang sets the value of __GNUC__
> appropriately.

OK.  I would imagine that this would go on top of jk/pack-bitmap,
which we could be merged down to 2.0.x maintenance track if we
wanted to.

Tom, can you make it a habit to sign-off your patch?
