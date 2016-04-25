From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Supporting .git/hooks/$NAME.d/* && /etc/git/hooks/$NAME.d/*
Date: Mon, 25 Apr 2016 10:45:45 -0700
Message-ID: <xmqq4mapmvjq.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:45:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auka2-0000LC-5J
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933132AbcDYRpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 13:45:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933071AbcDYRpt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 13:45:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0606D14FEB;
	Mon, 25 Apr 2016 13:45:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6AIEBJb5sy9n
	uU0arba1dfgDbvo=; b=FMBc5qijNzIETCY24ksjjFN4Oa177W6h/85GDXKXeLLx
	hmmicV9sEQOYmuUSSSWyh+ywF0HqFu6JuRy6f9coXMgypjlpsNdXDZsQacBLfk2c
	1/RKJCUPbCzpusXVduKtUadCwipHII14oHsZF7k7Dx8Mh12qUOEW313QvC8Uwb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Lr9F8R
	cen5G8MOYnv7OtlJOK8ZhiGJon5gamHcqdGiYX1bxdTRpMtc9nVM8xJxLePPbHC0
	/dzWzJ6vUxBFv4WIfzqJxTSQjLDef51DmL4C/8A2L315eCWSFq0FssvU667EHvab
	Ergd6AaKJyFWd3sc5wyZoTrDQMrPgAxcDJ4Fk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F2FC914FEA;
	Mon, 25 Apr 2016 13:45:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61C4814FE9;
	Mon, 25 Apr 2016 13:45:47 -0400 (EDT)
In-Reply-To: <CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 23 Apr
 2016 01:51:06
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8AE4DF6A-0B0D-11E6-88C1-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292533>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The reason for supporting the *.d directories was that I spotted a lo=
t
> of hooks people had hacked up at work using the pee(1) command[1] to
> run sequences of other unrelated hook commands.

IIRC, we wanted to do this several years ago but after discussion
decided that we didn't want to have this in the core, because we
didn't want to hardcode the policy on interaction among multiple
hooks.

You can easily resolve the ordering of hooks--just declare that they
are executed sequentially in strcmp() order of filenames and users
will know to prefix them with fixed-number-of-digits to force their
desired ordering without complaining.

What is harder and the core part cannot unilaterally dictate is what
should happen after seeing a failure/rejection from a hook.  Some
hooks among the remainder would not want to be even called.  Some
others do want to be called but want to learn that the previous
hooks already have decided to fail/reject the operation.  There may
even be some others that cannot be moved to earlier part of the hook
chain for other external constraints (e.g. side effect of some
previous hook is part of its input), but would want to override the
previous decision to reject and let the operation pass.

I am happy to see that the idea brought back alive again, but I
think we prefer this start its life clearly marked as "highly
experimental and subject to change", then invite interested and
brave users who tolerate backward incompatible changes to
experiment, in order to allow us to gauge what the right semantics
and flexibility the users would want.  One way to do so may be an
opt-in configuration variable e.g. "experimental.multiHooks";
another may be to implement the logic as a pair of scripts (one for
the command line argument variant, the other for stdin variant) and
ship them in contrib/.

The latter approach (i.e. scripting) might be easier for people to
experiment and tweak, and in the olden days that would certainly be
the approach would would have taken, but I am not too afraid of
appearing uninviting to casual scripters anymore these days, so...
