From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 08/67] add reentrant variants of sha1_to_hex and
 find_unique_abbrev
Date: Tue, 15 Sep 2015 17:55:55 +0100
Message-ID: <55F84D9B.90004@ramsayjones.plus.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152629.GH29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:56:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbtWe-0001OV-7T
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbbIOQ4D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:56:03 -0400
Received: from avasout08.plus.net ([212.159.14.20]:35250 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbIOQ4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:56:00 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout08 with smtp
	id HUvw1r0062FXpih01UvxWb; Tue, 15 Sep 2015 17:55:58 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=68u01Zwx31FXMBOPKh8A:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150915152629.GH29753@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277973>



On 15/09/15 16:26, Jeff King wrote:
> The sha1_to_hex and find_unique_abbrev functions always
> write into reusable static buffers. There are a few problems
> with this:
>
>   - future calls overwrite our result. This is especially
>     annoying with find_unique_abbrev, which does not have a
>     ring of buffers, so you cannot even printf() a result
>     that has two abbreviated sha1s.
>
>   - if you want to put the result into another buffer, we
>     often strcpy, which looks suspicious when auditing for
>     overflows.
>
> This patch introduces sha1_to_hex_to and find_unique_abbrev_to,
> which write into a user-provided buffer. Of course this is
> just punting on the overflow-auditing, as the buffer
> obviously needs to be GIT_SHA1_HEXSZ + 1 bytes. But it is
> much easier to audit, since that is a well-known size.

Hmm, I haven't read any other patches yet (including those which use these
new '_to' functions), but I can't help feeling they should be named something
like 'sha1_to_hex_str()' and 'find_unique_abbrev_str()' instead.  i.e. I don't get
the '_to' thing - not that I'm any good at naming things ...

ATB,
Ramsay Jones

