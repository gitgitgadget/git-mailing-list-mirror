From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge-file: correctly open files when in a subdir
Date: Wed, 11 Feb 2015 10:21:56 -0800
Message-ID: <xmqqd25gux4r.fsf@gitster.dls.corp.google.com>
References: <CAPHKiG7vzKbtH7=cXD-7Cta=a-iy-ViMustn98z+VEog5ep2sg@mail.gmail.com>
	<xmqqwq3pv60p.fsf@gitster.dls.corp.google.com>
	<CAPHKiG6M9_fOjpx8Pt8UTpUcrS+tmqL3YcT11WyJJu8m6nkJ4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:22:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLbvM-0007BC-KZ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 19:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbbBKSWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 13:22:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752959AbbBKSWC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 13:22:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE4FF36EF0;
	Wed, 11 Feb 2015 13:22:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VfnbRMUKwo8g/VDAKPFbyYak+3w=; b=ntqlWh
	SHBRKiOO7jq09Q7amHpC+Je/HLtoPk3V1aAMntEtJL2Fw+drj2+SLyay2KZG842k
	00GNhOJKC0eQLUGSnRoQFSGD+0nbUub/nZ7DyJW9YxRc3FimXvAXiES0pgM6TZ/l
	hY5joyLpXv5JTHVWGFB30Lh/q2AOYwfpg+f7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T+2uY5k0juSOzUQReHeqNLni6QzXyN7G
	+p4df/VUPsdCqrvpSDajTtGCSLFZzb/W1yDMZ5hUEF0Nw4DPlKqpHcCdFwK6AKUG
	VypLlS4758NHcNtgTBYSAK2a3x873HKyfMEKV6wZEhO4xKIwKPURgx5awpbVbVIJ
	uB3ICJZ+0VA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3D2F36EEF;
	Wed, 11 Feb 2015 13:22:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6503536EE4;
	Wed, 11 Feb 2015 13:21:58 -0500 (EST)
In-Reply-To: <CAPHKiG6M9_fOjpx8Pt8UTpUcrS+tmqL3YcT11WyJJu8m6nkJ4A@mail.gmail.com>
	(Aleksander Boruch-Gruszecki's message of "Wed, 11 Feb 2015 10:58:51
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD930EAA-B21A-11E4-BCF0-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263685>

Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
writes:

>>> @@ -72,6 +72,12 @@ test_expect_success 'works in subdirectory' '
>>>      ( cd dir && git merge-file a.txt o.txt b.txt )
>>>  '
>>>
>>> +mkdir -p dir/deep
>>> +cp new1.txt orig.txt new2.txt dir/deep
>>> +test_expect_success 'accounts for subdirectory when writing' '
>>> +    (cd dir && git merge-file deep/new1.txt deep/orig.txt deep/new2.txt)
>>> +'
>>
>> Interesting.  Makes us wonder why the one before this new one you
>> added did not catch the issue, doesn't it?
>
> The test before the one added by me does work because merge-file
> tries to open "a.txt" for writing in repo root directory, which will create
> a file if it does not exist.

Ahh, this existing test

>>>      ( cd dir && git merge-file a.txt o.txt b.txt )

implicitly expects that dir/a.txt is written, but the broken
implementation writes to a.txt (i.e. outside dir).  But the test
only checks the exit code from the command without making sure that
dir/a.txt is written, it does not notice the breakage.

Thanks, that makes sense and it also makes sense that checking the
resulting content in dir/a.txt would make sense.  Then we many not
need to add a new dir/deep/* test---after all they are checking the
same thing.
