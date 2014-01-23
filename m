From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 11:52:06 -0800
Message-ID: <20140123195206.GU18964@google.com>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 20:52:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QKM-0004F8-SB
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 20:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbaAWTwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 14:52:15 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59310 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214AbaAWTwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 14:52:13 -0500
Received: by mail-bk0-f46.google.com with SMTP id r7so617431bkg.33
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ae6xsnIuj70NqfLmNkgmdlSl8hybCkp2XaRqxi0gvWA=;
        b=zyD0b9nCLbDo89uN3gzR2dfk7UbgTabuoz2vC6vg0JszXVlcIw00NhnA51sI1k8Huj
         NfGFyiHg+EjzQcWNu4OFdQiH26mC1K2/G4duQd5cShBegR7CRCxm3KyqLbE1W1giRe6l
         0nJe4tQMD6X9iYdgbcDVd+t9adbQRrIn2kWm2tMIejqoOeHvDNHz0yt1JqttoC6nIMLR
         8okXpO95hOzSsaPUP8yhai84nNaRW7QwU+l56fwGVZ457gKhfnpYYNJcqhjv2J1vST3H
         bZqLRIDj9pYf4w6rV12oD1aV7UaR/ZM3kOxFAq++4OBnyEmCIMEGzUWtzxMh6ygF/26W
         XW/Q==
X-Received: by 10.205.97.69 with SMTP id cj5mr1542871bkc.132.1390506731965;
        Thu, 23 Jan 2014 11:52:11 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ch4sm96251bkc.8.2014.01.23.11.52.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 11:52:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123183320.GA22995@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240931>

Jeff King wrote:

> Here's a patch series (on top of jk/pack-bitmap, naturally) that lets
> t5310 pass there. I assume the ARM problem is the same, though seeing
> the failure in realloc() is unexpected. Can you try it on both your
> platforms with these patches?

Thanks.  Trying it out now.

[...]
>> Hopefully it's possible to get the alignment right in the caller
>> and tweak the signature to require that instead of using unaligned
>> reads like this.  There's still something wrong after this patch ---
>> the new result is a NULL pointer dereference in t5310.7 "enumerate
>> --objects (full bitmap)".
>
> After my patches, t5310 runs fine for me. I didn't try your patch, but
> mine are similar. Let me know if you still see the problem (there may
> simply be a bug in yours, but I didn't see it).

I had left out a cast to unsigned, producing an overflow.

My main worry about the patches is that they will probably run into
an analagous problem to the one that v1.7.12-rc0~1^2~2 (block-sha1:
avoid pointer conversion that violates alignment constraints,
2012-07-22) solved.  By casting the pointer to (uint32_t *) we are
telling the compiler it is 32-bit aligned (C99 section 6.3.2.3).

Thanks,
Jonathan
