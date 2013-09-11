From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/5] add a hashtable implementation that supports O(1) removal
Date: Wed, 11 Sep 2013 16:56:04 -0700
Message-ID: <xmqqtxhqrjzf.fsf@gitster.dls.corp.google.com>
References: <522FAAC4.2080601@gmail.com> <522FAB19.3080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 01:56:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJuGh-0003lt-L9
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 01:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab3IKX4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 19:56:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756241Ab3IKX4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 19:56:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E271C4159A;
	Wed, 11 Sep 2013 23:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vBi6Z+eLa343G9idW62Y3a87/RY=; b=VkEmYi
	WlMuamqnoKVjHObofjCiGAiyLa1y98WTcz9gqABS6/DVP/5OdISDb0tlZvLJgAXm
	1ggUVSjuGIStbcQ5ISz6UWE99GcstJPagAHpK8dXm7Ezn6x3uGtpBhujs8YKbIHW
	0NIkREP4BMxGl1rrXi/2JIRUg1owE09g6rG/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PusHoJ1lekoa0Ma8AhryTAmNzx5qOeZQ
	6tGqjyZBk+6+5zoqxktWXmNVPc0SFrTiFWuNGlWza9M94Z3eFL58V8QtGWIBWXXW
	nqmM2ril355Dq1qXWWMoPVtQSiJYrgm/3nXXvx7jSmTaMeGCN6RKvxNvgH/f6JKe
	gUAmo7DemVw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D842041599;
	Wed, 11 Sep 2013 23:56:06 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49ED541595;
	Wed, 11 Sep 2013 23:56:06 +0000 (UTC)
In-Reply-To: <522FAB19.3080704@gmail.com> (Karsten Blees's message of "Wed, 11
	Sep 2013 01:28:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B9111B96-1B3D-11E3-B35E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234614>

Karsten Blees <karsten.blees@gmail.com> writes:

> +#define FNV32_BASE ((unsigned int) 0x811c9dc5)
> +#define FNV32_PRIME ((unsigned int) 0x01000193)
> + ...
> +static inline unsigned int bucket(const hashmap *map, const hashmap_entry *key)
> +{
> +	return key->hash & (map->tablesize - 1);
> +}

As tablesize would hopefully be reasonably small, not worrying about
platforms' "unsigned int" being 64-bit (in which case it would be
more appropriate to compute with FNV64_PRIME) should be fine.

> +static inline hashmap_entry **find_entry(const hashmap *map,
> +		const hashmap_entry *key)
> +{
> +	hashmap_entry **e = &map->table[bucket(map, key)];
> +	while (*e && !entry_equals(map, *e, key))
> +		e = &(*e)->next;
> +	return e;
> +}

(mental note) This finds the location the pointer to the entry is
stored, not the entry itself.

> +void *hashmap_get(const hashmap *map, const void *key)
> +{
> +	return *find_entry(map, key);
> +}

... which is consistent with this, and more importantly, it is
crucial for hashmap_remove()'s implementation, because...

> +void *hashmap_remove(hashmap *map, const void *key)
> +{
> +	hashmap_entry *old;
> +	hashmap_entry **e = find_entry(map, key);
> +	if (!*e)
> +		return NULL;
> +
> +	/* remove existing entry */
> +	old = *e;
> +	*e = old->next;

... this wants to update the linked list in place.

Looking good.

I however wonder if the singly linked linear chain is a really good
alternative for the access pattern of the hashes we use, though.  Do
we really want to trigger growth on the bucket load factor, not the
length of the longest chain, for example?

> +	old->next = NULL;
> +
> +	/* fix size and rehash if appropriate */
> +	map->size--;
> +	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
> +		map->size * HASHMAP_SHRINK_AT < map->tablesize)
> +		rehash(map, map->tablesize >> HASHMAP_GROW);

Please align the first two lines so that the first non-whitespace on
the second line of the condition part of the "if" statement
(i.e. 'm') aligns with the first non-whitespace inside the '(' open
parenthesis (i.e. 'm').
