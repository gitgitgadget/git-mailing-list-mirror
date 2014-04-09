From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Verify index file before we opportunistically update it
Date: Wed, 09 Apr 2014 16:05:33 -0700
Message-ID: <xmqqwqeyxfwi.fsf@gitster.dls.corp.google.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397082869-24873-1-git-send-email-yiannis.marangos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yiannis Marangos <yiannis.marangos@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 01:05:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WY1Yt-00043Y-Hh
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 01:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933360AbaDIXFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 19:05:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932719AbaDIXFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 19:05:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2D80791E2;
	Wed,  9 Apr 2014 19:05:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Aq1KGN4OdxI5ydX1RJt/TfqH1Y=; b=UKbmCk
	9zIhElZ7FLQbVg3Tuee9MpqoeU7Kq3Oamzal9mNSAPP0uC1dDQZYgprF3cvmAsgc
	2hVQZlGNckkQD0w1DNoVDPCYIeKxLdj8Nt3wJt+QLYtx+6F78wIeyJH2PAblQgYt
	4lPhsO/ahuy/hdwncMP1vJuP7BE2HR9kLri3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cAc+IL8tDF/tT0U8FG5yksaA00UAllWs
	rTna6CvZHLIJXT5WwxCATbcPPCZ1eb657tHxJ8WSEZLqZXGtidYYofblj7E/bfog
	t8EViH78RC8kR2Ln7DodjBNLuSo0YZUlEF8EFmeS+iyx1EqrOMPLe7BBvagL59Ed
	U4BfbPH1nZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBDC8791E0;
	Wed,  9 Apr 2014 19:05:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49B8D791CD;
	Wed,  9 Apr 2014 19:05:35 -0400 (EDT)
In-Reply-To: <1397082869-24873-1-git-send-email-yiannis.marangos@gmail.com>
	(Yiannis Marangos's message of "Thu, 10 Apr 2014 01:34:29 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7532E5AA-C03B-11E3-B393-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246004>

Yiannis Marangos <yiannis.marangos@gmail.com> writes:

> Before we proceed to "opportunistic update" we must verify that the
> current index file is the same as the one that we read before. There
> is a possible race if we don't do this:

Please somehow make it clear that the race is in general, and use of
"git rebase" in this description is merely an example.

>   1. process A calls git-rebase

... or does anything that uses the index.

>   2. process A applies 1st commit
>
>   3. process B calls git-status
>
>   4. process B reads index
>
>   5. process A applies 2nd commit

... or does anything that updates the index.

>   6. process B takes the lock, then overwrites process A's changes.
>
>   7. process A applies 3rd commit
>
> As an end result the 3rd commit will have a revert of the 2nd commit.

And the missing piece is...?  "When process B takes the lock, it
needs to make sure that the index hasn't changed since it read at
step 4."

> Signed-off-by: Yiannis Marangos <yiannis.marangos@gmail.com>
> ---

This is a place for you to describe how this version is different
from the previous round.  I am guessing that the only change is that
you removed the unnecessary printf() from the top of if-able, but I
didn't compare (nor read either versions carefully).

>  cache.h      |  3 +++
>  read-cache.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 69 insertions(+), 11 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 107ac61..b0eedad 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -279,6 +279,7 @@ struct index_state {
>  		 initialized : 1;
>  	struct hashmap name_hash;
>  	struct hashmap dir_hash;
> +	unsigned char sha1[20];
>  };
>  
>  extern struct index_state the_index;
> @@ -456,6 +457,8 @@ extern int daemonize(void);
>  	} while (0)
>  
>  /* Initialize and use the cache information */
> +extern int verify_index_from(const struct index_state *, const char *path);
> +extern int verify_index(struct index_state *);

I do not think these should be extern; they are implementation
details of the opportunistic update, and update-if-able is the only
thing the outside world needs to know about, I think.

>  extern int read_index(struct index_state *);
>  extern int read_index_preload(struct index_state *, const struct pathspec *pathspec);
>  extern int read_index_from(struct index_state *, const char *path);
> diff --git a/read-cache.c b/read-cache.c
> index ba13353..a49a441 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -14,6 +14,7 @@
>  #include "resolve-undo.h"
>  #include "strbuf.h"
>  #include "varint.h"
> +#include "git-compat-util.h"

An unnecessary change; we include "cache.h" as the very first thing
in this file.

> @@ -1321,6 +1322,59 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
>  	return 0;
>  }
>  
> +/* This function verifies if index_state has the correct sha1 of an index file.
> + * Don't die if we have any other failure, just return 0. */

	/*
         * Please write multi-line comment
         * like this.
         */

