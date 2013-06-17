From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Sun, 16 Jun 2013 19:38:32 -0700
Message-ID: <7v7ghtjwbb.fsf@alter.siamese.dyndns.org>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
	<87ip1e2tzx.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 17 04:38:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoPL7-0004hf-46
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 04:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123Ab3FQCih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 22:38:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45978 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754996Ab3FQCig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 22:38:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA6121D7BF;
	Mon, 17 Jun 2013 02:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EdeyYXxUXWxGBLSmOYXKeXfL+i0=; b=ZuQuuk
	DNlvpqmNvCXK1IhjKw4bCmhFBalJl77d3qFuz3g981x3bUoY+iMiXyy4TaLIauvM
	P7BKjfm5Y1Q/nY2m6rf/+avAmAS3MznvnijLxIdsw170XG5dqmY7dgU5p2cFu/Qp
	flVfzRz8ej442Mj17ilGaygOFDTiPGEVtte3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gArNXPYWxTL83x8zVIBaObT8NYGjJek0
	l713id66raKecyyQrzHbGdHEsOTN61M1OE5q0dY+opRPmUpwu8JulgGFZ5nCiKGV
	1qgyAPII3BUb45whbA8IifK9929o6AfyavkpwhMEGtMf6UQSsuMf/nt1fwmbE6eV
	re5cVAjo0fU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90A641D7BE;
	Mon, 17 Jun 2013 02:38:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C675D1D7BB;
	Mon, 17 Jun 2013 02:38:34 +0000 (UTC)
In-Reply-To: <87ip1e2tzx.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Sun, 16 Jun 2013 13:08:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01B1D2EA-D6F7-11E2-9F61-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228032>

Thomas Rast <trast@inf.ethz.ch> writes:

> Isn't it a bit of an academic question?
> ...
> And once you have that, it seems a nicer and cleaner idea to generate
> 'fixup! A' each time, instead of a successive sequence of
>
>   fixup! A
>   fixup! fixup! A
>   fixup! fixup! fixup! A
>   ...

As to reordering, you are absolutely correct.

If you are going to apply all three anyway, then the end result
either does not change at all (when none of them overlap textually),
or you will end up with unnecessary conflicts (when they do).

But if you were to pick (and drop some), all three labeled with
"fixup A" vs later ones having more "fixup" in front will make a
difference in identification and usability.  When you want to drop
the second fixup, "fixup fixup A" can be chosen unambiguously in
your editor among "fixup A", "fixup fixup A" and "fixup fixup fixup
A".

It also somewhat feels wrong when the user sees this:

    $ git log --oneline -2
    xxxx A
    yyyy fixup! A

and asks to do this:

    $ git commit --fixup yyyy

and if you end up with "fixup! A", not "fixup! fixup! A".  The user
is asking to follow-up on the "fixup! A", not on the original "A".

Does dropping these leading "fixup!" (or "squash!") at commit time
make the application in "rebase -i --autosquash" significantly
easier to do?
