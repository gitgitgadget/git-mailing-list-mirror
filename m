From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] completion: be nicer with zsh
Date: Sun, 29 Jan 2012 21:50:44 -0800
Message-ID: <7v4nvdeo23.fsf@alter.siamese.dyndns.org>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
 <1327880479-25275-2-git-send-email-felipe.contreras@gmail.com>
 <7v8vkperli.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 06:50:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrk8i-00087u-NW
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 06:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab2A3Fus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 00:50:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937Ab2A3Fur (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 00:50:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C9B278F4;
	Mon, 30 Jan 2012 00:50:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ozLdB0cWJjCD3m+8F/CvrTyqdgM=; b=hFIess
	WpQDZ6ffqTFZbdrlQMh4Jh3IxB+DZXJalQQpaeHVgeg/zComIntupOgwR7SPHTFa
	RqDNbUMaNJW78HnrZkwOi67cv+5FZdhKKXoRImVlDmHehz4NFNywVQOHMdWeGmyY
	JmbjTK0+UwnNHn6l8f6tvq09LsLU6WHfkgceo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BjOvrzrxQAIPnydI2bCwMoKUUPGbCfi5
	UVtSmb6R95nx++7udEqoREH36C6WUrlkp/LZhb0qvwk3TVHitnldB2WjFfDY0ylZ
	yl9WPBa6qyR4HkXZME10I4w6u7LNclUKTCk2+5pHEjM05YcjO91msYWiHYEi6XIb
	k+ySVv5KRZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94BCC78F3;
	Mon, 30 Jan 2012 00:50:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 295E478F2; Mon, 30 Jan 2012
 00:50:46 -0500 (EST)
In-Reply-To: <7v8vkperli.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 29 Jan 2012 20:34:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AB9240C-4B06-11E1-9657-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189323>

Junio C Hamano <gitster@pobox.com> writes:

> Avoiding zsh's bug that cannot use conditional assignment on the no-op
> colon command (if the bug is really that; it is somewhat hard to imagine
> if the bug exists only for colon command, though) *is* by itself a good
> justification for this change, even though the resulting code is harder to
> read for people who are used to read shell scripts.

Just from my curiosity, I am wondering what zsh does when given these:

	bar () { echo "frotz nitfol xyzzy" }

	unset foo; : ${foo:=$(bar)}; echo "<$?,$foo>"
        unset foo; true ${foo:=$(bar)}; echo "<$?,$foo>"
        unset foo; echo >/dev/null ${foo:=$(bar)}; echo "<$?,$foo>"

The first one is exactly your "And yet another bug in zsh[1] causes a
mismatch; zsh seems to have problem emulating wordspliting, but only when
the ':' command is involved.", so we already know it "seems to have
problem emulating word-splitting" (by the way, can we replace that with
exact description of faulty symptom? e.g. "does not split words at $IFS"
might be what you meant but still when we are assigning the result to a
single variable, it is unclear how that matters).

Note that I am not suggesting to rewrite the existing ": ${var:=val}" with
"echo ${var:val} >/dev/null" at all. Even if "echo >/dev/null" makes it
work as expected, your rewrite to protect it with an explicit conditional
e.g. "test -n ${foo:-} || foo=$(bar)" would be a lot better than funny
construct like "echo >/dev/null ${foo:=$(bar)", because it is not an
established shell idiom to use default assignment with anything but ":".

Thanks.