> +int verify_index_from(const struct index_state *istate, const char *path)
> +{

Also, this does not have to be extern.  At least not yet.

> +	int fd;
> +	struct stat st;
> +	struct cache_header *hdr;
> +	void *mmap_addr;
> +	size_t mmap_size;
> +
> +	if (!istate->initialized)
> +		return 0;
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return 0;
> +
> +	if (fstat(fd, &st))
> +		return 0;
> +
> +	/* file is too big */
> +	if (st.st_size > (size_t)st.st_size)
> +		return 0;
> +
> +	mmap_size = (size_t)st.st_size;
> +	if (mmap_size < sizeof(struct cache_header) + 20)
> +		return 0;
> +
> +	mmap_addr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);

Why PROT_WRITE?

> +	close(fd);
> +	if (mmap_addr == MAP_FAILED)
> +		return 0;
> +
> +	hdr = mmap_addr;
> +	if (verify_hdr(hdr, mmap_size) < 0)
> +		goto unmap;
> +
> +	if (hashcmp(istate->sha1, (unsigned char *)hdr + mmap_size - 20))
> +		goto unmap;
> +
> +	munmap(mmap_addr, mmap_size);
> +	return 1;
> +
> +unmap:
> +	munmap(mmap_addr, mmap_size);
> +	return 0;
> +}
> +
> +int verify_index(struct index_state *istate)
> +{
> +	return verify_index_from(istate, get_index_file());
> +}
> +
>  static int read_index_extension(struct index_state *istate,
>  				const char *ext, void *data, unsigned long sz)
>  {
> @@ -1445,7 +1499,7 @@ int read_index_from(struct index_state *istate, const char *path)
>  	struct stat st;
>  	unsigned long src_offset;
>  	struct cache_header *hdr;
> -	void *mmap;
> +	void *mmap_addr;

This introduces noise to the patch to make it harder to review, and
does not look a necessary change.  Am I mistaken?

>  	size_t mmap_size;
>  	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>  
> @@ -1468,15 +1522,16 @@ int read_index_from(struct index_state *istate, const char *path)
>  	if (mmap_size < sizeof(struct cache_header) + 20)
>  		die("index file smaller than expected");
>  
> -	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> -	if (mmap == MAP_FAILED)
> +	mmap_addr = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> +	if (mmap_addr == MAP_FAILED)
>  		die_errno("unable to map index file");
>  	close(fd);
>  
> -	hdr = mmap;
> +	hdr = mmap_addr;
>  	if (verify_hdr(hdr, mmap_size) < 0)
>  		goto unmap;
>  
> +	hashcpy(istate->sha1, (unsigned char *)hdr + mmap_size - 20);
>  	istate->version = ntohl(hdr->hdr_version);
>  	istate->cache_nr = ntohl(hdr->hdr_entries);
>  	istate->cache_alloc = alloc_nr(istate->cache_nr);
> @@ -1494,7 +1549,7 @@ int read_index_from(struct index_state *istate, const char *path)
>  		struct cache_entry *ce;
>  		unsigned long consumed;
>  
> -		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
> +		disk_ce = (struct ondisk_cache_entry *)((char *)mmap_addr + src_offset);
>  		ce = create_from_disk(disk_ce, &consumed, previous_name);
>  		set_index_entry(istate, i, ce);
>  
> @@ -1512,21 +1567,21 @@ int read_index_from(struct index_state *istate, const char *path)
>  		 * in 4-byte network byte order.
>  		 */
>  		uint32_t extsize;
> -		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
> +		memcpy(&extsize, (char *)mmap_addr + src_offset + 4, 4);
>  		extsize = ntohl(extsize);
>  		if (read_index_extension(istate,
> -					 (const char *) mmap + src_offset,
> -					 (char *) mmap + src_offset + 8,
> +					 (const char *) mmap_addr + src_offset,
> +					 (char *) mmap_addr + src_offset + 8,
>  					 extsize) < 0)
>  			goto unmap;
>  		src_offset += 8;
>  		src_offset += extsize;
>  	}
> -	munmap(mmap, mmap_size);
> +	munmap(mmap_addr, mmap_size);
>  	return istate->cache_nr;
>  
>  unmap:
> -	munmap(mmap, mmap_size);
> +	munmap(mmap_addr, mmap_size);
>  	die("index file corrupt");
>  }
>  
> @@ -1779,7 +1834,7 @@ static int has_racy_timestamp(struct index_state *istate)
>  void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
>  {
>  	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
> -	    !write_index(istate, lockfile->fd))
> +	    verify_index(istate) && !write_index(istate, lockfile->fd))
>  		commit_locked_index(lockfile);
>  	else
>  		rollback_lock_file(lockfile);
