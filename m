From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 1/7] receive-pack.c: add protocol support to negotiate
 atomic-push
Date: Mon, 22 Dec 2014 18:09:50 -0800
Message-ID: <5498CEEE.9010105@gmail.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>	<1419017941-7090-2-git-send-email-sbeller@google.com> <CAPig+cRStBZMNj_K-81n2aZ3SzvH8VSeXwwk0MM5Q01FANRdPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 03:10:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Ev7-0003jT-S1
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 03:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbaLWCJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 21:09:54 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:57277 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbaLWCJx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 21:09:53 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so6948787pac.22
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 18:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HBiAVpoToqoBuSa4UlhWVOxY59cWXn5JVvC1RO3ZJ10=;
        b=lJJxopN28fimrwroulQ7GN3rJCJZQGYxVTjVe8Vj5iI7uTkr3piXtkXrnLduDlLVPE
         WtW4stptVgmO+4YUdPHtb1PH5S7a4UkzCLvEfKAOlzdCkNUXcUlHSFjFrZ+ShPkzoqEo
         RTtVh63sJmG46iNJa7McmPE1/LYCuboN2K4DrKMuoLQdEhqRhB8JskapUwgZ426lrlA5
         ReH4L9x7WLZcZQ7QWBX+PqhsZ2n81G0KnXUBbr4EpUwyWXOGnhGeB/bLrvi3DAzmTg8Q
         Q2MNb6K2WwWv4GmQ5UVH16PfFIbV4AWyt7ZLQKiQL6ubMsPfMGMp2Uvi7Y4iE3IEHKBk
         gTaQ==
X-Received: by 10.66.65.138 with SMTP id x10mr40007088pas.74.1419300593095;
        Mon, 22 Dec 2014 18:09:53 -0800 (PST)
Received: from [192.168.2.7] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id am14sm18451609pac.35.2014.12.22.18.09.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2014 18:09:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CAPig+cRStBZMNj_K-81n2aZ3SzvH8VSeXwwk0MM5Q01FANRdPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261709>

On 22.12.2014 14:52, Eric Sunshine wrote:
> On Fri, Dec 19, 2014 at 2:38 PM, Stefan Beller <sbeller@google.com> wrote:
>> From: Ronnie Sahlberg <sahlberg@google.com>
>>
>> This adds support to the protocol between send-pack and receive-pack to
>> * allow receive-pack to inform the client that it has atomic push capability
>> * allow send-pack to request atomic push back.
>>
>> There is currently no setting in send-pack to actually request that atomic
>> pushes are to be used yet. This only adds protocol capability not ability
>> for the user to activate it.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
>> index 6d5424c..4f8a7bf 100644
>> --- a/Documentation/technical/protocol-capabilities.txt
>> +++ b/Documentation/technical/protocol-capabilities.txt
>> @@ -244,6 +245,14 @@ respond with the 'quiet' capability to suppress server-side progress
>>  reporting if the local progress reporting is also being suppressed
>>  (e.g., via `push -q`, or if stderr does not go to a tty).
>>
>> +atomic
>> +------
>> +
>> +If the server sends the 'atomic' capability it is capable of accepting
>> +atomic pushes. If the pushing client requests this capability, the server
>> +will update the refs in one atomic transaction. Either all refs are
> 
> Not itself worth a re-send, but if you re-send for some other reason...
> 
> "one atomic" still smacks of redundancy; "an atomic" sounds better.

I did hear you saying 'one single atomic' being too redundant. And I
agree that 'one' and 'single' makes the redundancy.

However I have the impression 'an atomic' is too weak. Not everybody is
a careful reader picking up the subtle notions. Not everybody is english
native. Or concentrated.

Look at it the other way: How could it be done?

* All of the refs could be updated one at a time, not atomically, so
	foreach ref:
		open refs/heads/bla:
			write new sha1

* All of the refs could be updated at once, not atomically:
	open refs pack file:
		write new content
* All of the refs could be updated, one at a time, atomically:
	foreach ref:
		get lock
		write content to lock
		rename into place
* All of the refs at once, atomically.
	open packed refs file lock:
	write new content
	rename into place

That said, atomicity and how many transactions there are, are orthogonal
to each other. That's why I'd keep pointing out 'one atomic'
transaction.

Thanks for all the comments. I may be doing cleanup patches for you on
top of what Junio queued.

	





> 
>> +updated or none.
>> +
>>  allow-tip-sha1-in-want
>>  ----------------------
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
