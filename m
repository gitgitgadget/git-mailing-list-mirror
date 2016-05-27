From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t7610-mergetool.sh test failure
Date: Thu, 26 May 2016 23:33:27 -0700
Message-ID: <xmqqshx4row8.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
	<CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
	<20160525231615.GC2634@sigill.intra.peff.net>
	<20160526015114.GA12851@sigill.intra.peff.net>
	<20160527044027.GA26143@gmail.com>
	<20160527050054.GA25774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 08:33:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6BKy-0001iP-Si
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 08:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbcE0Gdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 02:33:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753966AbcE0Gdb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 02:33:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D3C7146F4;
	Fri, 27 May 2016 02:33:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ymbi41jIE3h4afeaQyi2WwXE84M=; b=V/ulMS
	/HWKlDHT3WVN/ixd7K16nWnob6wL4ZygoGr1IVC5jfIfUybUM6yvh5O+6lxxncom
	HPuDnwMj08RaEWZ9UhvIa9zsk/dK42EO/LfTMVedrO/AOH39l8nClH1uhrih2RLx
	MnQ7IqKxqe/Hq2dOehMQDWOcvzT+YhDtacYSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O1W0GnRxONXZX9CLUxEkRmcFamY4K2Cx
	8A8PvCAZt+wVEt8aeOm9efn/jBgD7BcmG94GWTPr5CwMxgFgciyOhdYHxU56328R
	kpFYa2DuCf+9dUDHMUYyYi1oIYdU1BdE8ORssxHzIdnqB1wth7R7VujqE1BCmPDp
	iqb/rhhtGLQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 34CBB146F3;
	Fri, 27 May 2016 02:33:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4797146F2;
	Fri, 27 May 2016 02:33:29 -0400 (EDT)
In-Reply-To: <20160527050054.GA25774@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 27 May 2016 01:00:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ECFEA6EC-23D4-11E6-9821-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295737>

Jeff King <peff@peff.net> writes:

> The only one I can think of is that if something leaves cruft in
> $TMPDIR, it could affect later tests that want to `git add`
> indiscriminately.

Or "git ls-files -u", "git clean", etc.  I'd mostly worry about a
failed test in which a program dies without a chance to clean up
after itself, and letting the cruft affecting the next test.

> OTOH, I do not think putting things in /tmp is hurting anything. I was
> mostly just surprised by it.

Moving TMPDIR into somewhere under t/ would force us to do more work
to clean things up, and it would probably be a good thing in the
longer term.

I just checked my /tmp, and I see a lot of directories whose name
look like mktemp generated one, with a single socket 's' in them.  I
wouldn't be surprised if they turn out to be from our tests that
expect failure, killing a daemon that does not properly clean after
itself.  People probably would not notice if they are in /tmp, and
if we moved TMPDIR to the trash, we still wouldn't (because running
tests successfully without "-d" option will remove the trash
directory at the end), but if it were dropped somewhere in the
source tree, we have a better chance of noticing it.
