From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH] MinGW readdir reimplementation to support d_type
Date: Thu, 09 Apr 2009 22:34:38 +0200
Message-ID: <49DE5BDE.9050709@kdbg.org>
References: <1239224507-5372-1-git-send-email-marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: marius@trolltech.com
X-From: git-owner@vger.kernel.org Thu Apr 09 22:36:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls0z2-0004eX-PA
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 22:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936331AbZDIUeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 16:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762291AbZDIUeo
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 16:34:44 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:15756 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761962AbZDIUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 16:34:44 -0400
Received: from [77.118.127.118] (77.118.127.118.wireless.dyn.drei.com [77.118.127.118])
	by bsmtp.bon.at (Postfix) with ESMTP id 0320CA7EC1;
	Thu,  9 Apr 2009 22:34:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239224507-5372-1-git-send-email-marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116206>

Marius Storm-Olsen schrieb:
> The original readdir implementation was fast, but didn't
> support the d_type. This means that git would do additional
> lstats for each entry, to figure out if the entry was a
> directory or not. This unneedingly slowed down many
> operations, since Windows API provides this information
> directly when walking the directories.
> 
> By running this implementation on Moe's repo structure:
>   mkdir bummer && cd bummer; for ((i=0;i<100;i++)); do
>     mkdir $i && pushd $i;
>       for ((j=0;j<1000;j++)); do echo "$j" >$j; done;
>     popd;
>   done
> 
> We see the following speedups:
>   git add .
>   -------------------
>   old: 00:00:23(.087)
>   new: 00:00:21(.512) 1.07x
> 
>   git status
>   -------------------
>   old: 00:00:03(.306)
>   new: 00:00:01(.684) 1.96x
> 
>   git clean -dxf
>   -------------------
>   old: 00:00:01(.918)
>   new: 00:00:00(.295) 6.50x

Well done!

> +struct mingw_dirent
> +{
> +	long		d_ino;			/* Always zero. */
> +	union {
> +		unsigned short	d_reclen;	/* Always zero. */
> +		unsigned char   d_type;		/* Reimplementation adds this */
> +	};

VERY sneaky! I was wondering why you could get away without replacing 
opendir and closedir, and why you still defined a replacement mingw_DIR 
that contains the replacement mingw_dirent, until I noticed this unnamed 
union.

Since we don't use d_reclen anywhere in the code, wouldn't you get away with

#define d_type d_reclen

unless the type (short vs. char) makes a difference. Or would you say that 
doing that would be even more sneaky?

> +	unsigned short	d_namlen;		/* Length of name in d_name. */
> +	char		d_name[FILENAME_MAX];	/* File name. */
> +};
> +#define dirent mingw_dirent
> +#define readdir(x) mingw_readdir(x)
> +#endif // !NO_MINGW_REPLACE_READDIR

-- Hannes
