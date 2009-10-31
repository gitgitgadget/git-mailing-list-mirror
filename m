From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't create the $GIT_DIR/branches directory on init
Date: Sat, 31 Oct 2009 11:15:56 -0700
Message-ID: <7vr5sj8m5f.fsf@alter.siamese.dyndns.org>
References: <1256923228-18949-1-git-send-email-robin.rosenberg@dewire.com>
 <200910311011.31189.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	<spearce@spearce.org>, <sasa.zivkov@sap.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Oct 31 19:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4IUy-0003Af-FH
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 19:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932855AbZJaSQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 14:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbZJaSQM
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 14:16:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932816AbZJaSQL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 14:16:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECA238DC9D;
	Sat, 31 Oct 2009 14:16:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/CBHODAawOcNKZdqeNfDc+AfE38=; b=FJ8t9m
	EvQBy3r6dghdYuzFt7BfCPulowAdUu7Jx1LB25iZvTtn1QGK+Q5LNiV/om0+jz+1
	g08j5tvrbfFiPjR7Y3h1EAgVyLlFp+c3TSeYZxNUobMJcwCLliUtsv1vsdV67khV
	nYQcYf2WFW54CU6bJYuoSfeLXlUJI3ZbiTpZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e33nZggd7Hg2befFkggWQ14b17syBdSo
	BBq6xpJ+YbDiAwQ6vRuPSKYGr+jFCDvSoCCiDVXYDMYkSbD2A/XA6aiu2LBwbbH4
	wgV4spUQL0y0oQM4kXLhq8tpwJUweOgFwSdZ3qqw5xc/95l8O92WfqLf3bhkEANS
	94EQZDGgwrA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A083D8DC9A;
	Sat, 31 Oct 2009 14:16:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 50BA88DC98; Sat, 31 Oct 2009
 14:15:59 -0400 (EDT)
In-Reply-To: <200910311011.31189.trast@student.ethz.ch> (Thomas Rast's
 message of "Sat\, 31 Oct 2009 10\:11\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75A1E798-C649-11DE-9979-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131848>

Thomas Rast <trast@student.ethz.ch> writes:

> Robin Rosenberg wrote:
>> Git itself does not even look at this directory.

Modern git Porcelains write remote definitions solely to .git/config, but
still reads from .git/{branches,remotes}.  What we do not do is to update
these locations, and we do not need to have these locations to operate.

So "not even look at" is too strong; it just "not touch".

I do not think there is reason to change that part of the equation.  For
people who need to fetch and merge hundreds of random places, it is a lot
handier to be able to do

	echo "$url#$branch" >.git/branch/$nickname
        rm .git/branch/$nickname

to manage the set of locations added to and deleted from the daily
compose.  Andrew Morton explicitly asked for this to be kept a few years
ago and I do not see a reason to deprecate this.

Now, not installing an empty .git/branch directory does break the above
workflow.  You would need to mkdir _once_ yourself, but I do not think
that is such a big deal.

On the other hand, I do not think it is such a big deal to have otherwise
unused .git/branches/ directory, either.  Robin wrote:

    Shawn and other wants to stop JGit from creating this directory on
    init with the motivation that newer Git version doesn't create it
    anymore. This patch would make that assertion true.

and after re-reading it, I realize "the motivation" is not a motivation at
all---it is merely an excuse ("after this patch is applied, git wouldn't
create it anymore"---so JGit will have an excuse not to do so).  It does
not say _why_ it shouldn't be there in the first place.  IOW, we need to
fill in the blank in: "JGit is merely following suit; the reason git
stopped creating the directory is ________").

This patch alone breaks tests in the t55?? series quite a lot, and I am
tempted to revert it.  My time is more valuable than fixing the fallouts
from this change, when the real purpose of the change is not yet stated.
