From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG in git diff-index
Date: Thu, 31 Mar 2016 13:39:02 -0700
Message-ID: <xmqqwpoil6vt.fsf@gitster.mtv.corp.google.com>
References: <loom.20160331T143733-916@post.gmane.org>
	<20160331140515.GA31116@sigill.intra.peff.net>
	<CAJxkE8SVF_ikHqDCh6eHExq=seitHPVpxW2GmPo40jtqWvz1JQ@mail.gmail.com>
	<20160331142704.GC31116@sigill.intra.peff.net>
	<56FD7AE8.4090905@nglowry.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Andy Lowry <andy.work@nglowry.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 22:39:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljNK-0004Mw-H7
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 22:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456AbcCaUjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 16:39:16 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932941AbcCaUjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 16:39:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0FEC752D6C;
	Thu, 31 Mar 2016 16:39:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PN4zhfeff5PYoAxl7lUQAK46Q5s=; b=tArQX/
	U2O/3IT7rBAWRF7uH/6yCUGu7B7znw8ByTOdXbD5BWBP9kMKnVNj7RjIbfql8bEC
	uXV3HuAySHnypAEfJ+vqAgOFLGYWrHh7nK9ra6vtbB7o+5OIJy95e58CaeBZsH+h
	cOdk1hCGQhyACivPGlT0JOFDdJ5yOZh2nbAlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AnxzB/AGm1oY3gzRHM+ZCYaFpWcEhREi
	dGmTnh+MAg/LNd899Ucj9DZkn+AC5HycXbNH/4rz5euqsZJP5TXYc87lLZt+5dmR
	3wD+4pStA+CmhAlMxyPvwiVZ+ljZDApxIFau6HVg4NQeqUMyhLNQeUlFUP4fVzMU
	fDwh7Xiix2g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0782752D6B;
	Thu, 31 Mar 2016 16:39:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 71CB652D63;
	Thu, 31 Mar 2016 16:39:03 -0400 (EDT)
In-Reply-To: <56FD7AE8.4090905@nglowry.com> (Andy Lowry's message of "Thu, 31
	Mar 2016 15:30:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9B1B14EE-F780-11E5-BF39-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290463>

Andy Lowry <andy.work@nglowry.com> writes:

> So I think now that the script should do "update-index --refresh"
> followed by "diff-index --quiet HEAD". Sound correct?

Yes.  That has always been one of the kosher ways for any script to
make sure that the files in the working tree that are tracked have
not been modified relative to HEAD (assuming that the index matches
HEAD).  If you are fuzzy about that assumption, you would also do
"diff-index --quiet --cached HEAD" to ensure it, making the whole
thing:

	update-index --refresh
        diff-index --quiet --cached HEAD && diff-index --quiet HEAD

Our scripts traditionally do the equivalent in a slightly different
way.  require_clean_work_tree() in git-sh-setup makes sure that (1)
your working tree files match what is in your index and that (2)
your index matches the HEAD, i.e.

	update-index --refresh
        diff-files --quiet && diff-index --cached --quiet HEAD

They are equivalent in that H==I && H==W (yours) mean H==I==W, while
I==W && H==I (ours) also mean H==I==W.  Two diff-index would require
you to open the tree object of the HEAD twice, so our version may be
more efficient but you probably wouldn't be able to measure the
difference.
