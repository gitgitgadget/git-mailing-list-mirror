From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Thu, 15 Apr 2010 05:30:17 -0700
Message-ID: <7v4ojclwyu.fsf@alter.siamese.dyndns.org>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
 <7vfx2xpyam.fsf@alter.siamese.dyndns.org> <4BC6B5FF.6030406@viscovery.net>
 <7vochlkvtg.fsf@alter.siamese.dyndns.org> <4BC6D30F.5020004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 15 14:30:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ODI-0006di-Fz
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 14:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab0DOMa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 08:30:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab0DOMa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 08:30:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30C18AA07C;
	Thu, 15 Apr 2010 08:30:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9+kdiPsAvEjEW18kLMo0vHuPckM=; b=e+EVqr
	0xEQ1092t0w4sSco35EIOm1zAeRGHNJXxsxe3iZ5uKWW+JUbUTgtW8GjSa+881OI
	Anvz0wry5lBTganhRUMwRIrX3NLVdM/cR9b6Q9edi8W8R/LKyE+cGFdnvDpIRreJ
	hUORFZUg4GMYmQCrSL8YLTKIE1mQa6COXNKRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a5tQN+wWA21OAq6ngHbqFqlBckOXyQqw
	CjlpQg4jsUnfnI3QEvAwFvAWHXtHod8tfBZmWES63/TZtQnIEMpd7nQ7Yq0ZyeJi
	6NWUhDRByTU63lxXywMtkVmvk/65s7rv4hAsRhMa42TMwTG2Ur+KsGWyb5kEuOzZ
	iW40EoFkqtA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09FDFAA07B;
	Thu, 15 Apr 2010 08:30:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F2F0AA079; Thu, 15 Apr
 2010 08:30:19 -0400 (EDT)
In-Reply-To: <4BC6D30F.5020004@viscovery.net> (Johannes Sixt's message of
 "Thu\, 15 Apr 2010 10\:49\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8DB58E2-488A-11DF-BCD8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144976>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 4/15/2010 9:40, schrieb Junio C Hamano:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> Does not help what? What is the problem?
>> 
>> You will lose the record from HEAD reflog that records the fact that you
>> were at the tip of "next" less than "reflogexpire" but more than
>> "reflogexpireunreachable" time ago, if you run "gc" while on "master".
>> 
>> Such a pruning does not have much to do with the real reason why
>> expireunreachable would be a useful thing (namely, to prune failed
>> histories that have been rewound away faster than the history that
>> survived from reflog of individual branches).
>
> But what is the benefit?

That is a funny thing to ask.  Since when not losing information is a
lower priority?

> We expire reflogs so that we can garbage-collect objects.

I am tempted to say "Wrong!", but would stop at saying "We seem to have
differing opinions" for now.

A reflog consists of entries, each of which records how you got to the
current history by pointing to different commit objects.  Some entries
matter more than others do.  Dead-end experiments stop mattering faster
than others.  It is these _entries_ that we expire, because keeping them
indefinitely is a wasteful clutter.

Removing stale objects is not a goal; objects are removed merely as an
effect of them becoming stale after no refs and reflog entries that matter
point at them.
