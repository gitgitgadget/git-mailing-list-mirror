From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/22] make sure partially read index is not changed
Date: Mon, 08 Jul 2013 09:31:13 -0700
Message-ID: <7vehb910a6.fsf@alter.siamese.dyndns.org>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
	<1373184720-29767-7-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 18:31:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwELR-00050M-Vf
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 18:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab3GHQbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 12:31:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab3GHQbR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 12:31:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DC372CE9D;
	Mon,  8 Jul 2013 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S3f2ooWsQZ8t70xYr5dpHPdv4Rk=; b=uMQwws
	Z43UVrWv8pVIg2eHLa/Kd54GSEpd+h9mmUZoabYuz8L8xjBH5w6IyZdDAEfccyAj
	9gDKAykD5ysAgpt506B64x4t2f2aCASP53NQ4A2cX6WEkh1EMnC6nFgPPldqvwuv
	K3zn2eEr1M2SqSsdWej/rTPtGdvF67B4uic9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ViqmK+CfmZGN72j4z63A0YrnLsrzMfo6
	0VwPs5ZnVDEQlZ1FobM0koYys4KhNA8aD6AV4uM4aueCLLq35YoXdwpcjt/N3ydr
	PosfW1dS3yPFHgCiQg8azD0Ino9hklE0+Qd72TrxL9RkBx6Ss7qmmCpmHIn2ouDG
	spe99ResgUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1426E2CE9C;
	Mon,  8 Jul 2013 16:31:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C0F12CE92;
	Mon,  8 Jul 2013 16:31:15 +0000 (UTC)
In-Reply-To: <1373184720-29767-7-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Sun, 7 Jul 2013 10:11:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF25AEEA-E7EB-11E2-B45C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229874>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> A partially read index file currently cannot be written to disk.  Make
> sure that never happens, by re-reading the index file if the index file
> wasn't read completely before changing the in-memory index.

I am not quite sure what you are trying to do.  

In operations that modify the index (replace_index_entry(),
remove_index_entry_at(), etc.)  you lift the filter_ops and keep
partially_read flag still on.  In the write-out codepath, you have
an assert to make sure the caller has cleared the partially_read
flag.  A natural way to clear the flag is to re-read the index from
the file, but then you can easily lose the modifications.  Should
there be another safety that says "calling read_index() with the
partially_read flag on is a bug" or something?

Also shouldn't the flag be cleared upon discard_index()?  If it is
done there, you probably would not need to clear it in read_index().

>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  builtin/update-index.c | 4 ++++
>  cache.h                | 4 +++-
>  read-cache-v2.c        | 3 +++
>  read-cache.c           | 8 ++++++++
>  4 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 5c7762e..03f6426 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -49,6 +49,8 @@ static int mark_ce_flags(const char *path, int flag, int mark)
>  	int namelen = strlen(path);
>  	int pos = cache_name_pos(path, namelen);
>  	if (0 <= pos) {
> +		if (active_cache_partially_read)
> +			cache_change_filter_opts(NULL);
>  		if (mark)
>  			active_cache[pos]->ce_flags |= flag;
>  		else
> @@ -253,6 +255,8 @@ static void chmod_path(int flip, const char *path)
>  	pos = cache_name_pos(path, strlen(path));
>  	if (pos < 0)
>  		goto fail;
> +	if (active_cache_partially_read)
> +		cache_change_filter_opts(NULL);
>  	ce = active_cache[pos];
>  	mode = ce->ce_mode;
>  	if (!S_ISREG(mode))
> diff --git a/cache.h b/cache.h
> index d38dfbd..f6c3407 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -293,7 +293,8 @@ struct index_state {
>  	struct cache_tree *cache_tree;
>  	struct cache_time timestamp;
>  	unsigned name_hash_initialized : 1,
> -		 initialized : 1;
> +		 initialized : 1,
> +		 partially_read : 1;
>  	struct hash_table name_hash;
>  	struct hash_table dir_hash;
>  	struct index_ops *ops;
> @@ -315,6 +316,7 @@ extern void free_name_hash(struct index_state *istate);
>  #define active_alloc (the_index.cache_alloc)
>  #define active_cache_changed (the_index.cache_changed)
>  #define active_cache_tree (the_index.cache_tree)
> +#define active_cache_partially_read (the_index.partially_read)
>  
>  #define read_cache() read_index(&the_index)
>  #define read_cache_from(path) read_index_from(&the_index, (path))
> diff --git a/read-cache-v2.c b/read-cache-v2.c
> index 1ed640d..2cc792d 100644
> --- a/read-cache-v2.c
> +++ b/read-cache-v2.c
> @@ -273,6 +273,7 @@ static int read_index_v2(struct index_state *istate, void *mmap,
>  		src_offset += 8;
>  		src_offset += extsize;
>  	}
> +	istate->partially_read = 0;
>  	return 0;
>  unmap:
>  	munmap(mmap, mmap_size);
> @@ -495,6 +496,8 @@ static int write_index_v2(struct index_state *istate, int newfd)
>  	struct stat st;
>  	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>  
> +	if (istate->partially_read)
> +		die("BUG: index: cannot write a partially read index");
>  	for (i = removed = extended = 0; i < entries; i++) {
>  		if (cache[i]->ce_flags & CE_REMOVE)
>  			removed++;
> diff --git a/read-cache.c b/read-cache.c
> index b30ee75..4529fab 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -30,6 +30,8 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
>  {
>  	struct cache_entry *old = istate->cache[nr];
>  
> +	if (istate->partially_read)
> +		index_change_filter_opts(istate, NULL);
>  	remove_name_hash(istate, old);
>  	set_index_entry(istate, nr, ce);
>  	istate->cache_changed = 1;
> @@ -467,6 +469,8 @@ int remove_index_entry_at(struct index_state *istate, int pos)
>  {
>  	struct cache_entry *ce = istate->cache[pos];
>  
> +	if (istate->partially_read)
> +		index_change_filter_opts(istate, NULL);
>  	record_resolve_undo(istate, ce);
>  	remove_name_hash(istate, ce);
>  	istate->cache_changed = 1;
> @@ -978,6 +982,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
>  {
>  	int pos;
>  
> +	if (istate->partially_read)
> +		index_change_filter_opts(istate, NULL);
>  	if (option & ADD_CACHE_JUST_APPEND)
>  		pos = istate->cache_nr;
>  	else {
> @@ -1184,6 +1190,8 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
>  				/* If we are doing --really-refresh that
>  				 * means the index is not valid anymore.
>  				 */
> +				if (istate->partially_read)
> +					index_change_filter_opts(istate, NULL);
>  				ce->ce_flags &= ~CE_VALID;
>  				istate->cache_changed = 1;
>  			}
