From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 10/16] Read resolve-undo data
Date: Sun, 05 Aug 2012 18:51:39 -0700
Message-ID: <7vk3xc23f8.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-11-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:51:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyCU3-0006gW-M2
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435Ab2HFBvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:51:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286Ab2HFBvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:51:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A0688FC0;
	Sun,  5 Aug 2012 21:51:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XenFwmVR8cnP/KiBWcynILSpvi0=; b=bP+Tcn
	lhwRNKlJB8Sze2FF2vHm+q8B7Gr+gAdXAPmlWUtIGv21+PnsCDxBG7Fr7JaFV4rn
	MHa1Q8opXpCH2IuuN8nxI+Ao7tycgBpmYkaJahE9QNMR7TjjZqXJTpMsFtxom4Vb
	Fuawzf1BPJXt17B1Uw6aCwISHy3HKTm7SVwmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NVnXrWix/NB3q9YKSOlYSLdBng+4mYaI
	nkPKTbzVQjM1Ys7U9EOJQ3NFcLN657KawkJ4FxRaDgkm9QKxuRx0oj5KUrKIzqZ8
	eR5rQvPYBvYPb5CT+3vnlnt8yEL3iHBVg/105xfBpvErQfesQ5M1nhru+0B3CzH5
	IkbHSdB+YLg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6857E8FBF;
	Sun,  5 Aug 2012 21:51:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A54CD8FBE; Sun,  5 Aug 2012
 21:51:40 -0400 (EDT)
In-Reply-To: <1344203353-2819-11-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Sun, 5 Aug 2012 23:49:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44376444-DF69-11E1-B91E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202949>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Make git read the resolve-undo data from the index.
>
> Since the resolve-undo data is joined with the conflicts in
> the ondisk format of the index file version 5, conflicts and
> resolved data is read at the same time, and the resolve-undo
> data is then converted to the in-memory format.
>
> Helped-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  read-cache.c   |    1 +
>  resolve-undo.c |   36 ++++++++++++++++++++++++++++++++++++
>  resolve-undo.h |    2 ++
>  3 files changed, 39 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 70334f9..03370f9 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1942,6 +1942,7 @@ static struct directory_entry *read_entries_v5(struct index_state *istate,
>  	int i;
>  
>  	conflict_queue = read_conflicts_v5(de, mmap, mmap_size, fd);
> +	resolve_undo_convert_v5(istate, conflict_queue);
>  	for (i = 0; i < de->de_nfiles; i++) {
>  		ce = read_entry_v5(de,
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

It is unclear why this needs to be part of resolve-undo.c and
exported from it.  Shouldn't it (and bulk of the previous few
patches) be part of a read-cache-v5.c file (with v2/3/4 specific
part separated out from read-cache.c to form read-cache-v2.c)?

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
