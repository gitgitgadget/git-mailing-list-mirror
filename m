From: Rafael Gieschke <rafael@gieschke.de>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 21:16:00 +0200
Message-ID: <8B762D96-54CF-4E42-BF90-7790E900AA30@gieschke.de>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de> <BANLkTinPHeSfZXRb7pqt7-XWkR5fH=wAjg@mail.gmail.com> <EC81F772-7149-40A0-891A-973C886AB052@gieschke.de> <7v62p68ut0.fsf@alter.siamese.dyndns.org> <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 21:16:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN8hm-0000m9-Hw
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 21:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933897Ab1ESTQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 15:16:13 -0400
Received: from smtp1.goneo.de ([212.90.139.80]:37042 "EHLO smtp1.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757088Ab1ESTQM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 15:16:12 -0400
Received: from smtp1.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id 9F5113A3BBC;
	Thu, 19 May 2011 21:16:10 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.87
X-Spam-Level: 
X-Spam-Status: No, score=-2.87 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.030, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
	by smtp1.goneo.de (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQqjF1uopmcX; Thu, 19 May 2011 21:16:09 +0200 (CEST)
Received: from [10.167.157.160] (unknown [89.204.137.160])
	by smtp1-587.goneo.de (Postfix) with ESMTPSA id 80BE43A3BAC;
	Thu, 19 May 2011 21:16:05 +0200 (CEST)
In-Reply-To: <BANLkTimDW8W13Wm8i+n0ww9jCeHsXc__iA@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173992>


Am 19.05.2011 um 20:07 schrieb Erik Faye-Lund:

> On Thu, May 19, 2011 at 7:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Probably a properly abstracted common version would look like a function
>> that calls four platform-dependent helper funcions in this order:
>> 
>>        0. prompt
>>        1. start "noecho" mode
>>        2. get whole line
>>        3. exit "noecho" mode
>> 
> 
> When I think about it a bit more, it feels a bit pointless:
> 0. is identical (fputs)
> 1. is different (tc[gs]etattr vs nop)
> 2. is different (getc vs _getch)
> 3. is different (tcsetattr vs nop)
> 
> So there's probably not much code to share here. There's a bit of
> logic, but I'm not entirely sure this should be the same either,
> because on Windows we have to take care of '\r' (since we open stdin
> in binary mode at start-up).
> 

I agree, 0 would even have to be different, too, as we have to write to /dev/tty (which would have to be opened first) or (as fallback) stderr on POSIX.


> diff --git a/compat/mingw.h b/compat/mingw.h
> index 62eccd3..e37d557 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -48,6 +48,8 @@ typedef int socklen_t;
> #define EAFNOSUPPORT WSAEAFNOSUPPORT
> #define ECONNABORTED WSAECONNABORTED
> 
> +#define PASS_MAX 512
> +

It might be worth to have this in git-compat-util.h, so it can also be used by compat/getpass.c. I'm not sure about the name, however; it's a remote password and MAX_PASS is about local passwords AFAIK. Maybe PASS_MAX_REMOTE or something similiar. Like that, compat/getpass.c could also be used in case MAX_PASS has some insanely low value on a platform.
