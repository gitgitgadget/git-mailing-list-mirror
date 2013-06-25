From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] ewah: compressed bitmap implementation
Date: Tue, 25 Jun 2013 15:51:46 -0700
Message-ID: <7vfvw5ztvh.fsf@alter.siamese.dyndns.org>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-9-git-send-email-tanoku@gmail.com>
	<7v7ghj571o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 00:51:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urc5b-00071G-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 00:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab3FYWvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 18:51:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269Ab3FYWvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 18:51:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49B1C2BCDD;
	Tue, 25 Jun 2013 22:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OyjWOxh5laI8vTc2d9rxic3sKi4=; b=EsGiik
	xicW2XY6swTkgytrhP5MCiRyzB6hkZhYksSwJxFdpdnL35m3/PfkRUeo3bUQhcQ2
	CD3884a8mTwAUw60EyaweKyUPNPotzMHxlrgxmL2wggFU/r3DoSZqwqqMi2TelTS
	RdzxT1ysg3sd3LdsxvTIJRM1reBK8wRZjVTHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hlkb9iCh60TWudSfb0MscHgfJc621BVi
	22o+DTKyO3pKfXgX3kVK47NR8rfj0Q74Yl3gxutDOWuB30qGS3eQucJOp4nddGXy
	afMKanNWZ1QyplDkzTLEykdt9r5S2NhPL1vNw67JkK87jd8GjcjbSPInZ6Uvyzbi
	yssMcWKJVFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E2C02BCDC;
	Tue, 25 Jun 2013 22:51:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B1B72BCD3;
	Tue, 25 Jun 2013 22:51:47 +0000 (UTC)
In-Reply-To: <7v7ghj571o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 24 Jun 2013 18:10:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0E6D92C-DDE9-11E2-9714-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229011>

Junio C Hamano <gitster@pobox.com> writes:

> Vicent Marti <tanoku@gmail.com> writes:
>
>> The library is re-licensed under the GPLv2 with the permission of Daniel
>> Lemire, the original author. The source code for the C version can
>> be found on GitHub:
>>
>> 	https://github.com/vmg/libewok
>>
>> The original Java implementation can also be found on GitHub:
>>
>> 	https://github.com/lemire/javaewah
>> ---
>
> Please make sure that all patches are properly signed off.
>
>>  Makefile           |    6 +
>>  ewah/bitmap.c      |  229 +++++++++++++++++
>>  ewah/ewah_bitmap.c |  703 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  ewah/ewah_io.c     |  199 +++++++++++++++
>>  ewah/ewah_rlw.c    |  124 +++++++++
>>  ewah/ewok.h        |  194 +++++++++++++++
>>  ewah/ewok_rlw.h    |  114 +++++++++
>
> This is lovely.  A few comments after an initial quick scan-through.
>
>  - The code and the headers are well commented, which is good.
>
>  - What's __builtin_popcountll() doing there in a presumably generic
>    codepath?
>
>  - Two variants of "bitmap" are given different and easy to
>    understand type names (vanilla one is "bitmap", the clever one is
>    "ewah_bitmap"), but at many places, a pointer to ewah_bitmap is
>    simply called "bitmap" or "bitmap_i" without "ewah" anywhere,
>    which waas confusing to read.  Especially, the "NAND" operation
>    for bitmap takes two bitmaps, while "OR" takes one bitmap and
>    ewah_bitmap.  That is fine as long as the combination is
>    convenient for callers, but I wished the ewah variables be called
>    with "ewah" somewhere in their names.
>
>  - I compile with "-Werror -Wdeclaration-after-statement"; some
>    places seem to trigger it.
>
>  - Some "extern" declarations in *.c sources were irritating;
>    shouldn't they be declared in *.h file and included?
>
>  - There are some instances of "if (condition) stmt;" on a single
>    line; looked irritating.   
>
>  - "bool" is not a C type we use (and not a particularly good type
>    in C++, either).

One more.

  - Use of unnecessary float (e.g. "oldval *= 1.5") were moderately
    annoying.


> That is it for now. I am looking forward to read through the users
> of the library ;-)
>
> Thanks for working on this.
