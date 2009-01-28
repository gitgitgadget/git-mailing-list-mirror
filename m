From: Junio C Hamano <gitster@pobox.com>
Subject: ??? Re: [PATCH/RFC v1 1/6] symlinks.c: small cleanup and
 optimisation
Date: Wed, 28 Jan 2009 12:36:09 -0800
Message-ID: <7vskn3np6u.fsf@gitster.siamese.dyndns.org>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
 <1233004637-15112-2-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:38:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSHAQ-0007NH-Ql
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 21:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757710AbZA1UgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 15:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756311AbZA1UgS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 15:36:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756297AbZA1UgR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 15:36:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4464794E2C;
	Wed, 28 Jan 2009 15:36:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E30C794E2B; Wed,
 28 Jan 2009 15:36:11 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4EF8CD02-ED7B-11DD-BECD-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107569>

Kjetil Barvik <barvik@broadpark.no> writes:

> Simplify the if-else test in longest_match_lstat_cache() such that we
> only have one simple if test.  Instead of testing for 'i == cache.len'
> or 'i == len', we transform this to a common test for 'i == max_len'.
>
> And to further optimise we use 'i >= max_len' instead of 'i ==
> max_len', the reason is that it is now the exact opposite of one part
> inside the while-loop termination expression 'i < max_len && name[i]
> == cache.path[i]', and then the compiler can hopefully/probably reuse
> a test-result from it.

This is *dense*, and made me wonder if is this really worth doing.

> +	/*
> +	 * Is the cached path string a substring of 'name', is 'name'
> +	 * a substring of the cached path string, or is 'name' and the
> +	 * cached path string the exact same string?
> +	 */
> +	if (i >= max_len && ((i < len && name[i] == '/') ||
> +			     (i < cache.len && cache.path[i] == '/') ||
> +			     (len == cache.len))) {

As you described in your commit log message, what this really wants to
check is (i == max_len).  By saying (i >= max_len) you are losing
readability, optimizing for compilers (that do not notice this) and
pessimizing for human readers (like me, who had to spend a few dozens of
seconds to realize what you are doing, to speculate why you might have
thought this would be a good idea, and writing this paragraph).  I do not
know if it is a good trade-off.

> @@ -91,7 +92,7 @@ static int lstat_cache(int len, const char *name,
>  		match_len = last_slash =
>  			longest_match_lstat_cache(len, name, &previous_slash);
>  		match_flags = cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
> -		if (match_flags && match_len == cache.len)
> +		if (match_flags && match_len >= cache.len)
>  			return match_flags;
>  		/*
>  		 * If we now have match_len > 0, we would know that

Likewise.

> @@ -102,7 +103,7 @@ static int lstat_cache(int len, const char *name,
>  		 * we can return immediately.
>  		 */
>  		match_flags = track_flags & FL_DIR;
> -		if (match_flags && len == match_len)
> +		if (match_flags && match_len >= len)
>  			return match_flags;
>  	}
>  

Likewise.

> @@ -184,7 +185,7 @@ void invalidate_lstat_cache(int len, const char *name)
>  	int match_len, previous_slash;
>  
>  	match_len = longest_match_lstat_cache(len, name, &previous_slash);
> -	if (len == match_len) {
> +	if (match_len >= len) {
>  		if ((cache.track_flags & FL_DIR) && previous_slash > 0) {
>  			cache.path[previous_slash] = '\0';
>  			cache.len = previous_slash;

Likewise.

People who would want to fix potential bugs in this code 3 months down the
road may not have a ready access to your commit log message (they may be
looking at an extract from a release tarball, scratching their heads
wondering why you are not checking for equality).  Perhaps the inline
function can have comments that says something like "when comparing the
return value from this function to see if it is equal to cache.len or len,
checking if the returned value is >= might help your compiler optimize it
better" to help the readers, but still, I do not know if it is a good
trade-off.

> @@ -153,7 +154,7 @@ static int lstat_cache(int len, const char *name,
>  		cache.path[last_slash] = '\0';
>  		cache.len = last_slash;
>  		cache.flags = save_flags;
> -	} else if (track_flags & FL_DIR &&
> +	} else if ((track_flags & FL_DIR) &&
>  		   last_slash_dir > 0 && last_slash_dir <= PATH_MAX) {
>  		/*
>  		 * We have a separate test for the directory case,

Good.
