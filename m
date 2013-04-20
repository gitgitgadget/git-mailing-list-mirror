From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] upload-pack: ignore 'shallow' lines with unknown obj-ids
Date: Sat, 20 Apr 2013 13:51:40 -0700
Message-ID: <7v7gjxx6w3.fsf@alter.siamese.dyndns.org>
References: <CAJDSCnN6Ekp3wF9hX9Dbt3+CLNg1_aBz8nPGUuCu0WS9MF8aXA@mail.gmail.com>
	<CACsJy8B6OYC-Qcwc53BsVtUSHw1ag6LWF2rBSP6agO6yTXQo+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Heemskerk <mheemskerk@atlassian.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 22:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTel9-0007O4-Jz
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 22:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab3DTUvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 16:51:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755026Ab3DTUvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 16:51:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37D6F18181;
	Sat, 20 Apr 2013 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K4Y87W4wmRedW1FY6OvfuELKmuE=; b=bRpgrn
	RDNvH+i5yTTNmOIrJFwW4tIh7q53kilDPug/c81TOokwVQ2E/yYMcoMLFhkVzw8i
	DnzOunBPCRKN9uoZLLFK392Q94Uj9vNW0B7S17vDDsmamTnzgYBx6wlYipqnVQQs
	HtBKkFii3CnbrgAeolbB5xN1XKI4K3dd7qWNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xI1wv25lXpVvEkGW5DVo5vgFsQOoUlfL
	a2BfSWxLM+3WeUC+ODyvd/QOziuO7kkqTfMUS8BMqd2acq10QAJhpNrzsNuizjGk
	+xEk1rvKYyQRSPeB6yE6zArUnf5rrv7+PV8i3az76CslTNP6/sRhaoU285mAVUD7
	gvc5xFRn5mo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FC6C18180;
	Sat, 20 Apr 2013 20:51:42 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96C761817F;
	Sat, 20 Apr 2013 20:51:41 +0000 (UTC)
In-Reply-To: <CACsJy8B6OYC-Qcwc53BsVtUSHw1ag6LWF2rBSP6agO6yTXQo+g@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 20 Apr 2013 20:34:41 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A843934-A9FC-11E2-A512-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221875>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Apr 20, 2013 at 8:05 PM, Michael Heemskerk
> <mheemskerk@atlassian.com> wrote:
>> When the client sends a 'shallow' line for an object that the server does
>> not have, the server currently dies with the error: "did not find object
>> for shallow <obj-id>". The client may have received the object from a
>> different server, or the object may have been garbage collected by the
>> server. In either case, the object is not relevant for calculating the pack
>> that is to be sent and can be safely ignored.

For the purpose of generating a pack, these shallow boundaries are
irrelevant.  The above describes only that part.

But the shallow list is also used to compute the updated boundary
(i.e. "this client does not have a valid history behind these
commits")?  When we know their current shallow boundary, after
sending history that crosses that boundary, we can tell them "before
this fetch, you did not have any history behind this commit, but we
know that you now have a bit more. Update your record with these new
boundaries. You still do not have any history behind these commits."
That is how deepening works.

When you receive a shallow boundary unknown to you, it might not
hurt if you keep it and parrot it at the end, so that the fetcher
will still remember that it does not have any history behind the
commit.  There may be reasons why doing so is not sufficient and we
have to reject clients whose history is truncated at a place unknown
to us.

You would declare "now you have everything behind that unknown
shallow boundary", if you ignore an unknown shallow boundary and do
not send it back.

That sounds ourright wrong to me. You simply do not know enough to
make such a declaration.

I do not seem to find the patch you are responding to, so I do not
know how the patch handled the unshallowing part, but the impression
I got from reading the log message quoted is that the patch was not
even aware of the issue.
