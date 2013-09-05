From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Zero padded file modes...
Date: Thu, 05 Sep 2013 12:25:29 -0400
Message-ID: <5228B079.9000601@gmail.com>
References: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com> <20130905153646.GA12372@sigill.intra.peff.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 18:25:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHcNI-0001Yi-C0
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 18:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab3IEQZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 12:25:36 -0400
Received: from mail-ye0-f175.google.com ([209.85.213.175]:42572 "EHLO
	mail-ye0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab3IEQZf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 12:25:35 -0400
Received: by mail-ye0-f175.google.com with SMTP id q8so639778yen.34
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ruRdxlAXpZhXNRBGu1U204tQxIlRdlWKt/VeXfcsqJw=;
        b=jPwh3f8ckWF1Ll5203jD1wNcdTxqFeypMBAkbFbD+zc/wK0BthKU++SuDsqSINXD2C
         Uznim4EQzF+HuD0Xnl9f14n4u7U0ZU/G5lrG7sRH9GbpWmpViPfQMJxQwJ+ouPLhSOo6
         gNgDvks5sKKVggK/DNMrC2uVBsGgD+J/dG1LUaYMYpe/MbsFJMarJqvToqtaYKHGfOFM
         Rrk4GHsOelFaH4B9DdOxK2TT96yKjIK5x/DqoMSSTqayLR4icHlPt5QfH5cfgJBfRL0T
         jugD7T5Qtaajor+liYQzeGVJPX05C3sQknoYtPn+A+Ui6nKkuL8i+mVfOn4lT+c4bbnj
         xc4g==
X-Received: by 10.236.126.48 with SMTP id a36mr1250660yhi.93.1378398334770;
        Thu, 05 Sep 2013 09:25:34 -0700 (PDT)
Received: from [10.0.1.133] (50-88-155-14.res.bhn.net. [50.88.155.14])
        by mx.google.com with ESMTPSA id g47sm36981509yhb.21.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Sep 2013 09:25:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130827 Icedove/17.0.8
In-Reply-To: <20130905153646.GA12372@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233966>



On 09/05/2013 11:36 AM, Jeff King wrote:
[...]
>
> I haven't looked carefully at the pack v4 patches yet, but I suspect
> that yes, it's still a problem. The premise of pack v4 is that we can do
> better by not storing the raw git object bytes, but rather storing
> specialized representations of the various components. For example, by
> using an integer to store the mode rather than the ascii representation.
> But that representation does not represent the "oops, I have a 0-padded
> mode" quirk. And we have to be able to recover the original object, byte
> for byte, from the v4 representation (to verify sha1, or to generate a
> loose object or v2 pack).
>
> There are basically two solutions:
>
>    1. Add a single-bit flag for "I am 0-padded in the real data". We
>       could probably even squeeze it into the same integer.
>
>    2. Have a "classic" section of the pack that stores the raw object
>       bytes. For objects which do not match our expectations, store them
>       raw instead of in v4 format. They will not get the benefit of v4
>       optimizations, but if they are the minority of objects, that will
>       only end up with a slight slow-down.
>
> As I said, I have not looked carefully at the v4 patches, so maybe they
> handle this case already. But of the two solutions, I prefer (2). Doing
> (1) can solve _this_ problem, but it complicates the format, and does
> nothing for any future compatibility issues. Whereas (2) is easy to
> implement, since it is basically just pack v2 (and implementations would
> need a pack v2 reader anyway).

3. Keep those objects in v2 packs instead of the v4 pack. Transfers 
would have to be v3 or multi-pack transfers would need to be supported.

4. Don't use v4 packs with projects that have "crufty" objects. Projects 
with such objects may choose to pay the "cost" to "upgrade" to v4 
compatibility.

There's nothing that requires the next pack format to support all of the 
broken stuff that's happened over the years.
