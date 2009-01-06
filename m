From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/4] Optimised, faster, more effective
 symlink/directory detection
Date: Tue, 06 Jan 2009 00:19:26 -0800
Message-ID: <7vprj0j181.fsf@gitster.siamese.dyndns.org>
References: <1231161001-32599-1-git-send-email-barvik@broadpark.no>
 <1231161001-32599-2-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:21:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7BN-0007yr-Gu
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbZAFITe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbZAFITe
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:19:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40535 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbZAFITd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:19:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA07C8DEA9;
	Tue,  6 Jan 2009 03:19:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 882998DEA7; Tue,
  6 Jan 2009 03:19:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF217286-DBCA-11DD-B68D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104661>

Kjetil Barvik <barvik@broadpark.no> writes:

> +static inline void
> +update_path_cache(unsigned int ret_flags, unsigned int track_flags,
> +		  int last_slash)
> +{
> +	/* Max 3 different path types can be cached for the moment! */
> +	unsigned int save_flags =
> +		ret_flags & track_flags & (LSTAT_DIR|
> +					   LSTAT_NOTDIR|
> +					   LSTAT_SYMLINK);
> +	if (save_flags && last_slash > 0 && last_slash < PATH_MAX) {
> +		cache_flags = save_flags;
> +		cache_len   = last_slash;
> +	} else {
> +		cache_flags = 0;
> +		cache_len   = 0;
> +	}
> +}

I personally found this inline function with a single call site
distracting in following the logic.  It does not make the indentation
level shallower, either.  Also, the else part should probably call
clear_lstat_cache() to protect it from possible future enhancements to add
more state variables.

> +
> +/*
> + * Check if name 'name' of length 'len' has a symlink leading
> + * component, or if the directory exists and is real, or not.
> + *
> + * To speed up the check, some information is allowed to be cached.
> + * This is indicated by the 'track_flags' argument.
> + */
> +unsigned int
> +check_lstat_cache(int len, const char *name, unsigned int track_flags)
> +{
> +	int match_len, last_slash, max_len;
> +	unsigned int match_flags, ret_flags;
> +	struct stat st;
> +
> +	/* Check if match from the cache for 2 "excluding" path types.
> +	 */
> +	match_len = last_slash =
> +		greatest_common_path_cache_prefix(len, name);
> +	match_flags =
> +		cache_flags & track_flags & (LSTAT_NOTDIR|
> +					     LSTAT_SYMLINK);
> +	if (match_flags && match_len == cache_len)
> +		return match_flags;

Let me see if I understand the logic behind this caching.  When you have
checked A/B/C earlier and you already know B is a symlink, you remember
that A/B was a symlink..  You can fill a request to check A/B/$whatever
(assuming A/B does not change --- otherwise the caller should clear the
cache) from the cached data, because no matter what $whatever is, it will
result in the same "has-leading-symlink".

Similarly, if you know A/B is not a directory from an earlier test, you
know that a request to check A/B/$whatever will result in the same ENOTDIR
no matter what $whatever is, so you can return early.

The above "return match_flags" will not trigger if the cached path does
not have any leading symlink.  So we know the matched part are all good
directories when we start lstat() loop.

Am I following you so far?

> +	/* Okay, no match from the cache so far, so now we have to
> +	 * check the rest of the path components and update the cache.
> +	 */
> +	ret_flags = LSTAT_DIR;
> +	max_len = len < PATH_MAX ? len : PATH_MAX;
> +	while (match_len < max_len) {
> +		do {
> +			cache_path[match_len] = name[match_len];
> +			match_len++;
> +		} while (match_len < max_len && name[match_len] != '/');

You take one component from the input, and append it to the part that is
already known to be true directory (i.e. cached part and the part earlier
iteration of the loop checked so far), to be tested by lstat()...

> +		if (match_len >= max_len)
> +			break;

... but you are not interested in the full input.  We are only checking
the leading path (e.g. check for "A/B/C" may lstat() "A", "A/B" but not
"A/B/C").

> +		last_slash = match_len;
> +		cache_path[last_slash] = '\0';
> +
> +		if (lstat(cache_path, &st)) {
> +			ret_flags = LSTAT_LSTATERR;
> +			if (errno == ENOENT || errno == ENOTDIR)
> +				ret_flags |= LSTAT_NOTDIR;

If you tested "A/B" here and got ENOENT back, you know "A/B" does not
exist; you cache this knowledge as "A/B is not a directory" (I also think
you could use it as a cached knowledge that "A exists and is a directory".
I am not sure if you are taking advantage of that).

What I do not understand about this code is the ENOTDIR case.  If you
tested "A/B" and got ENOTDIR back, what you know is that "A" is not a
directory (if the path tested this round were deeper like "X/Y/A/B", you
know "X/Y/A" is not a directory, and you know "X" and "X/Y" are true
directories; otherwise the loop would have exited before this round when
you tested "X" or "X/Y" in the earlier rounds).

So as far as I can think of, ENOENT case and ENOTDIR case would give you
different information (ENOENT would say "A is a dir, A/B is not"; ENOTDIR
would say "A is not a dir").  I am confused how you can cache the same
path and same flag between these two cases here.

> +		} else if (S_ISDIR(st.st_mode)) {
> +			continue;
> +		} else if (S_ISLNK(st.st_mode)) {
> +			ret_flags = LSTAT_SYMLINK;
> +		} else {
> +			ret_flags = LSTAT_ERR;
> +		}
> +		break;
> +	}
> +	update_path_cache(ret_flags, track_flags, last_slash);
> +	return ret_flags;
> +}
> +
> +/*
> + * Before usage of the check_lstat_cache() function one should call
> + * clear_lstat_cache() (at an appropriate place) to make sure that the
> + * cache is clean before first call to check_lstat_cache().
> + */
> +void clear_lstat_cache(void)
> +{
> +	cache_flags = 0;
> +	cache_len   = 0;
> +}
> -- 
> 1.6.1.rc1.49.g7f705
