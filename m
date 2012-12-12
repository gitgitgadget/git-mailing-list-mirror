From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Wed, 12 Dec 2012 12:29:33 -0800
Message-ID: <7vtxrr2evm.fsf@alter.siamese.dyndns.org>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
 <7vvcc73yzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Wed Dec 12 21:29:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiswD-0007fq-1q
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 21:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935Ab2LLU3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 15:29:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245Ab2LLU3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 15:29:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 603F5A845;
	Wed, 12 Dec 2012 15:29:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DMFhjM5syGyNsCVHGFyxjpStJFw=; b=ndJDfx
	xUJBiYD1+S7SNOM+E6L8YA1XNk9YVX4qPQj9nFonT4rh8Xl/fKXhrorrS+yC4Cp3
	JdUmq742CWKKYlnLx875dYaA/EOSOC9r7APNqSYXvu+Rgmd/bfXOP1OLVZh+ZOkL
	cBuao3e4JQr/isnYSD8VQuRDavnO+PdBtryRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r5zo91JkRlneHdi+QPcdT+sKBK5Y5InY
	olUDfjCeH8F6ONEzUJmHhJUkhHMKtVdnLaxZlPcEe894oT9AF5Wfw2u56NLQ+m+1
	C+1Zj79Rw9JZkiyuRDVCYGvuRgrIxDrsBLMfpEw7oB+z1Gxp3GP7TAIgNMEwTpy0
	LqZFWs2zkjo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B7BCA844;
	Wed, 12 Dec 2012 15:29:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BB0AA842; Wed, 12 Dec 2012
 15:29:34 -0500 (EST)
In-Reply-To: <7vvcc73yzh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 12 Dec 2012 10:29:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4495248-449A-11E2-AE08-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211393>

Junio C Hamano <gitster@pobox.com> writes:

> Kevin <ikke@ikke.info> writes:
>
>> Regularly I notice that the diffs that are provided (through diff, or
>> add -p) tend to disconnect changes that belong to each other and
>> report lines being changed that are not changed.
>>
>> An example for this is:
>>
>>      /**
>> +     * Default parent
>> +     *
>> +     * @var int
>> +     * @access protected
>> +     * @index
>> +     */
>> +    protected $defaultParent;
>> +
>> +    /**
>>
>> I understand this is a valid view of what is changed, but not a very
>> logical view from the point of the user.
>>
>> I wondered if there is a way to improve this, or would that have other
>> consequences.

I forgot to mention consequences.  Changing it obviously changes the
shape of the diff, hence changes the patch id.  Anything that caches
output from "git cherry" to match up "identical patches" will need
to discard and repopulate its cache.  Your "rerere" database will go
stale.

Also "kup" tool used at k.org allows an uploader to pretend to
upload an incremental diff between two known commits by only sending
the GPG signature of the diff the uploader generates.  The actual
diff is generated on the k.org machine locally and deposited next to
the GPG signature file, with the expectation that the signture
matches the diff.  Changing the output from diff between two
versions will break the optimization and force the uploader to
upload the diff over the wire.
