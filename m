From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Tue, 16 Jul 2013 19:13:18 -0400
Message-ID: <51E5D38E.6080202@gmail.com>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk> <51E2CE97.2040900@gmail.com> <51E5BCDF.5070004@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 17 01:13:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzEQw-0000Rc-JE
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 01:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933680Ab3GPXNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 19:13:22 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:53241 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933635Ab3GPXNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 19:13:21 -0400
Received: by mail-qa0-f41.google.com with SMTP id f14so2652941qak.0
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eq69rat01kcDSvi4gHzuLdfAaIh/sOo+FJYXolNtl1s=;
        b=i9qQFpWooFlV6b3eEuGUbZxmS9ZzBMYOXZ7MlgJmbq6DKWwzzurS/d1XUeRV9q+nDF
         oePChYzxi+8/q3flcPgy3CxWAhYgchXIOm50V2icoeVQQpGZgjkFyuEf3uJ6ai47BDnS
         OEUYqEAd19h0x6jkXEcKbyPWKQEH4Cl6bvH8DLR4Oe0OT7i0mFSnNIJbFc5jeg/TklmL
         9wnm4ISFcX67ECmRY0xZHCl3ypqIzhJyD6xCn7yj+nVNN3XN4Pe2pDhNVQJRp+ooP84G
         L8kEahtURosAZNuW6ui7Bnkx/5AxZipeqrbMEWxpLrFUfROLisePI0U3FxfJFs3knh/b
         rpng==
X-Received: by 10.224.54.204 with SMTP id r12mr6217730qag.105.1374016400449;
        Tue, 16 Jul 2013 16:13:20 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id r2sm4995893qeh.7.2013.07.16.16.13.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 16:13:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <51E5BCDF.5070004@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230594>

On 07/16/2013 05:36 PM, Ramsay Jones wrote:
> Caveats:
> 1) I don't find any speed improvement of the current patch over the
> previous one (the tests actually ran faster with the earlier patch,
> though the difference was less than 1%).
> 2) I still question this whole approach, especially having this
> non-POSIX compliant mode be the default. Running in this mode breaks
> interoperability with Linux, but providing a Linux environment is the
> *primary* goal of Cygwin.
> Yes, I agree. Since I _always_ disable the Win32 stat functions (by
> setting core.filemode by hand - yes it's a little annoying), I don't
> get any "benefit" from the added complexity.
>
> However, I don't use git on cygwin with *large* repositories. git.git
> is pretty much as large as it gets. So, the difference in performance
> for me amounts to something like 0.120s -> 0.260s, which I can barely
> notice.
>
> Other people may not be so lucky ...
>
> I would be happy if my original patch (removing the win32 stat funcs)
> was applied, but others may not be. :-P
>
> ATB,
> Ramsay Jones
>
Cygwin 1.7 is very different than the earlier, no longer supported, and 
no longer available Cygwin variants in many ways, but stat is one of 
them. Cygwin 1.7 uses Windows ACLs to represent file permissions, and 
therefore gets the file permissions directly from the underlying OS 
calls. Earlier Cygwin versions (attempted to) overlay POSIX permissions 
on Windows systems using extended attributes and other means, and in 
many cases had to resort to opening the file and examining it to 
determine executability. This is not true in 1.7.

Therefore, your later patch would be expected to have much less benefit 
for 1.7 than for 1.5 (I don't detect *any* benefit on 1.7 when I set 
core.filemode=false). There are many choices, three are:

a) Remove the win32 stat funcs, eliminating all of the troublesome code 
paths and maintenance burden (your original patch).
b) Add your latest patch, with attendant complexity and maintenance 
burden, to support a version of Cygwin that is no longer available and 
was last updated over four years ago.
c) Like b, except make this triggered only by a "CYGWIN_15" macro, 
limiting this to use by the legacy cygwin platform.

I strongly vote for a, could support c, but fear b is just going to keep 
us chasing down bugs. Especially so when we consider that this patch can 
only speed things up when core.filemode=false, which mode:
a) causes git to fail its test suite.
b) breaks compatibility with Linux
c) violates the primary goal of the Cygwin project, which is to provide 
a Linux environment on Windows.

Mark
