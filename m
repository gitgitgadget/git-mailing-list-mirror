Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1834D207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 13:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941479AbcIZNu7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 09:50:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:48082 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941470AbcIZNu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 09:50:58 -0400
Received: (qmail 25114 invoked by uid 109); 26 Sep 2016 13:50:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 13:50:57 +0000
Received: (qmail 4956 invoked by uid 111); 26 Sep 2016 13:51:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 09:51:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 09:50:55 -0400
Date:   Mon, 26 Sep 2016 09:50:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Gustavo Grieco <gustavo.grieco@imag.fr>, git@vger.kernel.org
Subject: Re: Stack read out-of-bounds in parse_sha1_header_extended using git
 2.10.0
Message-ID: <20160926135055.zeagw6mj3udzhv7s@sigill.intra.peff.net>
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
 <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 25, 2016 at 05:10:31PM -0700, Junio C Hamano wrote:

> Gustavo Grieco <gustavo.grieco@imag.fr> writes:
> 
> > We found a stack read out-of-bounds parsing object files using git 2.10.0. It was tested on ArchLinux x86_64. To reproduce, first recompile git with ASAN support and then execute:
> >
> > $ git init ; mkdir -p .git/objects/b2 ; printf 'x' > .git/objects/b2/93584ddd61af21260be75ee9f73e9d53f08cd0
> 
> Interesting.  If you prepare such a broken loose object file in your
> local repository, I would expect that either unpack_sha1_header() or
> unpack_sha1_header_to_strbuf() that sha1_loose_object_info() calls
> would detect and barf by noticing that an error came from libz while
> it attempts to inflate and would not even call parse_sha1_header.
> 
> But it is nevertheless bad to assume that whatever happens to
> inflate without an error must be formatted correctly to allow
> parsing (i.e. has ' ' and then NUL termination within the first 32
> bytes after inflation), which is exactly what the hdr[32] is saying.

Yeah. I also was surprised that we didn't barf on a zlib failure. But
based on previous debugging of corrupted zlib data, my recollection
is that there are a large number of weird corruptions that zlib will
happily pass back and only later complain about a checksum error. So
presumably "x" is one of those, and it might not hold for other
corruptions (but I didn't try).

> Note that this is totally unteseted and not thought through; I
> briefly thought about what unpack_sha1_header_to_strbuf() does with
> this change (it first lets unpack_sha1_header() to attempt with a
> small buffer but it seems to discard the error code from it before
> seeing if the returned buffer has NUL in it); there may be bad
> interactions with it.

Yeah, that seems wrong. I don't think it would involve an out of bounds
read, but we probably could fail to correctly report zlib corruption.

> diff --git a/sha1_file.c b/sha1_file.c
> index 60ff21f..dfcbd76 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1648,6 +1648,8 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
>  
>  int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
>  {
> +	int status;
> +
>  	/* Get the data stream */
>  	memset(stream, 0, sizeof(*stream));
>  	stream->next_in = map;
> @@ -1656,7 +1658,15 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
>  	stream->avail_out = bufsiz;
>  
>  	git_inflate_init(stream);
> -	return git_inflate(stream, 0);
> +	status = git_inflate(stream, 0);
> +	if (status)
> +		return status;
> +
> +	/* Make sure we got the terminating NUL for the object header */
> +	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
> +		return -1;
> +
> +	return 0;

This doesn't look too invasive as an approach, though I would have done
it differently. We're making the assumption that once there is a NUL,
the header-parser won't do anything stupid, which creates a coupling
between those two bits of code. My inclination would have been to just
treat the header as a ptr/len pair, and make sure the parser never reads
past the end.

But I implemented that, and it _is_ rather invasive. And it's not like
coupling unpack_sha1_header() and parse_sha1_header() is all that
terrible; they are meant to be paired.

I haven't read through your follow-up yet; I'll do that before posting
my version.

>  static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
> @@ -1758,6 +1768,8 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
>  		char c = *hdr++;
>  		if (c == ' ')
>  			break;
> +		if (!c)
> +			die("invalid object header");
>  		type_len++;
>  	}

We keep reading from hdr after this, though I think those bits would all
bail correctly on seeing NUL.

-Peff
