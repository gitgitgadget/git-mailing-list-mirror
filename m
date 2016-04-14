From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] format-patch: add '--base' option to record base tree info
Date: Thu, 14 Apr 2016 09:23:17 -0700
Message-ID: <xmqq37qoi2h6.fsf@gitster.mtv.corp.google.com>
References: <1460342873-28900-1-git-send-email-xiaolong.ye@intel.com>
	<1460342873-28900-3-git-send-email-xiaolong.ye@intel.com>
	<xmqq7fg2r6fi.fsf@gitster.mtv.corp.google.com>
	<20160414142333.GA31621@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Ye Xiaolong <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 18:30:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqkAL-0003dz-K7
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 18:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbcDNQao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 12:30:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932183AbcDNQan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 12:30:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6093813B45;
	Thu, 14 Apr 2016 12:30:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jo9ae/VtyxTEXjIUkiRqb9NQ/44=; b=Yy+3Jv
	vSVs1ewxJg3c4ZC0TClbnS0QHYliyXOwzARisMLdGo8FuVrDh7y4s1sUJVz7dE7Q
	T1dO/mmBa/xMktUiHZh1SrPXashBilMY/Gq2N2G1QJIO/4NjrtlFLLjSh56k86hR
	AMxFPmkjo6rwaWRW/Tb5gmK42Q0xnvSopRUqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i4GSfPoqb53CIObCm3BwY4/Mc7IL0eSc
	fuFYhoa//NnkXeDddZepdR3lD6O/RQUPLmiXKuvDqZoY5OMIGG4E6KQboV2VoKNJ
	D0exNV336q/9fA1h8OFgSbxxM/TQ5AM6IdfnasGuvrn8O+TOaRsPFujacfwoKFra
	iXk8LwetGVk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56AA013B43;
	Thu, 14 Apr 2016 12:30:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3083313A6B;
	Thu, 14 Apr 2016 12:23:19 -0400 (EDT)
In-Reply-To: <20160414142333.GA31621@yexl-desktop> (Ye Xiaolong's message of
	"Thu, 14 Apr 2016 22:23:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32FEC710-025D-11E6-8AF9-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291532>

Ye Xiaolong <xiaolong.ye@intel.com> writes:

>>> +	for (i = 0; i < total; i++) {
>>> +		if (!in_merge_bases(base, list[i]) || base == list[i])
>>> +			die(_("base commit should be the ancestor of revision list"));
>>
>>This check looks overly expensive, but I do not think of a more
>>efficient way to do this, given that "All the commits from our
>>series must reach the specified base" is what you seem to want.
>>
>>My understanding is that if base=P is given and you are doing
>>"format-patch Z..C" in this picture:
>>
>>    Q---P---Z---B---*---C
>>     \             /
>>      .-----------A
>>
>
> How about we compute the merge base of the specified rev list in
> cmdline (it should be Q in above case), then check whether specified
> base (P in this case) could be reachable from it, if it couldn't, we
> just error out.

What commits are you considering "the specified rev list in cmdline"
in the example?  Do you mean "commits in the list[], i.e. those to
be shown as patches?"

That is, you are proposing to find the topologically-youngest common
ancestors of A, B and C, which is Q?

There is no canned way to compute that (merge_bases_many() is not
that function).

You however can do repeated pair-wise merge base computations to
reduce the complexity from your O(n) loop to O(log n), I guess.  Do
a pair-wise merge base between A and B (which is Q), and do a merge
base between C (which is the remaining one) and Q to arrive at Q.
