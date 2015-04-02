From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Thu, 02 Apr 2015 15:58:50 -0700
Message-ID: <xmqq7ftugms5.fsf@gitster.dls.corp.google.com>
References: <20150302092136.GA30278@lanh>
	<xmqqr3szql9r.fsf@gitster.dls.corp.google.com>
	<xmqqd23pq6r3.fsf@gitster.dls.corp.google.com>
	<1935847.zk75T7vt7M@mfick1-lnx>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 00:58:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydo4f-000777-Sz
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 00:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbbDBW6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 18:58:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752315AbbDBW6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 18:58:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E314644DD2;
	Thu,  2 Apr 2015 18:58:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=48yvDWkoUZzNTCshcir9eCkvq/c=; b=AD76oi
	KGhF95Tsf9Zv21kvAkWahZy/E/GfmXU6seH7jUFvqj6qgzEUbMF7hilQkY4vC4Vb
	Mi/yfGMONXtBYulFJ2n18jQehTuOGHRufXJWjnS1/P3l4meH3xdftpmvkmMvi4g1
	HJhdTRLMrYQWWR7S6I0bnVelz1ShvAa/PEizU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ghNSK3EnWzSqtqCw8QO9yaplAWt5JU8H
	wtvX8FuQ6/q+YYZh4ykyhCDH9Blm1BLFfyWMWTRVYWXodDZus5ae+/xuVYc4UDSP
	ROD5xRIQYTB2cs/FEGMI5ckOzCxEtlB7EXQxx4fpoUssCYz4Ix54f7FweRa6lV6X
	5gSs5Kr99OA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DCA2444DD1;
	Thu,  2 Apr 2015 18:58:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6649F44DCD;
	Thu,  2 Apr 2015 18:58:51 -0400 (EDT)
In-Reply-To: <1935847.zk75T7vt7M@mfick1-lnx> (Martin Fick's message of "Thu,
	02 Apr 2015 16:18:22 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D45A3BFE-D98B-11E4-8CA1-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266690>

Martin Fick <mfick@codeaurora.org> writes:

>> The current protocol has the following problems that limit
>> us:
>> 
>>  - It is not easy to make it resumable, because we
>> recompute every time.  This is especially problematic for
>> the initial fetch aka "clone" as we will be talking about
>> a large transfer. Redirection to a bundle hosted on CDN
>> might be something we could do transparently.
>> 
>>  - The protocol extension has a fairly low length limit.
>> 
>>  - Because the protocol exchange starts by the server side
>> advertising all its refs, even when the fetcher is
>> interested in a single ref, the initial overhead is
>> nontrivial, especially when you are doing a small
>> incremental update.  The worst case is an auto-builder
>> that polls every five minutes, even when there is no new
>> commits to be fetched.
>
> A lot of focus about the problems with ref advertisement is 
> about the obvious problem mentioned above (a bad problem 
> indeed).  I would like to add that there is another related 
> problem that all potential solutions to the above problem do 
> not neccessarily improve.   When polling regularly there is 
> also no current efficient way to check on the current state of 
> all refs.  It would be nice to also be able to get an 
> incremental update on large refs spaces.

Yes, incremental ref update is an important problem to solve.  I
think one potential solution was indeed mentioned to improve that
exact issue, e.g. footnote #3 in $gmane/264000.
