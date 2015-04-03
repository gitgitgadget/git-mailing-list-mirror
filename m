From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] diff-highlight: Fix broken multibyte string
Date: Thu, 2 Apr 2015 18:59:50 -0700
Message-ID: <1D1557A9-737A-4BF6-A3DE-BF4C0465BD36@gmail.com>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com> <20150330221635.GB25212@peff.net> <ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c> <20150403012430.GA16173@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Yi EungJun <semtlenori@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 04:00:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydqtr-0007eg-Kk
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 03:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035AbbDCB74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 21:59:56 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35498 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbbDCB7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 21:59:54 -0400
Received: by patj18 with SMTP id j18so101519873pat.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 18:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=98CVllctLToWH9e0KDKu9qPvyWBoeFL3Epp9g5/ubDw=;
        b=xgficF3+Jf8EF4uLkeZgE7GC1X7q+9cvDvesiC0pyLgzJlX1Shy6tw8KniMk9W9UBR
         sfSa6j3i2/9UGAx/A0UO8s2SChQo59PlAWDXkjVNh40EKlu0bClAC6h85Z19/uhU1m1Z
         tMjASVYXiZNekYO8LtFAl5sc03tZLnfBJI5jg3+qz3HK9dri0wtZua8p+fxYy4uleSrs
         NRuMcmE35OTwX67l9FcHY8BUex5fiCimd1CJLhSAXA9BCg+E7F9L5ic0Apev9h1yQruv
         jFaTVXKVwq5ny1IQzvIQZtgcCZjjRJrHbuK2XdwInvIxwDpbybbX3VZTr5LCMOoKojjC
         Lk8Q==
X-Received: by 10.70.132.2 with SMTP id oq2mr330072pdb.53.1428026393818;
        Thu, 02 Apr 2015 18:59:53 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id fc3sm6482356pdb.22.2015.04.02.18.59.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 18:59:53 -0700 (PDT)
In-Reply-To: <20150403012430.GA16173@peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266700>

On Apr 2, 2015, at 18:24, Jeff King wrote:

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

It should work as well as the original did for any 1-byte encoding.   
That is, if it's not valid UTF-8 it should pass through unchanged and  
any single byte encoding should just work.  But, as you point out,  
multibyte encodings other than UTF-8 won't work, but they should  
behave the same as they did before.

> but I'm not sure the original was all that helpful either (in that we
> don't actually _know_ the file encodings in the first place).

I think it should work fine on any single byte encoding (i.e. ISO-8859- 
x, WINDOWS-1252, etc.).

> I timed this one versus the existing diff-highlight. It's about 7%
> slower.

I'd expect that, we're doing extra work we weren't doing before.

> That's not great, but is acceptable to me. The String::Multibyte
> version was a lot faster, which was nice (but I'm still unclear on
> _why_).

Must be the mbcs->strsplit routine has special case code for splitting  
on '' to just split on character boundaries.

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

Maybe that should be added.  The rest of Git's perl code seems to have  
a 'use 5.008;' already, so I figured that was a reasonable  
dependency.  :)

-Kyle
