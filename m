From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] sha1_file: refactor sha1_file.c to support 'cat-file --literally'
Date: Tue, 17 Mar 2015 13:10:31 -0700
Message-ID: <xmqqbnjro05k.fsf@gitster.dls.corp.google.com>
References: <5507B7EE.1070403@gmail.com>
	<1426569419-8266-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 21:10:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXxp2-0000f7-CW
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 21:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbbCQUKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 16:10:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753230AbbCQUKf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 16:10:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CD65405A4;
	Tue, 17 Mar 2015 16:10:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vw8xelMYuryTZVPbB/5YJEl5VO8=; b=dToRCR
	Quy+U/RzpKwYegHTlFkX/5r5c3KyZ7riT2PAYg7Twfjf4wle1Z3R0HwCeydFSKKL
	dvKBRqpcO2HJBnDWSfFrWy4RuXm2YnO1i3N4MWdPxfEwcbiQaU5Sabidap0sFTgc
	hYtlJ2CnGnL5Ra2tM37dHz96XAW6bEUf4SlYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ebxE3ReG+ZWp2pZUetFHthwVChbrED4k
	Sb9UtTwqJDv0lkitFOweTlib+KFHaDdoURVtUP/TDbsD30IdUlqzCe/lFAvzf/hA
	ZDCGe2/xXhqUh7Af8UBahiV2iSZsZbXiFzhovpJlK/MEMG05aUjp2bL/XuiKcvfm
	zN0nrI198lI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2596E405A2;
	Tue, 17 Mar 2015 16:10:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CCFC4059E;
	Tue, 17 Mar 2015 16:10:33 -0400 (EDT)
In-Reply-To: <1426569419-8266-1-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 17 Mar 2015 10:46:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AAB9AC6E-CCE1-11E4-B92A-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265661>

Karthik Nayak <karthik.188@gmail.com> writes:

> Subject: Re: [PATCH v4 2/2] sha1_file: refactor sha1_file.c to support 'cat-file --literally'

> Modify sha1_loose_object_info() to support 'cat-file --literally'
> by accepting flags and also make changes to copy the type to
> object_info::typename.

It would be more descriptive to mention the central point on the
title regarding what it takes to "support cat-file --literally".

For example:

  sha1_file.c: support reading from a loose object of a bogus type

  Update sha1_loose_object_info() to optionally allow it to read
  from a loose object file of unknown/bogus type; as the function
  usually returns the type of the object it read in the form of enum
  for known types, add an optional "typename" field to receive the
  name of the type in textual form.

By the way, I think your 1/2 would not even compile unless you have
this change; the patches in these two patch series must be swapped,
no?

> diff --git a/sha1_file.c b/sha1_file.c
> index 69a60ec..e31e9e2 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1564,6 +1564,36 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
>  	return git_inflate(stream, 0);
>  }
>  
> +static int unpack_sha1_header_literally(git_zstream *stream, unsigned char *map,
> +					unsigned long mapsize,
> +					struct strbuf *header)
> +{
> +	unsigned char buffer[32], *cp;
> +	unsigned long bufsiz = sizeof(buffer);
> +	int status;
> +
> +	/* Get the data stream */
> +	memset(stream, 0, sizeof(*stream));
> +	stream->next_in = map;
> +	stream->avail_in = mapsize;
> +	stream->next_out = buffer;
> +	stream->avail_out = bufsiz;
> +
> +	git_inflate_init(stream);
> +
> +	do {
> +		status = git_inflate(stream, 0);
> +		strbuf_add(header, buffer, stream->next_out - buffer);
> +		for (cp = buffer; cp < stream->next_out; cp++)
> +			if (!*cp)
> +				/* Found the NUL at the end of the header */
> +				return 0;
> +		stream->next_out = buffer;
> +		stream->avail_out = bufsiz;
> +	} while (status == Z_OK);
> +	return -1;
> +}
> +

There is nothing "literal" about this function.

The only difference between the original and this one is that this
uses a strbuf, instead of a buffer of a fixed size allocated by the
caller, to return the early part of the inflated data.

I wonder if it incurs too much overhead to the existing callers if
you reimplementated unpack_sha1_header() as a thin wrapper around
this function, something like

	int unpack_sha1_header(git_zstream *stream,
				unsigned char *map, unsigned long mapsize,
                                void *buffer, unsigned long bufsiz)
	{
                int status;
		struct strbuf header = STRBUF_INIT;

                status = unpack_sha1_header_to_strbuf(stream, map, mapsize, &header);
		if (bufsiz < header.len)
                	die("object header too long");
		memcpy(buffer, header.buf, header.len);
                return status;
	}
    			  
Note that I am *not* suggesting to do this blindly.  If there is no
downside from performance point of view, however, the above would be
a way to avoid code duplication.

