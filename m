From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Coccinelle for automated refactors
Date: Mon, 06 Jun 2016 11:55:50 -0700
Message-ID: <xmqqy46iw3ih.fsf@gitster.mtv.corp.google.com>
References: <20160605205518.GA153578@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 20:56:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9zgy-0004le-0I
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 20:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbcFFSz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 14:55:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751718AbcFFSz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 14:55:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A35C22494;
	Mon,  6 Jun 2016 14:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7s1au9BeHCSdl7eFxLrXqMkQuFg=; b=QiR5Jb
	AoJ5NaVLNPav0YKBNWNTx7Dfcr2o28DXxKM4Uu89e163eP1GUVye01aTp/1NGpi7
	PgRbZAzvbKJmV1s+/8hAflg6yVtKXeN/t+wqlgKbtTF+wI8I5HAgp6pjdZ+bFKla
	9G7r55wKd3vmdcKfnqCb2rj929Rj2nae6skok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PO1Cu9k6c79WJeAzbtx4BlbEL4qAv8hP
	UqsQG5O3G39YT+1C8MbWFzwgyYDnOSQs/pWmh+nHhrc0TPzuT/36d49DcnttoA/2
	XOYcdMY4xcObt62lKHOkni59g+yIi4HkSgDXnC0x6JcYbM2d9fS8o5XTiV9Y7HlO
	x9c77ZXD25I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 61DBD22493;
	Mon,  6 Jun 2016 14:55:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D711F22492;
	Mon,  6 Jun 2016 14:55:51 -0400 (EDT)
In-Reply-To: <20160605205518.GA153578@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 5 Jun 2016 20:55:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4A4F2C36-2C18-11E6-86ED-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296550>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> An example semantic patch looks like this:
>
> @@
> expression E1;
> @@
> - is_null_sha1(E1.hash)
> + is_null_oid(&E1)
>
> @@
> expression E1;
> @@
> - is_null_sha1(E1->hash)
> + is_null_oid(E1)
>
> This does what you think it does: transforms calls to is_null_sha1 that
> use the struct object_id hash member into calls to is_null_oid.
>
> I'd like to use this for some of the struct object_id work if others
> think this is a good idea.  I feel it's likely to reduce the reviewing
> overhead and allow people to better reason about the quality and
> behavior of the sent patches.  Of course, I would still review the
> patches manually for errors and improvements, and would still accept
> responsibility for the content of the patches.

Is the plan for such a "refactor" patch to compose such a series as
two patch series:

 [1/2] automatic refactor

which gives the "semantic patch" in the proposed log message as part
of its description, and the automated result (with possible
misconversions that may have come from bugs in the automated tools),
with a separate

 [2/2] manual fixups

that corrects what was misconverted and what was missed?

As long as [2/2] can be kept to the minimum (and an automated tool
that is worth using should make it so), I think that is a good way
forward.  Another possibility would be to send the end-result as a
single patch, with description on the manual fixups in the proposed
log message, but it would be a lot more work to generate and review
such a patch, I would think.

> If there's interest, I can send a patch with a set of basic object_id
> transforms to make it easier for others to make those changes when
> they're doing work elsewhere in the codebase.
>
> [0] http://coccinelle.lip6.fr/
