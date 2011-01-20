From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correctly report corrupted objects
Date: Thu, 20 Jan 2011 13:17:33 -0800
Message-ID: <7voc7bqnpu.fsf@alter.siamese.dyndns.org>
References: <20110120201220.GD12418@atjola.homenet>
 <7vsjwnqoao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 22:17:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg1t8-0000fI-OH
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 22:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab1ATVRq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jan 2011 16:17:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab1ATVRp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jan 2011 16:17:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33A293D0B;
	Thu, 20 Jan 2011 16:18:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5Dig9OzaWkrZ
	pOjzsp4SAAplzp8=; b=Xr0PYxUyKG/8Q73vgm8OY3WpPiP8fmU9xvl7MV0X0q5e
	3yrUToBdFprVP21VcxVg6XrQA6OOgUSQmSERSACQ5GZos4r2SOMtp7XAhrWnEXEZ
	BS0LKvGhmSEeW+zRe4auabDwkyykz7mMO+hyw/t4G0Tnw5Rjv1U/vwxHdTkuuO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YIhPTz
	a8YSnVHitBjGpk8GDNvJT6biWEzh+Cooxt9iC2wfy0LjoCo/IZluWbDVQLUhDbOd
	cqpH+MjciL02LS7cvPNsxkMnk5q0lxWkwr6LtIonJ4QkErSmzJLd5CbtBa3OSRhG
	8UN2NZnzNg5lqM9X0TpbDq2caEO0WkrA4RE1A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF5863D06;
	Thu, 20 Jan 2011 16:18:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 91E9D3CFF; Thu, 20 Jan 2011
 16:18:22 -0500 (EST)
In-Reply-To: <7vsjwnqoao.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 20 Jan 2011 13\:05\:03 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2CF16B6-24DA-11E0-A6F3-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165338>

Junio C Hamano <gitster@pobox.com> writes:

> Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>
>> The errno check added in commit 3ba7a06 "A loose object is not corru=
pt
>> if it cannot be read due to EMFILE" only checked for whether errno i=
s
>> not ENOENT and thus incorrectly treated "no error" as an error
>> condition.
>>
>> Because of that, it never reached the code path that would report th=
at
>> the object is corrupted and instead caused funny errors like:
>>
>>   fatal: failed to read object 333c4768ce595793fdab1ef3a036413e2a883=
853: Success
>>
>> So we have to extend the check to cover the case in which the object
>> file was successfully read, but its contents are corrupted.
>
> Hmm, what is the exact code path that read_object() callchain fails t=
o set
> errno when it returns a NULL?  It is unclear from the above descripti=
on.

Ah, nevermind.  I wasn't thinking.  If for example unpack_sha1_header()
says the type bits are garbled, it will return -1 without having any
system calls failed up to that point (because the file itself was mmapp=
ed
and read correctly) and the calling unpack_sha1_file() will return NULL=
=2E
