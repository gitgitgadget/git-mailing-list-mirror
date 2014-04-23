From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] pack-bitmap: do not core dump
Date: Tue, 22 Apr 2014 17:40:23 -0700
Message-ID: <CC07C833-D42A-488D-8523-46445F8C1C20@gmail.com>
References: <781073ea08e86301f62e708bc0b80fd@74d39fa044aa309eaea14b9f57fe79c> <20140422231748.GA20353@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 02:40:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WclEm-0006ZD-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 02:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbaDWAk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 20:40:28 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55077 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbaDWAk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 20:40:27 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so177179pab.39
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 17:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=cON2HWqtnNGtLnFxGBIFNrmAcoW6a/aRj+B6SzjEFOg=;
        b=si3nwftLyAdOBZ480vG7duqpcTTdpyMTEq8xpIlftns/Aeg9BxBDj5gcKBvLjJnDip
         acdaomjcTg0rEWpZ4sLlQ3gfbOfZFZZatnS7+y+0bqUNSMtGKBty+pcd7eGTOCCoVGCn
         XgFZxlWd7yKkeenjXPWWxR5gxQOmpPLdLPPQiB9aXaQOPO/50nEeNnOLOSbcqRN7405T
         c47prEE8yGL89qCMJL9AgY22tVFD2/yQ2UKAKoS2GyTYCUPoG8cHidRat5RO1xO6u+Hc
         +LIgzSRgH3gpQyJEipQo39GLiBjsSecQSj/nndDjq1kIYhYvXi1BEGgxG5FvBfRUZnTI
         pkdg==
X-Received: by 10.68.202.194 with SMTP id kk2mr7721036pbc.156.1398213626522;
        Tue, 22 Apr 2014 17:40:26 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id vm3sm58835563pbc.45.2014.04.22.17.40.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 17:40:25 -0700 (PDT)
In-Reply-To: <20140422231748.GA20353@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246807>

On Apr 22, 2014, at 16:17, Jeff King wrote:
> but I do not think that is necessarily any more readable, especially
> because we probably need to cast it like:
>
>  self->rlw = (eword_t *)((uint8_t *)self->buffer + rlw_offset);

I suspect that will produce a warning about a cast increasing pointer  
alignment in some cases.

> So why do any uint8_t math in the first place?

Just guessing it started out as uint8_t math throughout then the  
warning about increasing alignment showed up so that part got changed  
but the save pointer offset part did not.

> I think we could write it as:
>
> 	eword_t *old = self->buffer;
> 	... realloc ...
> 	self->rlw = self->buffer + (self->rlw - old);

Yeah that seems good too.

> I'm fine with your patch, though.


thanks.

I tend to gravitate towards the most minimal change that fixes the  
issue when touching someone else's code especially if I'm not familiar  
with it.  There's also the minor issue of optimizing out the pointer  
arithmetic implicit divide by sizeof(eword_t) for the subtract and the  
implicit multiply by sizeof(eword_t) for the add -- I didn't check to  
see if one of the alternatives is best -- the one you mention above  
with the cast (keeping the uint8_t math) is probably guaranteed not to  
have any implicit multiply, but there's that pesky warning to get rid  
of.  Of course those multiplies and divides should just end up being  
shifts so not a big deal if they didn't get optimized out (the realloc  
time should dwarf them into irrelevancy anyway).

--Kyle
