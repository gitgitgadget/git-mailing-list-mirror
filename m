From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2 1/4] refs: add common refname_match_patterns()
Date: Sat, 11 Feb 2012 11:37:42 -0800
Message-ID: <20120211193742.GD4903@tgrennan-laptop>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <1328926618-17167-2-git-send-email-tmgrennan@gmail.com>
 <7vpqdln68v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 20:38:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwIln-00023O-DS
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 20:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844Ab2BKTh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 14:37:58 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47735 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836Ab2BKTh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 14:37:56 -0500
Received: by vbjk17 with SMTP id k17so2405784vbj.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 11:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KKAzDxSq6OnoQzpDaaleJ/XkOpUsn2gWBz1Bf5GBHhE=;
        b=uyaRpP+A9v0XL3GqVfS5N887QDkKv9ceWng/pOzsF9uoMi1zULSFR5cLsbPj02b1CB
         OKoGi7L/dPNEVgiHc4MhBVTakmVDPrnHFJxyL7UemmX43JR3yjf7rxGEulmW/z3nr3EM
         pLFCSqNOgxY0hrswbbVU4CfM0EzBPy3v0Kntc=
Received: by 10.220.153.201 with SMTP id l9mr5820784vcw.1.1328989075935;
        Sat, 11 Feb 2012 11:37:55 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id h2sm6643955vdi.18.2012.02.11.11.37.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 11:37:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpqdln68v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190532>

On Sat, Feb 11, 2012 at 12:06:56AM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> +int refname_match_patterns(const char **patterns, const char *refname)
>> +{
>> +	int given_match_pattern = 0, had_match = 0;
>> +
>> +	for (; *patterns; patterns++)
>> +		if (**patterns != '!') {
>> +			given_match_pattern = 1;
>> +			if (!fnmatch(*patterns, refname, 0))
>> +				had_match = 1;
>> +		} else if (!fnmatch(*patterns+1, refname, 0))
>> +			return 0;
>> +	return given_match_pattern ? had_match : 1;
>> +}
>
>This, while its semantics seem sane, is highly inefficient when you have
>many patterns, and you will be calling this to filter dozens of refs.  And
>it can trivially improved by first pre-parsing the pattern[] array.
>
> * If you know the patterns do not have any negative entry, you can return
>   true upon seeing the first match. Because you do not pre-parse the
>   pattern[] array, this loop does not know if there is any negative one,
>   and has to scan it always all the way.
>
> * If you arrange the pattern[] array so that it has negative ones early,
>   again, you can return false upon seeing the first hit with a negative
>   one. If your input has negative ones at the end, the loop ends up
>   scanning all the way, noting the positive matches, only to discard upon
>   seeing the negative match at the end.
>
>That is why I said Nguyen's idea of reusing pathspec matching logic
>somewhat attractive, even though I think it has downsides (the exact
>matching logic for pathspec is more similar to that of for-each-ref
>and very different from branch/tag).

Yes, I should have stated that this emphasized containment over
efficiency.  If instead we stipulate that the caller must list exclusion
patterns before others, this could simply be:

int match_pattern(const char **patterns, const char *refname)
{
	if (*patterns)
		return 1;
	for (; *patterns && **patterns == '!'; patterns++)
		if (!fnmatch(*patterns+1, refname, 0))
			return 0;
	for (; *patterns; patterns++)
		if (!fnmatch(*patterns, refname, 0))
			return 1;
	return 0;
}

Of course I'd add a with_exclusions_first() before the
respective ref iterator.

-- 
TomG
