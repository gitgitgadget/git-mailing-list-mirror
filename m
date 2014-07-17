From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 2/2] config: use chmod() instead of fchmod()
Date: Thu, 17 Jul 2014 10:57:58 +0200
Message-ID: <53C79016.2020303@gmail.com>
References: <20140712075035.GA12400@ucw.cz>	<1405431797-20899-1-git-send-email-kasal@ucw.cz>	<xmqq38e2wkkh.fsf@gitster.dls.corp.google.com>	<53C5B0A1.4060502@gmail.com> <53C5B126.6020404@gmail.com> <xmqqlhrtq7a7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stepan Kasal <kasal@ucw.cz>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 10:58:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7hWA-0007id-4b
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 10:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbaGQI6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 04:58:17 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:64635 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365AbaGQI6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 04:58:07 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so2051357wgh.11
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TwubZJeDHBtqbkdvBXSm419I8kUGOEY5Igb5/vKeUMs=;
        b=sOkM0Fs5rj1qZYjFNbuy3atd4PXIF0H2jVuZozhddFogr03NIYc5PcXVMLH1Uvouzn
         ZoVPMCq8ME2lna6FW+TmyksOrrhRJS2MFd7tmvHEGIj46jlUVI1XlJp9ghOx0vPxcCkY
         qEqb7pLmu9wmwVzKm9znb2DQTLu79eE899jPYlUWUrmLRbOyW7SkbTFOBgYi1SU/jUgt
         KoxFhNFnKP4pkQGZ2nFWjIrEsLQYT6fKBkrrY3JA3Wstdgo96PQCJGk7Wn2IVKQaFMGP
         LanTgiOJw0XX3Dlqdzj1xR3uYIyCCaveyv0Ew7muMfIkXtbSJ4phmqFM9qpyu2LX4UcF
         fhpw==
X-Received: by 10.180.83.8 with SMTP id m8mr20295428wiy.8.1405587483368;
        Thu, 17 Jul 2014 01:58:03 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id r14sm18826900wik.3.2014.07.17.01.58.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 01:58:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqlhrtq7a7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253726>

Am 17.07.2014 00:16, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> There is no fchmod() on native Windows platforms (MinGW and MSVC), and the
>> equivalent Win32 API (SetFileInformationByHandle) requires Windows Vista.
>>
>> Use chmod() instead.
>>
>> Signed-off-by: Karsten Blees <blees@dcon.de>
>> ---
> 
> I am wondering if it is saner to just revert the fchmod() patch and
> replace it with something along the lines of
> 
> http://thread.gmane.org/gmane.comp.version-control.git/251682/focus=253219
> 

I also think it makes a lot of sense to handle permissions centrally.

However, with this patch, the permissions of the target file will
additionally be limited by umask (by passing them to open()), and then
overridden completely if core.sharedRepository is set.

Perhaps the lockfile API should respect the location of the lock files
(i.e. use core.sharedRepository in .git, 0666 in the work-tree, and
copy permissions anywhere else).

Another thing I find strange is that, by doing copy/replace, git silently
overwrites readonly files. If we grab the permissions from the source
file anyway, we should perhaps add 'if (!(perms & 0222)) error("file
is readonly");', or even 'access(filename, W_OK)'?

> Having said that, these are the only two callers of fchmod()
> currently in our code base, so I'll queue this patch to allow us to
> kick the problem-can down the road ;-)
> 

Thanks.
