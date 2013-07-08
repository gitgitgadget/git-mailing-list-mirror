From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 06/22] make sure partially read index is not changed
Date: Mon, 08 Jul 2013 20:33:03 +0200
Message-ID: <877gh0rjfk.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-7-git-send-email-t.gummerer@gmail.com> <7vehb910a6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 20:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwGFP-0004DE-NR
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 20:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab3GHSdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 14:33:11 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58049 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab3GHSdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 14:33:10 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so4690917pab.27
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=0eUPMQmmw3Ffcp38lQr3wBCMuPa8lVbcCn5UlPP2E9k=;
        b=PoR0v1Uu4HfS+lj8BgJiYxMSO7WpEe6n0uZDdZkq8Blf6WQev+3+DbgOLs4Ncgp7Lh
         JYbuEMFOVamKM8NRvnUkMxoOQu/8vk7JfB7ApcUMbQMZidG6+bZdPgdHmstxEVpYuX8/
         JPDrSAXUtiUMEYnqdkvW5KRd6t8/ko1N0QD88ikpthlUyrngNaqlbbMWOUYXiGi+eFKE
         XTWZmIXzE5c4mzu72N1bQY4H5MXoXSyTz4Ro3IZOl1z4Vg+xlGKe3awspNIPeupfEMSU
         tWcco6QwpCSDfUyCWzXhvr/inbQRCA3BOlL/LpWefxIjxAOVTeXsBVHHh1sy3wP5d/FM
         0mmw==
X-Received: by 10.66.25.45 with SMTP id z13mr24504796paf.151.1373308390001;
        Mon, 08 Jul 2013 11:33:10 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id py6sm23753599pbb.33.2013.07.08.11.33.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 11:33:09 -0700 (PDT)
In-Reply-To: <7vehb910a6.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229883>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> A partially read index file currently cannot be written to disk.  Make
>> sure that never happens, by re-reading the index file if the index file
>> wasn't read completely before changing the in-memory index.
>
> I am not quite sure what you are trying to do.
>
> In operations that modify the index (replace_index_entry(),
> remove_index_entry_at(), etc.)  you lift the filter_ops and keep
> partially_read flag still on.  In the write-out codepath, you have
> an assert to make sure the caller has cleared the partially_read
> flag.  A natural way to clear the flag is to re-read the index from
> the file, but then you can easily lose the modifications.
>
> Also shouldn't the flag be cleared upon discard_index()?  If it is
> done there, you probably would not need to clear it in read_index().

Hrm, maybe the code isn't quite clear enough here, or maybe the patch
should come directly before (16/22) read-cache: read index-v5 to be more
clear.

The flag is always set to 0 in read_index_v2, as the whole index is
always read and therefore it never needs to be reset.  With
read_index_v5 on the other hand the flag is set when the filter_opts are
different than NULL.

But thinking about it, the flag is actually not necessary at all.  The
filter_opts should simply be checked for NULL for the assert and they
should also be set to NULL on discard_index.  Will fix this in the next
version.  Thanks.

> Should
> there be another safety that says "calling read_index() with the
> partially_read flag on is a bug" or something?

I'm not sure.  I think it doesn't hurt, as we discard the index when
we change the index_ops.  At the moment I can't think of a case where
where calling read_index() could be used when it's partially read
without discarding the cache first.  I'll add it in the next version.

