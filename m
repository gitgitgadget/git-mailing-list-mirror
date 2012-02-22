From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv3 1/5] refs: add match_pattern()
Date: Wed, 22 Feb 2012 15:47:33 -0800
Message-ID: <20120222234733.GD2410@tgrennan-laptop>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
 <1329874130-16818-2-git-send-email-tmgrennan@gmail.com>
 <7vobsrbcny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 00:47:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0LuT-0008B9-SH
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 00:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823Ab2BVXrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 18:47:41 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:46761 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab2BVXrk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 18:47:40 -0500
Received: by qafk1 with SMTP id k1so810394qaf.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 15:47:39 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.229.69.67 as permitted sender) client-ip=10.229.69.67;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.229.69.67 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.229.69.67])
        by 10.229.69.67 with SMTP id y3mr23380594qci.15.1329954459474 (num_hops = 1);
        Wed, 22 Feb 2012 15:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=svfrxY503iDNzB+NEyUa3zffb6X+ZPXELDs/FZDgA0k=;
        b=i6s9md40eLVoIVuYAhNdDg6xyTxuaPKdY0yDjUAj2QumqmkUeKUMBNiFc0sBRh4UJ6
         p5XhtcIrIyYsT8HkWrJ+A0+PZm8YUw8b/YeZY+3uLd0+xlk6rz5891VK51ZttDaVcvsI
         UJ/Do1VHTTp4G2IqwA8AU1kjwUBz8xbriI+yc=
Received: by 10.229.69.67 with SMTP id y3mr19705304qci.15.1329954458731;
        Wed, 22 Feb 2012 15:47:38 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id e2sm69636800qao.14.2012.02.22.15.47.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 15:47:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vobsrbcny.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191310>

On Tue, Feb 21, 2012 at 10:33:05PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> +static int match_path(const char *name, const char *pattern, int nlen)
>> +{
>> +	int plen = strlen(pattern);
>> +
>> +	return ((plen <= nlen) &&
>> +		!strncmp(name, pattern, plen) &&
>> +		(name[plen] == '\0' ||
>> +		 name[plen] == '/' ||
>> +		 pattern[plen-1] == '/'));
>> +}
>
>This is a counterpart to the tail match found in ls-remote, so we would
>want to call it with a name that makes it clear this is a leading path
>match not just "path" match.  Perhaps match_leading_path() or something.

OK

>> +int match_pattern(const char *name, const char **match,
>> +		  struct string_list *exclude, int flags)
>> +{
>> +	int nlen = strlen(name);
>> +
>> +	if (exclude) {
>> +		struct string_list_item *x;
>> +		for_each_string_list_item(x, exclude) {
>> +			if (!fnmatch(x->string, name, 0))
>> +				return 0;
>> +		}
>> +	}
>> +	if (!match || !*match)
>> +		return 1;
>> +	for (; *match; match++) {
>> +		if (flags == FNM_PATHNAME)
>> +			if (match_path(name, *match, nlen))
>> +				return 1;
>> +		if (!fnmatch(*match, name, flags))
>> +			return 1;
>> +	}
>> +	return 0;
>> +}
>
>As an API for a consolidated and generic function, the design needs a bit
>more improving, I would think.
>
> - The name match_pattern() was OK for a static function inside a single
>   file, but it is way too vague for a global function. This is to match
>   refnames, so I suspect there should at least be a string "ref_"
>   somewhere in its name.

OK

> - You pass "flags" argument, so that later we _could_ enhance the
>   implementation to cover needs for new callers, but alas, it uses its
>   full bits to express only one "do we do FNM_PATHNAME or not?" bit of
>   information, so essentially "flags" does not give us any expandability.

I agree.

> - Is it a sane assumption that a caller that asks FNM_PATHNAME will
>   always want match_path() semantics, too?  Aren't these two logically
>   independent?

Yes, these should be ligically independent although the current use has
combined them.

> - Is it a sane assumption that a caller that gives an exclude list will
>   want neither FNM_PATHNAME semantics nor match_path() semantics?

I'm not sure.  I tried using FNM_PATHNAME with both exclusion and match
patterns of git-for-each-ref but I couldn't get it to do something like
this:
	git for-each-ref ... --exclude '*HEAD' refs/remotes/

I don't remember if this worked,
	git for-each-ref ... --exclude HEAD refs/remotes/

Now I see how an implicit TRAILING match would be useful,
	git for-each-ref ... --exclude /HEAD refs/remotes/

Where git-for-each-ref uses this flag:
	REF_MATCH_LEADING | REF_MATCH_TRAILING | REF_MATCH_FNM_PATH

I'll experiment with this more. 

> - Positive patterns are passed in "const char **match", and negative ones
>   are in "struct string_list *". Doesn't the inconsistency strike you as
>   strange?

Yes, I tried to minimize change but the conversion of argv's to
string_list's won't add that much.

>Perhaps like...
>
>#define REF_MATCH_LEADING       01
>#define REF_MATCH_TRAILING      02
>#define REF_MATCH_FNM_PATH      04
>
>static int match_one(const char *name, size_t namelen, const char *pattern,
>		unsigned flags)
>{
>       	if ((flags & REF_MATCH_LEADING) &&
>            match_leading_path(name, pattern, namelen))
>		return 1;
>       	if ((flags & REF_MATCH_TRAILING) &&
>            match_trailing_path(name, pattern, namelen))
>		return 1;
>	if (!fnmatch(pattern, name, 
>		     (flags & REF_MATCH_FNM_PATH) ? FNM_PATHNAME : 0))
>		return 1;
>	return 0;
>}
>
>int ref_match_pattern(const char *name,
>		const char **pattern, const char **exclude, unsigned flags)
>{
>	size_t namelen = strlen(name);
>        if (exclude) {
>		while (*exclude) {
>			if (match_one(name, namelen, *exclude, flags))
>				return 0;
>			exclude++;
>		}
>	}
>        if (!pattern || !*pattern)
>        	return 1;
>	while (*pattern) {
>		if (match_one(name, namelen, *pattern, flags))
>			return 1;
>		pattern++;
>	}
>        return 0;
>}
>
>and then the caller could do something like
>
>	ref_match_pattern("refs/heads/master",
>        		  ["maste?", NULL],
>                          ["refs/heads/", NULL],
>                          (REF_MATCH_FNM_PATH|REF_MATCH_LEADING));
>
>Note that the above "ref_match_pattern()" gives the same "flags" for the
>call to match_one() for elements in both positive and negative array and
>it is very deliberate.  See review comment to [3/5] for the reasoning.

OK, I think that I understand, but please confirm, you'd expect no output in
the above example, right?

-- 
TomG
