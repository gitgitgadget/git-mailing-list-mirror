From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: drop confusing prefix parameter of die_on_unclean_work_tree()
Date: Thu, 10 Mar 2016 09:54:04 -0800
Message-ID: <xmqqr3fidxs3.fsf@gitster.mtv.corp.google.com>
References: <974d0bfed38e8aa410e97e05022bc5dbbd78d915.1457615785.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 10 18:54:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae4mr-00069M-2H
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 18:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbcCJRyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 12:54:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752865AbcCJRyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 12:54:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56FA649C89;
	Thu, 10 Mar 2016 12:54:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j42SAXebYY4o0UP8FY5gJvkscc4=; b=Ghztym
	RTX1sKzrgVscrZkTh2E3St4f7smpQZqYehfckDHdBzM14swfxMTlXiRC8RLJjBvO
	oncLXMHUB0e+0caWmilEpcUw6sVB/jsRv0g8/61sCnPbUSDcmPg93VmXxKnrtzBx
	deST80wioZhIj1Pb1PNdXwCaGbpVDcJYonYEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oGIG6JQr/nwvbfJ28MGJ1ezR1OU0LrXp
	vdvFClJA3hLvHTHmqagQjTd4+LchnHhD8b8cx2kxUopAuyKo6T/bxXYIabSo0BWG
	Mgo8kiziI2l6K4Y8pDISzNLZ/aQc4EAsso6yc/cBv9hKrZgysnf+vHSqnpezzWf4
	KU2xi6yDYdw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4DCCF49C88;
	Thu, 10 Mar 2016 12:54:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C73BC49C87;
	Thu, 10 Mar 2016 12:54:05 -0500 (EST)
In-Reply-To: <974d0bfed38e8aa410e97e05022bc5dbbd78d915.1457615785.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 10 Mar 2016 14:24:26 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 14F95260-E6E9-11E5-A4FD-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288629>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In cmd_pull(), when verifying that there are no changes preventing a
> rebasing pull, we diligently pass the prefix parameter to the
> die_on_unclean_work_tree() function which in turn diligently passes it
> to the has_unstaged_changes() and has_uncommitted_changes() functions.
>
> The casual reader might now be curious (as this developer was) whether
> that means that calling `git pull --rebase` in a subdirectory will
> ignore unstaged changes in other parts of the working directory. And be
> puzzled that `git pull --rebase` (correctly) complains about those
> changes outside of the current directory.

I think this is quite subjective, as I tend to take the presence of
"prefix" to mean "the callee assumes that the caller has gone up to
the root level already", and take the absense of use of "prefix" in
the callee to mean "the callee is working on the whole tree", and
discarding the parameter is robbing that clue from that point of
view.

So I am mildly opposed to most parts of this change, including not
spelling out (void) as the list of parameters for a function that
does not take any.

I do think not passing "prefix" to init_revisions() would be the
right thing.  In fact, that prefix is copied to rev, but the current
end result is correct _only_ because the pathspec limit given by
that "prefix" parameter to init_revisions() is not automatically
copied to rev_info.diffopt, and the code is very misleading.
