From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ls-files -X option is relative to repo root
Date: Fri, 13 Feb 2015 14:02:10 -0800
Message-ID: <xmqqy4o1lbbx.fsf@gitster.dls.corp.google.com>
References: <CAG4vEKM-2sy0z3=YLS+rgH99w6ukdcNBode9CAh4C4t9eSa02A@mail.gmail.com>
	<xmqqmw4hmtlw.fsf@gitster.dls.corp.google.com>
	<xmqqiof5mt0q.fsf@gitster.dls.corp.google.com>
	<CAG4vEKP760_sq1fsJD_1jjz0_G+T8NosSXDqx0bvQy4tPVz5JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Daniel Finnie <dan@danfinnie.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 23:02:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMOJb-00057M-OL
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 23:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbbBMWCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 17:02:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753281AbbBMWCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 17:02:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D2BA34476;
	Fri, 13 Feb 2015 17:02:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h2HU57WcPTnps8a18lSfjkThXf0=; b=tL91m5
	GqFSmE9F+XeQrj+S2AakTs4913lKdcXnltt9e9G7B98CFqURT9hT34IUJIJWzL4d
	V6skAhUi9NNF6i9/WWkEYkVhcK92MAfESNvv6ct83Senk5jjOWoM8YShrt4QUFjO
	k4E48GeXqw+KEz/hQB4V0cI04IvqQa2GXoQFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KNRCZHmMGUsbWkAGAr7F/Gya053mrVbV
	gdFBYvQ/1N2n/yK0LyS1gJbV5Mp+C78dr/JkMeU4uthEM860CNLEUFkdE5SFxFIQ
	YaaFlS8R4KHFwBTDykHaGKTEeX5iMbeUdCRMZ28F5UOjnigLnhAzEn+S7VdTtReE
	OGd+c1eZEgc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0249734475;
	Fri, 13 Feb 2015 17:02:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7068234474;
	Fri, 13 Feb 2015 17:02:11 -0500 (EST)
In-Reply-To: <CAG4vEKP760_sq1fsJD_1jjz0_G+T8NosSXDqx0bvQy4tPVz5JQ@mail.gmail.com>
	(Daniel Finnie's message of "Fri, 13 Feb 2015 16:19:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F5FD0D44-B3CB-11E4-B68B-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263843>

Daniel Finnie <dan@danfinnie.com> writes:

> Do you have any comments on why the path in --exclude-from=<path> is
> relative to the project root?

Not really.

Because ls-files was designed to be used by Porcelain scripts, and
because the first thing Porcelain scripts are expected to do is to
learn the prefix and then cd to the root level of the working tree
before doing anything else, <path> that is relative to the root
level of the working tree ends up to be not so unnatural thing to be
used with --exclude-from=<path> (e.g. ".git/info/exclude").

If it were relative to whatever subdirectory the invoker of the
Porcelain script happened to be, Porcelain would have to do a lot
more (e.g. in "cd x/y && myPorcelain ../../.git/info/exclude", the
myPorcelain script would first have to learn the prefix is x/y, go
up two levels, and then strip two ../ from ../../.git/info/exclude
to turn it into .git/info/exclude when it runs ls-files).

So that is a convenience explanation in retrospect, but "Why" is
often a futile question to ask when talking about evolution, in
which whatever works gets picked.
