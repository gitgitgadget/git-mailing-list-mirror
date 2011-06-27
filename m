From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] rebase: command "ref" and options
 --rewrite-{refs,heads,tags}
Date: Mon, 27 Jun 2011 11:36:18 -0700
Message-ID: <7vhb7bxgt9.fsf@alter.siamese.dyndns.org>
References: <cover.1309133817.git.greg@quora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Price <greg@quora.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 20:37:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbGgE-0004zD-RL
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 20:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab1F0SgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 14:36:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab1F0SgW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 14:36:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB2036A3A;
	Mon, 27 Jun 2011 14:38:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+eaATaNBfcXBF+MteGQnPlrV4YQ=; b=On1ShZ
	2rJZoC4wSb/5geEcETSdc/ujniLqajJ7eMcXWjuzfozV1SUIfeUNi5a/66DKmJcs
	dHo+9Vo/ZZ8Ry/h/wssWJ3peoLkIy9Fm8m0XUi5v0HKoLwfVmlaLbc4rLAHHv8qU
	TFrNFaFhbzhguhRDF4iaqSLRx/HtsDo/R1K0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gs3k6eIGPdue68fQEZQhcg+8SURa1Vxk
	2AMJPG0/5hYfRcjfRK1FQvJa+2DpuGUWpev/FqK2UeJVqHf3WG4LawQMohn3uECz
	B88ofhweplzciE7FjqntKM8CmY8Lg5V1DogiNS2LIIHMz4dZV1PyV/V19d+CZcTZ
	MMYeN+tSmRc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B323E6A39;
	Mon, 27 Jun 2011 14:38:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E31486A38; Mon, 27 Jun 2011
 14:38:31 -0400 (EDT)
In-Reply-To: <cover.1309133817.git.greg@quora.com> (Greg Price's message of
 "Sun, 26 Jun 2011 17:16:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A86A547E-A0EC-11E0-B64F-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176359>

Greg Price <greg@quora.com> writes:

> With this series, the command
>   $ git rebase --rewrite-heads master topic
> suffices to produce this result:
>
>         part1 part2 topic
>   A       |     |     |
>    \      v     v     v
>     B--*--*--*--*--*--*
>     ^
>     |
>     master

Thanks for a re-roll.

I notice that this does not address the "side branch" issue raised during
the original discussion. I do agree with Michael

  http://thread.gmane.org/gmane.comp.version-control.git/135601/focus=135617

that having some commits on these part$N side branches is far more common
use case that would benefit from a "rewrite together" feature like this,
than moving part$N side branches that just mark points in the topic
without doing anything on their own and makes me doubt if doing only the
parts that can sanely done within the limitation of the current rebase-i
implementation like this series does adds much value to the system [*1*].

It would be nice to have a clear definition of what _should_ happen in
this case, and a test that makes sure that that is the behaviour we get.

Starting from this topology

          1   2   topic
  A---X---Y---Z---W
   \
    B

where the change going from A to B is an equilvalent to the change going
from Y to Z, a rebase of A..W would reproduce this topology:


          1   2   topic
  A---X---Y---Z---W
   \
    B---X'--Y'--W'
	    1'  topic'

What should heppen to ref2? Should it be deleted? Should it point at Y'?


[Footnote]

*1* I suspect that dealing with side branches would require a much richer
implementation of the sequencer machinery that lets you go back to a
previous state, which we do not have right now.

While I think that it makes your series much less interesting than the
series could be that not being able to rewrite side branches, I do not
think it is reasonable to expect it be done within the current rebase-i
implementation/limitation.

With a richer sequencer, when you want to rebuild 'topic' along with 'side'
in this picture:

            D side
           /
  A---B---C---E---F topic
   \
    X

on top of X, I would imagine that your rebase-i insn sheet would say
something like this:

    detach at X
    replay B
    replay C
    replay E
    replay F
    update ref "topic" with HEAD
    detach at the rewritten C
    replay D
    update ref "side" with HEAD
