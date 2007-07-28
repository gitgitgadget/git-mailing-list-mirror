From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make verify-tag a builtin.
Date: Sat, 28 Jul 2007 20:02:09 +0200
Message-ID: <1b46aba20707281102j6d519125y176fd11e3ab53fab@mail.gmail.com>
References: <46A96F86.2030704@gmail.com>
	 <7vr6mu2uo0.fsf@assigned-by-dhcp.cox.net>
	 <1b46aba20707271251g7cf968a6o3840739dec548408@mail.gmail.com>
	 <7vtzrpwo44.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 20:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEqcJ-0004NJ-Sd
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 20:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbXG1SCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 14:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbXG1SCL
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 14:02:11 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:54338 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbXG1SCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 14:02:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1279752wah
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 11:02:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=InKJGwh7o0MrjyOVQeYh3436WxXQ04WE/ExRbNlXwJRJ8KR6lMm/w1agLRVLMYawm4S6RcbSN7xz2QRqn98SweJQ8N1tBR7YWvkzaalYIaCT4BCM3QS5BE7RJbrZ3R72mpNFp+LYR/yfswMBNYdl+bGKERG5DQd4zDBB+SMWCyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qn0hb9IVMmywqQsKBI38ycPg1JUMGCNGV6pMnXUOF9aTJ7jrIgCTLWIh+LvtpmDe8X0J9EeUhBHO5T8K+JVuNghzXQHVYdbdepdosySs+AESMmizxcAZfta2TlsVR4mNSfm2BcDQwe9LJH+pe660I5mMSXy1atiYkpZG8JHqPjo=
Received: by 10.114.57.1 with SMTP id f1mr4067330waa.1185645729150;
        Sat, 28 Jul 2007 11:02:09 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Sat, 28 Jul 2007 11:02:09 -0700 (PDT)
In-Reply-To: <7vtzrpwo44.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54045>

Your explanation about the I/O in parallel sounds much better to me,
now I understand, thank you Junio.

2007/7/27, Junio C Hamano <gitster@pobox.com>:
> What is happening is:
>
>  1. Your process prepares the whole thing in vtag-tmp, to hand
>     to gpg;
>
>  2. You make a pipe and start gpg with the above file telling it
>     "here is a detached signature file, the payload will be fed
>     through your stdin";
>
>  3-a. You feed the payload to the pipe, expecting gpg to read it.
>
>  3-b. gpg reads the detached signature file, finds no signature in
>     the vtag-tmp file because the tag in question is not signed,
>     and exits without reading a single byte from the pipe;
>
> Now, 3-a and 3-b run in parallel.  If 3-a is scheduled before
> 3-b happens, because payload is very often much smaller than the
> in-kernel pipe buffer, your write(2) succeeds before gpg gives up
> and exits without reading from the pipe.  If 3-b is scheduled
> before 3-a, then gpg exits and when 3-a gets around to write(2)
> to the pipe, write notices that there is nobody on the other end
> of the pipe, and you get SIGPIPE.
