From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/5] sha1_file: support reading from a loose object of unknown type
Date: Wed, 29 Apr 2015 07:49:08 -0700
Message-ID: <xmqqtwvzt2fv.fsf@gitster.dls.corp.google.com>
References: <5540D397.8020104@gmail.com>
	<1430311933-23180-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 16:49:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnTIg-0004Ei-SP
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 16:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423052AbbD2OtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 10:49:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031690AbbD2OtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 10:49:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 084804BD9C;
	Wed, 29 Apr 2015 10:49:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yw7KuV1vfa8JZwQCpXAYS5Id1e8=; b=aOcVcy
	gy8YzI/Prs5W8VLQ5RUkeuWgnrXqvGsuSJs+/Sq1Vqo4+Yjkn4eDqMoUvGxQvYKk
	2az04qUNoiHBRJEcpmLsAnC5P9aQZaoj8ALR+U7m4CfNj3A5sYYPZqHTKSZydVmJ
	ZgevSp40Qnf4Xxgwsmtx0Vny5Fh5KU2W7wI6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhsPxgDmm5cD0kEHy1NxD/tVvE+TdURN
	H0xe+pRjs4mINOyii5a/gmwahuWIhh3FeFVP4bik8RG4LYBFfaRRhxD0Pk6fm58Y
	jU823V7UY1OjREqbRO4UhFc3S7jn/PeAjwSH7vjUi+jGP43kOKby+NxILQztVuzQ
	vuJ5GddAFg4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E26524BD9A;
	Wed, 29 Apr 2015 10:49:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17ED84BD94;
	Wed, 29 Apr 2015 10:49:10 -0400 (EDT)
In-Reply-To: <1430311933-23180-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 29 Apr 2015 18:22:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E4E019D2-EE7E-11E4-A5EF-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267967>

Karthik Nayak <karthik.188@gmail.com> writes:

> Update sha1_loose_object_info() to optionally allow it to read
> from a loose object file of unknown/bogus type; as the function
> usually returns the type of the object it read in the form of enum
> for known types, add an optional "typename" field to receive the
> name of the type in textual form and a flag to indicate the reading
> of a loose object file of unknown/bogus type.
>
> Add parse_sha1_header_extended() which acts as a wrapper around
> parse_sha1_header() allowing more information to be obtained.

Thanks.  This mostly looks good modulo a nit.

> diff --git a/sha1_file.c b/sha1_file.c
> index 980ce6b..9a15634 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1564,6 +1564,33 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
>  	return git_inflate(stream, 0);
>  }
>  
> +static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
> +					unsigned long mapsize, void *buffer,
> +					unsigned long bufsiz, struct strbuf *header)

This function in this round looks somewhat tricky.

> +{
> +	unsigned char *cp;
> +	int status;
> +
> +	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);

Here, we unpack into the caller-supplied buffer, without touching
the caller-supplied header strbuf.

> +	/*
> +	 * Check if entire header is unpacked in the first iteration.
> +	 */
> +	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
> +		return 0;

And we return the object header in the buffer without ever touching
the header strbuf.  We expect that the caller would know that the
buffer it gave us would contain the full object header line.

> +	strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
> +	do {
> +		status = git_inflate(stream, 0);
> +		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
> +		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
> +			return 0;

However, here, we return the object header in the caller-supplied
header strbuf, while using the caller-supplied buffer as a scratch
area.  We expect that the caller would know that the header strbuf
is what it has to use to find the object header.

Which is good in the sense that there is no unnecessary copies, but
the caller needs to be careful to do something like:

	if (!unpack_to_strbuf(... buffer, sizeof(buffer), &header)) {
    		if (header.len)
                	object_header = header.buf;
		else
                	object_header = buffer;
	} else {
        	error("cannot unpack the object header");
	}

It is a good trade-off between complexity and efficiency.  The
complexity is isolated as the function is file-scope-static and it
is perfectly fine to force the callers to be extra careful.

But this suggests that the patch to add tests should try at least
two, preferably three, kinds of test input.  A bogus type that needs
a header longer than the caller's fixed buffer, a bogus type whose
header would fit within the fixed buffer, and optionally a correct
type whose header should always fit within the fixed buffer.

> @@ -1614,27 +1641,38 @@ static void *unpack_sha1_rest(git_zstream *stream, void
> ...
> +	/*
> +	 * Set type to 0 if its an unknown object and
> +	 * we're obtaining the type using '--allow-unkown-type'
> +	 * option.
> +	 */
> +	if ((flags & LOOKUP_UNKNOWN_OBJECT) && (type == -1))
> +		type = 0;
> +	else if (type == -1)
> +		die("invalid object type");

Would "type == -2" or any other negative value, if existed, mean
something different?  I do not think so, and hence I would prefer
these two checks be done with "type < 0" instead.

> @@ -2522,13 +2572,15 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
>  }
>  
>  static int sha1_loose_object_info(const unsigned char *sha1,
> -				  struct object_info *oi)
> +				  struct object_info *oi,
> +				  int flags)
>  {
> -	int status;
> -	unsigned long mapsize, size;
> +	int status = 0;
> +	unsigned long mapsize;
>  	void *map;
>  	git_zstream stream;
>  	char hdr[32];
> +	struct strbuf hdrbuf = STRBUF_INIT;
> ...
> +	if ((flags & LOOKUP_UNKNOWN_OBJECT)) {
> +		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
> +			status = error("unable to unpack %s header with --allow-unknown-type",
> +				       sha1_to_hex(sha1));
> +	} else if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
>  		status = error("unable to unpack %s header",
>  			       sha1_to_hex(sha1));
> -	else if ((status = parse_sha1_header(hdr, &size)) < 0)
> +	if (hdrbuf.len) {

And here the caller is being careful, but the way it does is a bit
subtle.  Even if it has a codepath that entirely bypasses a call to
unpack_to_strbuf(), it knows that the other codepath does not touch
the hdrbuf strbuf, which means that this block can be reached only
when it called unpack_to_strbuf(), the callee found a long object
header, and the unpacking succeeded.  Otherwise, it will make a
call to parse_sha1_header_extended() using the fixed hdr[] in the
"else if" clause that corresponds to this "if".

> +		if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
> +			status = error("unable to parse %s header with --allow-unknown-type",
> +				       sha1_to_hex(sha1));
> +	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
>  		status = error("unable to parse %s header", sha1_to_hex(sha1));

However, I wonder what happens when "status" is already set after
the call to unpack functions above.  hdrbuf.len may be zero so this
"else if" part would be taken, and it then still try to feed the
hdr[] to parse_sha1_header_extended(), no?

In other words, shouldn't the flow be more like this?

	if (lookup-unknown) {
        	if (unpack-to-strbuf)
			status = error();
	} else if (unpack-to-hdr)
		status = error();

+	if (status < 0)
+        	; /* do not do anything */
+	else if (hdrbuf.len)
-	if (hdrbuf.len)
		parse(hdrbuf.buf);
	else
        	parse(hdr);
