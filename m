From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 18/25] struct lock_file: declare some fields volatile
Date: Tue, 15 Apr 2014 08:55:14 +0200
Message-ID: <534CD7D2.4060005@viscovery.net>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu> <1397483695-10888-19-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torst?= =?ISO-8859-15?Q?en_B=F6gershausen?= 
	<tboegi@web.de>, Eric Sunshine <sunshine@sunshineco.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 08:55:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZxHC-0000Gf-J3
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 08:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbaDOGzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 02:55:18 -0400
Received: from so.liwest.at ([212.33.55.14]:44679 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbaDOGzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 02:55:16 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WZxH1-00013Y-7c; Tue, 15 Apr 2014 08:55:15 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id ECBBF16613;
	Tue, 15 Apr 2014 08:55:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1397483695-10888-19-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246277>

Am 4/14/2014 15:54, schrieb Michael Haggerty:
> The function remove_lock_file_on_signal() is used as a signal handler.
> It is not realistic to make the signal handler conform strictly to the
> C standard, which is very restrictive about what a signal handler is
> allowed to do.  But let's increase the likelihood that it will work:
> 
> The lock_file_list global variable and several fields from struct
> lock_file are used by the signal handler.  Declare those values
> "volatile" to increase the chance that the signal handler will see a
> valid object state.

Yes, it's important that the signal handler sees a valid object state, and
"volatile" can help here. But I think the reason why it helps is not
obvious, and it should be mentioned in the commit message:

It is not so much that "volatile" forces the compiler to lay down each
access of the variable coded in C in the assembly code, but more
importantly, that "volatile" disallows any re-ordering of these accesses.
Then:

- 'lock->active = 1' must be the last assignment during setup

- 'lock->active = 0' must be the first assignment during tear-down.

- Ideally, all members of struct lock_file should be "volatile".

The last point is important because the compiler is allowed to re-order
accesses to non-"volatile" variables across "volatile" accesses. I say
"ideally" because if filename were defined "volatile filename[PATH_MAX]",
strcpy() could not be used anymore. OTOH, it is unlikely that a compiler
re-orders a strcpy() call across other expressions, and we can get away
without "volatile" in the "filename" case in practice.

> Suggested-by: Johannes Sixt <j.sixt@viscovery.net>

Not a big deal, but just in case you re-roll again and you do not forget:

  Johannes Sixt <j6t@kdbg.org>

is preferred.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  cache.h    | 6 +++---
>  lockfile.c | 2 +-
>  refs.c     | 5 +++--
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index b7af173..9019c7d 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -538,10 +538,10 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
>  #define LOCK_SUFFIX_LEN 5
>  
>  struct lock_file {
> -	struct lock_file *next;
> +	struct lock_file *volatile next;
>  	volatile sig_atomic_t active;
> -	int fd;
> -	pid_t owner;
> +	volatile int fd;
> +	volatile pid_t owner;
>  	char on_list;
>  	char filename[PATH_MAX];
>  };
> diff --git a/lockfile.c b/lockfile.c
> index 50a0541..fce53f1 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -69,7 +69,7 @@
>   * See Documentation/api-lockfile.txt for more information.
>   */
>  
> -static struct lock_file *lock_file_list;
> +static struct lock_file *volatile lock_file_list;
>  static const char *alternate_index_output;
>  
>  static void remove_lock_file(void)
> diff --git a/refs.c b/refs.c
> index cb2f825..db8057c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2213,15 +2213,16 @@ int commit_packed_refs(void)
>  	struct packed_ref_cache *packed_ref_cache =
>  		get_packed_ref_cache(&ref_cache);
>  	int error = 0;
> +	int fd;
>  
>  	if (!packed_ref_cache->lock)
>  		die("internal error: packed-refs not locked");
>  	write_or_die(packed_ref_cache->lock->fd,
>  		     PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
>  
> +	fd = packed_ref_cache->lock->fd;
>  	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
> -				 0, write_packed_entry_fn,
> -				 &packed_ref_cache->lock->fd);
> +				 0, write_packed_entry_fn, &fd);
>  	if (commit_lock_file(packed_ref_cache->lock))
>  		error = -1;
>  	packed_ref_cache->lock = NULL;
> 
