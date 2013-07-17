From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 00/19] Index-v5
Date: Wed, 17 Jul 2013 10:04:15 +0200
Message-ID: <87zjtlsjcw.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <51E5B52C.7050603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 17 10:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzMj0-00020y-Vu
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 10:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab3GQIE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 04:04:29 -0400
Received: from mail-ea0-f169.google.com ([209.85.215.169]:58474 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab3GQIET (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 04:04:19 -0400
Received: by mail-ea0-f169.google.com with SMTP id h15so856406eak.14
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=FEgYejRdBJZZE8BkbGfsRJBl/SKjpdQcFmHrikJL8TU=;
        b=eXFvNVOCJgOfQLXb9neuiTBO5orH7i4UY1CjMfTCTPZN2zJawWOnbEb+s8w1Ope/5G
         OasUzxdeEQMP54May1Qw+q7X8L6uvgGVXuCpgoZtQ3+jZdZoVi64Ct8FxaN9By/mXS24
         JDqmKgkalU644IeVD49rFBEDNL6rPdm6KE3dj/GC74pB1GoYFwlQFSM0I2fqJizJbsdJ
         ZAnaRyOGjjEK05WqvIfGEt0hvoWaUqWXD1vdckJRjtsj/EI5pAkVj5jZ8yHRAAY7535k
         koqjGEZc98DQCA24gRtsAL2p7Tkc3NDaK0vQwxeKoY1bu1Emuy6b1wIrinaPdoF21ME3
         wSyw==
X-Received: by 10.14.223.199 with SMTP id v47mr5257599eep.32.1374048258288;
        Wed, 17 Jul 2013 01:04:18 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id cg12sm8772484eeb.7.2013.07.17.01.04.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 01:04:17 -0700 (PDT)
In-Reply-To: <51E5B52C.7050603@ramsay1.demon.co.uk>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230605>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Thomas Gummerer wrote:
>> Hi,
>>
>> previous rounds (without api) are at $gmane/202752, $gmane/202923,
>> $gmane/203088 and $gmane/203517, the previous round with api was at
>> $gmane/229732.  Thanks to Junio, Duy and Eric for their comments on
>> the previous round.
>
> If I remember correctly, the original version of this series had the
> same problem as Michael's "Fix some reference-related races" series
> (now in master). In particular, you had introduced an 'index_changed()'
> function which does essentially the same job as 'stat_validity_check()'
> in the new reference handling API. I seem to remember advising you
> not to compare st_uid, st_gid and st_ino on __CYGWIN__.

Yes, you provided a patch that simply wrapped those checks in a #if
!defined (__CYGWIN__), which is included in the new series too.


> I haven't had time to look at this version of your series yet, but it
> may be worth taking a look at stat_validity_check(). (although that is
> causing failures on cygwin at the moment! ;-)

I took a quick look, that function makes sense I think.  I'll use it in
the re-roll.  It makes probably sense to wrap the uid, gid and ino
fields as in the index_changed function.


> Also, I can't recall if I mentioned it to you at the time, but your
> index reading code was (unnecessarily) calling munmap() twice on the
> same buffer (without an intervening mmap()). This causes problems for
> systems that have the NO_MMAP build variable set. In particular, the
> compat/mmap.c code will attempt to free() the allocated memory block
> twice, with unpredictable results.
>
> I wrote a patch to address this at the time (Hmm, seems to be built
> on v1.8.1), but didn't submit it since your patch didn't progress. :-D
> I have included the patch below.

I can't recall this either.  From a quick check I don't call munmap() on
a already unmapped mmap, so I think this is fine as it is and your patch
is independent from it.  Not sure if it makes sense as safeguard for
future changes.

> -- >8 --
> From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> Date: Sun, 9 Sep 2012 20:50:32 +0100
> Subject: [PATCH] mmap.c: Keep log of mmap() blocks to avoid double-delete bug
>
> When compiling with the NO_MMAP build variable set, the built-in
> 'git_mmap()' and 'git_munmap()' compatibility routines use simple
> memory allocation and file I/O to emulate the required behaviour.
> The current implementation is vulnerable to the "double-delete" bug
> (where the pointer returned by malloc() is passed to free() two or
> more times), should the mapped memory block address be passed to
> munmap() multiple times.
>
> In order to guard the implementation from such a calling sequence,
> we keep a list of mmap-block descriptors, which we then consult to
> determine the validity of the input pointer to munmap(). This then
> allows 'git_munmap()' to return -1 on error, as required, with
> errno set to EINVAL.
>
> Using a list in the log of mmap-ed blocks, along with the resulting
> linear search, means that the performance of the code is directly
> proportional to the number of concurrently active memory mapped
> file regions. The number of such regions is not expected to be
> excessive.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  compat/mmap.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/compat/mmap.c b/compat/mmap.c
> index c9d46d1..400e034 100644
> --- a/compat/mmap.c
> +++ b/compat/mmap.c
> @@ -1,14 +1,61 @@
>  #include "../git-compat-util.h"
>
> +struct mmbd {  /* memory mapped block descriptor */
> +	struct mmbd *next;  /* next in list */
> +	void   *start;      /* pointer to memory mapped block */
> +	size_t length;      /* length of memory mapped block */
> +};
> +
> +static struct mmbd *head;  /* head of mmb descriptor list */
> +
> +
> +static void add_desc(struct mmbd *desc, void *start, size_t length)
> +{
> +	desc->start = start;
> +	desc->length = length;
> +	desc->next = head;
> +	head = desc;
> +}
> +
> +static void free_desc(struct mmbd *desc)
> +{
> +	if (head == desc)
> +		head = head->next;
> +	else {
> +		struct mmbd *d = head;
> +		for (; d; d = d->next) {
> +			if (d->next == desc) {
> +				d->next = desc->next;
> +				break;
> +			}
> +		}
> +	}
> +	free(desc);
> +}
> +
> +static struct mmbd *find_desc(void *start)
> +{
> +	struct mmbd *d = head;
> +	for (; d; d = d->next) {
> +		if (d->start == start)
> +			return d;
> +	}
> +	return NULL;
> +}
> +
>  void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
>  {
>  	size_t n = 0;
> +	struct mmbd *desc = NULL;
>
>  	if (start != NULL || !(flags & MAP_PRIVATE))
>  		die("Invalid usage of mmap when built with NO_MMAP");
>
>  	start = xmalloc(length);
> -	if (start == NULL) {
> +	desc = xmalloc(sizeof(*desc));
> +	if (!start || !desc) {
> +		free(start);
> +		free(desc);
>  		errno = ENOMEM;
>  		return MAP_FAILED;
>  	}
> @@ -25,18 +72,26 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
>  			if (errno == EAGAIN || errno == EINTR)
>  				continue;
>  			free(start);
> +			free(desc);
>  			errno = EACCES;
>  			return MAP_FAILED;
>  		}
>
>  		n += count;
>  	}
> +	add_desc(desc, start, length);
>
>  	return start;
>  }
>
>  int git_munmap(void *start, size_t length)
>  {
> +	struct mmbd *d = find_desc(start);
> +	if (!d) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +	free_desc(d);
>  	free(start);
>  	return 0;
>  }
> --
> 1.8.3
