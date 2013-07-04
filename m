From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Thu, 04 Jul 2013 19:18:43 +0100
Message-ID: <51D5BC83.20706@ramsay1.demon.co.uk>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de> <51C8BF2C.2050203@ramsay1.demon.co.uk> <7vy59y4w3r.fsf@alter.siamese.dyndns.org> <51C94425.7050006@alum.mit.edu> <51CB610C.7050501@ramsay1.demon.co.uk> <20130626223552.GA12785@sigill.intra.peff.net> <51CBD2FD.5070905@alum.mit.edu> <51CCC643.1050702@ramsay1.demon.co.uk> <51D06AC8.70206@ramsay1.demon.co.uk> <7v4ncfjs32.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 20:29:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuoHx-0006RT-8M
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 20:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776Ab3GDS3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 14:29:49 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:49965 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752912Ab3GDS3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 14:29:48 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id F1BE618C887;
	Thu,  4 Jul 2013 19:29:45 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 8229618C867;
	Thu,  4 Jul 2013 19:29:44 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Thu,  4 Jul 2013 19:29:41 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7v4ncfjs32.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229607>

Junio C Hamano wrote:
> I like the part that gets rid of that "get-mode-bits" but at the
> same time, I find this part wanting a reasonable in-code comment.

Indeed. (As I said, a bit rough around the edges ;-)

> At least, with the earlier get-mode-bits, it was clear why we are
> doing something special in that codepath, both from the name of the
> helper function/macro and the comment attached to it describing how
> the "regular" one is cheating.
> 
> We must say why this "fast" is not used everywhere and what criteria
> you should apply when deciding to use it (or not use it).  And the
> "fast" name is much less descriptive.
> 
> I suspect (without thinking it through) that the rule would be
> something like:
> 
>     The "fast" variant is to be used to read from the filesystem the
>     "stat" bits that are stuffed into the index for quick "touch
>     detection" (aka "cached stat info") and/or that are compared
>     with the cached stat info, and should not be used anywhere else.

Sounds good to me.

> But then we always use lstat(2) and not stat(2) for that, so...

Indeed. Although there may be need of an "fast_fstat" (see below). :(

>> +#ifndef GIT_FAST_STAT
>> +static inline int fast_stat(const char *path, struct stat *st)
>> +{
>> +	return stat(path, st);
>> +}
>> +static inline int fast_lstat(const char *path, struct stat *st)
>> +{
>> +	return lstat(path, st);
>> +}
>> +#endif

Yes, I'm not very good at naming things, so suggestions welcome!

Note that I missed at least one lstat() call which needed to be renamed
to fast_lstat() (builtin/apply.c, line 3094 in checkout_target()).
This is my main concern with this patch (i.e. that I have missed some
more lstat calls that need to be renamed). I was a little surprised
at the size of the patch; direct index manipulation is more widespread
than I had expected.

Also, since cygwin has UNRELIABLE_FSTAT defined, on the first pass of
the patch, I ignored the use of fstat() in write_entry(). However, *if*
we allow for some other platform, which has a reliable fstat, but wants
to provide "fast" stat variants, then these fstat calls should logically
be "fast". Alternatively, we could drop the use of fstat(), like so:

  diff --git a/entry.c b/entry.c
  index 4d2ac73..d04d7a1 100644
  --- a/entry.c
  +++ b/entry.c
  @@ -104,21 +104,9 @@ static int open_output_fd(char *path, struct cache_entry *ce, int to_tempfile)
   	}
   }
 
  -static int fstat_output(int fd, const struct checkout *state, struct stat *st)
  -{
  -	/* use fstat() only when path == ce->name */
  -	if (fstat_is_reliable() &&
  -	    state->refresh_cache && !state->base_dir_len) {
  -		fstat(fd, st);
  -		return 1;
  -	}
  -	return 0;
  -}
  -
   static int streaming_write_entry(struct cache_entry *ce, char *path,
   				 struct stream_filter *filter,
  -				 const struct checkout *state, int to_tempfile,
  -				 int *fstat_done, struct stat *statbuf)
  +				 const struct checkout *state, int to_tempfile)
   {
   	int result = 0;
   	int fd;
  @@ -128,7 +116,6 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
   		return -1;
 
   	result |= stream_blob_to_fd(fd, ce->sha1, filter, 1);
  -	*fstat_done = fstat_output(fd, state, statbuf);
   	result |= close(fd);
 
   	if (result)
  @@ -139,7 +126,7 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
   static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
   {
   	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
  -	int fd, ret, fstat_done = 0;
  +	int fd, ret;
   	char *new;
   	struct strbuf buf = STRBUF_INIT;
   	unsigned long size;
  @@ -150,8 +137,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
   		struct stream_filter *filter = get_stream_filter(ce->name, ce->sha1);
   		if (filter &&
   		    !streaming_write_entry(ce, path, filter,
  -					   state, to_tempfile,
  -					   &fstat_done, &st))
  +					   state, to_tempfile))
   			goto finish;
   	}
 
  @@ -190,8 +176,6 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
   		}
 
   		wrote = write_in_full(fd, new, size);
  -		if (!to_tempfile)
  -			fstat_done = fstat_output(fd, state, &st);
   		close(fd);
   		free(new);
   		if (wrote != size)
  @@ -209,8 +193,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 
   finish:
   	if (state->refresh_cache) {
  -		if (!fstat_done)
  -			fast_lstat(ce->name, &st);
  +		fast_lstat(ce->name, &st);
   		fill_stat_cache_info(ce, &st);
   	}
   	return 0;
  -- 

I would need to do some timing tests (on Linux) to see what effect this
would have on performance. (I noticed that the test suite ran about 2%
slower with the above applied).

A simple pass-though fast_fstat(), including on cygwin, is probably the
way to go.

Sorry for being a bit slow on this - I'm very busy at the moment. :(

ATB,
Ramsay Jones
