From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3?] Add global and system-wide gitattributes
Date: Mon, 30 Aug 2010 13:47:36 -0700
Message-ID: <7voccjesk7.fsf@alter.siamese.dyndns.org>
References: <vpqy6bqr3ep.fsf@bauges.imag.fr>
 <1283020870-24888-1-git-send-email-Matthieu.Moy@imag.fr>
 <87fwxxhfpp.fsf_-_@gmail.com> <7vzkw4edc5.fsf@alter.siamese.dyndns.org>
 <vpqvd6sik0n.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Petr Onderka <gsvick@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 30 22:48:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBHA-00088M-TA
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 22:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654Ab0H3UsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 16:48:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab0H3UsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 16:48:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1576D27A9;
	Mon, 30 Aug 2010 16:48:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fvu5aGv5GTSO4D//h6L+CWiq3Ho=; b=ulTej1
	ll+/f1b2AXF90eNEFUPeDnBDIzoYXs4QoRuUj2o5iD21iR3hamfHEH6nYNIjy70+
	VePiWgY3SRB4d+96fbe+RDeDUDd7JqYiIeZ5GdlYWsJn/lOgR0quT6OnTCree4AF
	wgjcpe8wiOThby67IxFT8xMnXPnouKWyPpc2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BNf+bSCpnrbGRbOX3ETZtkyPCNByuFJN
	53Xs7PIKsk2gN0SOIV3E87R7DGyJoRllQ+RP2piXybrXJMX7U8jVUia4HejvlD+k
	59ptOL7FLMhgdkoVCWm6BXN5d67QAzngtL6HZ8v7LEvD8vXTsFVq2fV/NbS+YB3p
	gyPvIrr/ZBs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73713D279F;
	Mon, 30 Aug 2010 16:47:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ED03D279A; Mon, 30 Aug
 2010 16:47:37 -0400 (EDT)
In-Reply-To: <vpqvd6sik0n.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon\, 30 Aug 2010 10\:26\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9FA7E18-B477-11DF-9A1D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154844>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I don't understand why this breaks the test. It seems blame
> --encoding=UTF-8 relies on the fact that the i18n section of the
> configuration is not loaded.

That's interesting; I haven't traced the codepath involved, but I do not
think "configuration is not loaded" is the issue. "Reading either before
the main codepath is ready, or more likely overwriting/destroying what the
main codepath has read it by re-reading the configuration" may be.

Perhaps the part that reads encoding configuration is busted and is not
expected to be called way early or way late.  In short, this patch
introduces uncertainty that config reader is called at a random and
unexpected (from the existing code's point of view) place in the codepath,
and I wouldn't be very surprised if there are similar breakages introduced
by it.

What does the callchain look like when we bootstrap the attr stack for the
first time with this patch applied?  Have we already located where the git
repository is?  Has the main codepath that wants to read encoding settings
read them?  Has the main codepath already used the command line option
that overrides the settings it obtained from the configuration file?  Is
the extra reading of the config destroying that data?

I am afraid that your patch to narrow the parts of the config that is read
from this codepath is only sweeping the problem under the rug, making the
issue harder to diagnose.  Wouldn't we see exactly the same issue if some
codepath (other than blame) wants to see a core.* configuration not to be
read in this codepath for whatever reason?
