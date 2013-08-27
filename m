From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/23] pack v4: commit object encoding
Date: Tue, 27 Aug 2013 08:39:44 -0700
Message-ID: <xmqqy57ndtxb.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<1377577567-27655-10-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:40:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VELNF-000266-TC
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab3H0Pj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 11:39:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab3H0Pjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:39:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C938B3CA35;
	Tue, 27 Aug 2013 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lsl5/+M1i+296vBSe/4SEWkxOO8=; b=U+LbVs
	GApemZxRj2+ywVZVE8Dh546X6a8nEGYbc1AIP1bX8REZGKHsurvQ3LELBDO8WiNX
	fZkbarRm/gjkwCG+QaVd4Iwl2W5fncNx/pDq6aFoLEiXJeI/TClotuGZ0ffEzSo6
	r0aC4yXAhCIcRBnZIBzlfucGrq+6e6TZf4luI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B2hDlKAVATHXORfiP/R0WVFqGwSopJop
	rZjP/fxhdCbL0SvPLRDBbFILVyqJD25o9cZf/8KQWRIG28NoTLagjc+lgxugfFqP
	/bKFg25BDuRjbeugqiUzVnsepYmDLVfgsuwUB9erTw2d75+P+3cs+u0OKk0pdz1q
	D36PgNRsSHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90F683CA31;
	Tue, 27 Aug 2013 15:39:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64C323CA2D;
	Tue, 27 Aug 2013 15:39:46 +0000 (UTC)
In-Reply-To: <1377577567-27655-10-git-send-email-nico@fluxnic.net> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 00:25:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E6C2CE56-0F2E-11E3-8FCC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233103>

Nicolas Pitre <nico@fluxnic.net> writes:

> This goes as follows:
>
> - Tree reference: either variable length encoding of the index
>   into the SHA1 table or the literal SHA1 prefixed by 0 (see
>   add_sha1_ref()).
>
> - Parent count: variable length encoding of the number of parents.
>   This is normally going to occupy a single byte but doesn't have to.
>
> - List of parent references: a list of add_sha1_ref() encoded references,
>   or nothing if the parent count was zero.
>
> - Author reference: variable length encoding of an index into the author
>   string dictionary table which also covers the time zone.  To make the
>   overall encoding efficient, the author table is already sorted by usage
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
> requiring no zlib inflate processing, and all SHA1 references are most
> likely to be direct indices into the pack index file requiring no SHA1
> search into the pack index file.
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
>  packv4-create.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>
> diff --git a/packv4-create.c b/packv4-create.c
> index bf33d15..cedbbd9 100644
> --- a/packv4-create.c
> +++ b/packv4-create.c
> @@ -13,6 +13,9 @@
>  #include "tree-walk.h"
>  #include "pack.h"
>  
> +
> +static int pack_compression_level = Z_DEFAULT_COMPRESSION;
> +
>  struct data_entry {
>  	unsigned offset;
>  	unsigned size;
> @@ -289,6 +292,122 @@ static unsigned char *add_sha1_ref(unsigned char *dst, const unsigned char *sha1
>  	return dst + 20;
>  }
>  
> +/*
> + * This converts a canonical commit object buffer into its
> + * tightly packed representation using the already populated
> + * and sorted commit_name_table dictionary.  The parsing is
> + * strict so to ensure the canonical version may always be
> + * regenerated and produce the same hash.
> + */
> +void * conv_to_dict_commit(void *buffer, unsigned long *psize)

Drop SP between asterisk and "conv_"?

> +{
> +	unsigned long size = *psize;
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
> +	if (get_sha1_hex(in + 5, sha1) < 0)
> +		goto bad_data;

Is this strict enough to guarantee roundtrip hash identity?  Because
get_sha1_hex() accepts hexadecimal represented with uppercase A-F,
you need to reject such a "broken" commit object, no?

Same for parent commit object names below that are parsed with the
same helper.
