From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Tue, 29 Jan 2013 09:38:10 -0800
Message-ID: <7vy5fbq48t.fsf@alter.siamese.dyndns.org>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 18:38:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0F8l-0005jt-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 18:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab3A2RiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 12:38:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab3A2RiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 12:38:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C06CCC2D0;
	Tue, 29 Jan 2013 12:38:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=WWD7NpeEfDDRgrYyXMVBTh9dUOU=; b=SyVbhjhHgJkZVdfS82c7
	vL2X//4FTz7EmVRt+WAlfsH2V3e//jLjfAyW9Ei9E2oG7eE5rrEm8ji5BPTYFfaU
	BJGBAmtZgYfYaiGTFu0IRKbSb8MSZDpvaluEZ0zkhytUx8UXOUvKaXDFcMke5TPn
	LtcX4Zr1adFrgtzCKZbeJ60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=p961sNwWosGngKKfm1BN4wY9cEKcseiyAeg7T6AuTJVUDd
	Il1sIzED9eWWtSrIUV9vdkrBDovSt9L8eGV5GEuH/skVd/Ty24q8FT+xnwgOtJtf
	QJBcBX9Cs7F3/WI6vC8MgnaK18eToNmEwDTt/ZKN6t3tT45rj+srHUqT7EAnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B56A4C2CF;
	Tue, 29 Jan 2013 12:38:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6A10C2CD; Tue, 29 Jan 2013
 12:38:11 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A726F644-6A3A-11E2-9D64-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214950>

Jeff King <peff@peff.net> writes:

> +int commit_metapack(unsigned char *sha1,
> +		    uint32_t *timestamp,
> +		    unsigned char **tree,
> +		    unsigned char **parent1,
> +		    unsigned char **parent2)
> +{
> +	struct commit_metapack *p;
> +
> +	prepare_commit_metapacks();
> +	for (p = commit_metapacks; p; p = p->next) {
> +		unsigned char *data;
> +		int pos = sha1_entry_pos(p->index, 20, 0, 0, p->nr, p->nr, sha1);

This is a tangent, but isn't it about time to rip out the check for
GIT_USE_LOOKUP in find_pack_entry_one(), I wonder.

> +	prepare_commit_metapacks();
> +	for (p = commit_metapacks; p; p = p->next) {
> +		unsigned char *data;
> +		int pos = sha1_entry_pos(p->index, 20, 0, 0, p->nr, p->nr, sha1);
> +		if (pos < 0)
> +			continue;
> +
> +		/* timestamp(4) + tree(20) + parents(40) */
> +		data = p->data + 64 * pos;
> +		*timestamp = *(uint32_t *)data;
> +		*timestamp = ntohl(*timestamp);
> +		data += 4;
> +		*tree = data;
> +		data += 20;
> +		*parent1 = data;
> +		data += 20;
> +		*parent2 = data;
> +
> +		return 0;
> +	}
> +
> +	return -1;
> +}

I am torn on this one.

These cached properties of a single commit will not change no matter
which pack it appears in, and it feels logically wrong, especially
when you record these object names in the full SHA-1 form, to tie a
"commit metapack" to a pack.  Logically there needs only one commit
metapack that describes all the commits known to the repository when
the metapack was created.

In order to reduce the disk footprint and I/O cost, the future
direction for this mechanism may want to point into an existing
store of SHA-1 hashes with a shorter file offset, and the .idx file
could be such a store, and in order to move in that direction, you
cannot avoid tying a metapack to a pack.

> +static void get_commits(struct metapack_writer *mw,
> +			const unsigned char *sha1,
> +			void *data)
> +{
> +	struct commit_list ***tail = data;
> +	enum object_type type = sha1_object_info(sha1, NULL);
> +	struct commit *c;
> +
> +	if (type != OBJ_COMMIT)
> +		return;
> +
> +	c = lookup_commit(sha1);
> +	if (!c || parse_commit(c))
> +		die("unable to read commit %s", sha1_to_hex(sha1));
> +
> +	/*
> +	 * Our fixed-size parent list cannot represent root commits, nor
> +	 * octopus merges. Just skip those commits, as we can fallback
> +	 * in those rare cases to reading the actual commit object.
> +	 */
> +	if (!c->parents ||
> +	    (c->parents && c->parents->next && c->parents->next->next))
> +		return;
> +
> +	*tail = &commit_list_insert(c, *tail)->next;
> +}

It feels somewhat wasteful to:

 - use commit_list for this, rather than an array of commit
   objects.  If you have a rough estimate of the number of commits
   in the pack, you could just preallocate a single array and use
   ALLOC_GROW() on it, no?

 - iterate over the .idx file and run sha1_object_info() and
   parse_commit() on many objects in the SHA-1 order.  Iterating in
   the way builtin/pack-objects.c::get_object_details() does avoids
   jumping around in existing packfiles, which may be more
   efficient, no?

> +void commit_metapack_write(const char *idx)
> +{
> +	struct metapack_writer mw;
> +	struct commit_list *commits = NULL, *p;
> +	struct commit_list **tail = &commits;
> +	uint32_t nr = 0;
> +
> +	metapack_writer_init(&mw, idx, "commits", 1);
> +
> +	/* Figure out how many eligible commits we've got in this pack. */
> +	metapack_writer_foreach(&mw, get_commits, &tail);
> +	for (p = commits; p; p = p->next)
> +		nr++;
