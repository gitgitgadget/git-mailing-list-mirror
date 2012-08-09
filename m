From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 07/13] Read resolve-undo data
Date: Thu, 09 Aug 2012 15:51:58 -0700
Message-ID: <7vk3x7n0fl.fsf@alter.siamese.dyndns.org>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-8-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 00:52:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szbal-0004uj-8V
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 00:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759900Ab2HIWwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 18:52:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759873Ab2HIWwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 18:52:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF9F97A2;
	Thu,  9 Aug 2012 18:52:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l3JTTqOPjnB944KPbFUbg+r8vGk=; b=xZCRSF
	oKdY7bNDrD8SGT6VNkfcV3vPoyd1vEqjlG8qVypcgIMmCYMbimUuK801YJHJwG2x
	ONBQa0prg0M2jBvMM38WZv03d+RO50rs1aOaEMeJ8YkLtEppjPCQWe8vzlMvMMA8
	OAoSCfKROz/KoQcd9hWMnBSF2PZKT9+mT6ePo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IFYRJ7t0cV3R40WZsAbXokZw1X3b7w07
	FcEuLQhAm2siXYUhZJ6Qz43A8G2OB5XxxPotQFTTh9wvyQTv/A2XcIRraGL9ejDX
	hcwahWbYcTNcdKbwtBWIOqeBHjkMmrkRud4yMBad2sEDSDMkSDa/NspuQyOPYRF5
	h4xyELlVtnw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BA4597A1;
	Thu,  9 Aug 2012 18:52:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9036197A0; Thu,  9 Aug 2012
 18:51:59 -0400 (EDT)
In-Reply-To: <1344424681-31469-8-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Wed, 8 Aug 2012 13:17:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3D72BBC-E274-11E1-BDFF-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203186>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Make git read the resolve-undo data from the index.
>
> Since the resolve-undo data is joined with the conflicts in
> the ondisk format of the index file version 5, conflicts and
> resolved data is read at the same time, and the resolve-undo
> data is then converted to the in-memory format.

This, and the next one, are both about reading extension data from
the v2 formatted index, no?

Again, mild NAK.

I think it is a lot more logical for the v5 code to read data stored
in the resolve-undo and cache-tree extensions using the public API
just like other users of these data do, and write out whatever in a
way that is specific to the v5 index format.

If the v5 codepath needs some information that is not exposed to
other users of istate->resolve_undo and istate->cache_tree, then the
story is different, but I do not think that is the case.

>
> Helped-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  read-cache-v5.c |    1 +
>  resolve-undo.c  |   36 ++++++++++++++++++++++++++++++++++++
>  resolve-undo.h  |    2 ++
>  3 files changed, 39 insertions(+)
>
> diff --git a/read-cache-v5.c b/read-cache-v5.c
> index ec1201d..b47398d 100644
> --- a/read-cache-v5.c
> +++ b/read-cache-v5.c
> @@ -494,6 +494,7 @@ static struct directory_entry *read_entries(struct index_state *istate,
>  	int i;
>  
>  	conflict_queue = read_conflicts(de, mmap, mmap_size, fd);
> +	resolve_undo_convert_v5(istate, conflict_queue);
>  	for (i = 0; i < de->de_nfiles; i++) {
>  		ce = read_entry(de,
>  				entry_offset,
> diff --git a/resolve-undo.c b/resolve-undo.c
> index 72b4612..f96c6ba 100644
> --- a/resolve-undo.c
> +++ b/resolve-undo.c
> @@ -170,3 +170,39 @@ void unmerge_index(struct index_state *istate, const char **pathspec)
>  		i = unmerge_index_entry_at(istate, i);
>  	}
>  }
> +
> +void resolve_undo_convert_v5(struct index_state *istate,
> +					struct conflict_entry *ce)
> +{
> +	int i;
> +
> +	while (ce) {
> +		struct string_list_item *lost;
> +		struct resolve_undo_info *ui;
> +		struct conflict_part *cp;
> +
> +		if (ce->entries && (ce->entries->flags & CONFLICT_CONFLICTED) != 0) {
> +			ce = ce->next;
> +			continue;
> +		}
> +		if (!istate->resolve_undo) {
> +			istate->resolve_undo = xcalloc(1, sizeof(struct string_list));
> +			istate->resolve_undo->strdup_strings = 1;
> +		}
> +
> +		lost = string_list_insert(istate->resolve_undo, ce->name);
> +		if (!lost->util)
> +			lost->util = xcalloc(1, sizeof(*ui));
> +		ui = lost->util;
> +
> +		cp = ce->entries;
> +		for (i = 0; i < 3; i++)
> +			ui->mode[i] = 0;
> +		while (cp) {
> +			ui->mode[conflict_stage(cp) - 1] = cp->entry_mode;
> +			hashcpy(ui->sha1[conflict_stage(cp) - 1], cp->sha1);
> +			cp = cp->next;
> +		}
> +		ce = ce->next;
> +	}
> +}
> diff --git a/resolve-undo.h b/resolve-undo.h
> index 8458769..ab660a6 100644
> --- a/resolve-undo.h
> +++ b/resolve-undo.h
> @@ -13,4 +13,6 @@ extern void resolve_undo_clear_index(struct index_state *);
>  extern int unmerge_index_entry_at(struct index_state *, int);
>  extern void unmerge_index(struct index_state *, const char **);
>  
> +extern void resolve_undo_convert_v5(struct index_state *, struct conflict_entry *);
> +
>  #endif
