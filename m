From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 01/16] foreach_alt_odb: propagate return value from callback
Date: Sat, 04 Oct 2014 00:55:13 +0200
Message-ID: <542F2951.5050203@web.de>
References: <20141003202045.GA15205@peff.net> <20141003202104.GA16293@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 04 00:57:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaBmb-0005Tx-PD
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 00:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281AbaJCW5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 18:57:01 -0400
Received: from mout.web.de ([212.227.15.4]:50576 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759209AbaJCW4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 18:56:25 -0400
Received: from [192.168.178.27] ([79.253.134.107]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lud96-1YIMF33P2O-00zqMM; Sat, 04 Oct 2014 00:56:13
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <20141003202104.GA16293@peff.net>
X-Provags-ID: V03:K0:y+lIzYL8iddEbaCTKsqyWY0ooE105VE/HE2QKsNje42VdF81T+E
 JZGvNyEyNKfk5oNr/w9i32hbIPwM1GY046IUSUOM0XRVgYHZP40oZD3pYPXW+QgVhkoKUTp
 e3P8JUJ23y2DolSGcahrfrEHh4wArXpdtQkpkX5TBxoWn3MiQjDY/J1PLOwwZcYuR9dXT/P
 xGG2x/XbR4/Zqh80ZdqNg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257878>

Am 03.10.2014 um 22:21 schrieb Jeff King:
> We check the return value of the callback and stop iterating
> if it is non-zero. However, we do not make the non-zero
> return value available to the caller, so they have no way of
> knowing whether the operation succeeded or not (technically
> they can keep their own error flag in the callback data, but
> that is unlike our other for_each functions).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   cache.h     |  2 +-
>   sha1_file.c | 12 ++++++++----
>   2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 8206039..cd16e25 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1143,7 +1143,7 @@ extern void prepare_alt_odb(void);
>   extern void read_info_alternates(const char * relative_base, int depth);
>   extern void add_to_alternates_file(const char *reference);
>   typedef int alt_odb_fn(struct alternate_object_database *, void *);
> -extern void foreach_alt_odb(alt_odb_fn, void*);
> +extern int foreach_alt_odb(alt_odb_fn, void*);
>
>   struct pack_window {
>   	struct pack_window *next;
> diff --git a/sha1_file.c b/sha1_file.c
> index c08c0cb..bae1c15 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -412,14 +412,18 @@ void add_to_alternates_file(const char *reference)
>   		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0);
>   }
>
> -void foreach_alt_odb(alt_odb_fn fn, void *cb)
> +int foreach_alt_odb(alt_odb_fn fn, void *cb)
>   {
>   	struct alternate_object_database *ent;
> +	int r = 0;
>
>   	prepare_alt_odb();
> -	for (ent = alt_odb_list; ent; ent = ent->next)
> -		if (fn(ent, cb))
> -			return;
> +	for (ent = alt_odb_list; ent; ent = ent->next) {
> +		int r = fn(ent, cb);
> +		if (r)
> +			break;
> +	}
> +	return r;

This will always return zero.  You probably shadowed r unintentionally 
inside the loop, right?

>   }
>
>   void prepare_alt_odb(void)
>
