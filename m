From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/11] Remove va_copy at MSVC because there are
 va_copy.
Date: Mon, 17 Aug 2009 18:49:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171840450.4991@intel-tinevez-2-302>
References: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5PQ-0005J7-Oo
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757566AbZHQQtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757553AbZHQQtm
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:49:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:35516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757380AbZHQQtl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:49:41 -0400
Received: (qmail invoked by alias); 17 Aug 2009 16:49:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp027) with SMTP; 17 Aug 2009 18:49:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EsL1AvbxE0JywzJ/kZOqz6ZgfOqLg8GHDBNuNge
	apk2HL1fEkWq91
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126227>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> MSVs have not implemented va_copy. remove va_copy at MSVC environment.
> It will malloc buffer each time.
> 
> Signed-off-by: Frank Li <lznuaa@gmail.com>

How about this instead?

	Work around Microsoft Visual C++ not having va_copy()

	In winansi.c, Git wants to know the length of the formatted string 
	so it can allocate enough space for it.  But Microsoft Visual C++
	does not have va_copy(), so we have to guess.

The problem is the guessing part:

> diff --git a/compat/winansi.c b/compat/winansi.c
> index 9217c24..6091138 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -310,9 +314,13 @@ static int winansi_vfprintf(FILE *stream, const char *format, va_list list)
>  	if (!console)
>  		goto abort;
>  
> +#ifndef _MSC_VER 
>  	va_copy(cp, list);
>  	len = vsnprintf(small_buf, sizeof(small_buf), format, cp);
>  	va_end(cp);
> +#else
> +	len= sizeof(small_buf) ;
> +#endif

small_buf only is 256 bytes.  How do you want to make sure that the 
subsequent vsnprintf() is not writing outside of the buffer?

Also, you still miss a space between "len" and "=".

Ciao,
Dscho