>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>>  builtin/update-index.c | 4 ++++
>>  cache.h                | 4 +++-
>>  read-cache-v2.c        | 3 +++
>>  read-cache.c           | 8 ++++++++
>>  4 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 5c7762e..03f6426 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -49,6 +49,8 @@ static int mark_ce_flags(const char *path, int flag, int mark)
>>  	int namelen = strlen(path);
>>  	int pos = cache_name_pos(path, namelen);
>>  	if (0 <= pos) {
>> +		if (active_cache_partially_read)
>> +			cache_change_filter_opts(NULL);
>>  		if (mark)
>>  			active_cache[pos]->ce_flags |= flag;
>>  		else
>> @@ -253,6 +255,8 @@ static void chmod_path(int flip, const char *path)
>>  	pos = cache_name_pos(path, strlen(path));
>>  	if (pos < 0)
>>  		goto fail;
>> +	if (active_cache_partially_read)
>> +		cache_change_filter_opts(NULL);
>>  	ce = active_cache[pos];
>>  	mode = ce->ce_mode;
>>  	if (!S_ISREG(mode))
>> diff --git a/cache.h b/cache.h
>> index d38dfbd..f6c3407 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -293,7 +293,8 @@ struct index_state {
>>  	struct cache_tree *cache_tree;
>>  	struct cache_time timestamp;
>>  	unsigned name_hash_initialized : 1,
>> -		 initialized : 1;
>> +		 initialized : 1,
>> +		 partially_read : 1;
>>  	struct hash_table name_hash;
>>  	struct hash_table dir_hash;
>>  	struct index_ops *ops;
>> @@ -315,6 +316,7 @@ extern void free_name_hash(struct index_state *istate);
>>  #define active_alloc (the_index.cache_alloc)
>>  #define active_cache_changed (the_index.cache_changed)
>>  #define active_cache_tree (the_index.cache_tree)
>> +#define active_cache_partially_read (the_index.partially_read)
>>
>>  #define read_cache() read_index(&the_index)
>>  #define read_cache_from(path) read_index_from(&the_index, (path))
>> diff --git a/read-cache-v2.c b/read-cache-v2.c
>> index 1ed640d..2cc792d 100644
>> --- a/read-cache-v2.c
>> +++ b/read-cache-v2.c
>> @@ -273,6 +273,7 @@ static int read_index_v2(struct index_state *istate, void *mmap,
>>  		src_offset += 8;
>>  		src_offset += extsize;
>>  	}
>> +	istate->partially_read = 0;
>>  	return 0;
>>  unmap:
>>  	munmap(mmap, mmap_size);
>> @@ -495,6 +496,8 @@ static int write_index_v2(struct index_state *istate, int newfd)
>>  	struct stat st;
>>  	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
>>
>> +	if (istate->partially_read)
>> +		die("BUG: index: cannot write a partially read index");
>>  	for (i = removed = extended = 0; i < entries; i++) {
>>  		if (cache[i]->ce_flags & CE_REMOVE)
>>  			removed++;
>> diff --git a/read-cache.c b/read-cache.c
>> index b30ee75..4529fab 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -30,6 +30,8 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
>>  {
>>  	struct cache_entry *old = istate->cache[nr];
>>
>> +	if (istate->partially_read)
>> +		index_change_filter_opts(istate, NULL);
>>  	remove_name_hash(istate, old);
>>  	set_index_entry(istate, nr, ce);
>>  	istate->cache_changed = 1;
>> @@ -467,6 +469,8 @@ int remove_index_entry_at(struct index_state *istate, int pos)
>>  {
>>  	struct cache_entry *ce = istate->cache[pos];
>>
>> +	if (istate->partially_read)
>> +		index_change_filter_opts(istate, NULL);
>>  	record_resolve_undo(istate, ce);
>>  	remove_name_hash(istate, ce);
>>  	istate->cache_changed = 1;
>> @@ -978,6 +982,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
>>  {
>>  	int pos;
>>
>> +	if (istate->partially_read)
>> +		index_change_filter_opts(istate, NULL);
>>  	if (option & ADD_CACHE_JUST_APPEND)
>>  		pos = istate->cache_nr;
>>  	else {
>> @@ -1184,6 +1190,8 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
>>  				/* If we are doing --really-refresh that
>>  				 * means the index is not valid anymore.
>>  				 */
>> +				if (istate->partially_read)
>> +					index_change_filter_opts(istate, NULL);
>>  				ce->ce_flags &= ~CE_VALID;
>>  				istate->cache_changed = 1;
>>  			}
