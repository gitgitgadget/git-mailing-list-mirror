From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/67] use xsnprintf for generating git object headers
Date: Wed, 16 Sep 2015 11:30:30 -0700
Message-ID: <xmqqd1xiqks9.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915153816.GQ29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:30:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcHTZ-00062Z-Tv
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 20:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbbIPSad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 14:30:33 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33348 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbbIPSac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 14:30:32 -0400
Received: by pacex6 with SMTP id ex6so216510758pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ochbeeMiosMBoIp6ns3+8Lty1n/WRG0wsGakT3B6OYk=;
        b=kbcYQj7LtMJqwlHkCRxXyueo33hizvCT2BqMvy6HM/pJMUZYUwubsAC+biLgxg813A
         1vxpJOmbNh5PokdT9x7f5sU2XFJpxhlYshxMNxOz1LaDRtaEumAzEc0va0kSmdp8aWFD
         s2AkE7gzYv3P2fx+4TqqnXKngagx8QkrJHhQNnnc/rGLqYRhEeQOq9oIqDqYOHv00akM
         4sDPPnl3oZmOCFuVVsFMYIwTildKsd+U+e+rQDTa1TNNKCNb9PwKRdiyW5z6upg7uaOd
         UM/3eICTBtV2C+XT4nYmCY00uytBeQ7XgB5y957ETuHL3EuvAgeIx9kFJQT/UNXKzAcl
         0IaA==
X-Received: by 10.69.27.74 with SMTP id je10mr19925014pbd.169.1442428231752;
        Wed, 16 Sep 2015 11:30:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id tz1sm29123240pbc.50.2015.09.16.11.30.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 11:30:31 -0700 (PDT)
In-Reply-To: <20150915153816.GQ29753@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 11:38:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278046>

Jeff King <peff@peff.net> writes:

> We generally use 32-byte buffers to format git's "type size"
> header fields. These should not generally overflow unless
> you can produce some truly gigantic objects (and our types
> come from our internal array of constant strings). But it is
> a good idea to use xsnprintf to make sure this is the case.
>
> Note that we slightly modify the interface to
> write_sha1_file_prepare, which nows uses "hdrlen" as an "in"
> parameter as well as an "out" (on the way in it stores the
> allocated size of the header, and on the way out it returns
> the ultimate size of the header).

;-).  I skipped this paragraph and jumped directly into the code,
noticed that you did something funny in write-sha1-file-prepare and
did the right thing in hash-sha1-file to compensate for it, and then
came back here to find it properly described.  Now I read the patch
again and I see the other caller is also properly adjusted.

I think this change makes sense.  Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/index-pack.c |  2 +-
>  bulk-checkin.c       |  4 ++--
>  fast-import.c        |  4 ++--
>  http-push.c          |  2 +-
>  sha1_file.c          | 13 +++++++------
>  5 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 3431de2..1ad1bde 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -441,7 +441,7 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size,
>  	int hdrlen;
>  
>  	if (!is_delta_type(type)) {
> -		hdrlen = sprintf(hdr, "%s %lu", typename(type), size) + 1;
> +		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), size) + 1;
>  		git_SHA1_Init(&c);
>  		git_SHA1_Update(&c, hdr, hdrlen);
>  	} else
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 7cffc3a..4347f5c 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -200,8 +200,8 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
>  	if (seekback == (off_t) -1)
>  		return error("cannot find the current offset");
>  
> -	header_len = sprintf((char *)obuf, "%s %" PRIuMAX,
> -			     typename(type), (uintmax_t)size) + 1;
> +	header_len = xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
> +			       typename(type), (uintmax_t)size) + 1;
>  	git_SHA1_Init(&ctx);
>  	git_SHA1_Update(&ctx, obuf, header_len);
>  
> diff --git a/fast-import.c b/fast-import.c
> index 6c7c3c9..d0c2502 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1035,8 +1035,8 @@ static int store_object(
>  	git_SHA_CTX c;
>  	git_zstream s;
>  
> -	hdrlen = sprintf((char *)hdr,"%s %lu", typename(type),
> -		(unsigned long)dat->len) + 1;
> +	hdrlen = xsnprintf((char *)hdr, sizeof(hdr), "%s %lu",
> +			   typename(type), (unsigned long)dat->len) + 1;
>  	git_SHA1_Init(&c);
>  	git_SHA1_Update(&c, hdr, hdrlen);
>  	git_SHA1_Update(&c, dat->buf, dat->len);
> diff --git a/http-push.c b/http-push.c
> index 154e67b..1f3788f 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -361,7 +361,7 @@ static void start_put(struct transfer_request *request)
>  	git_zstream stream;
>  
>  	unpacked = read_sha1_file(request->obj->sha1, &type, &len);
> -	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
> +	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
>  
>  	/* Set it up */
>  	git_deflate_init(&stream, zlib_compression_level);
> diff --git a/sha1_file.c b/sha1_file.c
> index d295a32..f106091 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1464,7 +1464,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
>  		return -1;
>  
>  	/* Generate the header */
> -	hdrlen = sprintf(hdr, "%s %lu", typename(obj_type), size) + 1;
> +	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(obj_type), size) + 1;
>  
>  	/* Sha1.. */
>  	git_SHA1_Init(&c);
> @@ -2930,7 +2930,7 @@ static void write_sha1_file_prepare(const void *buf, unsigned long len,
>  	git_SHA_CTX c;
>  
>  	/* Generate the header */
> -	*hdrlen = sprintf(hdr, "%s %lu", type, len)+1;
> +	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %lu", type, len)+1;
>  
>  	/* Sha1.. */
>  	git_SHA1_Init(&c);
> @@ -2993,7 +2993,7 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
>                     unsigned char *sha1)
>  {
>  	char hdr[32];
> -	int hdrlen;
> +	int hdrlen = sizeof(hdr);
>  	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
>  	return 0;
>  }
> @@ -3139,7 +3139,7 @@ static int freshen_packed_object(const unsigned char *sha1)
>  int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1)
>  {
>  	char hdr[32];
> -	int hdrlen;
> +	int hdrlen = sizeof(hdr);
>  
>  	/* Normally if we have it in the pack then we do not bother writing
>  	 * it out into .git/objects/??/?{38} file.
> @@ -3157,7 +3157,8 @@ int hash_sha1_file_literally(const void *buf, unsigned long len, const char *typ
>  	int hdrlen, status = 0;
>  
>  	/* type string, SP, %lu of the length plus NUL must fit this */
> -	header = xmalloc(strlen(type) + 32);
> +	hdrlen = strlen(type) + 32;
> +	header = xmalloc(hdrlen);
>  	write_sha1_file_prepare(buf, len, type, sha1, header, &hdrlen);
>  
>  	if (!(flags & HASH_WRITE_OBJECT))
> @@ -3185,7 +3186,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
>  	buf = read_packed_sha1(sha1, &type, &len);
>  	if (!buf)
>  		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
> -	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
> +	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
>  	ret = write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
>  	free(buf);
