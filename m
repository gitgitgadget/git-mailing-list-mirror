From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Wed, 13 Aug 2014 16:04:27 -0700
Message-ID: <xmqqiolw2dqc.fsf@gitster.dls.corp.google.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
	<1407857491-16633-2-git-send-email-jsorianopastor@gmail.com>
	<xmqq8umt5z8i.fsf@gitster.dls.corp.google.com>
	<CAPuZ2NFcJ5FFeJP=0-oG59fs=3ztenoPOGWOZKfZDdHpLGOYeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 01:04:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHhaz-00048u-TZ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 01:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbaHMXEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 19:04:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61874 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbaHMXEh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 19:04:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 823C432318;
	Wed, 13 Aug 2014 19:04:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EOvEDPrF23PckPaYBChBwewaEBE=; b=ShoMzM
	b1aQbkKtuY0N3TGVbUJNE34QmHUzJC0K0k+RfIYRBWgWLlciJuJW+qFYVniQnaIU
	SjhCKC/Gte9iWJPje7P9+pdAiDuzVTj0Moc54yoa0t+AMlFCVLHh0qD9PSitq4Lz
	kqJB7Tb5AjHKnA2Sy4SrDse6NXSegrjdKT9r0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDfVZdxkwq+iU6/vu0wj8y+8HPqZGxDF
	xdMQkV5ZpoRpcG7eE0LfHxoaKf2bCTgx73qN7kb2PrzMw3oK1WE+RGBG5kOphyH7
	uE2LoDqZJSX8Du6saHqSpC/Bf/0Uv5ihGdWjzEFZyQA6uOejWFltQpiMaM4dEExY
	SypNZAeBqVI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 784B332317;
	Wed, 13 Aug 2014 19:04:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E25832305;
	Wed, 13 Aug 2014 19:04:29 -0400 (EDT)
In-Reply-To: <CAPuZ2NFcJ5FFeJP=0-oG59fs=3ztenoPOGWOZKfZDdHpLGOYeA@mail.gmail.com>
	(Jaime Soriano Pastor's message of "Thu, 14 Aug 2014 00:10:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2DEB5E32-233E-11E4-96D8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255257>

Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:

> In the problematic cases I've seen (specially git add and git reset
> --hard) the final state of both, merged and unmerged files, is that
> only an entry in stage 0 exists.
> Also, the current implementation of git checkout -f silently removes
> higher stage entries in this case.
>>
>> Silently removing these at runtime may not be something we would
>> want to do; after all, we do not know if the broken tool actually
>> wanted to have the higher stage entries, or the merged entry.
>>
>
> Yes, I have to agree on that, the user should have the final decission
> about what stage entry to use, although I'm not sure if in the
> previously commented cases there could be such an additional loss as
> the operations that can be modified are already intended to silently
> remove stage entries.
> ...
> Which option would be better? And what could be a good message?

Being a conservative, I'd rather avoid doing any magic during
read_cache() time.  "ls-files -s" for example should show the four
stages so that the "broken" state can be inspected.

Instead, I suspect that the code paths with problematic iterations
over the index entries that assume that having stage #0 entry for a
path guarantees that there will not be any higher stage entry first
need to be identified (you already said "add" and "reset" may be
problematic, there may be others, or they may be the only ones, I
dunno), and then the most sensible one, which would be different
from case to case, among various possibilities need to be chosen as
a fix to each of them:

 (1) the loop may be fixed to ignore/skip unmerged entries;
 (2) the loop may be fixed to ignore/skip the merged entry;
 (3) the loop may be fixed not to spin indefinitely on a path with
     mixed entries; or
 (4) the command should error out.

Yes, it would be more work, but I'd feel safer if the following
worked:

	$ git ls-files -s
        100644 3cc58df83752123644fef39faab2393af643b1d2 0       conflict
        100644 f70f10e4db19068f79bc43844b49f3eece45c4e8 1       conflict
        100644 3cc58df83752123644fef39faab2393af643b1d2 2       conflict
        100644 223b7836fb19fdf64ba2d3cd6173c6a283141f78 3       conflict
	$ >empty
        $ git add empty
        100644 3cc58df83752123644fef39faab2393af643b1d2 0       conflict
        100644 f70f10e4db19068f79bc43844b49f3eece45c4e8 1       conflict
        100644 3cc58df83752123644fef39faab2393af643b1d2 2       conflict
        100644 223b7836fb19fdf64ba2d3cd6173c6a283141f78 3       conflict
	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       empty
	$ git cat-file blob :empty >output
        $ cmp empty output && echo OK
        OK

which would be impossible to do if we nuked the "problematic" stages
whenever we read the index, I am afraid.

> BTW, I didn't know "git cat-file blob 0:$path", but I only manage to
> get "Not a valid object name" fatals. How is it supposed to be used?

That was a typo of ":$n:$path" (where 0 <= $n <= 3).
