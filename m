From: "Blake Ramsdell" <blaker@gmail.com>
Subject: Re: [PATCH] Mac OS X 10.5 does not require the OLD_ICONV flag set
Date: Fri, 2 Nov 2007 13:03:05 -0700
Message-ID: <985966520711021303g905f638y2056219c22e5edeb@mail.gmail.com>
References: <1193971102-61907-1-git-send-email-blaker@gmail.com>
	 <7v4pg55893.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20711020319l26b4a8c1r99576dc29ea504d8@mail.gmail.com>
	 <7vbqad3pjw.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20711020423t6ce58818gcc5220b6427ded1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:03:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io2jk-0002jI-6s
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbXKBUDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 16:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194AbXKBUDI
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:03:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:30964 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbXKBUDG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 16:03:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1054347wah
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lMiqAQM3HhN8Smg5TYpW670tNgNA7xnbDNOmsSDKTt8=;
        b=RDzsTjwM+hGcI1L4S/3BaI/9IytEGJCeFFzQbAw/BWpBXPwAUFw1Rbvu75gmyan2MF8dIU3JyB5jvZ2amvvRJMwGowqCXogtju4Z17aJZGwRgLFsBi+cVzWnZ8QkimnxEmofYKPaqEdVdLk2zv9X5oTs2OVw7lLM1gep2P0m5KE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lkwfI7ZUXNwTC944apRVypHRaV7JGhH+ik369cRPyFwzIowZTWb+g4s2A7pRTajqqsCZ1KaRLPpRKAcd7wNdJ0YJfdB2FEHfL2mvtPDNKb6/pPx4RvpFmljQuPSyDepBy99R8M4C613yVtncdQzOCHni0KeeKSGSaO6UUTkY1SE=
Received: by 10.114.127.1 with SMTP id z1mr2276397wac.1194033785841;
        Fri, 02 Nov 2007 13:03:05 -0700 (PDT)
Received: by 10.114.176.14 with HTTP; Fri, 2 Nov 2007 13:03:05 -0700 (PDT)
In-Reply-To: <ee77f5c20711020423t6ce58818gcc5220b6427ded1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63163>

On 11/2/07, David Symonds <dsymonds@gmail.com> wrote:
> It would probably be most appropriate for the autoconf script. Now
> that I look at configure.ac, there's already a test for iconv in
> there; is it not used?

The crux of this problem is that the prototype for iconv in
/usr/include/iconv.h is different between OS X 10.4 and OS X 10.5. So
the "right thing" is definitely to determine what is in the function
prototype, and then act accordingly.

>From OS X 10.4.10:

#define _LIBICONV_VERSION 0x0109    /* version number: (major<<8) + minor */
...
extern size_t iconv (iconv_t cd, const char* * inbuf, size_t
*inbytesleft, char* * outbuf, size_t *outbytesleft);

>From OS X 10.5:

#define _LIBICONV_VERSION 0x010B    /* version number: (major<<8) + minor */
...
size_t iconv (iconv_t /*cd*/,
        char ** __restrict /*inbuf*/,  size_t * __restrict /*inbytesleft*/,
        char ** __restrict /*outbuf*/, size_t * __restrict /*outbytesleft*/);

So what happened in git is that someone put in OLD_ICONV to
dynamically adjust the const-ness of parameter 2 to the iconv
function, and the way they chose to do that is to identify the OS
(more accurately, the kernel), and then I went and furthered that by
identifying the version.

Now that I look at it further, it seems that yanking OLD_ICONV
altogether is a better approach, and to just check _LIBICONV_VERSION
to make sure it's "new enough". Now, I'm not sure what that comparison
would be, but we know that "later than 0x0109" is a good start. Based
on the version difference between OS X 10.4 and 10.5 I note that there
is only 0x010A intervening.

This strategy presumes that this const parameter was const all the way
up to a particular point, and then stopped being const, which is
probably a reasonable assumption.

Blake
-- 
Blake Ramsdell | http://www.blakeramsdell.com
