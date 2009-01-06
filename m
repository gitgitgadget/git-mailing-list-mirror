From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC 1/4] Optimised, faster,
 more effective symlink/directory detection
Date: Tue, 06 Jan 2009 10:36:59 +0100
Organization: private
Message-ID: <86fxjwlqro.fsf@broadpark.no>
References: <1231161001-32599-1-git-send-email-barvik@broadpark.no>
 <1231161001-32599-2-git-send-email-barvik@broadpark.no>
 <7vprj0j181.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 10:38:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK8OS-0003Ny-Go
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 10:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbZAFJhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 04:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbZAFJhG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 04:37:06 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:42497 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbZAFJhD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 04:37:03 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD1004J6MPP1L70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 06 Jan 2009 10:37:01 +0100 (CET)
Received: from localhost ([80.202.166.60]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD1006X5MPNBE50@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 06 Jan 2009 10:37:01 +0100 (CET)
In-reply-to: <7vprj0j181.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104671>

Junio C Hamano <gitster@pobox.com> writes:

> Kjetil Barvik <barvik@broadpark.no> writes:
>
>> +static inline void
>> +update_path_cache(unsigned int ret_flags, unsigned int track_flags,
>> +		  int last_slash)
>> +{
>> +	/* Max 3 different path types can be cached for the moment! */
>> +	unsigned int save_flags =
>> +		ret_flags & track_flags & (LSTAT_DIR|
>> +					   LSTAT_NOTDIR|
>> +					   LSTAT_SYMLINK);
>> +	if (save_flags && last_slash > 0 && last_slash < PATH_MAX) {
>> +		cache_flags = save_flags;
>> +		cache_len   = last_slash;
>> +	} else {
>> +		cache_flags = 0;
>> +		cache_len   = 0;
>> +	}
>> +}
>
> I personally found this inline function with a single call site
> distracting in following the logic.  It does not make the indentation
> level shallower, either.  Also, the else part should probably call
> clear_lstat_cache() to protect it from possible future enhancements to add
> more state variables.

  Ok, I will remove the function and update the else-part.

>> +
>> +/*
>> + * Check if name 'name' of length 'len' has a symlink leading
>> + * component, or if the directory exists and is real, or not.
>> + *
>> + * To speed up the check, some information is allowed to be cached.
>> + * This is indicated by the 'track_flags' argument.
>> + */
>> +unsigned int
>> +check_lstat_cache(int len, const char *name, unsigned int track_flags)
>> +{
>> +	int match_len, last_slash, max_len;
>> +	unsigned int match_flags, ret_flags;
>> +	struct stat st;
>> +
>> +	/* Check if match from the cache for 2 "excluding" path types.
>> +	 */
>> +	match_len = last_slash =
>> +		greatest_common_path_cache_prefix(len, name);
>> +	match_flags =
>> +		cache_flags & track_flags & (LSTAT_NOTDIR|
>> +					     LSTAT_SYMLINK);
>> +	if (match_flags && match_len == cache_len)
>> +		return match_flags;
>
> Let me see if I understand the logic behind this caching.  When you have
> checked A/B/C earlier and you already know B is a symlink, you remember
> that A/B was a symlink..  You can fill a request to check A/B/$whatever
> (assuming A/B does not change --- otherwise the caller should clear the
> cache) from the cached data, because no matter what $whatever is, it will
> result in the same "has-leading-symlink".
>
> Similarly, if you know A/B is not a directory from an earlier test, you
> know that a request to check A/B/$whatever will result in the same ENOTDIR
> no matter what $whatever is, so you can return early.
>
> The above "return match_flags" will not trigger if the cached path does
> not have any leading symlink.  So we know the matched part are all good
> directories when we start lstat() loop.
>
> Am I following you so far?

  Yes you do!

>> +	/* Okay, no match from the cache so far, so now we have to
>> +	 * check the rest of the path components and update the cache.
>> +	 */
>> +	ret_flags = LSTAT_DIR;
>> +	max_len = len < PATH_MAX ? len : PATH_MAX;
>> +	while (match_len < max_len) {
>> +		do {
>> +			cache_path[match_len] = name[match_len];
>> +			match_len++;
>> +		} while (match_len < max_len && name[match_len] != '/');
>
> You take one component from the input, and append it to the part that is
> already known to be true directory (i.e. cached part and the part earlier
> iteration of the loop checked so far), to be tested by lstat()...
>
>> +		if (match_len >= max_len)
>> +			break;
>
> ... but you are not interested in the full input.  

  If the lengt of name is larger than PATH_MAX all lstat() calls would
  fail with an ENAMETOOLONG error, at least on my Linux box, so I
  thought that it was not nessarry to test further.  But maybe we should
  emdiatly return an error if name is too long?

> We are only checking the leading path (e.g. check for "A/B/C" may
> lstat() "A", "A/B" but not "A/B/C").

  That is correct, and it is the same logic as in the
  has_symlink_leading_path() function.

>> +		last_slash = match_len;
>> +		cache_path[last_slash] = '\0';
>> +
>> +		if (lstat(cache_path, &st)) {
>> +			ret_flags = LSTAT_LSTATERR;
>> +			if (errno == ENOENT || errno == ENOTDIR)
>> +				ret_flags |= LSTAT_NOTDIR;
>
> If you tested "A/B" here and got ENOENT back, you know "A/B" does not
> exist; you cache this knowledge as "A/B is not a directory" 

  Correct.

> (I also think you could use it as a cached knowledge that "A exists
> and is a directory".  I am not sure if you are taking advantage of
> that).

  It does take adavantage of this fact.  It will also do simmilar things
  with a symlink cached path.

> What I do not understand about this code is the ENOTDIR case.  If you
> tested "A/B" and got ENOTDIR back, what you know is that "A" is not a
> directory (if the path tested this round were deeper like "X/Y/A/B", you
> know "X/Y/A" is not a directory, and you know "X" and "X/Y" are true
> directories; otherwise the loop would have exited before this round when
> you tested "X" or "X/Y" in the earlier rounds).

  Since the cache is supoosed to start from a known existing directory,
  and is testing each path component when the lstat("A/B") calls returns
  ENOTDIR, we should know the fact that the directory "A" exists, and
  that "A/B/" does not exists.
  
> So as far as I can think of, ENOENT case and ENOTDIR case would give you
> different information (ENOENT would say "A is a dir, A/B is not"; ENOTDIR
> would say "A is not a dir").  I am confused how you can cache the same
> path and same flag between these two cases here.

  I admit that I used copy-and-paste from other similar test's from the
  sourcecode:

kjetil@localhost ~/git/git $ grep -Hn ENOENT.*ENOTDIR *.c
builtin-apply.c:2364:	else if ((errno != ENOENT) && (errno != ENOTDIR))
builtin-update-index.c:74: *  - missing file (ENOENT or ENOTDIR). That's ok if we're
builtin-update-index.c:81:	if (err == ENOENT || err == ENOTDIR)
diff-lib.c:30:		if (errno != ENOENT && errno != ENOTDIR)
lstat_cache.c:81:			if (errno == ENOENT || errno == ENOTDIR)
setup.c:191:	if (errno != ENOENT && errno != ENOTDIR)

  From the 'man lstat' page I read the following for this 2 error codes:

    ENOENT    A component of the path _path_ does not exist, or the path is an empty string.
    ENOTDIR   A component of the path is not a directory.

  I would have guessed that for what we is looking for, it would be
  correct to threat both these error codes as the same.  Is this wrong?

  -- kjetil
