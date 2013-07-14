From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Sun, 14 Jul 2013 12:15:19 -0400
Message-ID: <51E2CE97.2040900@gmail.com>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 14 18:15:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyOxK-0003FI-Iw
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 18:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab3GNQPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 12:15:23 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:43940 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab3GNQPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 12:15:22 -0400
Received: by mail-qc0-f172.google.com with SMTP id j10so5892978qcx.17
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hGC1ekbl7cwsDi5NhfrVwO+H8upaOd/wOXBOZBJXJlA=;
        b=w6+60LHaTFZ5RXVVMkIhojn3jirkayZXUchuSG7BalvQ45vIdwKM5O5gr7aN/qwZqi
         kWggZA3kDJAncN/QA8A+e45x6GaJ8MqKmnWjoPLFxh3/eV5kKT+oxsu9OobN5Xio69PS
         8C1P3ycQPPZkDprgoVT5O/tMDj197CY3Y/QwT1Pua1wCSmLEH1J23nKsu4UtHpn+O1kO
         gHJyvotXhqsXOvrSqD/FA6nSEaQWKiU0Y7uzrWDaHnN0wCjy9Fd31Eea8Y5kkkLP5JmO
         4aBqNha9PNBIIY9eIIsMD15fYzwgYBYaTVJck7J6RZlsDHNwKxSmFpv8bjfg8p7QFZ9G
         +TMA==
X-Received: by 10.49.26.202 with SMTP id n10mr45532843qeg.60.1373818521669;
        Sun, 14 Jul 2013 09:15:21 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id 4sm50014982qaq.6.2013.07.14.09.15.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 09:15:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <51DDC2AF.9010504@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230369>

On 07/10/2013 04:23 PM, Ramsay Jones wrote:
> Commit adbc0b6b ("cygwin: Use native Win32 API for stat", 30-09-2008)
> added a Win32 specific implementation of the stat functions. In order
> to handle absolute paths, cygwin mount points and symbolic links, this
> implementation may fall back on the standard cygwin l/stat() functions.
> Also, the choice of cygwin or Win32 functions is made lazily (by the
> first call(s) to l/stat) based on the state of some config variables.
>
> Unfortunately, this "schizophrenic stat" implementation has been the
> source of many problems ever since. For example, see commits 7faee6b8,
> 79748439, 452993c2, 085479e7, b8a97333, 924aaf3e, 05bab3ea and 0117c2f0.
>
> In order to limit the adverse effects caused by this implementation,
> we provide a new "fast stat" interface, which allows us to use this
> only for interactions with the index (i.e. the cached stat data).
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---

I've tested this on Cygwin 1.7 on WIndows 7 , comparing to the results 
using your prior patch (removing the Cygwin specific lstat entirely) and 
get the same results with both, so this seems ok from me.

My comparison point was created by reverting your current patch from pu, 
then reapplying your earlier patch on top, so the only difference was 
which approach was used to address the stat functions.

Caveats:
1) I don't find any speed improvement of the current patch over the 
previous one (the tests actually ran faster with the earlier patch, 
though the difference was less than 1%).
2) I still question this whole approach, especially having this 
non-POSIX compliant mode be the default. Running in this mode breaks 
interoperability with Linux, but providing a Linux environment is the 
*primary* goal of Cygwin.

Mark
