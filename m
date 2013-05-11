From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] cache.h: eliminate SHA-1 deprecation warnings on OS X 10.8
Date: Sat, 11 May 2013 00:11:05 -0700
Message-ID: <CAJDDKr6QkeSk32kNhU_QuvrZSGUEokcEbN7Aq3PcOhvaA_hFgg@mail.gmail.com>
References: <1368240282-89581-1-git-send-email-davvid@gmail.com>
	<20130511062336.GD3394@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 09:11:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub3xl-0004YF-J5
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 09:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab3EKHLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 03:11:09 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:35687 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab3EKHLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 03:11:07 -0400
Received: by mail-ea0-f172.google.com with SMTP id r16so2678374ead.31
        for <git@vger.kernel.org>; Sat, 11 May 2013 00:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=jCk+fSu2BH+Yu647/hLNnT+c7DHo5RUsjggVW5CvwC0=;
        b=lMqUGzp2c1xhjw1lyMgvTO2qnSN3S2FeLfFQuqxe+xirNmA+TgmEJAWLSsvDeNpjRw
         KQJQtfAS9DVH4v3b0vonOzXItONyQ/kKzI/s8kC5FW4kfYelv/1Tx658ENPVFX3zY1en
         PYqbb5JPpwUtnNDBokpSSx5Tx8yBg/RQphi0dUzDv/R10p5wn3tY54nWge2O7wgujPpO
         qDKs6fsU7vsdTYGbRmVVfUuBY8qTigf25E2y2LNulJed1TeLXmSqopgNqr/YZlzzMhTD
         RMw7EKLfjvZzZwyUnB0i5FEJ4wcmqr+/RqFdYqVolBafwZhXH1alzTjBrrEbsKx45u6t
         5zOA==
X-Received: by 10.14.3.137 with SMTP id 9mr50816067eeh.0.1368256265483; Sat,
 11 May 2013 00:11:05 -0700 (PDT)
Received: by 10.14.32.65 with HTTP; Sat, 11 May 2013 00:11:05 -0700 (PDT)
In-Reply-To: <20130511062336.GD3394@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223937>

On Fri, May 10, 2013 at 11:23 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> David Aguilar wrote:
>
>> Mac OS X Mountain Lion prints warnings when building git:
>>
>>       warning: 'SHA1_Init' is deprecated
>>       (declared at /usr/include/openssl/sha.h:121)
>>
>> Silence the warnings by using the Common Digest SHA-1
>> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
>
> Thanks.
>
> Does this perform better or worse than just setting
> BLK_SHA1=YesPlease?  I'd naively think it could go either way: on one
> hand adding another library dependency can slow down startup, and on
> the other hand the implementation may or may not be optimized better
> than the generic block-sha1/ implementation.

Pretty much identical.

Here are the timings (I should probably read t/perf/README and get
better numbers):

Best of ten
$ time git rev-list --all --objects >/dev/null

# master
git rev-list --all --objects > /dev/null  5.16s user 0.11s system 99%
cpu 5.277 total

# BLK_SHA1
git rev-list --all --objects > /dev/null  5.17s user 0.11s system 99%
cpu 5.299 total

# CommonDigest
git rev-list --all --objects > /dev/null  5.18s user 0.11s system 99%
cpu 5.301 total

The library startup cost is identical to master since at the end of
the day it's still libcrypto.

FWIW the way it's done in this patch still allows defining BLK_SHA1,
which is parity with how the Makefile behaves on Linux.

Re-roll?
--
David
