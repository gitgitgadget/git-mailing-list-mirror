From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/38] pack v4: commit object encoding
Date: Thu, 05 Sep 2013 23:57:53 -0700
Message-ID: <xmqqvc2ezbbi.fsf@gitster.dls.corp.google.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
	<1378362001-1738-11-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 06 08:58:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHpzV-0005PY-Tl
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 08:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170Ab3IFG56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 02:57:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab3IFG55 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 02:57:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AA5938630;
	Fri,  6 Sep 2013 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WbASkUVfao6dT8rMKoW6Q+n3yH0=; b=m6djMO
	4UwbFCCL4KPFL+EhlzEdPqb9IAXzIz68eiroUGqQ9xtseP1CF+pL3WGA+kNt9NjU
	/D6psn7FIQgSXjqDFpcQfitxHSyJsqLOQuFSX02OZwpEvALnBFjOxM9wvoTfEfOe
	hEhVk/HzTiHYLKG3vmnt4+LBQw7PrLFMswmWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SpJk2ZkaGUdDfQ3rYmKK8VPIIEEVNPq9
	llIjJ4mBR/9PoYSPcK5QJ1GIBeGXmOh6k2vhZRKON0TURPuOnTyk1QuXAQ1nytM3
	JpFdknnCQ0b3gzbC5j00LhZsy+rmK4zbUfkDXT1jNPr8FAlsEo21GXk3sURjntsX
	1nFTmDS0e7c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E5473862F;
	Fri,  6 Sep 2013 06:57:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F0AC3862A;
	Fri,  6 Sep 2013 06:57:55 +0000 (UTC)
