From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/17] grep: read -f file with strbuf_getline_crlf()
Date: Mon, 04 Jan 2016 11:30:48 -0800
Message-ID: <xmqqmvslnnvb.fsf@gitster.mtv.corp.google.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
	<1450303398-25900-1-git-send-email-gitster@pobox.com>
	<1450303398-25900-17-git-send-email-gitster@pobox.com>
	<alpine.DEB.2.20.1601041321360.14434@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 20:30:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGAqE-0005qZ-V3
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 20:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbcADTaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 14:30:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751408AbcADTau (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 14:30:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19F1C36D5C;
	Mon,  4 Jan 2016 14:30:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=66gv6bpr9TWzEWJCGVl2u2+Mbd8=; b=wdo5CL
	IaphZgjOnV7YKb1ERU+m/vrfo08lzA9ffCwAegG3KZqTZVLvm4UU0ooTjYaBtadr
	nRjFwyOPEqM16Eehidu6CLuW/lgFr2qmJRa7jG51H+wMQyC5U1ux1CQ/Nay/gz9Y
	MJy3VOqkY45QoNJxj49450OO6JkN5YZQVCyVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tqxQlfRoRkD5Sot0Qgl0P9ToMXiZadZr
	gccZHh0PxC7bQZgE9HU0tPq0cmkoMPmLAXFPyq33T7d7teuXUON2wobYjNhokf9k
	gIBJOmQGyHhWJTfJhk14AjGoEV8UKfD0x7METwBb2KJQ16vk55MYxW25Gf03+fCK
	wSiITCygrok=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1034A36D5A;
	Mon,  4 Jan 2016 14:30:50 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 86E7436D59;
	Mon,  4 Jan 2016 14:30:49 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601041321360.14434@virtualbox> (Johannes
	Schindelin's message of "Mon, 4 Jan 2016 13:27:44 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A901219E-B319-11E5-AE7B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283319>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Having said that, `grep` operates on lines of text,

Correct.

> and CR is established as a non-text byte,

Correct but only if you are a pedant.

With this patch, you can no longer find "A<CR>" on a "line" that is
"A<CR><LF>", which is a regression on a system whose native line
ermination convention is to use a single LF at the end.

The thing is, users know "grep -e '<a non-text byte>' finds hits
with a line with the non-text byte, and telling them that they
shouldn't rely on the feature would not make the world a better
place.

This patch limits the damage by restricting the special casing of CR
only at the end of the line just before LF, so we can still find
"A<CR>B" on a "line" that has a non-text byte, e.g. "A<CR>B<CR><LF>"
or "A<CR>B<LF>".  It is just a <CR> at the end of the line (with or
without any other string before it) for which we see a regression,
and I suspect that it would be a small enough price to accept to
help those who would need to work with <CRLF> systems.
