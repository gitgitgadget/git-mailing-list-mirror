From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 15:35:38 -0700
Message-ID: <xmqq1t6sx685.fsf@gitster.mtv.corp.google.com>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
	<20160329203425.GA24027@sigill.intra.peff.net>
	<20160329205208.GF1578@serenity.lan>
	<20160329212143.GA30116@sigill.intra.peff.net>
	<20160329220003.GG1578@serenity.lan>
	<20160329221657.GA31811@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, Elliott Cable <me@ell.io>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:35:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2Ek-0006qz-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbcC2Wfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:35:42 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753367AbcC2Wfm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:35:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B2C850580;
	Tue, 29 Mar 2016 18:35:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ERTF2RbVDUP6iKVlshHBk1hiRKM=; b=Hko5IJ
	pVeVwaQqc0Ff9yNGiepRNEEASswRniOrdNs5BI7Pqdq9lQN6a33bIMJVfPIrvCIG
	PIbr3Ms1phSJJAww6K9MDruGG4KvomHiVdwarVGKDqwnn8UmP4J0Y393G5fiCMor
	H0B43gf54HZlEnIptKKE5/ZZC7b7GHbwJho+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ayfF7u6/CsadRxjzxXvTePSah6RhXiPt
	NeoirbQF3kSESO6e2AuD8JG70RlNBvo6sszvRM/BXiqtkC1mnJFCErOeyDssC+zR
	5+m1UifoNiaDQHGx2HCDF8sPVT83nF85nVQrCv6cCIpnHGEQxeDfDD8gqwvLd9GT
	Vpiti167Avo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 818AE5057F;
	Tue, 29 Mar 2016 18:35:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E7A2D5057E;
	Tue, 29 Mar 2016 18:35:39 -0400 (EDT)
In-Reply-To: <20160329221657.GA31811@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Mar 2016 18:16:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90826100-F5FE-11E5-987C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290212>

Jeff King <peff@peff.net> writes:

>   $ echo content >../file
>   $ GIT_WORK_TREE=$(cd ..; pwd) GIT_DIR=$(pwd) git add file
>   fatal: pathspec 'file' did not match any files
>
> I'd expect that to work, and it doesn't, because we pass ".git/" as the
> "prefix" to cmd_add(). Which I guess is true, but it feels kind of weird
> (I think most people who set both variables like that would generally
> point to some other directory entirely, and we would have a NULL
> prefix).

That reminds me of a related tangent.  If we really want to properly
support running from outside the working tree (or from inside .git
for that matter), I suspect we need two separate "prefix" for two
different uses.  The "we would have a NULL prefix" is what was
considered the true "prefix" traditionally, i.e. it is the directory
to which any pathspecs and relative paths that name paths in the
history are taken relative to.  E.g. if you run "git add HEAD" from
inside your GIT_DIR but you have GIT_WORK_TREE set up correctly, you
would want to add HEAD from the root of the working tree.

Another is the base directory for a relative filename that names a
file that does not have anything to do with the paths in the
history.  E.g. if you run "git grep --file patterns" from outside
the working tree but with GIT_DIR/GIT_WORK_TREE correctly set up,
you would still want to read the "patterns" file from the current
directory.

The former can be done by using prefix=NULL to say "we may or may
not have come from outside a working tree but we no longer care
after we chdir(2) to the root of the working tree.  Any path is
relative to the root of the working tree."  But then we may lose the
clue to read from the latter (the OPT_FILENAME option is handled by
prefix_filename() using the prefix).

The distinction between the two does not exist as long as you start
inside GIT_WORK_TREE and outside GIT_DIR.
