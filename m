From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between shorthand names and full refnames
Date: Sun, 12 May 2013 23:45:04 -0700
Message-ID: <7v8v3jqsy7.fsf@alter.siamese.dyndns.org>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-4-git-send-email-johan@herland.net>
	<7vmwrzsck1.fsf@alter.siamese.dyndns.org>
	<CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 13 08:45:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbmVr-0001ok-3s
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 08:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab3EMGpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 02:45:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48358 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809Ab3EMGpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 02:45:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E29F61B089;
	Mon, 13 May 2013 06:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TCc2tEoh1lkacsjb1C3ITYYaJWU=; b=hNRdoe
	UPyqghz4Tix3IcJ5dd/FWhaV/jDKH+5e9T+IqgOv77M16hUOzw1XOCjSS1xFHN/3
	9N0kHXep4a0XGT9QxujnUQyH3ItNFMjHiSln0/C/TFLh5ek16cEfExLmsS4DDtkm
	Hscnf0UtKERbEJcPwLlH9Uu3G0RDqCHGxD24E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XMZUBk14TxrLvuuWd9NIhm26rgxrg8lu
	yutQAIhPYVtLtoVlRjPr0s8Qlu7q5rIrP1keuIiy7+vDWkC09hw8ZoC/9Gq9xvHS
	KOQxFnbgcNStm91Ir/OKbKuREam6UlLaIfkB0EZkI03/XFdeD6+0UdP7L/vio/oC
	u+2AML3bkVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D514E1B088;
	Mon, 13 May 2013 06:45:06 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C6361B086;
	Mon, 13 May 2013 06:45:06 +0000 (UTC)
In-Reply-To: <CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com>
	(Johan Herland's message of "Mon, 13 May 2013 08:31:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5A7FC82-BB98-11E2-B869-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224095>

Johan Herland <johan@herland.net> writes:

> Obviously, I named it '%1' since it expands into the _first_ component
> of the (slash-separated) shorthand.

OK, I can buy something like

	%*
        refs/%*
        refs/heads/%*
        ...
        refs/remotes/%*/HEAD
        refs/remotes/%1/%2
        refs/peers/%1/heads/%2

that is, for a pattern that has %*, we feed the end-user string as a
whole, and for a pattern that has %1 thru %N, we find an appropriate
way to chop the end-user string into N pieces (e.g. nick/name would
be split into %1 = nick, %2 = name, while foo/bar/baz might have two
possibilities, <%1, %2> = <foo, bar/baz> or <foo/bar, baz>).  The
earlier ones on the above list can even be written with their %*
substituted with %1 if we go that route.

And that makes perfect sense, and is exactly the kind of "you plan
to have %2 and %3 that falls into the same category as %1" I was
asking you about in the message.

So, no more objection to %1 from me, if that is the direction you
are taking us.
