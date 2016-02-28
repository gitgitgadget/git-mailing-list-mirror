From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: fix unadvertised requests validation
Date: Sun, 28 Feb 2016 11:14:17 -0800
Message-ID: <xmqqr3fwejg6.fsf@gitster.mtv.corp.google.com>
References: <1456577034-6494-1-git-send-email-gabrielfrancosouza@gmail.com>
	<xmqqd1riggd7.fsf@gitster.mtv.corp.google.com>
	<20160227190712.GC12822@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 28 20:14:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa6nQ-0005ti-Rk
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 20:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbcB1TOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 14:14:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754548AbcB1TOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 14:14:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 948024747C;
	Sun, 28 Feb 2016 14:14:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kOQzbXlpehDO3BDKi8P/+OgNxAI=; b=qIIVWA
	cYyJUnTm8KbFNYuM+tmZygbeEZBVIIg1ooEWtpg60GIkLkZff7porOXnYqO1BwGg
	6kQBSZjCWR21IG5sAJr7GkrmX71utPaARuXJ2s48X3am/BjvAaeD0yXtzVgsj0gS
	x7fjBgmO5YPYQC3y/8BnQJosT3gWpc9l2pVWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NInhZl7cBg2MFMALL/g8lyLU4Cxnib7S
	bHA61PMSjuCByylpLqNRt8T+/v5CDuSUPC/QiDDsnbZoP/5iJp0wRyxPd1uuUbDU
	C1t2eXzcYWgy6JFc9HWhq2nzjyND/iB5A57u6InTN1yawkb2TFPRVX7f1oxKlxkF
	paVDebTnbeg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8BBCE4747A;
	Sun, 28 Feb 2016 14:14:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB5DF47479;
	Sun, 28 Feb 2016 14:14:18 -0500 (EST)
In-Reply-To: <20160227190712.GC12822@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 27 Feb 2016 14:07:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77499616-DE4F-11E5-A16D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287785>

Jeff King <peff@peff.net> writes:

> So the patch:
>
>> > diff --git a/fetch-pack.c b/fetch-pack.c
>>...
> is a wrong direction, I think. It removes the extra safety check that
> skips the ref above. But worse, in the example above, it overwrites the
> real object "1234..." with the name of the ref "abcd..." in the sha1
> field. We'll ask for an object that may not even exist.
>
> The commit message for Gabriel's patch says:
>
>> > Check was introduced in b791642 (filter_ref: avoid overwriting
>> > ref->old_sha1 with garbage, 2015-03-19), but was always false because
>> > ref->old_oid.hash is empty in this case. Instead copy sha1 from ref->name.
>
> but I don't think ref->old_oid.hash _is_ empty. At least, that was not
> the conclusion from our discussion in:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/265480
>
> We expect whoever creates the "sought" list to fill in the name and sha1
> as appropriate. If that is not happening in some code path, then yeah,
> filter_refs() will not work as intended. But I think the solution there
> would be to fix the caller to set up the "struct ref" more completely.

Ah, I forgot that thread completely.
