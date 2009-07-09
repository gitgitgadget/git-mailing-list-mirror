From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
 an up-to-date cache entry
Date: Thu, 09 Jul 2009 09:32:03 -0700
Message-ID: <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org>
 <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
 <7vskh646bw.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 18:32:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOwXk-0006OF-66
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 18:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760012AbZGIQcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 12:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759670AbZGIQcN
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 12:32:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756304AbZGIQcM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 12:32:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6693B2668E;
	Thu,  9 Jul 2009 12:32:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C1CAE2668D; Thu, 
 9 Jul 2009 12:32:05 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain>
 (Linus Torvalds's message of "Thu\, 9 Jul 2009 08\:52\:37 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0CCD21C6-6CA6-11DE-96B1-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122989>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 9 Jul 2009, Junio C Hamano wrote:
>> 
>> I was wondering if we could also say that D exists as a directory when we
>> know there is D/F in the index and is up to date.
>
> Yeah, that would probably be a good thing, but is slightly slower to look 
> up (we have the name hashing for the case-ignoring code anyway, but that 
> only works for exact names, so you can't look up directories that way).
>
> You'd have to use the regular binary search for that (or we'd have to 
> change it to hash directories too - which we might want to do for other 
> reasons, but don't do now).
>
> Something like this?

Yeah, in Dmitry's response that crossed with this update patch from you,
he says lstat() on directories are still problem---it would be interesting to
hear what he sees after applying this patch and retesting.

> +static int get_index_mode(const char *path, int len)
> +{
> +	int pos;
> +	struct cache_entry *ce;
> +
> +	ce = cache_name_exists(path, len, 0);
> +	if (ce) {
> +		if (ce_uptodate(ce))
> +			return ce->ce_mode;

You return ce->ce_mode for up-to-date entries.  I do not remember what
ce_uptodate(ce) says for gitlinks, but ce->ce_mode for them would be
160000 that is not very kosher to give to S_ISDIR().  I realize that this
worry actually applies to your patch from yesterday, the one Dmitry
already tested.

> +		return 0;
> +	}
> +
> +	/* Try to look it up as a directory */
> +	pos = cache_name_pos(path, len);
> +	if (pos >= 0)
> +		return 0;

How can this find an exact entry for the path?  Assuming that the name
hash cache_name_exists() is not out of sync?  Shouldn't this be a BUG()
instead of "It somehow exists as a blob or submodule, and we'll let the
regular lstat() codepath take care of it by returning 0"?

> +	pos = -pos-1;
> +	while (pos < active_nr) {
> +		ce = active_cache[pos++];
> +		if (strncmp(ce->name, path, len))
> +			break;
> +		if (ce->name[len] > '/')
> +			break;
> +		if (ce->name[len] < '/')
> +			continue;
> +		if (!ce_uptodate(ce))
> +			break;	/* continue? */

I think this should be continue, as the directory D you are interested in
may have two files, one modified, the other uptodate.

> +		return S_IFDIR;
> +	}
> +	return 0;
> +}
> +
>  static int get_dtype(struct dirent *de, const char *path, int len)
>  {
>  	int dtype = de ? DTYPE(de) : DT_UNKNOWN;
> -	struct cache_entry *ce;
>  	struct stat st;
>  
>  	if (dtype != DT_UNKNOWN)
>  		return dtype;
> -	ce = cache_name_exists(path, len, 0);
> -	if (ce && ce_uptodate(ce))
> -		st.st_mode = ce->ce_mode;
> -	else if (lstat(path, &st))
> +	st.st_mode = get_index_mode(path, len);
> +	if (!st.st_mode && lstat(path, &st))
>  		return dtype;
>  	if (S_ISREG(st.st_mode))
>  		return DT_REG;
