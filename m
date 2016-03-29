From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 7/7] convert.c: more safer crlf handling with text attribute
Date: Tue, 29 Mar 2016 11:37:13 -0700
Message-ID: <xmqqr3etxh9i.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459257940-17428-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue Mar 29 20:37:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akyW4-000813-0t
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 20:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbcC2ShR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 14:37:17 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752994AbcC2ShQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 14:37:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E9084F339;
	Tue, 29 Mar 2016 14:37:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3aV1VoE3j1BX
	Hih6NHH2C+G4UZA=; b=dxH/xlIGmL4G5fU8xmjsm4wmkJYrUrQTv7sSCv8qkwS3
	2jnSYMTIk+yqwyw3z39enKeH9C+QZe+MWSbyvQsidAYAPrM+KpbAwKzwHGqzbWWd
	xBnSBgsxNYnjlNbCKQpyDqvazysYkHNpWQpP0hTeqx3OU0dGVh1I7F4w3pHzS5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GzhO/P
	0CYA0RaHc8Jz8OKeMqnM0oalkVpPEEDL2bvJ+BvKckc/Kgl3Ei/FlbCp6OkqHyOf
	Uah97WmEI2m01ytFGYPMWZASAry9XH1VReB1d6l+cdDfnb9EEaWAwhjphOhbCH6H
	Mr2Ck72bGFuYobBlJvcu5dOsulSuIHaUSnVyI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 269314F338;
	Tue, 29 Mar 2016 14:37:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 99D484F335;
	Tue, 29 Mar 2016 14:37:14 -0400 (EDT)
In-Reply-To: <1459257940-17428-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Tue, 29 Mar 2016 15:25:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 41DFE020-F5DD-11E5-B160-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290157>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> A follow-up after a discussion how to fix the flaky execution
> of t0025, gmane/$284352.
> ...
> The new handling makes sure that after running "git reset --hard".
> "git status" reports the working tree as clean regarding CRLF
> conversion.  It makes sure that the Git-internal eol conversion is
> doing roundtrip. A user can still write an external smudge/clean
> filter outside Git, which doesn't do a roundtrip and the working
> directory is not clean.

If the project (not Git itself, but I am talking about any project
used by real people) declares that the blobs in the history must be
using LF endings (perhaps it wants to be protable across two worlds)
by telling the users to set configurations so that "git add" would
do the crlf-to-lf conversion, why is it a good idea to bend over
backwards to _hide_ the fact that the index records something that
contradicts with the project policy expressed by the end-user
configuration?  If the project wants to standardize on CRLF endings
in the recorded history and some users use configurations and filters
to use LF ending in their working tree, the same argument applies.
If they by mistake or whatever adds blobs with LF line ending, that
also should be shown as a change.

I would understand if the "fix" were to make sure that the working
tree files are dirty after "git reset --hard".  If you "git add" the
files from the working tree and make a commit from such a state, you
will be changing the path in the commited history, so by definition
the working tree should be reported as dirty, shouldn't it?

I started to suspect that the flaky test in t0025 is not worth
addressing for some time ago (iow, it is testing and expecting some
fixed result where we should just declare "the behaviour is
undefined if you did so"), and especially if the best we can do is
to treat line-ending conversion something so special, it does not
sound like we are going in the right direction.
