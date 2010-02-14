From: Paolo Bonzini <bonzini@gnu.org>
Subject: mmap with MAP_PRIVATE is useless (was Re: Bug#569505: git-core: 'git
 add' corrupts repository if the working directory is modified as it runs)
Date: Sun, 14 Feb 2010 02:36:04 +0100
Message-ID: <4B775384.50009@gnu.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100212002741.GB9883@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, 569505-forwarded@bugs.debian.org,
	Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 02:36:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgTPb-0001FQ-OC
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 02:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109Ab0BNBgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 20:36:10 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:63421 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab0BNBgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 20:36:08 -0500
Received: by fxm27 with SMTP id 27so133357fxm.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 17:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=CJrDQLCRhMRLBvrZq+lmmmTFQIa8TfrbxOAqL2cUZEw=;
        b=ehzdGNscT+QBBuYzkqH0ky6yg6IIv15zRLJBIqwNHXkZUg8jgcY8wvXkDpGUfz/L4I
         HUtqZdhVwMwApkWNVHVzcWeXvSf4jDp/js3DjqlDMYRbIb7cblJNm/UiDf/Cf+ERo5mp
         DM4xB9oQmIAJXS1qn9Fe6i0BqonXTHtgxy4NY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=a1aSuiPnuw35xqHQWvAL8kzMr5f6zZc00WbDj0wS+prmIH5wTdSwJTeJ42zOXiTjFB
         9z5SAXP4TbTviRHbI9JAd9684+Ww8HGu3jPuO1cmd6TWqmimIXN38ny6/YQD62t7QzzR
         YGeEkArOjblGj16iS+rtpI/Q81sp7xf7pCGmM=
Received: by 10.223.6.27 with SMTP id 27mr3878584fax.31.1266111367564;
        Sat, 13 Feb 2010 17:36:07 -0800 (PST)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 2sm7961516fks.13.2010.02.13.17.36.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 17:36:07 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <20100212002741.GB9883@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139877>


> I tested this with a number of kernel versions from 2.6.27 to 2.6.31.
> All of them reproduced this problem.  I checked this because strace
> shows 'git add' doing a mmap(..., MAP_PRIVATE, ...) of its input file,
> so I was wondering if there might have been a recent change in mmap()
> behavior in either git or the kernel.

 From mmap(2): "it is unspecified whether changes made to the file after 
the mmap() call are visible in the mapped region".

You may think that doing a dummy "*p = *p" every 4096 bytes `fixes' it 
(because it causes copy-on-write for every page) but even that does not 
work because you can get a SIGBUS if the file is truncated while you 
have it mapped privately (e.g. by fopen ("file", "w") or open with O_TRUNC).

Testcase:

#include <sys/mman.h>
#include <fcntl.h>
#include <stdio.h>

int
main ()
{
   system ("echo foo > file.test");
   int f = open ("file.test", O_RDONLY);
   char *p = mmap (NULL, 4096, PROT_READ, MAP_PRIVATE, f, 0);
   close (f);
   printf ("%s", p);       // prints "foo\n"

   f = open ("file.test", O_RDWR | O_CREAT | O_TRUNC, 0666);
   write (f, "bar\n", 4);  // comment out and next printf SIGSEGVs
   printf ("%s", p);       // prints "bar\n"
}

This means that MAP_PRIVATE is utterly useless.

Paolo
