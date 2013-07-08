From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/22] read-cache: add index reading api
Date: Mon, 08 Jul 2013 09:36:58 -0700
Message-ID: <7va9lx100l.fsf@alter.siamese.dyndns.org>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
	<1373184720-29767-6-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 18:37:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwER3-0002As-CP
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 18:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab3GHQhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 12:37:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488Ab3GHQhB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 12:37:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 268CA2E2F8;
	Mon,  8 Jul 2013 16:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o9bvXrivcuzCg0gTB0n63rDweAU=; b=oDku0k
	yrrpPggSXxqYCtbScMwDCMIOcJkqLqF0OeI3PclCA2rbburqEuhLR9NkowNZpBH6
	Bfm/ELajyr05WlVmouN8W/SW2kW8x5wteCjQzySuW6jqEyrq+HuWUGIK3LqljH3H
	STxLsLeNoXRgZhkLkE+bpXTebOiUAFLipEMpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X5eK9p0hXeXZEvWhEnfekXqUd8mwNmSY
	kQVmaLTT0IzTwA3V6D34OrPsjDEofBuri6yp3ElgI7yiROCjXTrNYFhImfuV8O2k
	pRi6ISsTrPcr1tm2OtQOpdBBYm7Z14LOTJzhVxYannLqFRWJHUCGaBlY5l+RqDh2
	rq2SNKfKxiY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D43E2E2F7;
	Mon,  8 Jul 2013 16:37:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A7692E2EC;
	Mon,  8 Jul 2013 16:37:00 +0000 (UTC)
In-Reply-To: <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Sun, 7 Jul 2013 10:11:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CE59B56-E7EC-11E2-B743-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229875>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Add an api for access to the index file.  Currently there is only a very
> basic api for accessing the index file, which only allows a full read of
> the index, and lets the users of the data filter it.  The new index api
> gives the users the possibility to use only part of the index and
> provides functions for iterating over and accessing cache entries.
>
> This simplifies future improvements to the in-memory format, as changes
> will be concentrated on one file, instead of the whole git source code.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  cache.h         |  57 +++++++++++++++++++++++++++++-
>  read-cache-v2.c |  96 +++++++++++++++++++++++++++++++++++++++++++++++--
>  read-cache.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  read-cache.h    |  12 ++++++-
>  4 files changed, 263 insertions(+), 10 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 5082b34..d38dfbd 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -127,7 +127,8 @@ struct cache_entry {
>  	unsigned int ce_flags;
>  	unsigned int ce_namelen;
>  	unsigned char sha1[20];
> -	struct cache_entry *next;
> +	struct cache_entry *next; /* used by name_hash */
> +	struct cache_entry *next_ce; /* used to keep a list of cache entries */

The reader often needs to rewind the read-pointer partially while
walking the index (e.g. next_cache_entry() in unpack-trees.c and how
the o->cache_bottom position is used throughout the subsystem).  I
am not sure if this singly-linked list is a good way to go.

> +/*
> + * Options by which the index should be filtered when read partially.
> + *
> + * pathspec: The pathspec which the index entries have to match
> + * seen: Used to return the seen parameter from match_pathspec()
> + * max_prefix, max_prefix_len: These variables are set to the longest
> + *     common prefix, the length of the longest common prefix of the
> + *     given pathspec

These probably should use "struct pathspec" abstration, not just the
"array of raw strings", no?
