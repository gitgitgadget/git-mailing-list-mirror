From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 3/7] Extract, test and enhance the logic to collapse
 ../foo paths.
Date: Mon, 30 Jul 2012 13:46:29 -0700
Message-ID: <5016F2A5.1090102@pobox.com>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-4-git-send-email-schwern@pobox.com>
 <20120730195108.GA20137@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 22:46:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvwrP-0002rQ-Mb
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 22:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab2G3Uqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 16:46:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60721 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195Ab2G3Uqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 16:46:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C3948AE5;
	Mon, 30 Jul 2012 16:46:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=V6/np7YzbajI
	7Xb8hzkRnwXMISE=; b=cYtitE326j43MhWks3ZRCQuoU8lDCuqFxt62UpXf3QPV
	/qNtG8npuyNsKGreJILoviPhtyc/Ms46UD4FLxnEkpqWDPDetbVSVpibtCtiOKEg
	7AfcY32MT6gfWX5H3zWOBVPLFn0fwjWPVh8C6ppkyL3JKuPcCWxs41+SnyLGHUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QqDmCH
	yvqfHWZfNOXqzv4B0hNADp3IwJ+mEFhz8/1b/8A37Mp2OKekEwA2Xi4L42y/YxZF
	UCYr5MzLDZbzBSEKjKjSiCTEvcqpw56VJ4OmP6OBLWeO6vUxsxUtfHKQbOrYADoR
	VkkMSj2PZBTw8B06fD3MfV0+eTg2ulgyaHlSw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8905B8AE4;
	Mon, 30 Jul 2012 16:46:33 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A71798AE3; Mon, 30 Jul
 2012 16:46:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120730195108.GA20137@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: A5A26904-DA87-11E1-B5EC-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202614>

On 2012.7.30 12:51 PM, Eric Wong wrote:
>> The SVN API functions will not accept ../foo but their canonicalization
>> functions will not collapse it.  So we'll have to do it ourselves.
>>
>> _collapse_dotdot() works better than the existing regex did.
> 
> I don't dispute it's better, but it's worth explaining in the commit
> message to reviewers why something is "better".

Yeah.  I figured the tests covered that.


>> +# Turn foo/../bar into bar
>> +sub _collapse_dotdot {
>> +	my $path = shift;
>> +
>> +	1 while $path =~ s{/[^/]+/+\.\.}{};
>> +	1 while $path =~ s{[^/]+/+\.\./}{};
>> +	1 while $path =~ s{[^/]+/+\.\.}{};
> 
> This is a bug that's gone unnoticed[1] for over 5 years now,
> but I've just noticed this doesn' handle "foo/..bar"  or "foo/...bar"
> cases correctly.

Good catch.  Woo unit tests!  :)  You could add them as TODO tests.

A more accurate way to do it would be to split the path, collapse using the
resulting list, and rejoin it.


> [1] - I doubt anybody uses paths like these, though...

Not for an svnroot or branch name, no.


-- 
Hating the web since 1994.
