From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/11] t4014: more tests about appending s-o-b lines
Date: Sun, 27 Jan 2013 21:42:58 -0800
Message-ID: <7vboc9zwv1.fsf@alter.siamese.dyndns.org>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-10-git-send-email-drafnel@gmail.com>
 <20130128033146.GM8206@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	pclouds@gmail.com, Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 06:43:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzhV7-0004cw-C7
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 06:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab3A1FnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 00:43:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab3A1FnB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 00:43:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C6526BD4;
	Mon, 28 Jan 2013 00:43:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SSfPjV7lLMYVAB2ymP4UmC+7pEY=; b=c9ahiO
	CB3XYdj6bdT+zMfACYw0i5q7i45xrH00KlGZHCqns+jRDY/8YftpbMQdZdk597GL
	t1b1DdLxzcZVm94K9Z6J4s98sLA6vwsVPcaZdI90gi3XyIrEbFxN7S4+RoUjiXvm
	WnE4KP6EM9VojhqYyrnzySK7zMWpaG6FV6shA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q3uySatDhfTYpYlXekP76elrKvEtRzCf
	QFa92sM4kb125i541FHn6juGiZ5V3xBWRa2YDR9ucaE30bq2pgD+a88Uf8AZ47MA
	1MEMhCr+vy877IHBzvFRhPPp+x/The+c1590c2FQIJNGsAk3QeTVhqpfXDrlBzgk
	7CxTGe1PisE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 112206BD3;
	Mon, 28 Jan 2013 00:43:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B88D6BBE; Mon, 28 Jan 2013
 00:43:00 -0500 (EST)
In-Reply-To: <20130128033146.GM8206@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 27 Jan 2013 19:31:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 939158D2-690D-11E2-AB65-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214804>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Brandon Casey wrote:
>
> [...]
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -1021,4 +1021,246 @@ test_expect_success 'cover letter using branch description (6)' '
>>  	grep hello actual >/dev/null
>>  '
>>  
>> +append_signoff()
>> +{
>> +	C=`git commit-tree HEAD^^{tree} -p HEAD` &&
>> +	git format-patch --stdout --signoff ${C}^..${C} |
>> +		tee append_signoff.patch |
>> +		sed -n "1,/^---$/p" |
>> +		grep -n -E "^Subject|Sign|^$"
>> +}
>
> Is "grep -n" portable?  I didn't find any uses of it elsewhere in the
> testsuite.

Yes, "-n" is in POSIX.  Even though we use it ourselves, "git grep"
supports it, too.

Any Emacs user would scream if their platform "grep" does not
support it, as it will make M-x grep (or grep-find) useless.

> Style: checking exit status from format-patch, avoiding sed|grep pipeline:
>
> 	C=$(git commit-tree HEAD^ -p HEAD) &&
> 	git format-patch --stdout --signoff $C^..$C >append_signoff.patch &&
> 	awk '
> 		/^---$/ { exit; }
> 		/^Subject/ || /^Sign/ || /^$/ { print NR ":" $0 }
> 	' <append_signoff.patch >actual

Yeah, awk/perl would be fine, too, and it is good that you pointed
out that the original was losing the exit status from format-patch.

Thanks.
