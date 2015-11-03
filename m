From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git.git as of tonight
Date: Tue, 3 Nov 2015 22:03:02 +0100
Message-ID: <56392106.1010401@kdbg.org>
References: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
 <5637D266.4060904@kdbg.org>
 <CAGZ79kbx7UJOOkhiXiUJfUS25gMGx5BUq=Qxa9205H0Z78ijbQ@mail.gmail.com>
 <56385587.1010601@kdbg.org> <xmqq37wndndp.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbAj-tZS3X1EwFw_gGh1=YU8M0OmEX91W8f++fqs6TiBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:03:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztija-0003n2-Jy
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 22:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbbKCVDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 16:03:10 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:10079 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932525AbbKCVDI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 16:03:08 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nr3VK1TQLz5tlD;
	Tue,  3 Nov 2015 22:03:05 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 9DE5F538A;
	Tue,  3 Nov 2015 22:03:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kbAj-tZS3X1EwFw_gGh1=YU8M0OmEX91W8f++fqs6TiBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280816>

Am 03.11.2015 um 19:18 schrieb Stefan Beller:
> ... ReadFileEx ... "overlapped" operation.

Let's not go there just yet.

>>   1. Make this an optional feature so that platforms can compile it
>>      out, if it is not already done.  My preference, even if we go
>>      that route, would be to see if we can find a way to preserve the
>>      overall code structure (e.g. instead of spawning multiple
>>      workers, which is why the code needs NONBLOCK to avoid getting
>>      stuck on reading from one while others are working, perhaps we
>>      can spawn only one and not do a nonblock read?).
>
> Yeah that would be my understanding as well. If we don't come up with
> a good solution for parallelism in Windows now, we'd need to make it at
> least working in the jobs=1 case as well as it worked before.

That should be possible. I discovered today that we have this function:

static void set_nonblocking(int fd)
{
	int flags = fcntl(fd, F_GETFL);
	if (flags < 0)
		warning("Could not get file status flags, "
			"output will be degraded");
	else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
		warning("Could not set file status flags, "
			"output will be degraded");
}

Notice that it is not a fatal condition if O_NONBLOCK cannot be 
established. (BTW, did you ever test this condition?) If we add two 
lines (which remove the stuff that does not work on Windows) like this:

static void set_nonblocking(int fd)
{
#ifndef GIT_WINDOWS_NATIVE
	int flags = fcntl(fd, F_GETFL);
	if (flags < 0)
		warning("Could not get file status flags, "
			"output will be degraded");
	else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
#endif
		warning("Could not set file status flags, "
			"output will be degraded");
}

we should get something that works, theoretically. We still need a more 
complete waitpid emulation, but that does not look like rocket science. 
I'll investigate further in this direction.

-- Hannes
