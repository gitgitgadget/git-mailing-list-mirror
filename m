From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH] config.c: change the function signature of `git_config_string()`
Date: Tue, 22 Jul 2014 17:11:02 +0530
Message-ID: <53CE4DCE.1010908@gmail.com>
References: <1406026196-17877-1-git-send-email-tanayabh@gmail.com> <20140722110720.GA386@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 13:41:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9YRb-0007SD-NJ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 13:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbaGVLlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 07:41:10 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34637 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaGVLlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 07:41:09 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so10957293pdb.41
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9PQ3hz3DGLwN4WAbcdFeGPpsqYVYpxcEfCHNTn4MiQw=;
        b=wru18yqWjh97t3Hw3Bn5EPrnZZT0SUVzVK6IFJ8AHFF986Hq57phEsMIYCDyR2d0H/
         I82U9yyVI92DfG/goVmCUCuPOYbf0dcAwQ1VnPL3bFPqTdEdY/ztro7XGzVH9AH7lI2r
         xPyxd9RNEYX1dfJ7lwO/aPbMD3aRaptc5u3Rg++niJOUdfLJ1eguGZ5FRry1bUs75p2y
         IhwsvNG1Hyjw+2IlMPB8CmEsfClK8rUZSSnt2Fg7DiWXNwEmWfC3caGBKKLvYWhLVfTU
         S6BiwUubSMtLo4avkhdZo/qkDI2hGjHy0WM797yuF6JgJrnNiG4bxGNOb54thVhj8NRG
         g2Wg==
X-Received: by 10.70.128.140 with SMTP id no12mr321393pdb.147.1406029268426;
        Tue, 22 Jul 2014 04:41:08 -0700 (PDT)
Received: from [127.0.0.1] ([182.67.207.4])
        by mx.google.com with ESMTPSA id kq7sm150923pbc.90.2014.07.22.04.41.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jul 2014 04:41:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140722110720.GA386@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254014>



On 7/22/2014 4:37 PM, Jeff King wrote:
> On Tue, Jul 22, 2014 at 03:49:56AM -0700, Tanay Abhra wrote:
> 
>> `git_config_string()` output parameter `dest` is declared as a const
>> which is unnecessary as the caller of the function is given a strduped
>> string which can be modified without causing any harm.
>>
>> Thus, remove the const from the function signature.
> 
> You are correct that it is unnecessary. However, this patch alone is not
> sufficient because of the way const-ness in C works. If I have:
> 
>   static const char *some_global;
> 
> then with your patch, calling:
> 
>   git_config_string(&some_global, var, value);
> 
> will complain that we are passing a pointer to "const char *", not a
> pointer to "char *". And indeed, compiling with your patch introduces a
> ton of compiler warnings.
>

I had also thought that the compiler would raise lot of warnings but it didn't
on the first compile.
Now I checked again and now it complains a lot, maybe it because I was tinkering
with my config.mak, dunno.

> We would have to convert each of the variables we pass to it to:
> 
>   static char *some_global;
> 
> That's not so bad, but:
> 
>   static char *some_global = "some_default_value";
> 
> is wrong. Such a global sometimes points to const storage (i.e.,
> initially), and sometimes to allocated storage (if it was loaded from
> config). We simply keep the latter as a const pointer (since we would
> not bother to free it at the end of the program anyway), and that
> decision influences git_config_string, which is just a helper for
> setting such variables anyway.
> 
> So I would not mind lifting this unnecessary restriction on
> git_config_string, but I do not see a way to do it without making the
> rest of the code much uglier (and I do not see a particular advantage in
> modifying git_config_string here that would make it worth the trouble).
> 

Yes, you are right. This patch is the conclusion of discussion in [1].
I used the same function signature as git_config_string for
git_config_get_string() which lead to some ugly casts like

+git_config_get_string("imap.folder", (const char**)&imap_folder);

in imap-send.c patch and others. What should we do about such cases, I used
either an intermediate variable or casts but Junio commented that it would be better
if the dest parameter was a non-const and that it was a weakness of the config-set
API that demanded the dest to be a const pointer.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/253948/
