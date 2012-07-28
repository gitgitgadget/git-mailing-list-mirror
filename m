From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 6/7] Switch path canonicalization to use the SVN API.
Date: Sat, 28 Jul 2012 12:07:40 -0700
Message-ID: <5014387C.50903@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-7-git-send-email-schwern@pobox.com>
 <20120728135502.GC9715@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:07:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvCMf-0004tk-QW
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 21:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab2G1THm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 15:07:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004Ab2G1THl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 15:07:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85EA48EB7;
	Sat, 28 Jul 2012 15:07:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=RYjxFXxHHRL4
	LPf21qll5jMR4Ow=; b=PWVFWlrJjoLeIW6hZy2tt45Jd2GLI49RPtz8fALRwDYK
	a1gBwM1ioQpEswYEFAHLlPM0gXR+QK++yoSTqYqhvKzNwz73iQ+Q2fEkgKRjp6q3
	GjvoGeOgpqHzvAF6Sq2Mngk2jr/N9E0yCmkMzkyK/79qQMeKd1VRPb2RJXjZT0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q97oRe
	U5JPEauFSFdhWYLBZDCsO1KygMVBfTu4g4TRm+vBAqHeB5B2fvWavK7X/LPv1h3W
	+SHd8FVmwy0aK3sgjqgfRPnKthHwv9Irb66Pn8ptStbND7ne8v5so/BURAk/bP32
	NeKpryOMv2IRTJgUXhZk+SkFxd9XWA1S5Mh9o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 726DE8EB6;
	Sat, 28 Jul 2012 15:07:41 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 689868EB4; Sat, 28 Jul
 2012 15:07:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120728135502.GC9715@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 80EB700C-D8E7-11E1-B248-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202456>

On 2012.7.28 6:55 AM, Jonathan Nieder wrote:
> Michael G. Schwern wrote:
>> --- a/perl/Git/SVN/Utils.pm
>> +++ b/perl/Git/SVN/Utils.pm
>> @@ -86,6 +86,27 @@ sub _collapse_dotdot {
>>  
>>  
>>  sub canonicalize_path {
>> +	my $path = shift;
>> +
>> +	# The 1.7 way to do it
>> +	if ( defined &SVN::_Core::svn_dirent_canonicalize ) {
>> +		$path = _collapse_dotdot($path);
>> +		return SVN::_Core::svn_dirent_canonicalize($path);
>> +	}
>> +	# The 1.6 way to do it
>> +	elsif ( defined &SVN::_Core::svn_path_canonicalize ) {
>> +		$path = _collapse_dotdot($path);
>> +		return SVN::_Core::svn_path_canonicalize($path);
>> +	}
>> +	# No SVN API canonicalization is available, do it ourselves
>> +	else {
> 
> When would this "else" case trip?

When svn_path_canonicalize() does not exist in the SVN API, presumably because
their SVN is too old.


> Would it be safe to make it
> return an error message, or even to do something like the following?

I don't know what your SVN backwards compat requirements are, or when
svn_path_canonicalize() appears in the API, so I left it as is.  git-svn's
home rolled path canonicalization worked and its no work to leave it working.
 No reason to break it IMO.


> 	sub canonicalize_path {
> 		my $path = shift;
> 		$path = _collapse_dotdot($path);
> 
> 		# Subversion 1.7 split svn_path_canonicalize() into
> 		# svn_dirent_canonicalize() and svn_uri_canonicalize().
> 		if (!defined &SVN::_Core::svn_dirent_canonicalize) {
> 			return SVN::_Core::svn_path_canonicalize($path);
> 		}
> 
> 		return SVN::_Core::svn_dirent_canonicalize($path);
> 	}

As a side note...
"If they don't have Mars bar, get me a Twix.  Else get me a Mars bar."
"If they have a Mars bar, get me one.  Else get me a Twix."


-- 
Look at me talking when there's science to do.
When I look out there it makes me glad I'm not you.
I've experiments to be run.
There is research to be done
On the people who are still alive.
    -- Jonathan Coulton, "Still Alive"
