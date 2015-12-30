From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: git bisect merge to usable base
Date: Wed, 30 Dec 2015 12:09:26 -0800
Message-ID: <xmqqsi2jem15.fsf@gitster.mtv.corp.google.com>
References: <CALCETrUgsawpwkkjO_BpPHyOaH7NsJNU-4mF97a6NAxCMB5aUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 21:10:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEN4Q-0007QA-QY
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 21:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbbL3UJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 15:09:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752118AbbL3UJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 15:09:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC575361E7;
	Wed, 30 Dec 2015 15:09:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aictQg58T5dfRSIBxLtBH61+K/8=; b=blp2Qs
	PwY9fe5bbuyHvYDId9apbQnTkFTfj/k4ShEYCJLKsCYsKPL/1e2GAiUzZye4dDT3
	g8Gt2jV9I6WxHeDNSRV2D+3wIysvgB/HGFn/Yjeo2wKcOTVXabXTCP0dLu8QGBhB
	V4ne+2+8KQa2odcuDxRChiEl0H+uVEBstmVVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O1fLftOiB4mGcjGM21MOZ/E4HISEPVcO
	e2IyxRGLDJVG4piqBdLFt465vRuXSSwyeJeXK+ACyHrNXdNtJijDxpUESUTpUI8Z
	BwgI8fw/Uc1LCi3tur5VEgAkZ4iS1C46UwDQG7HHt8VxaIJnDVFsK1HTI7V+9zcb
	Q6OYXZEwjP0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C39C2361E6;
	Wed, 30 Dec 2015 15:09:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4317B361E4;
	Wed, 30 Dec 2015 15:09:27 -0500 (EST)
In-Reply-To: <CALCETrUgsawpwkkjO_BpPHyOaH7NsJNU-4mF97a6NAxCMB5aUA@mail.gmail.com>
	(Andy Lutomirski's message of "Wed, 30 Dec 2015 02:40:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3A68FD10-AF31-11E5-ADD2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283194>

Andy Lutomirski <luto@kernel.org> writes:

> I'm currently bisecting a Linux bug on my laptop.  The starting good
> commit is v4.4-rc3 and the starting bad commit is v4.4-rc7.
> Unfortunately, anything much older than v4.4-rc3 doesn't boot at all.
>
> I'd like to say:
>
> $ git bisect merge-to v4.4-rc3
>
> or similar.  The effect would be that, rather than testing commits in
> between the good and bad commits, it would test the result of merging
> those commits with v4.4-rc3.
>
> Obviously the syntax could be tweaked a lot, but I think the concept
> could be quite handy.

I do not think such an option or "concept" belongs to "git bisect".

When "git bisect" checks out a commit to test, it is entirely up to
you how to decide if the commit is good or bad.  Your example is to
work on the Linux kernel project, so the way to test might be "make
mrproper && make bzImage && ... && reboot" to see if the result
boots.

There is nothing that prevents you from changing the test procedure
to be prefixed by "if the version to test is older than version X,
merge the commit to version X first before doing anything else".

The key thing to realize is that "merge the version X" is not
universally useful "fixup" to deal with unbuildable or untestable
commit.  In some situations, "I have this fix-up patch I need to
apply for versions that are older than Y before I can test" may be a
lot more appropriate "fixup".  So "merge-to" does not deserve to be
the first-class "concept".

"Here is a script to fix up the tree that 'git bisect' tells me to
test" instead might be a general enough concept, and you might say

	$ git bisect --fixup "./my-fixup-script"

and have "git merge --no-commit v4.4-rc3" in "my-fixup-script",
perhaps.

But at that point, it would be as easy as adding whatever you would
write in my-fixup-script at the beginning of the script you are
already using (and if you aren't, read up on "git bisect run") to
perform the test.  So...
