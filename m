From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH v3] diff-highlight: do not split multibyte characters
Date: Sat, 4 Apr 2015 23:47:05 +0900
Message-ID: <CAFT+Tg_dFvpxauPJgRi86qTFo4k6dXa6WST+UPTguisA9ma83Q@mail.gmail.com>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com>
	<20150330221635.GB25212@peff.net>
	<ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c>
	<20150403012430.GA16173@peff.net>
	<CAFT+Tg8-tUBAvgX1bTni7joye_ZuZ_NOT_mmamnnm5GdWzEhrg@mail.gmail.com>
	<6a8dcc870e53040e1f54d7c36a1b33a@74d39fa044aa309eaea14b9f57fe79c>
	<20150404140902.GA25455@peff.net>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 04 16:47:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YePLr-0007CL-Lf
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 16:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbbDDOrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 10:47:08 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35471 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbbDDOrG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 10:47:06 -0400
Received: by qcbii10 with SMTP id ii10so82509588qcb.2
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DCi95XQ3RtxuoNpnGcqzNnQC8slp91rvT1IuuImr3RM=;
        b=fb3nWLcnJfftbGLab3gI+FjYB3pbL01O9vDSvSnWP/uQmqq4eccVVA9PqrfjjDw+6B
         lma5nCGSpeRcv3oNvSQu5czCRZPd65OKqv53C6zl+spKNcQgI6Nk4v4Ni751ZoKWteyh
         khHz3uyIH2UpLbyU3GTZnwj1d+xNs9dpdAGxClbAmgvIwSuWOcjlei+m6FV81hTtdlxz
         uYw4CrL2wfMAb+qQsNpuxaJ3P+bHWvy4mQo4GsmmyZmKa2gVtwN+aATvLtWgk1hwWkbN
         9NC4wFmRHyTqDI89hSVbHUIFwlkxtywaYVvSB0SkMp94f2h92BdR0yHK8zmwdUmVO4ce
         OMzw==
X-Received: by 10.140.33.164 with SMTP id j33mr8010768qgj.10.1428158825487;
 Sat, 04 Apr 2015 07:47:05 -0700 (PDT)
Received: by 10.140.105.161 with HTTP; Sat, 4 Apr 2015 07:47:05 -0700 (PDT)
In-Reply-To: <20150404140902.GA25455@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266776>

On Fri, Apr 3, 2015 at 10:24 AM, Jeff King <peff@peff.net> wrote:
>
> EungJun, does this version meet your needs?
>
> -Peff

Yes, this patch is enough to meet my needs because it works well on
UTF-8, the only encoding I use. And this patch looks better than my
one because it is smaller, doesn't depend on String::Multibyte and
seems to have no side-effect.

I hope someone who use another multibyte encoding will send a patch to
support the encoding in future... :)

On Sat, Apr 4, 2015 at 11:09 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 03, 2015 at 03:15:14PM -0700, Kyle J. McKay wrote:
>
>> When the input is UTF-8 and Perl is operating on bytes instead of
>> characters, a diff that changes one multibyte character to another
>> that shares an initial byte sequence will result in a broken diff
>> display as the common byte sequence prefix will be separated from
>> the rest of the bytes in the multibyte character.
>>
>> For example, if a single line contains only the unicode character
>> U+C9C4 (encoded as UTF-8 0xEC, 0xA7, 0x84) and that line is then
>> changed to the unicode character U+C9C0 (encoded as UTF-8 0xEC,
>> 0xA7, 0x80), when operating on bytes diff-highlight will show only
>> the single byte change from 0x84 to 0x80 thus creating invalid UTF-8
>> and a broken diff display.
>>
>> Fix this by putting Perl into character mode when splitting the line
>> and then back into byte mode after the split is finished.
>>
>> The utf8::xxx functions require Perl 5.8 so we require that as well.
>>
>> Also, since we are mucking with code in the split_line function, we
>> change a '*' quantifier to a '+' quantifier when matching the $COLOR
>> expression which has the side effect of speeding everything up while
>> eliminating useless '' elements in the returned array.
>>
>> Reported-by: Yi EungJun <semtlenori@gmail.com>
>> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
>
> This version looks good to me. I looked over the diff of running "git
> log -p --color" on git.git through diff-highlight before and after this
> patch, and everything looks like an improvement.
>
>   Acked-by: Jeff King <peff@peff.net>
>
> Thanks both of you for working on this.
>
> -Peff
