From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] Introduce "abstract class" to make _locate_element()
 more independant of diff_rename_dst.
Date: Thu, 4 Nov 2010 15:56:55 -0500
Message-ID: <20101104205655.GB18187@burratino>
References: <1288902795-8597-1-git-send-email-ydirson@altern.org>
 <1288902795-8597-4-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 21:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE6s8-0001U0-NJ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 21:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106Ab0KDU5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 16:57:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56615 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab0KDU5S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 16:57:18 -0400
Received: by iwn10 with SMTP id 10so1834596iwn.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2NCkW9IjN6ebnllREia0pnstvlKkXdAW5GpYdNfC7kU=;
        b=KoRT9+KjWOnP4UQXjhbTKZ00XUyaGvIFsJeAxchLNDZEvPmWiWLO8A89h0cRyfapdB
         iX7k3gwpx86T+wIW4DVSUX0QapQSF2sXbKt54yX0iHhcF95kvlqBB3BFQK5m0UeXLRKZ
         d9eDy/NCx0ZeH+HJrdSuxpPzikG7on30dxovk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Pa6h6Nw/CLFsOVS50eekK0LLvP/h7ZKuXFEfp7pIbOZ8YIYikob3o3UboN1W0uwJ83
         vzBadVPoJzhlY+1I88LqguGiWAKZRoSEfkwFrZ7IxnwByP8/RJ+zhYWNuEXrK2QwwZRI
         5GQsydW2e0mPZq7Ysd/2n+W4erqoB4wHMzSVo=
Received: by 10.231.30.193 with SMTP id v1mr1065024ibc.87.1288904237944;
        Thu, 04 Nov 2010 13:57:17 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id fs21sm196188vbb.0.2010.11.04.13.57.16
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 13:57:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288902795-8597-4-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160766>

Yann Dirson wrote:

> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -6,12 +6,16 @@
>  #include "diffcore.h"
>  #include "hash.h"
>  
> +
> +/* "Abstract class" for lists of filespecs */
> +struct dst_obj {
> +	struct diff_filespec *two;
> +};
>  #define locate_element(list,elem,insert_ok)			\
>  	_locate_element(elem, &list##_nr, &list##_alloc,	\
>  			sizeof(*list), insert_ok)
>  
> -/* Table of rename/copy destinations */
> -
> +/* Table of rename/copy destinations, "subclass" of dst_obj */
>  static struct diff_rename_dst {
>  	struct diff_filespec *two;

Nit: language lawyers might be happier with:

  struct dst_obj {
	struct diff_filespec *spec
  };
  struct diff_rename_dst {
	struct dst_obj two;
	...
  };

or

  typedef struct diff_filespec *dst_obj;
  struct diff_rename_dst {
	dst_obj two;
	...
  };

or

  struct diff_rename_dst {
	struct diff_filespec *two;
	...
  };
  ...
  struct diff_filespec **dst = (const char *) rename_dst + next * elem_size;

to avoid violating strict aliasing rules.

Meanwhile, something like

 #define container_of(ptr, type, member) \
	((type *)((char *) ptr - offsetof(type, member)))

can be useful for making the meaning more obvious when downcasting.
