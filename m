From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] fetch-pack: mention server version with verbose
 output
Date: Mon, 13 Aug 2012 14:09:32 -0700
Message-ID: <7v628mcxdf.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
 <7v393uif9g.fsf@alter.siamese.dyndns.org>
 <7vboieehrf.fsf@alter.siamese.dyndns.org>
 <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org>
 <20120813205423.GA31630@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:09:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T11tP-0000iy-Cj
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 23:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab2HMVJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 17:09:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab2HMVJe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 17:09:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F95F8A04;
	Mon, 13 Aug 2012 17:09:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ANY1TjBPcKtDe1zE/+t9fZp3rQE=; b=N06UR/
	mVc7yT8i1iM+61GjOtpoir1HoU8rYyvDDugA5jJcflAD9t2vhJ279dQyzmo/9iuD
	8GihxMXQ8HHvBF6/6i0Ostm6IeLxJb1F4bsXFwvGp08f8BQieV3FJ3z61CnEr3fH
	yTb2cJuXlMUlwhOmd9yWZ4ccWI/EgOd6pTTFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AiLnc6z20AwsKUPs+mj4Ri9KlIUix9i7
	CIHe+x37tQVFvS1geQahrXfTvMU4W8smGJMMPRfOoXcYoaTtzcGeZLyWTFDHcMvP
	37ZCmxeuKiwpQt4TowBnPKqY0KXMHIMWYvzlyhZFSK/0lHC4uyVsSBQmXSywvO2a
	2EP/cNNFdAo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E6808A03;
	Mon, 13 Aug 2012 17:09:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C80628A02; Mon, 13 Aug 2012
 17:09:33 -0400 (EDT)
In-Reply-To: <20120813205423.GA31630@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 13 Aug 2012 16:54:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E538E3C-E58B-11E1-8C06-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203367>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 13, 2012 at 12:07:35PM -0700, Junio C Hamano wrote:
>
>>  * And this is your 4 adjusted for the previous one, releaving the
>>    caller from having to figure out where the capability string
>>    ends.
>> [...]
>> @@ -829,8 +831,15 @@ static struct ref *do_fetch_pack(int fd[2],
>>  			fprintf(stderr, "Server supports ofs-delta\n");
>>  	} else
>>  		prefer_ofs_delta = 0;
>> -	if (server_supports("agent"))
>> +
>> +	if ((agent_feature = server_feature("agent", &agent_len)) != NULL &&
>> +	    5 < agent_len && agent_feature[5] == '=') {
>>  		agent_supported = 1;
>> +		if (args.verbose) {
>> +			fprintf(stderr, "Server version is %.*s\n",
>> +				agent_len - 6, agent_feature + 6);
>> +		}
>> +	}
>
> Yeah, this is exactly the kind of ugliness I was trying to avoid with my
> allocating wrapper. Still, there is only one call site, so I do not care
> overly much (and I as I've already said, I'm lukewarm on the final two
> patches, anyway).

Actually, the above is vastly superiour compared to the allocating
kind.  Be honest and think about it.  If the caller wants to
allocate, it could, and it does not even have to count.  If the
caller does not want to allocate, it does not have to pay the price.
