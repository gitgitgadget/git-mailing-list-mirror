From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 2/7] Change canonicalize_url() to use the SVN 1.7 API
 when available.
Date: Sat, 28 Jul 2012 12:01:20 -0700
Message-ID: <50143700.80900@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-3-git-send-email-schwern@pobox.com>
 <20120728135018.GB9715@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:02:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvCH8-0001FP-EJ
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 21:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab2G1TBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 15:01:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36716 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846Ab2G1TBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 15:01:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C3E48DA1;
	Sat, 28 Jul 2012 15:01:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=UpIOz76KGcQw
	SqvoMdS9GR8hZoI=; b=i2yHqHHLDOHWcA/80E/0QzmCnemEPSX4qZaHu+qrZ8ML
	ek72WwyCYdEF7QKJMuxHb3sr+Uc59cLIhi/LhaaJkigxMiSOapwFp1J9WHtaKWsb
	eUgTbVKTzT5FZrfzOXtGPsBtoojMsVgZlwOZBS8MmIt6JKSMldjWMv1Jc1yFQCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pBK2DL
	7h6uDB9C1L+z2qgS8yjlAUsdIi2TijfPwMPhN5WDWQGuNDCkooPwnGdZAKDsMeZL
	ZPw128O9Wjne7Arf63kROItH4T0NpUdeGEnVYL/drsxvIjjuCxN9fGqLHwH2+EPL
	hAi36ZUPg1mD3INXtVWR18NkZkBdS1ullrDGk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 099988D9F;
	Sat, 28 Jul 2012 15:01:24 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C6B38D9D; Sat, 28 Jul
 2012 15:01:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120728135018.GB9715@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: A00D1B08-D8E6-11E1-9965-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202455>

On 2012.7.28 6:50 AM, Jonathan Nieder wrote:
>> --- a/perl/Git/SVN/Utils.pm
>> +++ b/perl/Git/SVN/Utils.pm
> [...]
>> @@ -100,6 +102,20 @@ API as a URL.
>>  =cut
>>  
>>  sub canonicalize_url {
>> +	my $url = shift;
>> +
>> +	# The 1.7 way to do it
>> +	if ( defined &SVN::_Core::svn_uri_canonicalize ) {
>> +		return SVN::_Core::svn_uri_canonicalize($url);
>> +	}
>> +	# There wasn't a 1.6 way to do it, so we do it ourself.
>> +	else {
>> +		return _canonicalize_url_ourselves($url);
>> +	}
>> +}
>> +
>> +
>> +sub _canonicalize_url_ourselves {
>>  	my ($url) = @_;
>>  	$url =~ s#^([^:]+://[^/]*/)(.*)$#$1 . canonicalize_path($2)#e;
> 
> Leaves me a bit nervous.

As it should, SVN dumped a mess on us.


> What effect should we expect this change to have?  Is our emulation
> of svn_uri_canonicalize already perfect and this change just a little
> futureproofing in case svn_uri_canonicalize gets even better, or is
> this a trap waiting to happen when new callers of canonicalize_url
> start relying on, e.g., %-encoding of special characters?

This change is *just* about sliding in the SVN API call and seeing if git-svn
still works with SVN 1.6.  It should have no effect on SVN 1.6.  These patches
are a very slow and careful refactoring doing just one thing at a time.  Every
time I tried to do too many things at once, tests broke and I had to tease the
patch apart.

At this point in the patch series the code is not ready for canonicalization.
 Until 3/8 in the next patch series, canonicalize_url() basically does nothing
on SVN 1.6 so the code has never had to deal with the problem.  3/8 deals with
improving _canonicalize_url_ourselves() to work more like
svn_uri_canonicalize() and thus "turns on" canonicalization for SVN 1.6 and
deals with the breakage.


> If I am reading Subversion r873487 correctly, in ancient times,
> svn_path_canonicalize() did the appropriate tweaking for URIs.  Today
> its implementation is comforting:
> 
> 	const char *
> 	svn_path_canonicalize(const char *path, apr_pool_t *pool)
> 	{
> 	  if (svn_path_is_url(path))
> 	    return svn_uri_canonicalize(path, pool);
> 	  else
> 	    return svn_dirent_canonicalize(path, pool);
> 	}
> 
> It might be easier to rely on that on pre-1.7 systems.

I didn't know about that.  I don't know what your SVN backwards compat
requirements are, but if that behavior goes back far enough in SVN to satisfy
you folks, then canonicalize_url() should fall back to
SVN::_Core::svn_path_canonicalize().  But try it at the end of the patch
series.  The code has to be prepared for canonicalization first.  Then how it
actually does it can be improved.


-- 
Defender of Lexical Encapsulation
