From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log: why are --full-diff and --pickaxe-all separate options?
Date: Wed, 24 Mar 2010 10:19:15 -0700
Message-ID: <7vy6hhr624.fsf@alter.siamese.dyndns.org>
References: <76718491003240852m2a2c12afjca2c71f6c78b2047@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 18:19:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuUEr-0003QL-JQ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 18:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab0CXRTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 13:19:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58277 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab0CXRTW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 13:19:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDA44A4FCE;
	Wed, 24 Mar 2010 13:19:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ASEHs9d9PbfepXoeWxPPgWMMTMw=; b=Cl2qE65ZRviNeqrL0KnS0FH
	gO3LR6zw3G8+P4M0QPWt3V0lB0RLnpNSblGvRoF4XLrY4ALNzMzwtc0pRK9QxeiE
	3Q5+M+MHlXwSZtZPuGMfRUrkPErkVoPrVXJGffcML9VkfNPhQjxtUADaeNF57+f1
	EnGCcSu/gjdxsadLKnbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RnmOA/R6XIWqyIqJmoL7SP2yXAqqLpTPmz/g89u6ICdb/U9Bv
	faWuWomc94wVdHCR7j2m8Do3aT1N5ip3WOi16nWjsHj8/Q1SbQTxRdQIL6qbmhLU
	TAkl++U9Khi5zEJiT7CWmE6NtlslT5oVVW3c7K1luDtFxDRcGPYYU4FFsI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B02E2A4FCD;
	Wed, 24 Mar 2010 13:19:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C14ABA4FC9; Wed, 24 Mar
 2010 13:19:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 61C8AE82-3769-11DF-B6E0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143096>

Jay Soffian <jaysoffian@gmail.com> writes:

> But now I wonder why these are separate options. Is there any reason
> they shouldn't be unified?

They do entirely different things, and It does not make any sense to
"unify" them.

But it would be an improvement to make them work better together.

 - Erroring out when --pickaxe-all is given without -S would make sense;

 - Making --full-diff to imply --pickaxe-all when -S is used would also
   make sense.


[Footnote]

*1* I wrote the following before reading Jeff's response where I explained
it already; it should say the same thing so if you read the message Jeff
pointed at, you don't have to read this, but I didn't want to waste my
typing, so ...

  The log dataflow is:

  - revision walker finds commits one-by-one, but limiting the commits
    to the ones that touch the paths in the pathspec.

  - each found commit and its ancestor(s) are given to the diff
    machinery, in order to skip the commit if there is no difference,
    and also as a side effect to show the diff.

  - diff front-end collects paths in the commit pair, limited by the
    pathspec given.  however, this can be countermanded with full-diff.

  - diffcore does its thing---compares the collected paths, ignoring
    changes between pairs that do not satisfy pickaxe filter (if given).

    - when pickaxe is in effect, usually paths that do not satisfy the
      pickaxe filter is _discarded_ even if they are different between
      the parent and the child.

    - pickaxe-all however prevents the above.  If even one path
      satisifies the pickaxe filter, all paths survive.

  - if there are still changes after the above computation, the change
    is shown in diff form (when -p is given).

For example, "log -Shello -- world/" would:

  a) limit to commits that touch something in world/ directory;

  b) compare commit and its parents but limit this comparison in world/
     directory.

  c) if some compared file have different number of "hello" in parent and
     child, diff for only those files is shown.

  Giving --full-diff affects step b.  files outside world/ will also be
  inspected in step c and the ones that changes the number of "hello"
  are shown even if outside world/

  Giving --pickaxe affects step c.
