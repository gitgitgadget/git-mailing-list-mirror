From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reacting to new commits in a poll-mirror
Date: Tue, 02 Feb 2010 17:32:03 -0800
Message-ID: <7vzl3rt88c.fsf@alter.siamese.dyndns.org>
References: <20100202220234.GA17107@lapse.rw.madduck.net>
 <20100203011050.GA23249@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 02:32:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcU6M-0008On-VA
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 02:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969Ab0BCBcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 20:32:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab0BCBcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 20:32:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6DB896FA7;
	Tue,  2 Feb 2010 20:32:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m/vHXWAe2N1VXeKKYD8izNj83/o=; b=oT0bL5
	HuWYlI1vmbqJapcs2JtWTSjl66kGpDBdKWUp9G7g2Xz55Iqhn0CsntodHB2N0Kr6
	31zCQvXXC5U3gAKlPkXuGiTQKZIhJ8xwrTA0EEZGzUBXemesOYUalokFliJJfm9t
	++kObA+fYRuhDD9e4ZdFvItSZG/ct52nOaSIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z5YJ/3b5pegt3vFKkFypdlG5bPXN2P1V
	TQBjvxg77WRP2qJBZeXcNMif/mKG8WSMekaoVOG4S5P85pl454qVEJHx+mNMnftT
	dJL4xHJC/mlZnaMabyfkF4o1vMWE0oidgcLQtxgAQT/VLtyqJ+UyhOm/RnkfS9c1
	9xWczK/Afqc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB18996FA6;
	Tue,  2 Feb 2010 20:32:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F39B396FA5; Tue,  2 Feb
 2010 20:32:04 -0500 (EST)
In-Reply-To: <20100203011050.GA23249@lapse.rw.madduck.net> (martin f.
 krafft's message of "Wed\, 3 Feb 2010 14\:10\:50 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F11B694E-1063-11DF-B179-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138798>

martin f krafft <madduck@madduck.net> writes:

> also sprach martin f krafft <madduck@madduck.net> [2010.02.03.1102 +1300]:
>> I am trying to set up Patchwork-Git integration on host A for
>> a project whose Git repo is on host B. I thought I could use
>> a mirror (git clone --mirror) on A and regularly fetch from B, but
>> I cannot find a way (hook) to make Git on A react to new commits it
>> fetched from B.
>
> One way is to have a mirror on A, as well as a second repo: first,
> fetch to synchronise the mirror, the push to the second repo, where
> the post-receive hook will get executed. Works, but it's hackish.
> I'd much rather have hooks react right away to the fetch.

Sorry, but I don't understand the motivation.

You are the one with a desire to know "what new things I got by 'git
fetch' I am going to run right now".

And most importantly, that "right now" is under complete control of you.

Unlike post-receive hook that was invented as a way to be triggered by an
action done by somebody else, iow, an action you (the hook owner) do not
control at all, you do not need any hook around fetch to do what you are
trying to do.  You know when you run fetch.  You are the only one who
updates that repository A.  Until you decide to fetch, nothing will change
in the repository A.

So I don't see what you find wrong about writing your script like:

    #!/bin/sh
    before_fetch=$(git for-each-ref --format='%(objectname)') &&
    git fetch || exit

    git rev-list --all --not $before_fetch |
    while read rev
    do
	do your patchwork magic...
    done

It seems (at least to me) to be exactly the way git plumbing layer was
designed to be used.
