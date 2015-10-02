From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC 1/2] sha1_file: close all pack files after running
Date: Fri, 02 Oct 2015 12:05:55 +0200
Organization: gmx
Message-ID: <33b74e875c7298f67640f5850e88c152@dscho.org>
References: <1443670163-31193-1-git-send-email-max@max630.net>
 <1443670163-31193-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Oct 02 12:06:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhxEK-00005G-4j
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 12:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbbJBKGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 06:06:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:51790 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829AbbJBKGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 06:06:08 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MT60g-1a6f7T0Y3a-00SAbL; Fri, 02 Oct 2015 12:05:57
 +0200
In-Reply-To: <1443670163-31193-2-git-send-email-max@max630.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:cU1I7eBsR6z6xRhtt0UDD18MOdbNdelMB8yT8Jpz4nAINDXBUu7
 RCUAO+WqsF43zfHVF+4iJkaO4lOYuCrUeGxPk3Mzye8JXfaHaVS1DznzRK5pyafHJxk/5fv
 kLT5OGen9Q4GZEmRJ5tWj6Ykr+g7FBtgBHiRxHDS8qcheuO5EkSXIW5Oc8shUKJwMqlSlqO
 k2SvYZc6/h3hQqV4YF8jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7SOAbrv4mR0=:AvpQntPB6wsls2DVdStsZc
 /vLfo+/uIBBV3GKVSGn/pX4JMKAZfS0edJ764ixdbllmGkJ1PoR7+YaQ3GXyAxFRBN8UlkTwG
 jCkzzH32UTidacO7KzSPN8KT2skOfwtLn+G5Q4/W3LsPyIYCQ8uCzXR/n6/9YCjdmpNlxLmpi
 wxJq8TjxmlqWcz0Q/ibc9cS25JwIM1323QWiQXnnDPI8MudXSYmkTyAX2aZqIc35VMV3UtABR
 7TBr9dFIh4ooc3+lAHuLw38saF6tqlrxbMGBYb6TF7C5lmbqARUDK3TG/TYFiNCvU4r183ujX
 VDQpr1GQ+tYLtXnAkcs74RMWrafPlw8Hz+ox6KFssELx4HgJd9CneK0Pjss6XunrZE1tCLgK+
 vLYblUnRXkDCSCbKWI9ZPOsaWygqTzq6WJ2/SqtAFsT64oVQtHpDZe+EXLoLOzBqiIJZ4Bgxl
 0KY32vMbtvNwIrSEFt7TjktynZwAL2bKM5YkhuqD0SmXSjmFNqcJ8mtzPpUz8H0ad7NjZY/Bc
 99IWBuGqY9TwrJLlEqD7P/+/hGQQGpnLMx5HR0giqkMJKkRyGW098We3cNA2nKhQ+a4SFxAhO
 7JuQGxXruL6UmaNY8EXrwU86l8JPW/FysaAcphAErKMgmMLVGkwYX+N1LotH3n3SdZY28dk+A
 TgzxDPylFHuPNZXIuRpUSUdy4fzZmOzkdyoaP+dJgUi7L0d9y4BIQWlrs3t/kuL93KgaCsakX
 Fg0mzIhLQdlkQSOtgRdq7eAm5cJyq0PieciUM2nQGISNvXydyrrrphXdJWobbacjdi9UDe5W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278910>

Hi Max,

On 2015-10-01 05:29, Max Kirillov wrote:
> When a builtin has done its job, but waits for pager or not waited
> by its caller and still hanging it keeps pack files opened.
> This can cause a number of issues, for example on Windows git gc
> cannot remove the packs.

I did not experience that issue. In any case, closing the packs after the builtin function has returned might not change anything anyway because we are about to `exit()` and that's that.

So I would like to skip this:

> diff --git a/git.c b/git.c
> index 5feba41..ad34680 100644
> --- a/git.c
> +++ b/git.c
> @@ -348,6 +349,7 @@ static int run_builtin(struct cmd_struct *p, int
> argc, const char **argv)
>  	trace_argv_printf(argv, "trace: built-in: git");
>  
>  	status = p->fn(argc, argv, prefix);
> +	close_all_packs();
>  	if (status)
>  		return status;
>  

Also, I would move the new declaration directly before `close_pack_windows()`:

> diff --git a/cache.h b/cache.h
> index 79066e5..153bc46 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1279,6 +1279,7 @@ extern void unuse_pack(struct pack_window **);
>  extern void free_pack_by_name(const char *);
>  extern void clear_delta_base_cache(void);
>  extern struct packed_git *add_packed_git(const char *, int, int);
> +extern void close_all_packs(void);
>  
>  /*
>   * Return the SHA-1 of the nth object within the specified packfile.

The convention in Git seems to call things _gently rather than _nodie:

> diff --git a/sha1_file.c b/sha1_file.c
> index 08302f5..62f1dad 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -773,20 +773,28 @@ void *xmmap(void *start, size_t length,
>  	return ret;
>  }
>  
> -void close_pack_windows(struct packed_git *p)
> +static int close_pack_windows_nodie(struct packed_git *p)
>  {
>  	while (p->windows) {
>  		struct pack_window *w = p->windows;
>  
>  		if (w->inuse_cnt)
> -			die("pack '%s' still has open windows to it",
> -			    p->pack_name);
> +			return 1;
> +
>  		munmap(w->base, w->len);
>  		pack_mapped -= w->len;
>  		pack_open_windows--;
>  		p->windows = w->next;
>  		free(w);
>  	}
> +
> +	return 0;
> +}

And while we're at it, why not teach that function a new parameter `int close_pack_fd`?

There is another problem: when we cannot close the pack window, we cannot really continue, can we? Because if we do, we *still* have the lock, and we'll just fail later, most likely with an unhelpful error message because we do not know where the pack closing failed. I do not think that the warning really helps...

Ciao,
Dscho
