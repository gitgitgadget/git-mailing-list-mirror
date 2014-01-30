From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Ensure __BYTE_ORDER is always set
Date: Thu, 30 Jan 2014 14:02:33 -0800
Message-ID: <20140130220233.GH27577@google.com>
References: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 23:02:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8zh3-00032V-MC
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 23:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbaA3WCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 17:02:37 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:60133 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbaA3WCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 17:02:37 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so3648161pab.21
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 14:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EbMuRh055oUH9g+yiJHjmUrCslmfxCzE9R+hQr/e2OQ=;
        b=ZZLnS4m1EPEeCJZYWPM33y2Xkix8pjcgA0POpsXd2k6A1/Wjylv6ss9LDzlWO7uwTU
         hPMGe+UZnu9lHK0Ut3po2blxbeYsCTscT2qa1RRYAcOqGJrTY03asXsT/0g/8Ck9550Y
         Y/4jqAMP87CSK1U3Ill2ky6mxs+BohgI8757WejL2Sz/4lRg4Eo8Dmtw6lQ7bJk9vW22
         awgHZzjJfKJ2bIOFhXBujIeyw1cxUPsHpYiJgVQ8ENI6DVB7WIVEvVFCWNwBxuRdk87Y
         aVaS0RhBP7DTl1Eiib1RnKPiyEPXJD6faCvx8HJ/L7EJVToZ/Ouxv2mTMYlV61f1jakk
         i8xw==
X-Received: by 10.66.180.200 with SMTP id dq8mr17057301pac.104.1391119356692;
        Thu, 30 Jan 2014 14:02:36 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xv2sm20803297pbb.39.2014.01.30.14.02.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jan 2014 14:02:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241282>

Hi,

Brian Gernhardt wrote:

> a201c20 (ewah: support platforms that require aligned reads) added a
> reliance on the existence of __BYTE_ORDER and __BIG_ENDIAN.  However,
> these macros are spelled without the leading __ on some platforms (OS
> X at least).  In this case, the endian-swapping code was added even
> when unnecessary, which caused assertion failures in
> t5310-pack-bitmaps.sh as the code that used the bitmap would read past
> the end.
>
> We already had code to handle this case in compat/bswap.h, but it was
> only used if we couldn't already find a reasonable version of bswap64.

Makes sense.  Sorry I missed this.

In an ideal world I would prefer to just rely on ntohll when it's
decent (meaning that the '#if __BYTE_ORDER != __BIG_ENDIAN' block
could be written as

	if (ntohll(1) != 1) {
		...
	}

or

	if (ntohll(1) == 1)
		; /* Big endian.  Nothing to do.
	else {
		...
	}

).  But compat/bswap.h already relies on knowing the endianness at
preprocessing time so that wouldn't buy anything.

Another "in an ideal world" option: make the loop unconditional after
checking that optimizers on big-endian systems realize it's a noop.
In any event, in the real world your patch looks like the right thing
to do.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
