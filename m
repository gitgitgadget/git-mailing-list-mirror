From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] interpret_branch_name bug potpourri
Date: Wed, 15 Jan 2014 13:03:35 -0800
Message-ID: <xmqqsisp0xg8.fsf@gitster.dls.corp.google.com>
References: <52D5C296.7050906@lge.com>
	<xmqqvbxm2kmg.fsf@gitster.dls.corp.google.com>
	<20140115050003.GA27237@sigill.intra.peff.net>
	<20140115082528.GA18974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 22:03:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Xcq-00085u-Bk
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 22:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbaAOVDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 16:03:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbaAOVDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 16:03:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B78F064D5A;
	Wed, 15 Jan 2014 16:03:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IMXpPRNSTqAToZBjIj81A89v3QI=; b=vLumEi
	NRyQ1jyRwJ++1qNfy0tppZ1eqtjGSkAM141+tDiSg8DHGHa5j6bv4X+x0G8AlSb1
	4pcEc0jEP3tk35SAwkSDr/o7tPzq8Bri/GYBFtS4oSMMLa6+MGa4PCZImHKBYKdB
	p+rR0LMUN6tuGkng7K44HInEdREp0BEEIv32M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DMvIDbVhFtuL/c0sh6/qsm3jDKxgDtIq
	TMA4nQJRTIeevCXxazKiDOhJmDvkdGJ1HX03trnFjKLVX+hjhfwHhvDtTjKUQgi1
	yzDM57LHq7Gdf/aSRs1t0DrrhfsCQd0Cg5PqJP475Q1LoGIq4BUULyNsEN3bSPa6
	ciw1gLRwvjg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A064664D59;
	Wed, 15 Jan 2014 16:03:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C21EF64D56;
	Wed, 15 Jan 2014 16:03:37 -0500 (EST)
In-Reply-To: <20140115082528.GA18974@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2014 03:25:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 80ECDCDE-7E28-11E3-91DD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240478>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 15, 2014 at 12:00:03AM -0500, Jeff King wrote:
>
>>   $ git rev-parse --symbolic-full-name HEAD@{u}
>>   refs/remotes/origin/master
>>   $ git rev-parse --symbolic-full-name @mybranch@{u}
>>   @mybranch@{u}
>>   fatal: ambiguous argument '@mybranch@{u}': unknown revision or path
>>   not in the working tree.
>> 
>> So I do think there is a bug. The interpret_branch_name parser somehow
>> gets confused by the "@" in the name.
>
> The "somehow" is because we only look for the first "@", and never
> consider any possible marks after that. The series below fixes it, along
> with two other bugs I found while looking at this code. Ugh. Remind me
> never to look at our object name parser ever again.
>
> I feel pretty good that this is fixing real bugs and not regressing
> anything else. I would not be surprised if there are other weird things
> lurking, though. See the discussion in patch 4.
>
>   [1/5]: interpret_branch_name: factor out upstream handling
>   [2/5]: interpret_branch_name: rename "cp" variable to "at"
>   [3/5]: interpret_branch_name: always respect "namelen" parameter
>   [4/5]: interpret_branch_name: avoid @{upstream} past colon
>   [5/5]: interpret_branch_name: find all possible @-marks
>
> -Peff

All the steps looked very sensible.  Thanks for a pleasant read.
