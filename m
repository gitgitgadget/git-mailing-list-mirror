From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Fri, 21 Mar 2014 19:55:06 +0100
Message-ID: <532C8B0A.70202@gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>	<532AF304.7040301@gmail.com>	<CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>	<CACsJy8AYs0-rmGZz2_KEkT2ibW-sTpm=Q9FxFhNGRYd2b6R+sA@mail.gmail.com>	<20140321052118.GA28519@duynguyen-vnpc.dek-tpc.internal> <CAHOQ7J8eEUd+NpL78RQqGFYzhD9Fs0hdGOHhmXiujJdGrfeS=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:55:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4bL-00079U-6e
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbaCUSzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:55:09 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:40961 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaCUSzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:55:06 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so2147407eek.34
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8laZTEet/OdAUO3t8Fb2i1W9UZ7E3vDABQUpBB4skmI=;
        b=jJtxu52graTOgPo72mhCA9mlarfHDtt1agn1UC9JZDzD3J9ab9IOvlB3+zUIQT9Olj
         GFge1zdQNWdgrf6BR8Rbkb6DUwrYpsUYeRwF49IdlhFAWnvMeQC397qH5LHly6fc4ECl
         1zrJr6kOxagm3aLjjEKIeO/EBfVDGS+kWIofD31T+9UYjo6ps1/fh9LRIjl/eIax8Og1
         FVeIcJIP/gt5ea+zZyHDp7iJKE3tjadpiiescOnmwtrdH+pIDYJOq9wVxxvdL8AJ8S0c
         wcR+IjvbYLe2XvL9ZF23Z8U4LZM00t9om8whYeUYFCnGIput8dYyPztIcajhT4a6mCFY
         FfRQ==
X-Received: by 10.14.39.3 with SMTP id c3mr49625309eeb.42.1395428104901;
        Fri, 21 Mar 2014 11:55:04 -0700 (PDT)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id x3sm13448338eep.17.2014.03.21.11.55.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 11:55:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CAHOQ7J8eEUd+NpL78RQqGFYzhD9Fs0hdGOHhmXiujJdGrfeS=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244724>

Am 21.03.2014 06:35, schrieb Stefan Zager:
> On Thu, Mar 20, 2014 at 10:21 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, Mar 21, 2014 at 08:51:18AM +0700, Duy Nguyen wrote:
>>> On Thu, Mar 20, 2014 at 11:08 PM, Stefan Zager <szager@chromium.org> wrote:
>>>> Duy, would you like to re-post your patch without the new pread implementation?
>>>
>>> I will but let me try out the sliding window idea first. My quick
>>> tests on git.git show me we may only need 21k mmap instead of 177k
>>> pread. That hints some potential performance improvement.
>>
>> The patch at the bottom reuses (un)use_pack() instead of pread(). The
>> results on linux-2.6 do not look any different. I guess we can drop
>> the idea.
>>
>> It makes me wonder, though, what's wrong a simple patch like this to
>> make pread in index-pack thread-safe? It does not look any different
>> either from the performance point of view, perhaps because
>> unpack_data() reads small deltas most of the time
> 
> When you serialize disk access in this way, the effect on performance
> is really dependent on the behavior of the OS, as well as the locality
> of the read offsets.  Assuming -- fairly, I think -- that the reads
> will be pretty randomly distributed (i.e., no locality to speak of),
> then your best bet is get as many read operations in flight as
> possible, and let the disk scheduler optimize the seek time.
> 

The read() implementation in MSVCRT.DLL is synchronized anyway, and I strongly suspect that this is also true for ReadFile() (at least for synchronous file handles, i.e. opened without FILE_FLAG_OVERLAPPED). So I guess separate file descriptors would help with parallel IO as well.
