From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] MSVC: fix stat definition hell
Date: Tue, 10 Sep 2013 20:35:41 -0400
Message-ID: <CAPig+cTU6iuv84QH+Y+u4UJ9b-aHQo7zzTv6umnG1tZ9v7+nvw@mail.gmail.com>
References: <522FA959.80108@gmail.com>
	<522FA9E1.7010705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 02:35:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJYPM-0006Vv-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 02:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab3IKAfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 20:35:44 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:41999 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab3IKAfn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 20:35:43 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so6706897lab.24
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 17:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iqHAo5FiM0S6yJ3MI/+RN57JMGujU5Z9GPj0BV7dp/0=;
        b=N8ENE8YhTYd8ca0vdyQ8gQBGoDu5xyJBFwj7Utdw2cekbGAtrhehVN1jzrK8J17B+h
         yNNYeM/2hTXKtbS/W7bw6SkEnr3u+S4SrCC8RQ0si/TzoyQOfmUgbBaJWTTCVP4Rv6OT
         hZai2IkVn3b4H1aHHOM76BxVycDNZMc5AK8j73foQO6B+5yIdXzUbNRqOW+xXDfEgTYG
         gSMLZSGXMaBC5sf5mx7ZCTtAYUVN15yg+q7Jjy3DqhKc//RQuZY7MDtRgQv+KuFUZrmj
         V59vqXJCt03pS7V/WjkO1Q45IFA6MYtbHYHxNW8XrOSoa/8ljPdCAHA27yPcNu2+RvuR
         gBug==
X-Received: by 10.112.89.100 with SMTP id bn4mr428117lbb.16.1378859742046;
 Tue, 10 Sep 2013 17:35:42 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Tue, 10 Sep 2013 17:35:41 -0700 (PDT)
In-Reply-To: <522FA9E1.7010705@gmail.com>
X-Google-Sender-Auth: YmTIkrmRhl2IA7XVVGcXmZUymvU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234516>

On Tue, Sep 10, 2013 at 7:23 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> In msvc.h, there's a couple of stat related functions defined diffently

s/diffently/differently/

> from mingw.h. When we remove these definitions, the only problem we get is
> "warning C4005: '_stati64' : macro redefinition" for this line in mingw.h:
>
> #define _stati64(x,y) mingw_stat(x,y)
>
> The reason is that as of MSVCR80.dll (distributed with MSVC 2005), the
> original _stati64 family of functions was renamed to _stat32i64, and the
> former function names became macros (pointing to the appropriate function
> based on the definition of _USE_32BIT_TIME_T).
>
> Defining _stati64 works on MinGW because MinGW by default compiles against
> the MSVCRT.DLL that is part of Windows (i.e. _stati64 is a function rather
> than a macro).
>
> Note: MinGW *can* compile for newer MSVC runtime versions, and MSVC
> apparently can also compile for the Windows MSVCRT.DLL via the DDK (see
> http://www.syndicateofideas.com/posts/fighting-the-msvcrt-dll-hell ).
>
> Remove the stat definitions from msvc.h, as they are not compiler related.
>
> In mingw.h, determine the runtime version in use from the definitions of
> _stati64 and _USE_32BIT_TIME_T, and define stat() accordingly.
>
> This also fixes that stat() in MSVC builds still resolves to mingw_lstat()
> instead of mingw_stat().
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
