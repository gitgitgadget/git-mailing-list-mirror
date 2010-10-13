From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: Recognize epoch timestamps with : in the timezone
Date: Wed, 13 Oct 2010 11:59:05 -0700
Message-ID: <7v4ocpncli.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.00.1009291644440.15192@dr-wily.mit.edu>
 <20100929214107.GA4485@capella.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@ksplice.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 20:59:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P66Y1-0006NT-Ly
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 20:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab0JMS7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 14:59:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0JMS7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 14:59:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CAD52DE303;
	Wed, 13 Oct 2010 14:59:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+5KJSqF5YVLtP+jcw3g+9x3/ah4=; b=stLRss
	DihVJGYvnapkVCvq34bB5KkC1ZkfuxEy2aPEArudGfPa63Zs4eR8xF1Fk7mWfiiP
	fo2X8+KEmrCuO9RFpKTEcpVibbfWJBYemKCKeUi9SUvoHLAyKqbNR9b8iOmKlTyM
	QOyUMzQbElCddBmGx6/ehqMPcpSnSeIy9sYZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C12q+kfRjU/rbCP18wy1mf/tBDADgSKf
	9y1TzgR/ccXZB3HfOlnnpR+H0fEH+hYtLo6nvlubgL88IW+Z8uuXcJXvj5v/gvb1
	9gpEEv8QnX0XyJ9gAiLz+KrdyEk/6Oaim9V2GnGtYMiCPuh9qSgXWsxqmfgvgq/c
	SEwqDhoj0qA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 831ADDE2FF;
	Wed, 13 Oct 2010 14:59:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C6A9DE2FB; Wed, 13 Oct
 2010 14:59:07 -0400 (EDT)
In-Reply-To: <20100929214107.GA4485@capella.cs.uchicago.edu> (Jonathan
 Nieder's message of "Wed\, 29 Sep 2010 16\:41\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F716EABC-D6FB-11DF-B17A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158960>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Anders,
>
> Anders Kaseorg wrote:
>> Some patches have a timezone formatted like '-08:00' instead of
>> '-0800' (e.g. http://lwn.net/Articles/131729/)
>
> Odd.  Any idea what tool generates these patches?
>
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
> [...]
>> @@ -765,7 +765,9 @@ static int has_epoch_timestamp(const char *nameline)
>>  	}
>>  
>>  	zoneoffset = strtol(timestamp + m[3].rm_so + 1, NULL, 10);
>> -	zoneoffset = (zoneoffset / 100) * 60 + (zoneoffset % 100);
>> +	if (m[4].rm_so == m[3].rm_so + 3)
>> +		zoneoffset /= 100;
>> +	zoneoffset = zoneoffset * 60 + strtol(timestamp + m[4].rm_so, NULL, 10);
>
> Might be clearer to write
>
> 	if (timestamp[m[3].rm_so + 3] != ':')

Neither the patch nor your suggestion makes much sense to me.  With the
patch, the regexp is now

    ^(1969-12-31|1970-01-01) <time>(\.0+)? ([-+][0-2][0-9]):?([0-5][0-9])

so $3 is always 3 letters long (i.e. hour with sign), no?  IOW, zoneoffset
is never divided by 100 by the original patch.

What am I missing?
