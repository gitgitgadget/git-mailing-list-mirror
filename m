Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E05203E3
	for <e@80x24.org>; Fri, 22 Jul 2016 22:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbcGVWTi (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 18:19:38 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:50122 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbcGVWTi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 18:19:38 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bQin3-0003tQ-5H; Sat, 23 Jul 2016 07:19:29 +0900
Date:	Sat, 23 Jul 2016 07:19:29 +0900
From:	Mike Hommey <mh@glandium.org>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, spearce@spearce.org, jrnieder@gmail.com
Subject: Re: [PATCH/RFC] fast-import: Keep a fake pack window on the recently
 written data
Message-ID: <20160722221929.uusi4lowxow3ddmh@glandium.org>
References: <20160703234439.8889-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160703234439.8889-1-mh@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.1-neo (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

Any thoughts on the following?

Mike

On Mon, Jul 04, 2016 at 08:44:39AM +0900, Mike Hommey wrote:
> The are many ways in which fast-import ends up calling gfi_unpack_entry,
> and fery few work-arounds. I've patched fast-import for it to be smarter
> in corner cases, allowing some additional work-arounds, but it's just
> too easy to fall on gfi_unpack_entry again, so I abandonned that path.
> 
> The problem with gfi_unpack_entry is that if something has been written
> to the pack after last time it was used, it closes all pack windows. On
> OSX, this triggers munmap, which shows up in performance profiles.
> 
> To give an idea how bad this is, here is how long it takes to clone
> https://hg.mozilla.org/mozilla-unified/ with the master branch of
> git-cinnabar (which uses fast-import) on a mac mini: more than 5 hours.
> I can't actually give the exact number, because it was killed, after
> spending 2 hours importing 1.77M files and 3 hours importing 120k
> manifests.
> 
> The same clone, with a variant of this patch, *finished* in 2 hours and
> 10 minutes, spending 24 minutes importing the same 1.77M files and only
> 13 minutes to cover the same 120k manifests. It took an hour and 20
> minutes to cover the remaining 210k manifests. You can imagine how long
> it would have taken without the patch if it hadn't been killed...
> 
> Now, this is proof of concept level. There are many things that are not
> right with this patch, starting from the fact it doesn't handle
> checkpoints, and isn't safe for every kind of integer overflows. Or
> malloc'ating exactly packed_git_window_size bytes (which on 64-bits
> systems, is 1GB), etc.
> 
> But it feels to me this kind of fake pack window is a cheap way to
> counter the slowness of munmap on OSX, although the fact that it's a
> hack around the pack code in sha1_file.c is not very nice. Maybe a
> better start to fix the issue would be to add better interfaces to
> the pack code to handle pack writers that can read at the same time.
> 
> Thoughts?
> 
> Past related discussions:
>   $gmane/291717
>   $gmane/273465
> ---
>  fast-import.c | 90 +++++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 27 deletions(-)
> 
> diff --git a/fast-import.c b/fast-import.c
> index c504ef7..4e26883 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -316,6 +316,7 @@ static struct atom_str **atom_table;
>  static struct pack_idx_option pack_idx_opts;
>  static unsigned int pack_id;
>  static struct sha1file *pack_file;
> +static struct pack_window *pack_win;
>  static struct packed_git *pack_data;
>  static struct packed_git **all_packs;
>  static off_t pack_size;
> @@ -862,6 +863,39 @@ static struct tree_content *dup_tree_content(struct tree_content *s)
>  	return d;
>  }
>  
> +static void _sha1write(struct sha1file *f, const void *buf, unsigned int count)
> +{
> +	sha1write(f, buf, count);
> +	/* Always last used */
> +	pack_win->last_used = -1;
> +	pack_win->inuse_cnt = -1;
> +
> +	pack_data->pack_size += count;
> +
> +	if (packed_git_window_size - pack_win->len >= count) {
> +		memcpy(pack_win->base + pack_win->len - 20, buf, count);
> +		pack_win->len += count;
> +	} else {
> +		struct pack_window *cursor = NULL;
> +		/* We're sliding the window, so we don't need to memcpy
> +		 * everything. */
> +		pack_win->offset += ((pack_win->len - 20 + count)
> +			 / packed_git_window_size) * packed_git_window_size;
> +		pack_win->len = count % packed_git_window_size -
> +			(packed_git_window_size - pack_win->len);
> +		memcpy(pack_win->base, buf + count - pack_win->len + 20,
> +		       pack_win->len - 20);
> +
> +		/* Ensure a pack window on the data before that, otherwise,
> +		 * use_pack() may try to create a window that overlaps with
> +		 * this one, and that won't work because it won't be complete. */
> +		sha1flush(f);
> +		use_pack(pack_data, &cursor,
> +			 pack_win->offset - packed_git_window_size, NULL);
> +		unuse_pack(&cursor);
> +	}
> +}
> +
>  static void start_packfile(void)
>  {
>  	static char tmp_file[PATH_MAX];
> @@ -873,15 +907,22 @@ static void start_packfile(void)
>  			      "pack/tmp_pack_XXXXXX");
>  	FLEX_ALLOC_STR(p, pack_name, tmp_file);
>  	p->pack_fd = pack_fd;
> +	p->pack_size = 20;
>  	p->do_not_close = 1;
>  	pack_file = sha1fd(pack_fd, p->pack_name);
>  
> +	p->windows = pack_win = xcalloc(1, sizeof(*p->windows));
> +	pack_win->offset = 0;
> +	pack_win->len = 20;
> +	pack_win->base = xmalloc(packed_git_window_size);
> +	pack_win->next = NULL;
> +
>  	hdr.hdr_signature = htonl(PACK_SIGNATURE);
>  	hdr.hdr_version = htonl(2);
>  	hdr.hdr_entries = 0;
> -	sha1write(pack_file, &hdr, sizeof(hdr));
> -
>  	pack_data = p;
> +	_sha1write(pack_file, &hdr, sizeof(hdr));
> +
>  	pack_size = sizeof(hdr);
>  	object_count = 0;
>  
> @@ -954,10 +995,25 @@ static void unkeep_all_packs(void)
>  static void end_packfile(void)
>  {
>  	static int running;
> +	struct pack_window *win, *prev;
>  
>  	if (running || !pack_data)
>  		return;
>  
> +	/* Remove the fake pack window first */
> +	for (prev = NULL, win = pack_data->windows; win;
> +	     prev = win, win = win->next) {
> +		if (win != pack_win)
> +			continue;
> +		if (prev)
> +			prev->next = win->next;
> +		else
> +			pack_data->windows = win->next;
> +		break;
> +	}
> +	free(pack_win->base);
> +	free(pack_win);
> +
>  	running = 1;
>  	clear_delta_base_cache();
>  	if (object_count) {
> @@ -1122,22 +1178,22 @@ static int store_object(
>  		e->depth = last->depth + 1;
>  
>  		hdrlen = encode_in_pack_object_header(OBJ_OFS_DELTA, deltalen, hdr);
> -		sha1write(pack_file, hdr, hdrlen);
> +		_sha1write(pack_file, hdr, hdrlen);
>  		pack_size += hdrlen;
>  
>  		hdr[pos] = ofs & 127;
>  		while (ofs >>= 7)
>  			hdr[--pos] = 128 | (--ofs & 127);
> -		sha1write(pack_file, hdr + pos, sizeof(hdr) - pos);
> +		_sha1write(pack_file, hdr + pos, sizeof(hdr) - pos);
>  		pack_size += sizeof(hdr) - pos;
>  	} else {
>  		e->depth = 0;
>  		hdrlen = encode_in_pack_object_header(type, dat->len, hdr);
> -		sha1write(pack_file, hdr, hdrlen);
> +		_sha1write(pack_file, hdr, hdrlen);
>  		pack_size += hdrlen;
>  	}
>  
> -	sha1write(pack_file, out, s.total_out);
> +	_sha1write(pack_file, out, s.total_out);
>  	pack_size += s.total_out;
>  
>  	e->idx.crc32 = crc32_end(pack_file);
> @@ -1220,7 +1276,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
>  
>  		if (!s.avail_out || status == Z_STREAM_END) {
>  			size_t n = s.next_out - out_buf;
> -			sha1write(pack_file, out_buf, n);
> +			_sha1write(pack_file, out_buf, n);
>  			pack_size += n;
>  			s.next_out = out_buf;
>  			s.avail_out = out_sz;
> @@ -1295,26 +1351,6 @@ static void *gfi_unpack_entry(
>  {
>  	enum object_type type;
>  	struct packed_git *p = all_packs[oe->pack_id];
> -	if (p == pack_data && p->pack_size < (pack_size + 20)) {
> -		/* The object is stored in the packfile we are writing to
> -		 * and we have modified it since the last time we scanned
> -		 * back to read a previously written object.  If an old
> -		 * window covered [p->pack_size, p->pack_size + 20) its
> -		 * data is stale and is not valid.  Closing all windows
> -		 * and updating the packfile length ensures we can read
> -		 * the newly written data.
> -		 */
> -		close_pack_windows(p);
> -		sha1flush(pack_file);
> -
> -		/* We have to offer 20 bytes additional on the end of
> -		 * the packfile as the core unpacker code assumes the
> -		 * footer is present at the file end and must promise
> -		 * at least 20 bytes within any window it maps.  But
> -		 * we don't actually create the footer here.
> -		 */
> -		p->pack_size = pack_size + 20;
> -	}
>  	return unpack_entry(p, oe->idx.offset, &type, sizep);
>  }
>  
> -- 
> 2.9.0.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
