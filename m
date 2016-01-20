From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: resolve $commit^{tree} in no-index case
Date: Tue, 19 Jan 2016 19:23:35 -0800
Message-ID: <xmqqziw153yg.fsf@gitster.mtv.corp.google.com>
References: <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
	<xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
	<20160119213705.GA28656@sigill.intra.peff.net>
	<xmqq37tt9r9g.fsf@gitster.mtv.corp.google.com>
	<20160119215100.GB28656@sigill.intra.peff.net>
	<20160119215928.GA6556@sigill.intra.peff.net>
	<20160119222802.GC6556@sigill.intra.peff.net>
	<20160120012253.GD16090@google.com>
	<20160120013436.GA24541@sigill.intra.peff.net>
	<xmqqbn8h6mrl.fsf@gitster.mtv.corp.google.com>
	<20160120020039.GD24541@sigill.intra.peff.net>
	<xmqq4me96kd2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	John Fultz <jfultz@wolfram.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 04:23:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLjN1-0000jp-Ae
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 04:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934634AbcATDXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 22:23:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934599AbcATDXi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 22:23:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80C203E594;
	Tue, 19 Jan 2016 22:23:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XO4CdcK1/vplh3FH5HqAPdyKOpI=; b=KS43t5
	V5nekt5u4yXZ2sEOfcaxezD6Dp/DqbaLVo8hgLk2xg/u52/sDMORU9oQtZCWcUb9
	Sfx5t02mUhIZzKmMFjEpkG2kMrbF7i55nMZHd3+qUMC9we7XiTzep+7AFDwlwDSg
	jwo3lJ2fHC5v2/PYZNo4MervDudVemUzczUXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O4nGHXRUy5z81ch1l7+eOegjQg0sAAE/
	872YIIZdLPPifOe25u/LClfb1aAWQBIPXEiBiwZ8oQi/7fedBixSXTR6erKx1GM3
	pHXtanR7cTHocKTFUkdtUWLB1SaSvUR0anfMYFUSzx/W6/2Hy7HfUHN+JRDVHKne
	WDaIqlxFWls=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E9253E593;
	Tue, 19 Jan 2016 22:23:37 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C41F13E592;
	Tue, 19 Jan 2016 22:23:36 -0500 (EST)
In-Reply-To: <xmqq4me96kd2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 Jan 2016 18:43:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3166658C-BF25-11E5-9BB9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284418>

Junio C Hamano <gitster@pobox.com> writes:

> In other words, I do not think "broken tree object may look the same
> to diff-tree, but I do want to replace it" is relevant to this
> codepath; it is not something this function handles, I think.
>
> What am I not seeing?

One thing that I was not seeing is that "diff-tree --quiet" (without
any magic options like -ignore-whitespace that may make two
different tree object judged to be the same, and without -C -C that
forces it to recurse into identical subtrees) lacks an obvious and
stupid optimization to say "they are the same" or "they are
different when given two tree object names without opening the
tree(s).  So if you make it compare a rewritten and corrected tree
and an incorrect and possibly broken one, it may try to read the
tree data from the latter and comparison can lead to incorrect
results.

A consequence of this is if you are running filter-branch without
any tree filters (i.e. no_index) but with "--prune-empty", and a
commit and its parent actually have different trees but one (or
both) of them are broken, "diff-tree" _might_ say "they are the
same" and you end up skipping a commit when you do not want to.  If
your plan was to run another round of filter-branch, this time with
a "broken tree encoding correction" tree-filter, on the result of
the first "--prune-empty" filtering, we would definitely end up with
a wrong history.

But for such a case, I would say you should be running the
correction filter as the very first thing.  So I am not sure if it
matters in practice.

One possible action item out of this is that we might want to think
about giving the obvious and stupid optimization to such invocation
of "diff-tree --quiet".  I _think_ we correctly avoid descending
into the identical subtrees while doing a recursive diff-tree by
saying "hey these two corresponding directories have the same tree
object names", but there is no fundamental reason why we shouldn't
be doing the same optimization at the top-level of the comparison.
