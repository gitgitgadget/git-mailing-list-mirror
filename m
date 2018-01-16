Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E824D1F404
	for <e@80x24.org>; Tue, 16 Jan 2018 17:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbeAPRZ7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 12:25:59 -0500
Received: from ikke.info ([178.21.113.177]:57016 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeAPRZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 12:25:58 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id CA20D4402C2; Tue, 16 Jan 2018 18:25:56 +0100 (CET)
Date:   Tue, 16 Jan 2018 18:25:56 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] sha1_file: remove static strbuf from sha1_file_name()
Message-ID: <20180116172556.GA5618@alpha.vpn.ikke.info>
References: <20180116071814.19884-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116071814.19884-1-chriscool@tuxfamily.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 08:18:14AM +0100, Christian Couder wrote:
> Using a static buffer in sha1_file_name() is error prone
> and the performance improvements it gives are not needed
> in most of the callers.
> 
> So let's get rid of this static buffer and, if necessary
> or helpful, let's use one in the caller.

Missing sign-off

> ---
>  cache.h       |  8 +++-----
>  http-walker.c |  6 ++++--
>  http.c        | 16 ++++++++++------
>  sha1_file.c   | 38 +++++++++++++++++++++++++-------------
>  4 files changed, 42 insertions(+), 26 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index d8b975a571..6db565408e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -957,12 +957,10 @@ extern void check_repository_format(void);
>  #define TYPE_CHANGED    0x0040
>  
>  /*
> - * Return the name of the file in the local object database that would
> - * be used to store a loose object with the specified sha1.  The
> - * return value is a pointer to a statically allocated buffer that is
> - * overwritten each time the function is called.
> + * Put in `buf` the name of the file in the local object database that
> + * would be used to store a loose object with the specified sha1.
>   */
> -extern const char *sha1_file_name(const unsigned char *sha1);
> +extern void sha1_file_name(struct strbuf *buf, const unsigned char *sha1);
>  
>  /*
>   * Return an abbreviated sha1 unique within this repository's object database.
> diff --git a/http-walker.c b/http-walker.c
> index 1ae8363de2..07c2b1af82 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -544,8 +544,10 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
>  	} else if (hashcmp(obj_req->sha1, req->real_sha1)) {
>  		ret = error("File %s has bad hash", hex);
>  	} else if (req->rename < 0) {
> -		ret = error("unable to write sha1 filename %s",
> -			    sha1_file_name(req->sha1));
> +		struct strbuf buf = STRBUF_INIT;
> +		sha1_file_name(&buf, req->sha1);
> +		ret = error("unable to write sha1 filename %s", buf.buf);
> +		strbuf_release(&buf);
>  	}
>  
>  	release_http_object_request(req);
> diff --git a/http.c b/http.c
> index 5977712712..5979305bc9 100644
> --- a/http.c
> +++ b/http.c
> @@ -2168,7 +2168,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
>  	unsigned char *sha1)
>  {
>  	char *hex = sha1_to_hex(sha1);
> -	const char *filename;
> +	struct strbuf filename = STRBUF_INIT;
>  	char prevfile[PATH_MAX];
>  	int prevlocal;
>  	char prev_buf[PREV_BUF_SIZE];
> @@ -2180,14 +2180,15 @@ struct http_object_request *new_http_object_request(const char *base_url,
>  	hashcpy(freq->sha1, sha1);
>  	freq->localfile = -1;
>  
> -	filename = sha1_file_name(sha1);
> +	sha1_file_name(&filename, sha1);
>  	snprintf(freq->tmpfile, sizeof(freq->tmpfile),
> -		 "%s.temp", filename);
> +		 "%s.temp", filename.buf);
>  
> -	snprintf(prevfile, sizeof(prevfile), "%s.prev", filename);
> +	snprintf(prevfile, sizeof(prevfile), "%s.prev", filename.buf);
>  	unlink_or_warn(prevfile);
>  	rename(freq->tmpfile, prevfile);
>  	unlink_or_warn(freq->tmpfile);
> +	strbuf_release(&filename);
>  
>  	if (freq->localfile != -1)
>  		error("fd leakage in start: %d", freq->localfile);
> @@ -2302,6 +2303,7 @@ void process_http_object_request(struct http_object_request *freq)
>  int finish_http_object_request(struct http_object_request *freq)
>  {
>  	struct stat st;
> +	struct strbuf filename = STRBUF_INIT;
>  
>  	close(freq->localfile);
>  	freq->localfile = -1;
> @@ -2327,8 +2329,10 @@ int finish_http_object_request(struct http_object_request *freq)
>  		unlink_or_warn(freq->tmpfile);
>  		return -1;
>  	}
> -	freq->rename =
> -		finalize_object_file(freq->tmpfile, sha1_file_name(freq->sha1));
> +
> +	sha1_file_name(&filename, freq->sha1);
> +	freq->rename = finalize_object_file(freq->tmpfile, filename.buf);
> +	strbuf_release(&filename);
>  
>  	return freq->rename;
>  }
> diff --git a/sha1_file.c b/sha1_file.c
> index 3da70ac650..f66c21b2da 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -321,15 +321,11 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
>  	}
>  }
>  
> -const char *sha1_file_name(const unsigned char *sha1)
> +void sha1_file_name(struct strbuf *buf, const unsigned char *sha1)
>  {
> -	static struct strbuf buf = STRBUF_INIT;
> -
> -	strbuf_reset(&buf);
> -	strbuf_addf(&buf, "%s/", get_object_directory());
> +	strbuf_addf(buf, "%s/", get_object_directory());
>  
> -	fill_sha1_path(&buf, sha1);
> -	return buf.buf;
> +	fill_sha1_path(buf, sha1);
>  }
>  
>  struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
> @@ -710,7 +706,12 @@ int check_and_freshen_file(const char *fn, int freshen)
>  
>  static int check_and_freshen_local(const unsigned char *sha1, int freshen)
>  {
> -	return check_and_freshen_file(sha1_file_name(sha1), freshen);
> +	static struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_reset(&buf);
> +	sha1_file_name(&buf, sha1);
> +
> +	return check_and_freshen_file(buf.buf, freshen);
>  }
>  
>  static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
> @@ -866,8 +867,12 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
>  			  const char **path)
>  {
>  	struct alternate_object_database *alt;
> +	static struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_reset(&buf);
> +	sha1_file_name(&buf, sha1);
> +	*path = buf.buf;
>  
> -	*path = sha1_file_name(sha1);
>  	if (!lstat(*path, st))
>  		return 0;
>  
> @@ -891,8 +896,12 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
>  	int fd;
>  	struct alternate_object_database *alt;
>  	int most_interesting_errno;
> +	static struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_reset(&buf);
> +	sha1_file_name(&buf, sha1);
> +	*path = buf.buf;
>  
> -	*path = sha1_file_name(sha1);
>  	fd = git_open(*path);
>  	if (fd >= 0)
>  		return fd;
> @@ -1557,9 +1566,12 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
>  	git_SHA_CTX c;
>  	unsigned char parano_sha1[20];
>  	static struct strbuf tmp_file = STRBUF_INIT;
> -	const char *filename = sha1_file_name(sha1);
> +	static struct strbuf filename = STRBUF_INIT;
> +
> +	strbuf_reset(&filename);
> +	sha1_file_name(&filename, sha1);
>  
> -	fd = create_tmpfile(&tmp_file, filename);
> +	fd = create_tmpfile(&tmp_file, filename.buf);
>  	if (fd < 0) {
>  		if (errno == EACCES)
>  			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
> @@ -1612,7 +1624,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
>  			warning_errno("failed utime() on %s", tmp_file.buf);
>  	}
>  
> -	return finalize_object_file(tmp_file.buf, filename);
> +	return finalize_object_file(tmp_file.buf, filename.buf);
>  }
>  
>  static int freshen_loose_object(const unsigned char *sha1)
> -- 
> 2.16.0.rc2.2.g7757b9aa6e.dirty
> 
