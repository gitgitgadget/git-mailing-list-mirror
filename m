From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Fri, 21 Mar 2014 21:01:45 +0100
Message-ID: <532C9AA9.1010102@gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>	<532AF304.7040301@gmail.com>	<CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>	<532B5F0D.2070300@gmail.com> <CAHOQ7J-sUt3HGYNE7n=X3ZmV3Q-n+n9hMDAtzLbH3YU8iAqoqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 21:01:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR5dX-0004dW-SB
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 21:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbaCUUBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 16:01:46 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:60802 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbaCUUBo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 16:01:44 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so2201390eek.34
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kQ2NIs0lXZvuF+l64PKfBZZJhKqAak5k5/h5xr88i68=;
        b=SuCSa+VT/sCFXD3hOtHI3lAUhUNqHePoNikaUPP/++tX7fJ6MqpM7H1fG58z9aWNzm
         /gCq3ef89eEazNdmibD5KxQQ8cE/SChgYXVUbmhU8Ju2AYHWYgaQi2YU3xCPQ/1htSjJ
         XFyqW/615CRm/xukV8w0+q91+Qlji0qv3BdZaHsDXayEt8RwdjXtfkgDrHjkK2F6ieJC
         NtGe4ALeBcCP76SSCyLn/piCsY7DZbrC2AUCry/88lSdEaI/oWMCD0QNAgLUMdu4Bljf
         qFVfHxLiwmzMRaDU0ZXzWAwe2U7O+5rCP3Dx5CCCjFt0xE3dYMWNiopecoMsayB08UB5
         GXIg==
X-Received: by 10.14.69.201 with SMTP id n49mr3592782eed.106.1395432103888;
        Fri, 21 Mar 2014 13:01:43 -0700 (PDT)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id e42sm13804672eev.32.2014.03.21.13.01.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 13:01:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CAHOQ7J-sUt3HGYNE7n=X3ZmV3Q-n+n9hMDAtzLbH3YU8iAqoqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244731>

Am 20.03.2014 22:56, schrieb Stefan Zager:
> On Thu, Mar 20, 2014 at 2:35 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Am 20.03.2014 17:08, schrieb Stefan Zager:
>>
>>> Going forward, there is still a lot of performance that gets left on
>>> the table when you rule out threaded file access.  There are not so
>>> many calls to read, mmap, and pread in the code; it should be possible
>>> to rationalize them and make them thread-safe -- at least, thread-safe
>>> for posix-compliant systems and msysgit, which covers the great
>>> majority of git users, I would hope.
>>>
>>
>> IMO a "mostly" XSI compliant pread (or even the git_pread() emulation) is still better than forbidding the use of read() entirely. Switching from read to pread everywhere requires that all callers have to keep track of the file position, which means a _lot_ of code changes (read/xread/strbuf_read is used in ~70 places throughout git). And how do you plan to deal with platforms that don't have a thread-safe pread (HP, Cygwin)?
>>
>> Considering all that, Duy's solution of opening separate file descriptors per thread seems to be the best pattern for future multi-threaded work.
> 
> Does that mean you would endorse the (N threads) * (M pack files)
> approach to threading checkout and status?  That seems kind of
> crazy-town to me.  Not to mention that pack windows are not shared, so
> this approach to multi-threading can have the side-effect of blowing
> out memory consumption.  We have already had to dial back settings for
> pack.threads and core.deltaBaseCacheLimit, because threaded index-pack
> was causing OOM errors on 32-bit platforms.
> 

Opening more file descriptors doesn't significantly increase the memory footprint, so it shouldn't matter whether the threads read data via shared or private descriptors.

git-status with core.preloadindex is already multithreaded (at least the first part), and AFAIK doesn't read pack files at all.

I'm still not convinced that multi-threaded git-checkout is a good idea. According to my tests this is actually slower than sequential checkout. You'd have to be very careful to only multi-thread the parts that don't do any IO, such as unpacking / undeltifying.
