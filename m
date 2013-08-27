From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/23] pack v4: tree object encoding
Date: Tue, 27 Aug 2013 08:44:09 -0700
Message-ID: <xmqqtxibdtpy.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<1377577567-27655-11-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:44:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VELRL-0005KX-QV
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab3H0PoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 11:44:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36520 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab3H0PoP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:44:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE2763CDD7;
	Tue, 27 Aug 2013 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WXpARzbKQAk5FS+EATqbW8r62iI=; b=rBZKfJ
	fEbpRWV5McVQd6ErJT1dSAAbZ9sj6H+Tqez0TRRlF5tNrzux/MRTaTuNDZRJu4P7
	jmYGF14ZkOiU+l6tXeyUUk8ZHgtp0wx/AYCv2s49+PdQ2gAexeOjM65o4VJ97Vp0
	d9wNsnF49XBYu/OglwOUxseGcMIBXtSzPDrr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mh1Tx/Vq81UgNg2uDRAiWA3H8Tavl/JJ
	JlL1Z3hYz7N2oIkSowatquqVNfXCASTin0mK9S885zxZDSonfMnWL9ufEA8CFtmL
	U/uFiqOwPQeDIlGjmx0RLs6E+lg4klW/EJjFiVH4IJRqVUZZWp5cEh56a2L4co+x
	y7Bn3B/l5ps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29FE03CDD4;
	Tue, 27 Aug 2013 15:44:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2A6B3CDCB;
	Tue, 27 Aug 2013 15:44:10 +0000 (UTC)
In-Reply-To: <1377577567-27655-11-git-send-email-nico@fluxnic.net> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 00:25:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8466A736-0F2F-11E3-BCA0-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233104>

Nicolas Pitre <nico@fluxnic.net> writes:

> This goes as follows:
>
> - Number of tree entries: variable length encoded.
>
> Then for each tree entry:
>
> - Path component reference: variable length encoded index into the path
>   string dictionary table which also covers the entry mode.  To make the
>   overall encoding efficient, the author table is already sorted by usage
>   frequency so the most used names are first and require the shortest
>   index encoding.

s/author table/tree path table/, I think. The reason why it is a
good idea to sort these tables by use count applies equally to both
the author table and the tree path table, though.

> - SHA1 reference: either variable length encoding of the index into the
>   SHA1 table or the literal SHA1 prefixed by 0 (see add_sha1_ref()).
>
> Rationale: all the tree object data is densely encoded while requiring
> no zlib inflate processing, and all SHA1 references are most likely to
> be direct indices into the pack index file requiring no SHA1 search.
> Path filtering can be accomplished on the path index directly without
> any string comparison during the tree traversal.
>
> Still lacking is some kind of delta encoding for multiple tree objects
> with only small differences between them.  But that'll come later.
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
>  packv4-create.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/packv4-create.c b/packv4-create.c
> index cedbbd9..f46fbd9 100644
> --- a/packv4-create.c
> +++ b/packv4-create.c
> @@ -408,6 +408,69 @@ bad:
>  	return NULL;
>  }
>  
> +/*
> + * This converts a canonical tree object buffer into its
> + * tightly packed representation using the already populated
> + * and sorted tree_path_table dictionary.  The parsing is
> + * strict so to ensure the canonical version may always be
> + * regenerated and produce the same hash.
> + */
> +void * conv_to_dict_tree(void *buffer, unsigned long *psize)
> +{
> +	unsigned long size = *psize;
> +	unsigned char *in, *out, *end;
> +	struct tree_desc desc;
> +	struct name_entry name_entry;
> +	int nb_entries;
> +
> +	if (!size)
> +		return NULL;
> +
> +	/*
> +	 * We can't make sure the result will always be smaller.
> +	 * The smallest possible entry is "0 x\0<40 byte SHA1>"
> +	 * or 44 bytes.  The output entry may have a realistic path index
> +	 * encoding using up to 3 bytes, and a non indexable SHA1 meaning
> +	 * 41 bytes.  And the output data already has the and nb_entries
> +	 * headers.  In practice the output size will be significantly
> +	 * smaller but for now let's make it simple.
> +	 */
> +	in = buffer;
> +	out = xmalloc(size);
> +	end = out + size;
> +	buffer = out;
> +
> +	/* let's count how many entries there are */
> +	init_tree_desc(&desc, in, size);
> +	nb_entries = 0;
> +	while (tree_entry(&desc, &name_entry))
> +		nb_entries++;
> +	out = add_number(out, nb_entries);
> +
> +	init_tree_desc(&desc, in, size);
> +	while (tree_entry(&desc, &name_entry)) {
> +		int pathlen = tree_entry_len(&name_entry);
> +		int index = dict_add_entry(tree_path_table, name_entry.mode,
> +					   name_entry.path, pathlen);
> +		if (index < 0) {
> +			error("missing tree dict entry");
> +			free(buffer);
> +			return NULL;
> +		}
> +		if (end - out < 45) {
> +			unsigned long sofar = out - (unsigned char *)buffer;
> +			buffer = xrealloc(buffer, sofar + 45);
> +			out = (unsigned char *)buffer + sofar;
> +			end = out + 45;
> +		}
> +		out = add_number(out, index);
> +		out = add_sha1_ref(out, name_entry.sha1);
> +	}
> +
> +	*psize = out - (unsigned char *)buffer;
> +	return buffer;
> +}
> +
>  static struct pack_idx_entry *get_packed_object_list(struct packed_git *p)
>  {
>  	unsigned i, nr_objects = p->num_objects;
