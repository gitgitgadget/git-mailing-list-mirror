From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How can I tell if a file has been updated upstream?
Date: Fri, 05 Feb 2010 08:50:21 -0800
Message-ID: <7vk4urbp9u.fsf@alter.siamese.dyndns.org>
References: <ed82fe3e1002050823gec57827j184c9c4cff4f4a45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 17:50:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdROA-0005SW-Kl
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 17:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab0BEQub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 11:50:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab0BEQu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 11:50:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9B7A9727F;
	Fri,  5 Feb 2010 11:50:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tabi8vFZ9VJHOwGwaFLid9BXUVI=; b=K0DFG9
	W5IuGQp6jbX2pKqTIKjtu44ggIDwcx90dHQwyDT87oSWOmag6vKkX1zRIckZMHVf
	4u2cIrnWxTBr56kfDTZGkwz23DiJP9KF3dIUhIEQ53eklFVAOiri30/PyrBLZUtV
	J31CX7ZtJtQfvW9d+i69awxbvRhb4WJk3yyts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A9EQ3QI9PkDlWC10kz4nFckbErFbRY98
	netCHlb0LwEfh+jmIzt3yVy5YH/PcM+xHTwqa5ny//hPl2eZmkgNwAGTaYIPUi5F
	fRBzRg0m+g8ey3JZ97JMthhQM0ejHMMa+Ik9k7k2Hoz/W4N4t5TcPdpDm9hxaW8a
	BgS7Xl2hZw4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9373197279;
	Fri,  5 Feb 2010 11:50:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA10097277; Fri,  5 Feb
 2010 11:50:22 -0500 (EST)
In-Reply-To: <ed82fe3e1002050823gec57827j184c9c4cff4f4a45@mail.gmail.com>
 (Timur Tabi's message of "Fri\, 5 Feb 2010 10\:23\:11 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8ECEA584-1276-11DF-9812-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139057>

Timur Tabi <timur@freescale.com> writes:

> The reason I ask is that I have a set of Python scripts that I
> distribute via git (other people in the company clone my repository).
> I want my script, every time it's run, to check if an update is
> available, and ask the user to do "git pull".

So whenever I run your script it calls home, spend a roundtrip time, and
nags me to update?  I don't want to be working with you unless I can go
without running that script less often than once a week ;-)

You need to teach it how to call home.  How do your users "clone"?  Some
over git://, some others over ssh://, yet some others over local
filesystem?  Also how do they run the script?  Directly out of the
repository work tree, or is there a "make install" step involved?

If your users are running from the work tree copy unmodified, then you
would need to look at sys.argv[0] to find out where it is, use that to
find the repository, and using its .git/config learn how the user pulls
from your repository (i.e. git config remote.origin.url), and at the same
time which version it is (i.e. git rev-parse HEAD).  If "make install" is
involved, then you would hardcode the necessary information during the
build process to the script your users would run.

At runtime, you would run "ls-remote HEAD" and compare with the version
you are running.  It may be stale, or it may not be.

How big is the script?  It _might_ be faster to distribute a launcher that
downloads the real script every time it runs and runs that fresh copy that
is guaranteed to be the latest than doing all the hassle of the above.
