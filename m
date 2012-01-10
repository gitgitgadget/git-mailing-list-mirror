From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] gitattribute macro expansion oddity
Date: Tue, 10 Jan 2012 09:22:05 -0800
Message-ID: <7v1ur7bhhe.fsf@alter.siamese.dyndns.org>
References: <20120110070300.GA17086@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 18:22:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkfOo-00058W-T7
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 18:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330Ab2AJRWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 12:22:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181Ab2AJRWI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 12:22:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A36575312;
	Tue, 10 Jan 2012 12:22:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SKXMTJGNZoHzDV5Lu45dRlXptco=; b=tthu1M
	yk9/kbHMEZi8OkY/mNxqD9yV/PBDo4BPTktXlKIMCp4C4n/RCvHuwOet+q0iLlMI
	AvJXIFQ+tuZ2i0qThzzMzaAMnhDRNYAFRAkwSMXeUagcTJ2Wk90/rslo1H4jl0Zm
	2cG8rcFbmG8y/M7nHWhVsfcNQeAyC/CuxHmYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g4PR2/cHanhamvcli7x9wJcbl++3f765
	ksapPMty7IsddeXghvUNItSk7CsdUGYNXr/M9Dv8UbRJ/p9KY0nTFZqx6CNB23OV
	iblLMr9SD8/nr0sljmUnpXOpw1pxnT5lS7Ha2maWJ3fE5RGStUXf7qO0omdelvQR
	21pmDTm7Dzs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A3785311;
	Tue, 10 Jan 2012 12:22:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D15C5310; Tue, 10 Jan 2012
 12:22:07 -0500 (EST)
In-Reply-To: <20120110070300.GA17086@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 10 Jan 2012 02:03:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F12E3B0-3BAF-11E1-AB48-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188268>

Jeff King <peff@peff.net> writes:

> Bisection points to ec775c4 (attr: Expand macros immediately when
> encountered., 2010-04-06), but it's too late for me to dig further
> tonight. Cc'ing Junio as the author of the attr code and Henrik as the
> author of ec775c4.

Thanks for getting the ball rolling.

Regardless of this unrelated regression, after looking at what ec775c4
wanted to do again, I am very much tempted to just revert it.

It aimed to take these three

        *       ident
        foo     mybin
        bar     mybin ident

and wanted to omit 'ident' from "foo" when there is this macro definition
elsewhere:

	[attr] mybin binary -ident

But the real point of the macro was that the users do not have to know
their internals, iow, if you explicitly specify a pattern that overrides
the contents of the macro, that explicit pattern should win. When deciding
the value of "ident" attribute for path "foo", "* ident" is stronger than
"foo mybin" (the latter of which does not say anything about 'ident'
explicitly).
