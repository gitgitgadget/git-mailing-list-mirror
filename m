From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's the difference between `git show branch:file | diff -u -
 file` vs `git diff branch file`?
Date: Mon, 29 Aug 2011 14:09:25 -0700
Message-ID: <7v62lf6i2i.fsf@alter.siamese.dyndns.org>
References: <loom.20110823T091132-107@post.gmane.org>
 <CACsJy8DMqjMfb5wVMnsrZhP8yv2rF1wyQ6LM6b-PVcYY1SXkcQ@mail.gmail.com>
 <loom.20110829T155805-331@post.gmane.org>
 <CACsJy8Dar5i3Fn+rhOq78vdsqRL4D+RNUc5G64BM-6DvKC=L5w@mail.gmail.com>
 <7v1uw46srf.fsf@alter.siamese.dyndns.org>
 <7vty9054qr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 23:09:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy95Q-0005Qw-R4
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab1H2VJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 17:09:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412Ab1H2VJb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 17:09:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C37C8436B;
	Mon, 29 Aug 2011 17:09:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hkXNkjsn6MfgqnN68tTLCCF6QP0=; b=SBj6mM
	conyFWoM8pxut9ZFSJoai7gYkmwNa+B89RpHfEihgwvmxyIARtDNqrJFTtejKn1W
	AvFL4Z+4EMEdmO0XX24r1VCBVAJa25yos+ozM0N2yd12FmABsF1FqEDRMvPsWdTJ
	ZO2lEFYdMdhmdgIpoxnm5WMrqJ003pGk4deyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mjpHyBexuVb84ca4Xre4AzpFMkNA2Cxk
	R0NESSV/SkCd266VLK1gcdxE+fsIOM79yoFAqgRv90ng2wL/CvN7HjZsRxMq3AQs
	PUX0S67u7sK/Lfo1N633we5yG50R2KAGYYOPHy5T2VUyjLBwbwvoQO6GUFATU7c7
	7JWpDcJXAlc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B925F436A;
	Mon, 29 Aug 2011 17:09:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 497994369; Mon, 29 Aug 2011
 17:09:27 -0400 (EDT)
In-Reply-To: <7vty9054qr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 29 Aug 2011 13:42:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DDCF4A0-D283-11E0-BF00-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180353>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Of course the merge machinery does not know anything about pruning with
>> pathspec, so it is understandable (not justifiable) it would walk the full
>> tree.
>>
>> Will try to find time this week to cook up something.
>
> This is still rough, but seems to pass the test suite, and gives me some
> performance boost when applied to the kernel tree:
>
>     (without patch)
>     $ time git diff --raw --cached v2.6.30 -- virt/kvm
>     real    0m0.114s
>     user    0m0.088s
>     sys     0m0.028s
>
>     (with patch)
>     $ time ./git diff --raw --cached v2.6.30 -- virt/kvm
>     real    0m0.075s
>     user    0m0.068s
>     sys     0m0.008s

Heh, this is even better without --cached.

    (without patch)
    $ /usr/bin/time git diff --raw v2.6.27 -- net/ipv6
    real    0m0.538s
    user    0m0.492s
    sys     0m0.048s

    (with patch)
    $ /usr/bin/time git diff --raw v2.6.27 -- net/ipv6
    real    0m0.038s
    user    0m0.028s
    sys     0m0.012s
