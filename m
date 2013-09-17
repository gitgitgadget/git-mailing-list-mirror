From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bisect needing to be at repo top-level?
Date: Tue, 17 Sep 2013 12:20:50 -0700
Message-ID: <xmqqioxzxnjh.fsf@gitster.dls.corp.google.com>
References: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com>
	<xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com>
	<20130917175813.GA14173@blizzard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Burton\, Ross" <ross.burton@intel.com>, git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Tue Sep 17 21:21:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM0pc-0000ok-Es
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 21:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058Ab3IQTUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 15:20:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47711 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921Ab3IQTUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 15:20:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A53742A19;
	Tue, 17 Sep 2013 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U11pMCbRkxie0EuyaRJmcR0Jdx0=; b=S55u4x
	qNaNoNUpg0x77JZl5C/58u9dpjGYgRaTo/mW/jQDkUhdFzmhFIuyxKNRm0ox5nfI
	UpM9Hf72YqaWEmnuD/dCVosKtKUG4d29eFw9PSTi0qDn2OMp7m2YN7G30ugxCy0J
	ayCDxKSX2KLLVHm/DOHi9BTbIEbMFGXxqn2i4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IM1JC89l3+rlP381cuzlnOlXNFguQd09
	MyHHJcXgXFLfWB89iXm9BW8YJCyUP2UM5EhGNCAqC/Cm4+T4wENBqT9S6GN40Pht
	9XSj63iUwrvdZ+vOFnDt8h3RL/lyazblk0Fb39NA85Z8rI5bMx0nITyaGvqmNgWg
	QJzufagTMq8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DEB442A18;
	Tue, 17 Sep 2013 19:20:53 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 704AB42A14;
	Tue, 17 Sep 2013 19:20:52 +0000 (UTC)
In-Reply-To: <20130917175813.GA14173@blizzard> (Lukas Fleischer's message of
	"Tue, 17 Sep 2013 19:58:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 44876A1A-1FCE-11E3-8777-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234905>

Lukas Fleischer <git@cryptocrack.de> writes:

>> Imagine if you start from a subdirectory foo/ but the directory did
>> not exist in the older part of the history of the project.  When
>> bisect needs to check out a revision that was older than the first
>> revision that introduced that subdirectory, what should happen?
>> Worse yet, if "foo" was a file in the older part of the history,
>> what should happen?
>
> If that is the real explanation,

No.  As the line you snipped from your quote says, it is just a
guess without running "git log -- git-bisect.sh git-bisect-script".

Also it points at things one needs to watch out for and think about
when attempting to update "git bisect" to make it possible to run it
anywhere in the working tree.

> why do we allow running git-checkout(1)
> from a subdirectory?

Oversight?

At least on Linux, if you checkout a revision with "foo/" directory,
chdir to it and then checkout a revision with "foo" file to nuke
your current place, I know "git checkout" will happily do so and you
will still be in a directory that is connected nowhere.  Your ".."
is probably pointing at the top-level, but there is no reverse, so
"cd ../foo" may or may not work from that state, and it would lead
to an interesting confusion.

We may want to check the condition and forbid such a checkout.
