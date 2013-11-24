From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: error: git-remote-https died of signal 13
Date: Sun, 24 Nov 2013 16:01:43 +0100
Message-ID: <529214D7.1030203@googlemail.com>
References: <5290D994.9040505@googlemail.com> <20131124065400.GB5535@sigill.intra.peff.net> <5291F70A.7070508@googlemail.com> <20131124133356.GA3507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 24 16:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkbC4-0001pf-0R
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 16:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab3KXPBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 10:01:47 -0500
Received: from mail-ea0-f175.google.com ([209.85.215.175]:56849 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3KXPBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 10:01:46 -0500
Received: by mail-ea0-f175.google.com with SMTP id z10so1808785ead.34
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=i42xiPnma6A06cbtvfT1F3dhdX0r4e9itNWxSX7pwSE=;
        b=TZz/aPh3Wjb1b9cjvodFmt90tiAItoiewV+QJsAoBjJD3U3d+pr20fJ8XX7IZpA2Jl
         tHt0dxMBmMwIhK3FQc/XyRDN9DGSslDQPDCyHiEFevU2CtCvXRJ3T36Fig1yp0WnEZvL
         nNLncErj89RiZkgsAi1tbAXXID4SVt/oou3ddmJMMrlZKM1L9s4XTEcR8RFP6HNncj60
         FcoCzCCb3YhibhmYlSXWHe0i4JdZvTZGGSc5Kh6XjykjIP9SoZtNoeOTrjcaYPJWN85N
         YH4xqSvDcCoqL/GPFEiE2pP02myijnfe5ro2KkDFc2nNtFKknWyKZAKrErMMZ9CtTtl4
         RCvQ==
X-Received: by 10.14.205.8 with SMTP id i8mr30029578eeo.19.1385305305291;
        Sun, 24 Nov 2013 07:01:45 -0800 (PST)
Received: from [192.168.1.9] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id k7sm53293005eeg.13.2013.11.24.07.01.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 07:01:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131124133356.GA3507@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238261>

On 24.11.2013 14:33, Jeff King wrote:
> On Sun, Nov 24, 2013 at 01:54:34PM +0100, Stefan Beller wrote:
> 
>> Here is the output of 
>> sb@sb:/tmp$ GIT_TRANSPORT_HELPER_DEBUG=1 git clone https://github.com/Bertram25/ValyriaTear.git tmp
> 
> Thanks. I think I see what is going on.
> 
> We finish the helper conversation here:
> 
>> Checking connectivity... done.
>> Debug: Disconnecting.
>> error: git-remote-https died of signal 13
>> sb@sb:/tmp$ 
> 
> which means that remote-https is trying to exit, and is cleaning up any
> curl connections. The actual SIGPIPE in the strace is here:
> 
> [pid 28319] write(3, "\25\3\2\0...[binary goo]...", 27) = -1 EPIPE (Broken pipe)
> 
> and if you walk backwards, fd 3 is:
> 
>   [pid 28319] socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 3
>   ...
>   [pid 28319] connect(3, {sa_family=AF_INET,
>                           sin_port=htons(443),
>                           sin_addr=inet_addr("192.30.252.131")}, 16
>                           ) = -1 EINPROGRESS (Operation now in progress)
> 
> So it's sending binary junk to the https socket while trying to exit,
> which makes me guess that it's something to do with terminating the SSL
> session, but the server has already hung up. Which would make it a curl
> problem.
> 
> Googling "curl sigpipe" seems to come up with a report of this exact
> case:
> 
>   http://curl.haxx.se/mail/archive-2013-01/0003.html

I cannot reproduce the error using the curl command from that site.
curl returns with 0.

> 
> with a bug opened here:
> 
>   http://sourceforge.net/p/curl/bugs/1180/
> 
> Looks like the fix went into curl 7.32.0. I have 7.33.0, which seems
> fine. Can you confirm that your libcurl is a bit older?
> 

dpkg -l |grep curl
ii  curl                                      7.32.0-1ubuntu1                            amd64        command line tool for transferring data with URL syntax
ii  libcurl3:amd64                            7.32.0-1ubuntu1                            amd64        easy-to-use client-side URL transfer library (OpenSSL flavour)
ii  libcurl3-gnutls:amd64                     7.32.0-1ubuntu1                            amd64        easy-to-use client-side URL transfer library (GnuTLS flavour)
ii  libcurl4-openssl-dev                      7.32.0-1ubuntu1                            amd64        development files and documentation for libcurl (OpenSSL flavour)
ii  python-pycurl                             7.19.0-5ubuntu8                            amd64        Python bindings to libcurl

Thanks,
Stefan
