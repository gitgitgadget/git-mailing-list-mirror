From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sat, 11 May 2013 10:54:12 -0700
Message-ID: <7vmws1xv0b.fsf@alter.siamese.dyndns.org>
References: <cover.1368274689.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat May 11 19:54:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbDzx-0002xf-2s
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 19:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741Ab3EKRyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 13:54:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab3EKRyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 13:54:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 141891D735;
	Sat, 11 May 2013 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l65/oAI+Tas3qs4Pmdte4rQ4GP0=; b=JhsTb+
	iMBCfAdwH5OShHksOQyAKn0ifBTVnsMddvILAWWVUMj+/f0Z0/XAldT7awrY/BLZ
	MF9XOTpqg5+AwcR4Dxe36iS+XcwPgwp/p4YbmLJhmOrpkI0KAtf+M8cPZuoqJYID
	Za8Tuk2IRKuXkgNW1X6iFhlyJQaGZoLpZcJYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f+Gx4mYEY+G1dkSYlMSouK5fngkoPFGK
	/eLXTIGDyJuI3bCHsanFFkNSMvm8reYpw/pk8m8lr5Gr/fWL4+y3CmSqg4wSSYC8
	/bgCgzL95v37Sa2QreSj24pbSAiwj97UbH6PgSfjcsSbKEZ0Lmnlb4xqCbbuG9Up
	ukgWV+bJBVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BCEB1D734;
	Sat, 11 May 2013 17:54:15 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83ACD1D733;
	Sat, 11 May 2013 17:54:14 +0000 (UTC)
In-Reply-To: <cover.1368274689.git.john@keeping.me.uk> (John Keeping's message
	of "Sat, 11 May 2013 13:23:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB0A0DF2-BA63-11E2-BFE1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223997>

John Keeping <john@keeping.me.uk> writes:

> This is helpful when examining branches with disjoint roots, for example
> because one is periodically merged into a subtree of the other.
>
> With the --merge-child option, "git merge-base" will print a
> first-parent ancestor of the first revision given, where the commit
> printed is either a merge-base of the supplied revisions or a merge for
> which one of its parents (not the first) is a merge-base.

The above two doe snot connect at least to me.  The second paragraph
seems to describe how this mysterious mode decides its output to a
sufficient detail, but what the output _means_, and it is unclear
how it relates to gitk/git-gui style merges.

> For example, given the history:
>
>         A---C---G
>              \
>         B-----D---F
>          \
>           E
>
> we have:
> ...
>         $ git log --left-right F...E --not $(git merge-base --merge-child F E)
>         < F
>         > E
>
> The git-log case is useful because it allows us to limit the range of
> commits that we are examining for patch-identical changes when using
> --cherry.

Hmph, is this reinventing ancestry-path in a different way?  At the
low level machinery, you are finding D to show only F and E, and
your goal seems to be to ignore the side ancestry A--C--G, but it is
not clear if you prefer "E D F"(which would be what F...E would give
in a history limited to ancestry-path, ignoring C) over "E F".

> For example with git-gui in git.git I know that anything
> before the last merge of git-gui is not interesting:

Can this be extended to find the second last such merge?  Or is the
last one always special?

Still skeptical, but I'll let people discuss it during the feature
freeze ;-).
