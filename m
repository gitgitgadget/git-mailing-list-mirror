From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Fri, 08 Jan 2010 15:31:36 -0800
Message-ID: <7vwrzsp413.fsf@alter.siamese.dyndns.org>
References: <4B474C73.8080100@mtu.net>
 <4B4751EA.8060707@drmicha.warpmail.net>
 <20100108162404.GA5799@coredump.intra.peff.net>
 <7vr5q05z74.fsf@alter.siamese.dyndns.org>
 <20100108164132.GA6171@coredump.intra.peff.net>
 <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org>
 <7vvdfcfjxo.fsf@alter.siamese.dyndns.org>
 <7veim0w68q.fsf_-_@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 00:32:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTOJD-0003wD-JW
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 00:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab0AHXbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 18:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188Ab0AHXbz
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 18:31:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab0AHXby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 18:31:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57E7E8FF59;
	Fri,  8 Jan 2010 18:31:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kkvx5ESndDsc+KdXixuRQM9FROg=; b=ey608i
	K8S0lP5qhwuH4+0Dv3LuNpUL8jorEFDNLx4vylXx8kenOtKi/4C5vsamuHFpofkB
	7zSV6cT67fqs2nY/jR8I1wvk55af6wra8NYEPTrhfTReTpBnCfKEmp9wS96INX7g
	NQ7PcL5B0WJHlbZarLkqmzdH7zIB1Wlk+4NuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T0kpElxXOiXAvf/wCKwIFHA5Mg/2vkm4
	7zTK72ALhnSmybFQEEJAmqwcX5Lq/6sWiuGpB/Pl6WPxJn/dGKKDOD6vl6qqNmhi
	ION69pRqJo7miYGnSGMbthdZvbYOEqVbWKKT3AhUUpY5OXAzpZJ4jVePMXTt15Ye
	D1WsiPKudiE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8E968FF42;
	Fri,  8 Jan 2010 18:31:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B16E8FF3A; Fri,  8 Jan
 2010 18:31:38 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain>
 (Linus Torvalds's message of "Fri\, 8 Jan 2010 15\:24\:13 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FCC166C8-FCAD-11DE-AFCF-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136497>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 8 Jan 2010, Junio C Hamano wrote:
>>
>> Given pathspecs that share a common prefix, ls-files optimized its call
>> into recursive directory reader by starting at the common prefix
>> directory.
>> 
>> If you have a directory "t" with an untracked file "t/junk" in it, but the
>> top-level .gitignore file told us to ignore "t/", this resulted in an
>> unexpected behaviour:
>
> Ok, I'm not sure how "unexpected" this is, since arguably you are 
> overriding the ignore file by _being_ in that directory (the same way 
> index contents override ignore files), but I could go either way on that.
>
> Your patch looks fine, although I think you did this in a very odd way.
>
>> +	at = 0;
>> +	memcpy(path, path_, len);
>> +	while (1) {
>> +		char *cp;
>> +		path[at] = '\0';
>> +		/*
>> +		 * NOTE! NOTE! NOTE!: we might want to actually lstat(2)
>> +		 * path[] to make sure it is a directory.
>> +		 */
>> +		if (excluded(dir, path, &dtype))
>> +			return 1;
>
> The above starts by testing the empty string, and then after that test it 
> goes on to the next directory component. That is just _odd_.
>
> Wouldn't it be more natural to write the loop the other way around, ie 
> _first_ look up the next directory component, and _then_ do the exclude 
> processing for thoose components? 
>
> Or is there some subtle reason I'm missing for actually checking the empty 
> name?

No, just being paranoid in case somebody managed to .gitignore the
top-level of the working tree ;-)
