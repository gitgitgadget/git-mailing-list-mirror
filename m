From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v4 23/23] compat/mingw.h: Fix the MinGW and msvc builds
Date: Sat, 28 Dec 2013 15:58:07 +0000
Message-ID: <52BEF50F.6010803@ramsay1.demon.co.uk>
References: <20131221135651.GA20818@sigill.intra.peff.net> <20131221140052.GW21145@sigill.intra.peff.net> <CABPQNSa+mtVoMiN_mxVfYW_=JMxO-0Odv5uLnGhknNhDq1yWrw@mail.gmail.com> <20131228100050.GA24929@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 17:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwwHI-0005pX-K4
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 16:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab3L1P6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 10:58:12 -0500
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:52310 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754677Ab3L1P6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 10:58:11 -0500
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id B0850128075;
	Sat, 28 Dec 2013 15:58:09 +0000 (GMT)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 6DE4E128074;
	Sat, 28 Dec 2013 15:58:09 +0000 (GMT)
Received: from [192.168.254.3] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Sat, 28 Dec 2013 15:58:08 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131228100050.GA24929@sigill.intra.peff.net>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239786>

On 28/12/13 10:00, Jeff King wrote:
> On Wed, Dec 25, 2013 at 11:08:57PM +0100, Erik Faye-Lund wrote:
> 
>> On Sat, Dec 21, 2013 at 3:00 PM, Jeff King <peff@peff.net> wrote:
>>> From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> Signed-off-by: Jeff King <peff@peff.net>
>>> ---
>>>  compat/mingw.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/compat/mingw.h b/compat/mingw.h
>>> index 92cd728..8828ede 100644
>>> --- a/compat/mingw.h
>>> +++ b/compat/mingw.h
>>> @@ -345,6 +345,7 @@ static inline char *mingw_find_last_dir_sep(const char *path)
>>>  #define PATH_SEP ';'
>>>  #define PRIuMAX "I64u"
>>>  #define PRId64 "I64d"
>>> +#define PRIx64 "I64x"
>>>
>>
>> Please, move this before patch #8, and adjust the commit message.
> 
> Yeah, that makes sense. Though I think we can do one better and simply
> remove the need for it entirely. The only use of PRIx64 is in a
> debugging function that does not get called.
> 
> How about squashing the patch below into patch 8 ("ewah: compressed
> bitmap implementation"):
> 
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index f104b87..9ced2da 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -381,18 +381,6 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
>  		read_new_rlw(it);
>  }
>  
> -void ewah_dump(struct ewah_bitmap *self)
> -{
> -	size_t i;
> -	fprintf(stderr, "%"PRIuMAX" bits | %"PRIuMAX" words | ",
> -		(uintmax_t)self->bit_size, (uintmax_t)self->buffer_size);
> -
> -	for (i = 0; i < self->buffer_size; ++i)
> -		fprintf(stderr, "%016"PRIx64" ", (uint64_t)self->buffer[i]);
> -
> -	fprintf(stderr, "\n");
> -}
> -
>  void ewah_not(struct ewah_bitmap *self)
>  {
>  	size_t pointer = 0;
> diff --git a/ewah/ewok.h b/ewah/ewok.h
> index 619afaa..43adeb5 100644
> --- a/ewah/ewok.h
> +++ b/ewah/ewok.h
> @@ -193,8 +193,6 @@ void ewah_and(
>  	struct ewah_bitmap *ewah_j,
>  	struct ewah_bitmap *out);
>  
> -void ewah_dump(struct ewah_bitmap *self);
> -
>  /**
>   * Direct word access
>   */

I'm always in favour of removing unused (or unwanted) code! :-D

ATB,
Ramsay Jones
