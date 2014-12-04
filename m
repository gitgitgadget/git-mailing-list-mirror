From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 12/13] refs.c: use a bit for ref_update have_old
Date: Thu, 04 Dec 2014 17:10:05 +0100
Message-ID: <5480875D.6050803@web.de>
References: <1417681763-32334-1-git-send-email-sbeller@google.com> <1417681763-32334-13-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu, jrnieder@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 17:10:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwYz2-0006PS-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 17:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbaLDQKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 11:10:19 -0500
Received: from mout.web.de ([212.227.17.11]:52601 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbaLDQKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 11:10:17 -0500
Received: from [192.168.209.17] ([78.72.72.190]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M1G68-1Xh6Wx0mro-00tDVH; Thu, 04 Dec 2014 17:10:11
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <1417681763-32334-13-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:yEMxBXLlIqEZLLlbkA2dUh0Awaoosbr/msIeSJCZTm/e6t/hLoE
 uWOwjrazmMg92mdjllmaqpW1kR1P1dkQhKEqKOwo6ol8uYPkk5l+E9JMem6xlLSB7fqzEvU
 23bgc9fbUqyrCnHrPsV0x4IUcOvHhvBj4hXqV08olcUEyTqvhJQWEHmFCqXSZMrbZvoD6bU
 dNGQ8eI35FvgnFjdTZtHQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260763>

On 12/04/2014 09:29 AM, Stefan Beller wrote:
Somewhat short commit message, especially the motivation is missing.

What do we gain with this patch ?
In the struct the compiler needs to layout 2*20 bytes for the sha's.
It follows an int, typically 4 bytes.
It follows another int, now with one bit.
Then we have the pointer "struct ref_lock *lock",
which needs to be aligned on 4 byte boundary for a 32 bit processor,
or an 8 byte boundary for a 64 bit machine.

Our "1 bit int" is padded with 31 bits.
We do not gain anything in memory consumption. (unless we declare int flags
to be 31 bits, and the compiler may join "have_old" and "flags" together
into one int in memory.

But there is a price to pay:
The generated code to fiddle out the bits from an int becomes more complicated.
You need to fetch the memory from one int, mask and shift.
Some processors can do this, out of my mind some ARM can, some can not.

We need to run the compiler to look at the generated code of course.
 


> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> Notes:
>     Also a patch, which hasn't been posted on the mailing list before.
> 
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/refs.c b/refs.c
> index b54b5b3..2942227 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3532,7 +3532,7 @@ struct ref_update {
>  	unsigned char new_sha1[20];
>  	unsigned char old_sha1[20];
>  	int flags; /* REF_NODEREF? */
> -	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
> +	int have_old:1; /* 1 if old_sha1 is valid, 0 otherwise */
>  	struct ref_lock *lock;
>  	int type;
>  	char *msg;
> 
