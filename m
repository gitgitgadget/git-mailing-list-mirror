X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on
 many OSes other than Linux
Date: Tue, 19 Dec 2006 15:02:02 -0500
Message-ID: <4588453A.3060904@garzik.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org> <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org> <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191027270.18171@xanadu.home> <7vk60npv7x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191409500.18171@xanadu.home> <Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 20:02:29 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34847>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwlAH-0002N6-K0 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 21:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932917AbWLSUCN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 15:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932924AbWLSUCN
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 15:02:13 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55343 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932917AbWLSUCM
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 15:02:12 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GwlA3-0007zO-5X; Tue, 19 Dec 2006 20:02:03 +0000
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> diff --git a/convert-objects.c b/convert-objects.c
> index 8812583..a630132 100644
> --- a/convert-objects.c
> +++ b/convert-objects.c
> @@ -1,7 +1,3 @@
> -#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
> -#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
> -#define _GNU_SOURCE
> -#include <time.h>
>  #include "cache.h"
>  #include "blob.h"
>  #include "commit.h"
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 0272d04..e619e29 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -11,6 +11,10 @@
>  
>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>  
> +#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
> +#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
> +#define _GNU_SOURCE
> +
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <sys/stat.h>
> @@ -25,6 +29,10 @@
>  #include <netinet/in.h>
>  #include <sys/types.h>
>  #include <dirent.h>
> +#include <sys/time.h>
> +#include <time.h>
> +#include <signal.h>
> +#include <sys/wait.h>


If you are going to do this, you have to audit -every- file, to make 
sure git-compat-util.h is -always- the first header.

For example, builtin-mailinfo.c includes git-compat-util.h after ctype.h 
and iconv.h, which renders your #define _XOPEN_SOURCE 600 useless. 
/usr/include/features.h has already been included at that point.

	Jeff

