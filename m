From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 15 Apr 2016 16:32:30 -0700
Message-ID: <CA+P7+xoMVzYwWv3=7hTUM7gMjm4i7Vv74aoyw17T_CbToZTVaA@mail.gmail.com>
References: <1460761306-18794-1-git-send-email-sbeller@google.com>
 <1460761306-18794-3-git-send-email-sbeller@google.com> <CA+P7+xq-njse8TKWExwKWx=6ynVNwM1ODHnTij6pdQNejvKT=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 01:32:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arDEO-0005nR-IN
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 01:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbcDOXcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 19:32:51 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36603 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcDOXcu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 19:32:50 -0400
Received: by mail-ig0-f175.google.com with SMTP id f1so32166142igr.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q5Upq3FGheQJIH9TJ1oBCzmGmTn1qxNCHOpSh5iAyJQ=;
        b=jSHxBmYSYG9D0tbx/79ihS6Ph1gMHLwFCa8huwgueA3eNtW3F8QbkJtzbRZ8RIeOsI
         1muT3Ld5+zRwfYJW1Y4sebTwZzQj4Iwp10KXVuxb3TStce4DTDHhVru7c+pTar0YbQ3+
         6g5yBtDA34c9ax9KbaLGhjWpjbi3BGqba30V7E+aKZUVAzv0KVhkH6PB74KEYWYFZRIv
         2kVTuz+29nqPxSSWJF7SoEGkIJGWUlIXVArEvhzW9l2PplcffmqPhlqVb8nye5Gxp9Uh
         4N/KJrKGMpPe1c72O0E1+7RwzIU9BJlOWw+ADLjWs1PE5OIFylu/8sO6u+UdVZzawwFt
         QESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q5Upq3FGheQJIH9TJ1oBCzmGmTn1qxNCHOpSh5iAyJQ=;
        b=a88Y/PM1PzixmKvQRszG3IkS69OAdFxw/hEsTUUzkKGpM0djsdvVdvHypuPR3a+a+m
         VGHYdlHU9m1q4vTiof7wwXq3TmKPhbGFicA6bTZxjwamovJuYDHMcpIDCEXYVyVBQA4B
         ByNCP8uhzPmHe+1lpxJzYjCh1gtIVk3ERsPja2ijoBucINutAkzZdxjHNencEcEGhKQ3
         kfhIAJhIPf7I2eN9wppMu8MGvv347PNwg4oytTV9rxOwgHesPZb61NoiNIsEnfOUCFAE
         1lr6urxz0msGScA+t2ZMjXLPmE4/faDNy1nhics/i3qzuJcpuPGTgnMqtMSW6oz1OSOH
         sXXw==
X-Gm-Message-State: AOPr4FWRqaG7Qwv1qAzwYhmZ2bLh2qlb0rAaQFkN5YN1xypUsOWdnsbPCqNiyv2gmpr0LdpAyYNKZtaPFzJruA==
X-Received: by 10.50.123.132 with SMTP id ma4mr7947090igb.92.1460763169913;
 Fri, 15 Apr 2016 16:32:49 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 16:32:30 -0700 (PDT)
In-Reply-To: <CA+P7+xq-njse8TKWExwKWx=6ynVNwM1ODHnTij6pdQNejvKT=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291698>

On Fri, Apr 15, 2016 at 4:05 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> There's a few places that will need cleaning up (comments and such)
> that mention empty line still, but that's not surprising. I am going
> to test this for a bit on my local repos, and see if it makes any
> difference to the old heuristic as well.
>
> Thanks,
> Jake
>

I ran this heuristic on git.git and it produces tons of false positive
transforms which are much lease readable (to me at least), far more
than those produced by the newline/blank link heuristic did.

I think we should stick with the empty line heuristic instead of this
version, even if it's easier to implement this version.

We still would need to figure out how to handle CRLF properly but it's
worth resolving that than this heuristic is.

Thanks,
Jake
