From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/21] Convert ce_path_match() to use struct pathspec
Date: Fri, 17 Dec 2010 12:29:00 -0800
Message-ID: <7voc8ki1o3.fsf@alter.siamese.dyndns.org>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-15-git-send-email-pclouds@gmail.com>
 <7v39pxl10y.fsf@alter.siamese.dyndns.org>
 <AANLkTikKCU==mS5_TdqHstETj=CQ_deHMCJ4xW0r+Sck@mail.gmail.com>
 <7vfwtwjv0f.fsf@alter.siamese.dyndns.org>
 <AANLkTinfzd8wOFTymVGeKH6cBg-6Ua6U+4N8x1TrQcHZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 21:29:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTgvW-0001KA-Jl
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 21:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab0LQU3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 15:29:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab0LQU3M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 15:29:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8539347F;
	Fri, 17 Dec 2010 15:29:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+KKPcnogJepYWX4yRe8ZIlX4eu8=; b=O24Opj
	MwuP62ixor6t2DetLjYmeL8CogN6+reGWbE6QtW1zQlMjfJpDx3GqeN+wzFPMg2p
	zsioSvQkZDwKD9qH0c9M5LNiqow3k9CzBCSPSxNhPt0G6PZCbefEimlUFZNHjsME
	CJMIjXNYtV2PhEwgiyOJiZ7d4ATytYHwGiBeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Blgb1bXagLBubjpk42x4UX6cupfbi0mR
	+23hM2jSsi7h+ai3FxCwzRksXqprUQ9UuaKQSQZD1Uc8nrlV6DZ/pcv9iB4FtGum
	+hQIB5LpHVl+Io3E1xjaLv22WPmfpVoe6kMzlFHnq0bkN8wPSziVJc5q/AEUo+ze
	OBg7z0MclJo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEFDC347E;
	Fri, 17 Dec 2010 15:29:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 57172347B; Fri, 17 Dec 2010
 15:29:30 -0500 (EST)
In-Reply-To: <AANLkTinfzd8wOFTymVGeKH6cBg-6Ua6U+4N8x1TrQcHZ@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Fri\, 17 Dec 2010 22\:11\:30 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5C598DD2-0A1C-11E0-A8A1-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163888>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Fri, Dec 17, 2010 at 10:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>>> I wonder if it makes more sense to change the type of revs->prune_data
>>>> from an array of pointers to strings to a pointer to struct pathspec.
>>>> Is there a downside?
>>>
>>> Converting a pointer to another pointer means mis typecasting can
>>> happen and the compiler won't help catching them.
>>
>> You can rename the field at the same time, and the compiler will catch
>> anything you forgot to touch, no?
>>
> Yes. I didn't think of that :(

And it would have an added benefit that it would catch new callsites
somebody else added while being unaware of your conversion--the merge
result will not compile.
