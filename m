From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 09/13] refs: introduce an iterator interface
Date: Mon, 30 May 2016 17:57:19 +0100
Message-ID: <574C70EF.5070705@ramsayjones.plus.com>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
 <89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
 <574C5AB0.4090005@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 30 18:57:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7QVM-0003rn-JM
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 18:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161764AbcE3Q5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 12:57:24 -0400
Received: from avasout01.plus.net ([84.93.230.227]:59032 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161418AbcE3Q5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 12:57:24 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 0gxL1t0015VX2mk01gxMmf; Mon, 30 May 2016 17:57:21 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=QAdNkNimmr_ngT2Z8oUA:9 a=3vHU_G3GScEn-qTI:21 a=Uj_MRYtTeGApSJ7w:21
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <574C5AB0.4090005@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295911>



On 30/05/16 16:22, Ramsay Jones wrote:
> 
> 
> On 30/05/16 08:55, Michael Haggerty wrote:
> [snip]
> 
>>  /* Reference is a symbolic reference. */
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 8ab4d5f..dbf1587 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -1,6 +1,7 @@
>>  #include "../cache.h"
>>  #include "../refs.h"
>>  #include "refs-internal.h"
>> +#include "../iterator.h"
>>  #include "../lockfile.h"
>>  #include "../object.h"
>>  #include "../dir.h"
>> @@ -704,6 +705,154 @@ static void prime_ref_dir(struct ref_dir *dir)
>>  	}
>>  }
>>  
>> +/*
>> + * A level in the reference hierarchy that is currently being iterated
>> + * through.
>> + */
>> +struct cache_ref_iterator_level {
>> +	/*
>> +	 * The ref_dir being iterated over at this level. The ref_dir
>> +         * is sorted before being stored here.
>> +	 */
>> +	struct ref_dir *dir;
>> +
>> +	/*
>> +	 * The index of the current entry within dir (which might
>> +	 * itself be a directory). If index == -1, then the iteration
>> +	 * hasn't yet begun. If index == dir->nr, then the iteration
>> +	 * through this level is over.
>> +	 */
>> +	int index;
>> +};
>> +
>> +/*
>> + * Represent an iteration through a ref_dir in the memory cache. The
>> + * iteration recurses through subdirectories.
>> + */
>> +struct cache_ref_iterator {
>> +	struct ref_iterator base;
>> +
>> +	/*
>> +	 * The number of levels currently on the stack. This is always
>> +	 * at least 1, because when it becomes zero the iteration is
>> +	 * ended and this struct is freed.
>> +	 */
>> +	size_t levels_nr;
>> +
>> +	/* The number of levels that have been allocated on the stack */
>> +	size_t levels_alloc;
>> +
>> +	/*
>> +	 * A stack of levels. levels[0] is the uppermost level that is
>> +	 * being iterated over in this iteration. (This is not
>> +	 * necessary the top level in the references hierarchy. If we
>> +	 * are iterating through a subtree, then levels[0] will hold
>> +	 * the ref_dir for that subtree, and subsequent levels will go
>> +	 * on from there.)
>> +	 */
>> +	struct cache_ref_iterator_level *levels;
>> +};
>> +
>> +static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
>> +{
>> +	struct cache_ref_iterator *iter =
>> +		(struct cache_ref_iterator *)ref_iterator;
>> +
>> +	while (1) {
>> +		struct cache_ref_iterator_level *level =
>> +			&iter->levels[iter->levels_nr - 1];
>> +		struct ref_dir *dir = level->dir;
>> +		struct ref_entry *entry;
>> +
>> +		if (level->index == -1)
>> +			sort_ref_dir(dir);
> 
> do you need to sort here ...
>> +
>> +		if (++level->index == level->dir->nr) {
>> +			/* This level is exhausted; pop up a level */
>> +			if (--iter->levels_nr == 0)
>> +				return ref_iterator_abort(ref_iterator);
>> +
>> +			continue;
>> +		}
>> +
>> +		entry = dir->entries[level->index];
>> +
>> +		if (entry->flag & REF_DIR) {
>> +			/* push down a level */
>> +			ALLOC_GROW(iter->levels, iter->levels_nr + 1,
>> +				   iter->levels_alloc);
>> +
>> +			level = &iter->levels[iter->levels_nr++];
>> +			level->dir = get_ref_dir(entry);
>> +			sort_ref_dir(level->dir);
> 
> ... given that you sort here?

I had intended to say 'or vice versa' here. When I wrote this, I had not
finished reading this patch (let alone the series). Now, I suspect that
you can simply drop this 'sort_ref_dir()' call site. Unless I've misread
the code, of course! ;-)

ATB,
Ramsay Jones
