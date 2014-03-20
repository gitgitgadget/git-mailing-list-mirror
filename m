From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Thu, 20 Mar 2014 22:35:09 +0100
Message-ID: <532B5F0D.2070300@gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>	<532AF304.7040301@gmail.com> <CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?Yw==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 22:35:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQkcS-0003tt-17
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 22:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbaCTVfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 17:35:12 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:46306 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328AbaCTVfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 17:35:09 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so1150365eek.6
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hRUxy4BocSdXBV4wHGNjNowowW3uqSm5UB3xxL2G2jY=;
        b=I/enjFZJQOpqr3px2C5FQGwbKnCbgDZhke4fv+XNaD8FykAtiQaMlQ7qZah1xFl4Ed
         V/qdIjxrwRmVZrdyO8+gMfTxmv8X5RP/fRVx8cck8KtFxoqHsu+dmisratuBESB/w+7R
         4hBbStd6VNR86EK3OFAmSOp2EvkqXHyM8vHOyqFwc+JGkSABWWKzFotowP5a/ssagM6P
         hPrTAvdI0YXM78HgX3ckQWacZ5r6bWOwwa9KFvPG2nb3RpXQcdXG4IzM1nTGafzZi5/j
         eK02hlF4XloQXnSfmN2/XpXZ5t8WRmSmdsvjfQvHPjVCoZ+isFMBPOF3LL+/Ufot5PlF
         PQyw==
X-Received: by 10.15.102.74 with SMTP id bq50mr44314990eeb.21.1395351308461;
        Thu, 20 Mar 2014 14:35:08 -0700 (PDT)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 4sm6967180eeq.33.2014.03.20.14.35.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 14:35:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244588>

Am 20.03.2014 17:08, schrieb Stefan Zager:
> On Thu, Mar 20, 2014 at 6:54 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Am 19.03.2014 01:46, schrieb szager@chromium.org:
>>> This adds a Windows implementation of pread.  Note that it is NOT
>>> safe to intersperse calls to read() and pread() on a file
>>> descriptor.
>>
>> This is a bad idea. You're basically fixing the multi-threaded issue twice, while at the same time breaking single-threaded read/pread interop on the mingw and msvc platform. Users of pread already have to take care that its not thread-safe on some platforms, now you're adding another breakage that has to be considered in future development.
>>
>> The mingw_pread implementation in [1] is both thread-safe and allows mixing read/pread in single-threaded scenarios, why not use this instead?
>>
>> [1] http://article.gmane.org/gmane.comp.version-control.git/242120
> 
> 
> That's not thread-safe.  There is, presumably, a point between the
> first and second calls to lseek64 when the implicit position pointer
> is incorrect.  If another thread executes its first call to lseek64 at
> that time, then the file descriptor may end up with an incorrect
> position pointer after all threads have finished.
> 

Correct, a multi-threaded code section using pread has the effect of randomizing the file position (btw., this is also true for your pread implementation). This can be easily fixed by resetting the file position after pthread_join, if necessary. Currently there's just six callers of pthread_join.

> Going forward, there is still a lot of performance that gets left on
> the table when you rule out threaded file access.  There are not so
> many calls to read, mmap, and pread in the code; it should be possible
> to rationalize them and make them thread-safe -- at least, thread-safe
> for posix-compliant systems and msysgit, which covers the great
> majority of git users, I would hope.
> 

IMO a "mostly" XSI compliant pread (or even the git_pread() emulation) is still better than forbidding the use of read() entirely. Switching from read to pread everywhere requires that all callers have to keep track of the file position, which means a _lot_ of code changes (read/xread/strbuf_read is used in ~70 places throughout git). And how do you plan to deal with platforms that don't have a thread-safe pread (HP, Cygwin)?

Considering all that, Duy's solution of opening separate file descriptors per thread seems to be the best pattern for future multi-threaded work.

Karsten