In-Reply-To: <1378362001-1738-11-git-send-email-nico@fluxnic.net> (Nicolas
	Pitre's message of "Thu, 05 Sep 2013 02:19:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A8053632-16C1-11E3-958D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234028>

Nicolas Pitre <nico@fluxnic.net> writes:

> This goes as follows:
>
> - Tree reference: either variable length encoding of the index
>   into the SHA1 table or the literal SHA1 prefixed by 0 (see
>   encode_sha1ref()).
>
> - Parent count: variable length encoding of the number of parents.
>   This is normally going to occupy a single byte but doesn't have to.
>
> - List of parent references: a list of encode_sha1ref() encoded
>   references, or nothing if the parent count was zero.
>
> - Author reference: variable length encoding of an index into the author
>   identifier dictionary table which also covers the time zone.  To make
>   the overall encoding efficient, the author table is sorted by usage
>   frequency so the most used names are first and require the shortest
>   index encoding.
>
> - Author time stamp: variable length encoded.  Year 2038 ready!
>
> - Committer reference: same as author reference.
>
> - Committer time stamp: same as author time stamp.
>
> The remainder of the canonical commit object content is then zlib
> compressed and appended to the above.
>
> Rationale: The most important commit object data is densely encoded while
> requiring no zlib inflate processing on access, and all SHA1 references
> are most likely to be direct indices into the pack index file requiring
> no SHA1 search into the pack index file.

May I suggest a small change to the above, though.

Reorder the entries so that Parent count, list of parents and
committer time stamp come first in this order, and then the rest.

That way, commit.c::parse_commit() could populate its field lazily
with parsing only the very minimum set of fields, and then the
revision walker, revision.c::add_parents_to_list(), can find where
in the priority queue to add the parents to the list of commits to
be processed while still keeping the object partially parsed.  If a
commit is UNINTERESTING, no further parsing needs to be done.

>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
>  packv4-create.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>
> diff --git a/packv4-create.c b/packv4-create.c
> index 12527c0..d4a79f4 100644
> --- a/packv4-create.c
> +++ b/packv4-create.c
> @@ -14,6 +14,9 @@
>  #include "pack.h"
>  #include "varint.h"
>  
> +
> +static int pack_compression_level = Z_DEFAULT_COMPRESSION;
> +
>  struct data_entry {
>  	unsigned offset;
>  	unsigned size;
> @@ -274,6 +277,122 @@ static int encode_sha1ref(const unsigned char *sha1, unsigned char *buf)
>  	return 1 + 20;
>  }
>  
> +/*
> + * This converts a canonical commit object buffer into its
> + * tightly packed representation using the already populated
> + * and sorted commit_name_table dictionary.  The parsing is
> + * strict so to ensure the canonical version may always be
> + * regenerated and produce the same hash.
> + */
> +void *pv4_encode_commit(void *buffer, unsigned long *sizep)
> +{
> +	unsigned long size = *sizep;
> +	char *in, *tail, *end;
> +	unsigned char *out;
> +	unsigned char sha1[20];
> +	int nb_parents, index, tz_val;
> +	unsigned long time;
> +	z_stream stream;
> +	int status;
> +
> +	/*
> +	 * It is guaranteed that the output is always going to be smaller
> +	 * than the input.  We could even do this conversion in place.
> +	 */
> +	in = buffer;
> +	tail = in + size;
> +	buffer = xmalloc(size);
> +	out = buffer;
> +
> +	/* parse the "tree" line */
> +	if (in + 46 >= tail || memcmp(in, "tree ", 5) || in[45] != '\n')
> +		goto bad_data;
> +	if (get_sha1_lowhex(in + 5, sha1) < 0)
> +		goto bad_data;
> +	in += 46;
> +	out += encode_sha1ref(sha1, out);
> +
> +	/* count how many "parent" lines */
> +	nb_parents = 0;
> +	while (in + 48 < tail && !memcmp(in, "parent ", 7) && in[47] == '\n') {
> +		nb_parents++;
> +		in += 48;
> +	}
> +	out += encode_varint(nb_parents, out);
> +
> +	/* rewind and parse the "parent" lines */
> +	in -= 48 * nb_parents;
> +	while (nb_parents--) {
> +		if (get_sha1_lowhex(in + 7, sha1))
> +			goto bad_data;
> +		out += encode_sha1ref(sha1, out);
> +		in += 48;
> +	}
> +
> +	/* parse the "author" line */
> +	/* it must be at least "author x <x> 0 +0000\n" i.e. 21 chars */
> +	if (in + 21 >= tail || memcmp(in, "author ", 7))
> +		goto bad_data;
> +	in += 7;
> +	end = get_nameend_and_tz(in, &tz_val);
> +	if (!end)
> +		goto bad_data;
> +	index = dict_add_entry(commit_name_table, tz_val, in, end - in);
> +	if (index < 0)
> +		goto bad_dict;
> +	out += encode_varint(index, out);
> +	time = strtoul(end, &end, 10);
> +	if (!end || end[0] != ' ' || end[6] != '\n')
> +		goto bad_data;
> +	out += encode_varint(time, out);
> +	in = end + 7;
> +
> +	/* parse the "committer" line */
> +	/* it must be at least "committer x <x> 0 +0000\n" i.e. 24 chars */
> +	if (in + 24 >= tail || memcmp(in, "committer ", 7))
> +		goto bad_data;
> +	in += 10;
> +	end = get_nameend_and_tz(in, &tz_val);
> +	if (!end)
> +		goto bad_data;
> +	index = dict_add_entry(commit_name_table, tz_val, in, end - in);
> +	if (index < 0)
> +		goto bad_dict;
> +	out += encode_varint(index, out);
> +	time = strtoul(end, &end, 10);
> +	if (!end || end[0] != ' ' || end[6] != '\n')
> +		goto bad_data;
> +	out += encode_varint(time, out);
> +	in = end + 7;
> +
> +	/* finally, deflate the remaining data */
> +	memset(&stream, 0, sizeof(stream));
> +	deflateInit(&stream, pack_compression_level);
> +	stream.next_in = (unsigned char *)in;
> +	stream.avail_in = tail - in;
> +	stream.next_out = (unsigned char *)out;
> +	stream.avail_out = size - (out - (unsigned char *)buffer);
> +	status = deflate(&stream, Z_FINISH);
> +	end = (char *)stream.next_out;
> +	deflateEnd(&stream);
> +	if (status != Z_STREAM_END) {
> +		error("deflate error status %d", status);
> +		goto bad;
> +	}
> +
> +	*sizep = end - (char *)buffer;
> +	return buffer;
> +
> +bad_data:
> +	error("bad commit data");
> +	goto bad;
> +bad_dict:
> +	error("bad dict entry");
> +bad:
> +	free(buffer);
> +	return NULL;
> +}
> +
>  static struct pack_idx_entry *get_packed_object_list(struct packed_git *p)
>  {
>  	unsigned i, nr_objects = p->num_objects;
