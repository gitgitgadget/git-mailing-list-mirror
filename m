From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH, maint] setup: make sure git_dir path is in a permanent
 buffer, getenv(3) case
Date: Fri, 12 Nov 2010 10:03:32 -0600
Message-ID: <20101112160332.GB15141@burratino>
References: <1289498903-18413-1-git-send-email-kirr@mns.spb.ru>
 <20101111181728.GF16972@burratino>
 <20101112140329.GA29604@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Nov 12 17:04:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGw6k-0000Sa-3Q
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 17:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524Ab0KLQEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 11:04:01 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52201 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512Ab0KLQEA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 11:04:00 -0500
Received: by fxm6 with SMTP id 6so218868fxm.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 08:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LEN0/nWxhvlTRotvsZGdiDMu6/t8Ksb+mDVcsVVKXxE=;
        b=OZbz0YqqjnmxhhJ0NkjB3KMVchnqFRTXWjIhnXhhIh0Xizhm1CLvHhT8b1VKfG9p1U
         PS3x6Bwr1X+BEbuZoS1LDIneB4QjihetXsTjCm5bntrxe/AbPwnjxAiYOjZK4a11/P/E
         MZhNEUHtow8x7WylsFhQw49TD7NSoZZ/OsCJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AghGYuwX+fjAEliGx4S4aPjf+VL0Ex2YyIhM8qdCmhu1l2ATEOo6WigW1XOODF4S6I
         HNu0d+uQoXutJJI8etbDSOBReEgmZIWpGIg1amGjLAoCjDaaYsfMqGhgX4hampR0MvVh
         s0nlWVCPJQilyKFbwwIB56A2kiCDBW47tVhbk=
Received: by 10.223.86.197 with SMTP id t5mr1722055fal.38.1289577839413;
        Fri, 12 Nov 2010 08:03:59 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 3sm72358fav.36.2010.11.12.08.03.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 08:03:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101112140329.GA29604@tugrik.mns.mnsspb.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161349>

Kirill Smelkov wrote:

>     static void run_service(const char **argv)
>     {
>             const char *encoding = getenv("HTTP_CONTENT_ENCODING");
>             const char *user = getenv("REMOTE_USER");
>             const char *host = getenv("REMOTE_ADDR");
> 
> 
> etc...
> 
> 
> To me, it's very unfortunate that subsequent getenv() could overwrite
> previous getenv() result, but according to `man 3 getenv` all these
> places are buggy.

Right, but do we know of any platforms that work that way currently?
We could make getenv() rotate between a few buffers on such platforms
(probably 10 or so would take care of the longest runs).

> Maybe we'll need something like our own xgetenv() which will keep vars
> in some kind of hash tab so that get/put on other vars do not interfere
> with what was originally returned by xgetenv().

For examples that store the result like you pointed out (which store the
result from getenv), something like that would be needed if we want
them to work on platforms where putenv shifts everything.

> Unfortunately I can't afford myself to dive into all this, so please
> choose what you like more.

I think we ought to fix this properly in the end.  But if you want a
quick workaround, maybe the vcs-svn/string_pool lib could help you.

Hope that helps,
Jonathan
