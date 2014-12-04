From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in reflog of length 0x2BFF
Date: Thu, 04 Dec 2014 14:14:50 -0800
Message-ID: <xmqq388vrrj9.fsf@gitster.dls.corp.google.com>
References: <547C8610.8080301@cs.uni-saarland.de>
	<20141201233515.GV6527@google.com>
	<xmqqvblrrwxu.fsf@gitster.dls.corp.google.com>
	<5480C60E.3070903@cs.uni-saarland.de>
	<20141204215805.GD19953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christoph Mallon <mallon@cs.uni-saarland.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 23:14:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwefp-0004MR-43
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 23:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbaLDWOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 17:14:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753014AbaLDWOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 17:14:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1178923895;
	Thu,  4 Dec 2014 17:14:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9H3P7/0BIRr3qPl/vPZczlxiSl0=; b=oeOdB8
	foXug+gdGcV1AcXSuKtTW0Tzoq6Uro4N0o871YqqUViUYXew4Yi/37afNxFNqO14
	rGN3O8SEl5+/uJYXve7ZaUlpktF3+obAFmxXzOTxbYa8pzX/RrI5Lw7zKqA/Ff+2
	f8MbBFGZTEA5et/WKL8dnTNHMoyej9kNWdz94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=boChLzuEd+8GrKMAZ+0VKg3TS0rh6Yn0
	kLZQGRrxu6bbVemqp74IIxmh457de8WDTjCRh4EMqz8IE/wny7pffOZsMx7Bnooa
	zXev5Fm9rNCuRLaBDQA0SrynaIiSDriohh80K9flxHAZ8Axv9S5UEo/xYgd8Eb2h
	L5CMhzLP1QI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0484523894;
	Thu,  4 Dec 2014 17:14:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7002923892;
	Thu,  4 Dec 2014 17:14:51 -0500 (EST)
In-Reply-To: <20141204215805.GD19953@peff.net> (Jeff King's message of "Thu, 4
	Dec 2014 16:58:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7A77BE4-7C02-11E4-8751-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260809>

Jeff King <peff@peff.net> writes:

> I think the bug is in the reverse-reflog reader in
> for_each_reflog_ent_reverse. It reads BUFSIZ chunks of the file in
> reverse order, and then parses them individually. If the trailing
> newline for a line falls directly on the block boundary, we may not have
> it in our current block, and pass the line to show_one_reflog_ent
> without a trailing newline.

Ahh, thanks for helping spot it.  A code that uses BUFSIZ explains
why a single reproduction recipe is platform dependent.

> So this is a long-standing bug in for_each_reflog_ent_reverse. It just
> showed up recently because we started using that function for
> read_ref_at_ent.
> ...
> The above is a workaround. I think the right solution is probably to
> teach for_each_reflog_ent_reverse to makes sure the trailing newline is
> included (either by tweaking the reverse code, or conditionally adding
> it to the parsed buffer).

Sounds correct.  Unfortunately I no longer remember how I decided to
deal with a line that spans the block boundary in that piece of code
X-<.