Another way to avoid code duplication may be to implement
unpack_sha1_header_to_strbuf() in terms of unpack_sha1_header(),
perhaps like this:

	static int unpack_sha1_header_to_strbuf(...)
        {
		unsigned char buffer[32], *cp;
                unsigned long bufsiz = sizeof(buffer);
        	int status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);

		if (status)
                	return status;
		do {
			strbuf_add(header, buffer, stream->next_out - buffer);
			for (cp = buffer; cp < stream->next_out; cp++)
				if (!*cp)
					/* Found the NUL at the end of the header */
					return 0;
			stream->next_out = buffer;
			stream->avail_out = bufsiz;
		} while (status == Z_OK);
		return -1;
	}

which may be more in line with how we read data from loose objects.

> +int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
> +			       int flags)

Unless we are taking advantage of the fact that MSB is special in
signed integral types, I would prefer to see us use an unsigned type
to store these bits in a variable of an integral type.  That would
let the readers assume that they have fewer tricky things possibly
going on in the code (also see the footnote to $gmane/263751).

> @@ -1652,12 +1674,45 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
>  			size = size * 10 + c;
>  		}
>  	}
> -	*sizep = size;
> +
> +	type = type_from_string_gently(typename.buf, -1, 1);

Doesn't the code know how long the typename is at this point?

> +	if (oi->sizep)
> +		*oi->sizep = size;
> +	if (oi->typename)
> +		strbuf_addstr(oi->typename, typename.buf);

Likewise.  Perhaps strbuf_addbuf()?

> +	if (oi->typep)
> +		*oi->typep = type;

Do you want to store -1 to *oi->typep when the caller asked to do
the "literally" thing?  Shouldn't it match what is returned from
this function?

> +	return *hdr ? -1 : type;
> +}
> +
> +/*
> + * We used to just use "sscanf()", but that's actually way
> + * too permissive for what we want to check. So do an anal
> + * object header parse by hand. Calls the extended function.
> + */

The comment "let's do better than sscanf() by parsing ourselves"
applies to the implementation of _extended() function, not this one,
no?  It is clear to everybody that it "Calls the extended function",
so why mention it?

> +int parse_sha1_header(const char *hdr, unsigned long *sizep)
> +{
> +	struct object_info oi;
> +
> +	oi.sizep = sizep;
> +	oi.typename = NULL;
> +	oi.typep = NULL;
> +	return parse_sha1_header_extended(hdr, &oi, LOOKUP_REPLACE_OBJECT);
>  }

> @@ -2524,13 +2579,15 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
>  }
>  
>  static int sha1_loose_object_info(const unsigned char *sha1,
> -				  struct object_info *oi)
> +				  struct object_info *oi,
> +				  int flags)
>  {
> -	int status;
> +	int status = 0;
>  	unsigned long mapsize, size;
>  	void *map;
>  	git_zstream stream;
>  	char hdr[32];
> +	struct strbuf hdrbuf = STRBUF_INIT;
>  
>  	if (oi->delta_base_sha1)
>  		hashclr(oi->delta_base_sha1);
> @@ -2557,17 +2614,29 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>  		return -1;
>  	if (oi->disk_sizep)
>  		*oi->disk_sizep = mapsize;
> -	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
> -		status = error("unable to unpack %s header",
> -			       sha1_to_hex(sha1));
> -	else if ((status = parse_sha1_header(hdr, &size)) < 0)
> -		status = error("unable to parse %s header", sha1_to_hex(sha1));
> -	else if (oi->sizep)
> +	if ((flags & LOOKUP_LITERALLY)) {
> +		if (unpack_sha1_header_literally(&stream, map, mapsize, &hdrbuf) < 0)
> +			status = error("unable to unpack %s header with --literally",
> +				       sha1_to_hex(sha1));
> +		else if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
> +			status = error("unable to parse %s header", sha1_to_hex(sha1));
> +	} else {
> +		if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
> +			status = error("unable to unpack %s header",
> +				       sha1_to_hex(sha1));
> +		else if ((status = parse_sha1_header(hdr, &size)) < 0)
> +			status = error("unable to parse %s header", sha1_to_hex(sha1));
> +	}
> +	if (oi->sizep)
>  		*oi->sizep = size;

Have you considered calling parse_sha1_header_extended() for both
literally and normal cases?  Then you wouldn't have to do any of the
"if (oi->blah) *oi->blah = value", no?

>  	git_inflate_end(&stream);
>  	munmap(map, mapsize);
>  	if (oi->typep)
>  		*oi->typep = status;

Likewise.

> +	if (oi->typename && !(oi->typename->len))
> +		strbuf_addstr(oi->typename, typename(status));

Likewise.