>
> We retain the non-reentrant forms, which just become thin
> wrappers around the reentrant ones. This patch also adds a
> strbuf variant of find_unique_abbrev, which will be handy in
> later patches.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> If we wanted to be really meticulous, these functions could
> take a size for the output buffer, and complain if it is not
> GIT_SHA1_HEXSZ+1 bytes. But that would bloat every call
> like:
>
>   sha1_to_hex_to(buf, sizeof(buf), sha1);
>
>  cache.h     | 27 ++++++++++++++++++++++++++-
>  hex.c       | 13 +++++++++----
>  sha1_name.c | 16 +++++++++++-----
>  strbuf.c    |  9 +++++++++
>  strbuf.h    |  8 ++++++++
>  5 files changed, 63 insertions(+), 10 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index e231e47..cc59aba 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -785,7 +785,21 @@ extern char *sha1_pack_name(const unsigned char *sha1);
>   */
>  extern char *sha1_pack_index_name(const unsigned char *sha1);
>  
> -extern const char *find_unique_abbrev(const unsigned char *sha1, int);
> +/*
> + * Return an abbreviated sha1 unique within this repository's object database.
> + * The result will be at least `len` characters long, and will be NUL
> + * terminated.
> + *
> + * The non-`_to` version returns a static buffer which will be overwritten by
> + * subsequent calls.
> + *
> + * The `_to` variant writes to a buffer supplied by the caller, which must be
> + * at least `GIT_SHA1_HEXSZ + 1` bytes. The return value is the number of bytes
> + * written (excluding the NUL terminator).
> + */
> +extern const char *find_unique_abbrev(const unsigned char *sha1, int len);
> +extern int find_unique_abbrev_to(char *hex, const unsigned char *sha1, int len);
> +
>  extern const unsigned char null_sha1[GIT_SHA1_RAWSZ];
>  
>  static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> @@ -1067,6 +1081,17 @@ extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
>  extern int get_sha1_hex(const char *hex, unsigned char *sha1);
>  extern int get_oid_hex(const char *hex, struct object_id *sha1);
>  
> +/*
> + * Convert a binary sha1 to its hex equivalent. The `_to` variant writes
> + * the NUL-terminated output to the buffer `out`, which must be at least
> + * `GIT_SHA1_HEXSZ + 1` bytes, and returns a pointer to out for convenience.
> + *
> + * The non-`_to` variant returns a static buffer, but uses a ring of 4
> + * buffers, making it safe to make multiple calls for a single statement, like:
> + *
> + *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
> + */
> +extern char *sha1_to_hex_to(char *out, const unsigned char *sha1);
>  extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
>  extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
>  
> diff --git a/hex.c b/hex.c
> index 899b74a..004fdea 100644
> --- a/hex.c
> +++ b/hex.c
> @@ -61,12 +61,10 @@ int get_oid_hex(const char *hex, struct object_id *oid)
>  	return get_sha1_hex(hex, oid->hash);
>  }
>  
> -char *sha1_to_hex(const unsigned char *sha1)
> +char *sha1_to_hex_to(char *buffer, const unsigned char *sha1)
>  {
> -	static int bufno;
> -	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
>  	static const char hex[] = "0123456789abcdef";
> -	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
> +	char *buf = buffer;
>  	int i;
>  
>  	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
> @@ -79,6 +77,13 @@ char *sha1_to_hex(const unsigned char *sha1)
>  	return buffer;
>  }
>  
> +char *sha1_to_hex(const unsigned char *sha1)
> +{
> +	static int bufno;
> +	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
> +	return sha1_to_hex_to(hexbuffer[3 & ++bufno], sha1);
> +}
> +
>  char *oid_to_hex(const struct object_id *oid)
>  {
>  	return sha1_to_hex(oid->hash);
> diff --git a/sha1_name.c b/sha1_name.c
> index da6874c..416e408 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -368,14 +368,13 @@ int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
>  	return ds.ambiguous;
>  }
>  
> -const char *find_unique_abbrev(const unsigned char *sha1, int len)
> +int find_unique_abbrev_to(char *hex, const unsigned char *sha1, int len)
>  {
>  	int status, exists;
> -	static char hex[41];
>  
> -	memcpy(hex, sha1_to_hex(sha1), 40);
> +	sha1_to_hex_to(hex, sha1);
>  	if (len == 40 || !len)
> -		return hex;
> +		return 40;
>  	exists = has_sha1_file(sha1);
>  	while (len < 40) {
>  		unsigned char sha1_ret[20];
> @@ -384,10 +383,17 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
>  		    ? !status
>  		    : status == SHORT_NAME_NOT_FOUND) {
>  			hex[len] = 0;
> -			return hex;
> +			return len;
>  		}
>  		len++;
>  	}
> +	return len;
> +}
> +
> +const char *find_unique_abbrev(const unsigned char *sha1, int len)
> +{
> +	static char hex[GIT_SHA1_HEXSZ + 1];
> +	find_unique_abbrev_to(hex, sha1, len);
>  	return hex;
>  }
>  
> diff --git a/strbuf.c b/strbuf.c
> index 29df55b..6c1b577 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -743,3 +743,12 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
>  	}
>  	strbuf_setlen(sb, sb->len + len);
>  }
> +
> +void strbuf_add_unique_abbrev(struct strbuf *sb, const unsigned char *sha1,
> +			      int abbrev_len)
> +{
> +	int r;
> +	strbuf_grow(sb, GIT_SHA1_HEXSZ + 1);
> +	r = find_unique_abbrev_to(sb->buf + sb->len, sha1, abbrev_len);
> +	strbuf_setlen(sb, sb->len + r);
> +}
> diff --git a/strbuf.h b/strbuf.h
> index ba099cd..9aace36 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -475,6 +475,14 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
>  extern void strbuf_list_free(struct strbuf **);
>  
>  /**
> + * Add the abbreviation, as generated by find_unique_abbrev, of `sha1` to
> + * the strbuf `sb`.
> + */
> +extern void strbuf_add_unique_abbrev(struct strbuf *sb,
> +				     const unsigned char *sha1,
> +				     int abbrev_len);
> +
> +/**
>   * Launch the user preferred editor to edit a file and fill the buffer
>   * with the file's contents upon the user completing their editing. The
>   * third argument can be used to set the environment which the editor is
