From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] compat/nedmalloc: Fix compiler warnings on linux
Date: Sun, 28 Apr 2013 22:06:16 -0700
Message-ID: <20130429050616.GB8031@elie.Belkin>
References: <517C1CF9.2080903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 29 07:06:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWgIF-0005fc-HG
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab3D2FGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 01:06:23 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:45622 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3D2FGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 01:06:23 -0400
Received: by mail-da0-f52.google.com with SMTP id j17so2776156dan.39
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vc/8R4Wef6oRPX11S0AgZF/VWbCn5AQ676qB/tQ33og=;
        b=BrQKyGUWeiQMU+sq4p821ozSLcHZf8WV/S4cqFCMKm6gdO5B6dd3/FY2eA/ZRct/Vh
         im5820VFf53FNzuka2MXWJktu/q0xTD7BvAgIYsxLBQaMTx39jFK7fa9fSCsybUkjBhA
         iAX5knXr+K4Id0/BKqviOjxW2B5onpxOKKcDsKy0sq5DvPV+SSYDERqaJrc92xYq/ghf
         ZT135tGInughnuhZ49XWZpCZeaTSoxdAV7h4Dg8TU3tp1ZoCLcl1b1bIW7wnJUxAlGE3
         PG1ETOBaxqDQx27dSN1AyGVpJtjRLf5ezdRKfns7prSQXNNxdvzt59LI+K1sUTkpozWI
         i+sw==
X-Received: by 10.68.172.65 with SMTP id ba1mr69739494pbc.166.1367211982463;
        Sun, 28 Apr 2013 22:06:22 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ya4sm22438005pbb.24.2013.04.28.22.06.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 28 Apr 2013 22:06:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <517C1CF9.2080903@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222767>

Hi,

Ramsay Jones wrote:

> --- a/compat/nedmalloc/malloc.c.h
> +++ b/compat/nedmalloc/malloc.c.h
> @@ -484,6 +484,10 @@ MAX_RELEASE_CHECK_RATE   default: 4095 unless not HAVE_MMAP
>  #define DLMALLOC_VERSION 20804
>  #endif /* DLMALLOC_VERSION */
> 
> +#if defined(linux)
> +#define _GNU_SOURCE 1
> +#endif

If we want to do this, I'd suggest defining _GNU_SOURCE
unconditionally.  Other platforms using glibc would benefit from it,
too, and other platforms not using glibc shouldn't care.

Alternatively it could make sense to see if the latest version from
Niall Douglas[1] works, which includes the following:

	#ifndef HAVE_MREMAP
	#ifdef linux
	#define HAVE_MREMAP 1
	#ifndef _GNU_SOURCE
	#define _GNU_SOURCE /* Turns on mremap() definition */
	#endif
	#else   /* linux */
	#define HAVE_MREMAP 0
	#endif  /* linux */
	#endif  /* HAVE_MREMAP */

It looks equally wrong there, but since it comes from upstream we
could just punt to him if anyone runs into problems. ;-)

My two cents,
Jonathan

[1] http://www.nedprod.com/programs/portable/nedmalloc/
