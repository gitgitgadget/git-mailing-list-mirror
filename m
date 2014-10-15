From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is only temporary
Date: Wed, 15 Oct 2014 10:29:24 -0700
Message-ID: <xmqqwq81w8az.fsf@gitster.dls.corp.google.com>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>
	<543E85FA.6050404@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 19:29:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeSOO-0003AP-5H
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 19:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbaJOR3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 13:29:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750758AbaJOR3c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 13:29:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AFF3C14B57;
	Wed, 15 Oct 2014 13:29:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CloWOXOBheE/7sWWceuv+lbge4c=; b=mdkExT
	K+IXbprpEpDwYxQOY4f6tBcSwLPVMLdu2VWEIG2gp57+byuFp4RM/o8r9Zg7y74y
	A5r40EL++uF+vyLN7RfG1dR+jyV+EnbFFPlbc5DevvDhibKZi1f+EaJSjj4UQhTs
	+QZ3F6KeliATo7V65trT7KBMthfBYbCg5n4lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QhlcF+REAcS0+x3xDPg28sxtYubFzfDR
	/q4ygImY0jqwXhekR1loQ8TvAjSCQfnAns5Ug7LCqvl47RclZbABxflbi5mdr9fq
	pJkOTQDYZlinM/Z2pkRZPYFXZ2p2ny1V3Y+XaV6CYMEKDsdOUwtxncrOKrwrsCvb
	hX+mPymFnK8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A732F14B56;
	Wed, 15 Oct 2014 13:29:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2937F14B55;
	Wed, 15 Oct 2014 13:29:26 -0400 (EDT)
In-Reply-To: <543E85FA.6050404@xiplink.com> (Marc Branchaud's message of "Wed,
	15 Oct 2014 10:34:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CF87E174-5490-11E4-96DE-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

> I think things would be more understandable if the option was "--dissociate
> <repository>" and was an explicit alternative to --reference:
> 	[[--reference | --dissociate] <repository>]
>
> I'm still not liking the name "--dissociate" though.  The original suggestion
> of "--borrow" is better.  Perhaps "--library" or "--local-cache"?  I dunno...

I was not thinking when I originally started the topic with
"--borrow", until I realized that it would not make much sense,
primarily because we allow multiple references.

What should this command line do, and how would you implement such a
behaviour?

    $ git clone \
        --reference=/local/pool/linux.git \
        --borrow=../my/neighbour/linux-hack.git \
        git://git.kernel.org/...../linux.git

With "do the usual --reference thing, but then dissociate the result
from referents" option, there is no ambiguity and that is why I did
not go with the "--borrow" option suggested in the original thread.

> So now I'm wondering if the implementation would be more efficient as an
> extension of the --local operation.  That is, instead of a post-clone repack,
> do a --local clone first followed by a simple "git fetch" from the source repo.

The network overhead may be comparable to the "--reference"
optimization, but if your "clone --local" ends up copying (instead
of hard-linking), the initial cost to copy locally would be a pure
extra price over "clone --reference and then --dissociate".  If the
local clone uses hard-linking, it would be cheaper, but it still
costs more than dropping an entry into .git/objects/info/alternates,
I would imagine.  You will pay with your scheme the same cost to run
"repack -a -d", which is paid by "--dissociate" at the end of clone,
eventually at the first "gc", so there is no efficiency advantage,
either.

The above is my knee-jerk assessment without any measuring, though.
