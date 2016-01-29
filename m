From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] attempt connects in parallel for IPv6-capable builds
Date: Fri, 29 Jan 2016 08:10:15 +0100
Message-ID: <56AB1057.6080700@kdbg.org>
References: <20160128115720.GA1827@dcvr.yhbt.net>
 <xmqqio2dl18i.fsf@gitster.mtv.corp.google.com>
 <20160129014106.GA8940@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 08:10:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP3CK-0007Se-E3
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 08:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbcA2HKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 02:10:20 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:47854 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbcA2HKT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 02:10:19 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3ps8vD6fqXz5tlM;
	Fri, 29 Jan 2016 08:10:16 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id D41675396;
	Fri, 29 Jan 2016 08:10:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <20160129014106.GA8940@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285069>

Am 29.01.2016 um 02:41 schrieb Eric Wong:
> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <normalperson@yhbt.net> writes:
>>
>>> getaddrinfo() may return multiple addresses, not all of which
>>> are equally performant.  In some cases, a user behind a non-IPv6
>>> capable network may get an IPv6 address which stalls connect().
>>> Instead of waiting synchronously for a connect() to timeout, use
>>> non-blocking connect() in parallel and take the first successful
>>> connection.
>>>
>>> This may increase network traffic and server load slightly, but
>>> makes the worst-case user experience more bearable when one
>>> lacks permissions to edit /etc/gai.conf to favor IPv4 addresses.
>>
>> Umm.  I am not sure what to think about this change--I generally do
>> not like a selfish "I'll try to use whatever resource given to me
>> to make my process go faster, screw the rest of the world" approach
>> and I cannot decide if this falls into that category.
>>
>> I'll wait for opinions from others.
>
> No problem, I can also make it cheaper for servers to handle
> aborted connections in git-daemon:
>
> standalone:
>
>    1) use recv with MSG_PEEK or FIONREAD to determine if there's
>       readable data in the socket before forking (and avoid
>       forking for zero-bytes-written connections)
>
>    2) use TCP_DEFER_ACCEPT in Linux and dataready filter in FreeBSD
>       for standalone git-daemon to delay accept()
>
> inetd:
>
>    3) suppress die("The remote end hung up unexpectedly")
>       if no bytes are read at all
>
> At some point in the future, I would love to have git-daemon implement
> something like IDLE in IMAP (to avoid having clients poll for updates).
> Perhaps the standalone changes above would make sense there, too.

Before you submit a patch in that direction (or resubmit the patch under 
discussion here), could you please find someone to test your patch on 
Windows first? A lot of the infrastructure mentioned may not be 
available there or may not work as expected. (I admit that I'm just 
hand-waving, I haven't tested your patch.)

Thanks,
-- Hannes
