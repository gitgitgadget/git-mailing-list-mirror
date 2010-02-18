From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Wed, 17 Feb 2010 17:20:00 -0800
Message-ID: <7vzl37z6f3.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 02:20:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhv4L-0004of-W0
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 02:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab0BRBUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 20:20:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53630 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab0BRBUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 20:20:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F33E9A44B;
	Wed, 17 Feb 2010 20:20:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NkPhn3+h6Sh6ztFWe2dPnzEjCoI=; b=ZhXw7f
	7aB/5EwoUgh//ADFV7hpDrPg5O34Y+ZicxPKh2BOZPuclI3KOSYe3xPx4gsrUwMl
	IGvqIc+ufoEysZJKCcAZWh5n6pGejz/5kcvNvFO1OG5eQEW0zW+/88qFP+6qx+LJ
	getZkjt3d3ZQY0sg7jVgDRoqPwnyf5RxgBD7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j9SRC1VjwbFJ86dUNDA94DkQJALSMnFP
	IWLBQol05ZGAUMckuK2Hb81tX/WDHKsVV9zDjVyIlT0eRsAZOoGI3+BS0+wK1YAe
	zh4hC0V/LVg5Xtt6+vRr9kH1omYO6zz79Zt4V1lG4DsSWwHiedAbhkutXi5kLcvp
	UFsTiV5W8Rk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3F59A449;
	Wed, 17 Feb 2010 20:20:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FD2A9A43D; Wed, 17 Feb
 2010 20:20:15 -0500 (EST)
In-Reply-To: <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 17 Feb 2010 17\:16\:23 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCE8D330-1C2B-11DF-8891-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140278>

Junio C Hamano <gitster@pobox.com> writes:

> But the nature of breakage caused by such an abuse is rather bad.  We will
> end up with loose object files, whose names do not match what are stored
> and recovered when uncompressed.
>
> This teaches the index_mem() codepath to be paranoid and hash and compress
> the data after reading it in core.  The contents hashed may not match the
> contents of the file in an insane use case, but at least this way the
> result will be internally consistent.

With a small fix to the test program earlier in the thread, this seems to
protect the repository; I didn't bother to assess the performance impact
of the patch, though.

Here is the corrected test.

-- >8 --
#!/bin/sh
set -e

# Create an empty git repo in /tmp/git-test
rm -fr /tmp/git-test
mkdir /tmp/git-test
cd /tmp/git-test
git init

# Create a file named foo and add it to the repo
touch foo
git add foo

# Thread 1:  continuously modify foo:
while echo -n .; do
	dd if=/dev/urandom of=foo count=1024 bs=1k conv=notrunc >/dev/null 2>&1
done &

# Thread 2:  loop until the repo is corrupted
while git fsck; do
	# Note the implied 'git add' in 'commit -a'
	# It will do the same with explicit 'git add'
	git commit -a -m'Test' || break
done

# Kill thread 1, we don't need it any more
kill $!

# Success!  Well, sort of.
if git fsck
then
	echo Repository is corrupted.  Have a nice day.
else
	echo Repository is still healthy.  You are stupid.
fi
