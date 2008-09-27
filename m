From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 3/4] mingw: move common functionality to win32.h
Date: Sun, 28 Sep 2008 01:51:02 +0400
Message-ID: <20080927215102.GF21650@dpotapov.dyndns.org>
References: <20080927084301.GB21650@dpotapov.dyndns.org> <200809272034.04931.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Sep 27 23:52:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjhi9-0004KG-7b
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 23:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbYI0VvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbYI0VvJ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 17:51:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:14100 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbYI0VvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 17:51:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1009290fgg.17
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RU6p3RAUX49Yyv7pOYKQbbmqtmKtiI8gPQ5wmvzfStU=;
        b=C4F9cZl+RyMf9G7DECKs5T94UZHy6nZHj8VDWG6Y/LYz7xsgWqB+kbs9JkG84YBRVX
         SPhEjBBjGePKfGzML2sO4xo73Y3LXleb5VaDQJCm8hxaiy0/JtnLusH5l67cigX4xden
         zGAvywc9UcZeYpZOn5JdXPYrkVi7f2anV/N78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wigHTw659wXhhg43nyp4cn/twpFpyORQ48i4klLdDnGuFEcq2ORubNrF9ZpUn1GXbn
         Nx7Z6jA07xUU3TGnKppZ6+cxRl4ctgfPJyTUHCY34u73kF9lWD9MOMcWUreRgRM6U7C8
         gY2dMP5KrrZMK/7liEC77bxxcIZjYz2w85f28=
Received: by 10.86.57.9 with SMTP id f9mr2668084fga.66.1222552266414;
        Sat, 27 Sep 2008 14:51:06 -0700 (PDT)
Received: from localhost (ppp85-141-151-122.pppoe.mtu-net.ru [85.141.151.122])
        by mx.google.com with ESMTPS id 4sm979063fgg.4.2008.09.27.14.51.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 14:51:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200809272034.04931.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96920>

On Sat, Sep 27, 2008 at 08:34:04PM +0200, Johannes Sixt wrote:
> On Samstag, 27. September 2008, Dmitry Potapov wrote:
> > +static inline int get_file_attr(const char *fname,
> > WIN32_FILE_ATTRIBUTE_DATA *fdata) +{
> > +	if (GetFileAttributesExA(fname, GetFileExInfoStandard, fdata))
> > +		return 0;
> > +
> > +	switch (GetLastError()) {
> > +	case ERROR_ACCESS_DENIED:
> > +	case ERROR_SHARING_VIOLATION:
> > +	case ERROR_LOCK_VIOLATION:
> > +	case ERROR_SHARING_BUFFER_EXCEEDED:
> > +		return EACCES;
> > +	case ERROR_BUFFER_OVERFLOW:
> > +		return ENAMETOOLONG;
> > +	case ERROR_NOT_ENOUGH_MEMORY:
> > +		return ENOMEM;
> > +	default:
> > +		return ENOENT;
> > +	}
> > +}
> 
> I've long wished for a function that translates Win32 error codes to errno 
> codes. It would be useful in a number of other places, too.
> 
> Here you introduce a new function get_file_attr() that is nothing but 
> GetFileAttributesExA() followed by such an error code translation.
> 
> I suggest that we leave the original call to GetFileAttributesExA() alone and 
> have a function win32_to_errno(void) that is just the switch statement above.

win32_to_errno was the first thing that implemented but then released
that translation of Win32 errors to errno cannot be in general case.
For instance, ERROR_BUFFER_OVERFLOW means ENAMETOOLONG here, but it
can be translated to ETOOSMALL in other cases. How do you propose to
deal with that?

So I have not found a better solution than to add get_file_attr(), which
calls GetFileAttributesExA() and translates Win32 error.


Dmitry
