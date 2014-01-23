From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 12:23:42 -0800
Message-ID: <20140123202342.GZ18964@google.com>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123195206.GU18964@google.com>
 <20140123200311.GA31920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:24:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Qoq-0001Uo-4c
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbaAWUYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:24:03 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56187 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbaAWUXs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:23:48 -0500
Received: by mail-bk0-f46.google.com with SMTP id r7so638486bkg.33
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 12:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tGBJMm/jYRelRQgbxBkFMBfqXyeNBKrSQQpt7tm8k7U=;
        b=jbdCaDVKS1BZjSrgWpkaj7YZaYJyOrSjHAY4RRzDdsgXrp7J2cp+q50WDXm1rUuzeB
         xBX1xX9hjPvLbXAQCwFBDAL9TcX/oi9l4N6DD1H7HTeafoBtvxZjIdYvgdALmNGCrHWL
         AffdPLaqJU7WiGSmL4GBTelft9ipq+tziuPJWrP/gg581zAXQrjxhd6E0m3Gc/HkLtbo
         PVNhyNqsudRJ3zKM/qPSAtEF23raZ35dWPR24w3jDmcxLJmgeyLHv4TdpemoQ+mkX5UW
         qTEdv51xK3h5+ZFqbUSrcTcTaydRmOSAnQtYVhfhNmrlznMSFpS14SktRVtOVtrfWShM
         Oprg==
X-Received: by 10.205.97.69 with SMTP id cj5mr1656201bkc.132.1390508627439;
        Thu, 23 Jan 2014 12:23:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ch4sm177066bkc.8.2014.01.23.12.23.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 12:23:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123200311.GA31920@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240945>

Jeff King wrote:

>                                                              If we
> change the signature of align_ntohl, we can do this:
>
>   uint32_t align_ntohl(void *ptr)
>   {
>           uint32_t x;
>           memcpy(x, ptr, sizeof(x));
>           return ntohl(x);
>   }
>
>   ...
>
>   foo = align_ntohl(ptr);
>
> The memcpy solution is taken from read-cache.c, but as we noted, it
> probably hasn't been used a lot. The blk_sha1 get_be may be faster, as
> it converts as it reads.

I doubt there's much difference either way, especially after an
optimizer gets its hands on it.  According to [1] ARM has no fast
byte swap instruction so with -O0 the byte-at-a-time implementation is
probably faster there.  I can try a performance test if you like.

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/125737
