From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/4] hashmap: add simplified hashmap_get_from_hash() API
Date: Mon, 07 Jul 2014 10:43:20 -0700
Message-ID: <xmqqk37pdpzb.fsf@gitster.dls.corp.google.com>
References: <53B48540.5070600@gmail.com> <53B48613.60509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:43:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Cwv-0007QZ-0F
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 19:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbaGGRn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 13:43:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51810 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbaGGRn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 13:43:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A25F426F6C;
	Mon,  7 Jul 2014 13:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=So0C2qZkI9262Ty1f81by3C4xnA=; b=xhATp7
	/NTeqLfZCSVYsuLdxEsAMvq0jek9VJp7x0WEf14qPALoNY6NZSFk7hpfzeMludTI
	W5ol5brmRlqAvF1idJkVc8GfFC4HbKEe3yHNqTI4guUCfqOVu/xWRM/yLQfIAjF0
	Vg8nnlsh9ErRnK58fiFZjMsxnANs07SJGyB2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C8Ifazo0I10RxR/6qD7evpgNCT7NbhTU
	0+8DD2FgPanuSiaOtzmtGz2VX7Ja21HM3cRZZ7xrQ8IfxKizGw2GodUe+2w9d9Yt
	izelcogt20tiHQhw7Dc8J2FwrplJtUxNSeiG87ppFV3OvPFe7ZDS5Q5hVXrIN/oc
	YS+uj/H8mbE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E3B526F6A;
	Mon,  7 Jul 2014 13:43:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9520326F5B;
	Mon,  7 Jul 2014 13:43:08 -0400 (EDT)
In-Reply-To: <53B48613.60509@gmail.com> (Karsten Blees's message of "Thu, 03
	Jul 2014 00:22:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 28701752-05FE-11E4-A31F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252975>

Karsten Blees <karsten.blees@gmail.com> writes:

> Hashmap entries are typically looked up by just a key. The hashmap_get()
> API expects an initialized entry structure instead, to support compound
> keys. This flexibility is currently only needed by find_dir_entry() in
> name-hash.c (and compat/win32/fscache.c in the msysgit fork). All other
> (currently five) call sites of hashmap_get() have to set up a near emtpy

s/emtpy/empty/;

> entry structure, resulting in duplicate code like this:
>
>   struct hashmap_entry keyentry;
>   hashmap_entry_init(&keyentry, hash(key));
>   return hashmap_get(map, &keyentry, key);
>
> Add a hashmap_get_from_hash() API that allows hashmap lookups by just
> specifying the key and its hash code, i.e.:
>
>   return hashmap_get_from_hash(map, hash(key), key);

While I think the *_get_from_hash() is an improvement over the
three-line sequence, I find it somewhat strange that callers of it
still must compute the hash code themselves, instead of letting the
hashmap itself to apply the user supplied hash function to the key
to derive it.  After all, the map must know how to compare two
entries via a user-supplied cmpfn given at the map initialization
time, and the algorithm to derive the hash code falls into the same
category, in the sense that both must stay the same during the
lifetime of a hashmap, no?  Unless there is a situation where you
need to be able to initialize a hashmap_entry without knowing which
hashmap the entry will eventually be stored, it feels dubious API
that exposes to the outside callers hashmap_entry_init() that takes
the hash code without taking the hashmap itself.

In other words, why isn't hashmap_get() more like this:

        void *hashmap_get(const struct hashmap *map, const void *key)
        {
                struct hashmap_entry keyentry;
                hashmap_entry_init(&keyentry, map->hash(key));
                return *find_entry_ptr(map, &keyentry, key);
        }

with hashmap_entry_init() purely a static helper in hashmap.c?
