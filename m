From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH] diff-highlight: Fix broken multibyte string
Date: Fri, 3 Apr 2015 11:19:24 +0900
Message-ID: <CAFT+Tg8-tUBAvgX1bTni7joye_ZuZ_NOT_mmamnnm5GdWzEhrg@mail.gmail.com>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com>
	<20150330221635.GB25212@peff.net>
	<ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c>
	<20150403012430.GA16173@peff.net>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 04:19:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdrCl-0004id-Dh
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 04:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbbDCCT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 22:19:26 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33387 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbDCCTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 22:19:25 -0400
Received: by qgdy78 with SMTP id y78so22875748qgd.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 19:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=L8Xrs8N8ddfdP3mtIUnO9HwaSjet0GrJoYYukDWVr7M=;
        b=i84rLyPa2M+e6aNsNpS9KdXzbVNoNRP+ytI1c2ZeL15R0eq0mZdfCDgcSYKaYSLXkU
         T7rgoxtPBiMp8abEG6re/V71S1CwP+D/nvC4SN4fF+byqx8w4V8dngG04HEwpINKJ99l
         H+S3E4xQUAHuUClUBq693tBtvx2LJCUpL+eA4I55b0hIh0sPCkEbQlr6IjDyUZCuxbG2
         qVIdj6EPZAU7N7692TmHdNz5zfNQEYCrEvu1jNjITJszSS2lFJzA7Ty/ovRi+xrhnZwK
         XU86HTPoobSCTQIYpV0sfsRClMg8IDFxacgE8hgUfXiX63Rn7uIc1KDW/h+wrPH+Gnm6
         O1kA==
X-Received: by 10.140.233.3 with SMTP id e3mr313482qhc.94.1428027565244; Thu,
 02 Apr 2015 19:19:25 -0700 (PDT)
Received: by 10.140.105.161 with HTTP; Thu, 2 Apr 2015 19:19:24 -0700 (PDT)
In-Reply-To: <20150403012430.GA16173@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266701>

> I timed this one versus the existing diff-highlight. It's about 7%
> slower. That's not great, but is acceptable to me. The String::Multibyte
> version was a lot faster, which was nice (but I'm still unclear on
> _why_).

I think the reason is here:

> sub split_line {
>    local $_ = shift;
>    return map { /$COLOR/ ? $_ : ($mbcs ? $mbcs->strsplit('', $_) : split //) }
>           split /($COLOR)/;
> }

I removed "*" from "split /($COLOR*)/". Actually I don't know why "*"
was required but I need to remove it to make my patch works correctly.


On Fri, Apr 3, 2015 at 10:24 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 02, 2015 at 05:49:24PM -0700, Kyle J. McKay wrote:
>
>> Subject: [PATCH v2] diff-highlight: do not split multibyte characters
>>
>> When the input is UTF-8 and Perl is operating on bytes instead
>> of characters, a diff that changes one multibyte character to
>> another that shares an initial byte sequence will result in a
>> broken diff display as the common byte sequence prefix will be
>> separated from the rest of the bytes in the multibyte character.
>
> Thanks, I had a feeling we should be able to do something with perl's
> builtin utf8 support.  This doesn't help people with other encodings,
> but I'm not sure the original was all that helpful either (in that we
> don't actually _know_ the file encodings in the first place).
>
> I briefly confirmed that this seems to do the right thing on po/bg.po,
> which has a couple of sheared characters when viewed with the existing
> code.
>
> I timed this one versus the existing diff-highlight. It's about 7%
> slower. That's not great, but is acceptable to me. The String::Multibyte
> version was a lot faster, which was nice (but I'm still unclear on
> _why_).
>
>> Fix this by putting Perl into character mode when splitting the
>> line and then back into byte mode after the split is finished.
>
> I also wondered if we could simply put stdin into utf8 mode. But it
> looks like it will barf whenever it gets invalid utf8. Checking for
> valid utf8 and only doing the multi-byte split in that case (as you do
> here) is a lot more robust.
>
>> While the utf8::xxx functions are built-in and do not require
>> any 'use' statement, the utf8::is_utf8 function did not appear
>> until Perl 5.8.1, but is identical to the Encode::is_utf8
>> function which is available in 5.8 so we use that instead of
>> utf8::is_utf8.
>
> Makes sense. I'm happy enough listing perl 5.8 as a dependency.
>
> EungJun, does this version meet your needs?
>
> -Peff
