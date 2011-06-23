From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] protobuf: minimal implementation for compact
 in-memory structures
Date: Thu, 23 Jun 2011 10:22:31 -0700
Message-ID: <7vliws31k8.fsf@alter.siamese.dyndns.org>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
 <1308728011-14136-2-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 19:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZnoD-00026s-Hj
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 19:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793Ab1FWRe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 13:34:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932783Ab1FWRWe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 13:22:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 836BF5FCB;
	Thu, 23 Jun 2011 13:24:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KymgSNmsdO+jN/4FfUIXWSTFy24=; b=qmv7UY
	qjlNt9k40hM6yihQ/NZPJGkajgxWw8+xzUCRO8355PczhkYZbii8RDH+n9TbxB6I
	4SN2pJgaBHBSR4axmEQv8FWqlSCpJOCi0ywbfBbv2CR/X0bLyOES5AIYk5+mRmSx
	FnP8nEbPn636p7zcG6h5LJVRj7k5lpP2NwWtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LyBc2h711LIrjkSxnBsLv9ROB7NSVolb
	CBg5nj+7H1s2BQrn31oH+Orku3Cl3Jr414Ocb5RkP4+yCaLbXnSOV98Qjx3elfFI
	qT0qrwkqcv7bZJzV4s8GicjSJOsTe+LJHULV+5FueDAQaEVPPWg8iqdshNH6ONpx
	N7bqBP7EJ1Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B35E5FCA;
	Thu, 23 Jun 2011 13:24:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C4E1E5FC9; Thu, 23 Jun 2011
 13:24:44 -0400 (EDT)
In-Reply-To: <1308728011-14136-2-git-send-email-davidbarr@google.com> (David
 Barr's message of "Wed, 22 Jun 2011 00:33:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFFDEBBA-9DBD-11E0-812E-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176285>

David Barr <davidbarr@google.com> writes:

> One struct to capture all types, just 4 methods: decode_message,
> encode_message, sizeof_message, hash_field.

Adding to the review from yesterday, hash_field() looked quite out of
place. If you are going to implement a hash table that holds protobuf
objects in a separate file/module, I would imagine the function belongs
there, not here.

> +uint32_t hash_field(const struct protobuf_field *field)
> +{
> +	uint32_t hc = 0;
> +	switch (field->type) {
> +	case WT_VARINT:
> +	case WT_64BIT:
> +		hc = (0x9e3779b97f4a7c15ull * field->val.num) >> 32;
> +		break;
> +	case WT_SHA1:
> +		memcpy(&hc, field->val.bin.ptr, sizeof(hc));
> +		break;
> +	case WT_STRING:
> +		hc = x65599(field->val.bin.ptr, field->val.bin.len);
> +		break;
> +	case WT_32BIT:
> +		hc = 0x9e3779b9ul * (uint32_t)field->val.num;
> +		break;
> +	}
> +	return hc;
> +}

It all depends on how you envision a "hash table of protobuf objects" is
to be used, but what is the point of using a complex math for 64BIT/32BIT
integer values? If you plan to have different kinds of protobuf objects
thrown into a single hash table, it may make sense, but without a crystal
ball it was kind of hard to judge.
