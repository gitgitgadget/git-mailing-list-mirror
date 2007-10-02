From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 1/2] Change "refs/" references to symbolic constants
Date: Tue, 2 Oct 2007 09:41:03 +0100
Message-ID: <200710020941.05288.andyparkins@gmail.com>
References: <200709291359.59147.andyparkins@gmail.com> <200710012141.44459.andyparkins@gmail.com> <20071002011659.GA7938@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 10:41:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcdJg-00078S-Cj
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 10:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbXJBIlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 04:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXJBIlM
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 04:41:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:20291 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbXJBIlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 04:41:10 -0400
Received: by nf-out-0910.google.com with SMTP id g13so3177369nfb
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=00n5eb54Jdq9u8rAoO36KtS7I9CZef4vlw48R3nUMgc=;
        b=f/eXL/n4twM7yRYHcEJnL6c8UDFZ3F48sYp09E635+udbiSVIG7sPdlZnRBF8c9NWP5jMxpAAZk84V7MH6jKbOjpK5YsG4FXqQ0vUldKui2kkjIvjhi/tQQT6D1g5o9jB3Lh3NeMvmLW/LGrdyZ+HwNfS/87aECpUSgJ5l5Cx2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GZyyWsdkK0NoX69dvMv32YlkA/2v7h2y8x6CZoZ3ymZ8S4OaR803/43lX7r2B2SR8fltNsaby9HN3ECWm0zPGNOXNqnrnzfVQywz5sdCESrYcdKST2T9YaDe+2WVexDU0xUTF+DLY4LSbIdZBnsUCf99JcDeDKdCWBxKcsMaYpU=
Received: by 10.78.107.8 with SMTP id f8mr4328142huc.1191314469234;
        Tue, 02 Oct 2007 01:41:09 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id d2sm1408603nfc.2007.10.02.01.41.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2007 01:41:08 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20071002011659.GA7938@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59673>

On Tuesday 2007 October 02, Jeff King wrote:

> -		    patlen != namelen - 5 &&
> -		    prefixcmp(name, "refs/heads/") &&
> -		    prefixcmp(name, "refs/tags/")) {
> +		    patlen != namelen - STRLEN_PATH_REFS_HEADS &&
> +		    prefixcmp(name, PATH_REFS_HEADS) &&
> +		    prefixcmp(name, PATH_REFS_HEADS)) {
>
> This is totally bogus. You meant STRLEN_PATH_REFS, and the second path
> should be PATH_REFS_TAGS. With those changes, t5516 passes.

Excellent!  Well done.  I spent a couple of hours last night going through 
every changed line and have spotted the TAGS mistake but didn't spot the 
STRLEN being wrong.  Amazing how easy it is to become blind to these things.  
There were a couple of errors in "/" placement too, but I don't think they 
were causing any trouble, just doubled up "/" characters.

> I haven't combed through your patch in detail, so there might be similar
> problems lurking. I did notice one or two spots where you call
> strlen(PATH_REFS_*), which should of course also be changed to
> STRLEN_PATH_REFS_*.

I think I caught a few of them in my review.  I think I had originally left 
them like that on purpose.  My reasoning was that a patch like that should 
leave the resultant code identical.  So I did replacements like:

- strlen("refs/heads/");
+ strlen(PATH_REFS_HEADS);

However, I think it was just pedantry, so I've been correcting them too.

I noticed a couple of places where memcmp() has been used where prefixcmp() 
would work fine.  I'm tempted to change them too - what do you think?  
Perhaps a separate patch?

> And as a final comment, your patch doesn't apply to next at all because
> of the reorganization of the fetching API (e.g., fetch-pack.c doesn't
> exist at all anymore). You should probably prepare a parallel patch for
> next.

I'm happy to do prepare a patch against any revision, I was really waiting for 
feedback from Junio as to how he'd like to manage it.  Last time I submitted 
this patch he (quite correctly) asked that I delay until after the next point 
release; of course I promptly found other things to do and never 
resubmitted :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
