From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: drop confusing prefix parameter of die_on_unclean_work_tree()
Date: Thu, 10 Mar 2016 10:09:01 -0800
Message-ID: <xmqqk2ladx36.fsf@gitster.mtv.corp.google.com>
References: <974d0bfed38e8aa410e97e05022bc5dbbd78d915.1457615785.git.johannes.schindelin@gmx.de>
	<xmqqr3fidxs3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 10 19:09:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae51K-0001Lk-PM
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 19:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbcCJSJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 13:09:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754323AbcCJSJF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 13:09:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CFB5B4A090;
	Thu, 10 Mar 2016 13:09:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vlu404SRsEt7RLenM4zlNXpSJos=; b=crFSrt
	pvPFklGOo2jx6EWh5m6BvRnbJn4zqZkaJo685f0oLnP002TOkXk8bDBXWKtqtNKI
	+GvIWnNVuzxeWM/2owjkzdg46KXeegbhu5pH7RppCwsrvK25f5EkvMcQJAoCfPtq
	2cCMlIA7j0SpSq55vH7BzkR7ssaYPAsxnqtg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RjY46AlkrcJmRpXeYFQzyGMGL/1GVAa5
	KY5iLmgIYNCxA3grGpQYwYQ/0xDesvgJZZjFBJMo61hf5cV2jmB9a4K+2q073WKC
	cTDB/2JQm/bhnI9/JvqGxEGUYe+Dq3NxJgA0nHStnutUMcf4Bd9gKNIEx8mqUXeT
	HOyOW+2Ujig=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 885664A08F;
	Thu, 10 Mar 2016 13:09:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ADD044A08C;
	Thu, 10 Mar 2016 13:09:02 -0500 (EST)
In-Reply-To: <xmqqr3fidxs3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 10 Mar 2016 09:54:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2B90D1C2-E6EB-11E5-BAC0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288630>

Junio C Hamano <gitster@pobox.com> writes:

> I think this is quite subjective, as I tend to take the presence of
> "prefix" to mean "the callee assumes that the caller has gone up to
> the root level already", and take the absense of use of "prefix" in
> the callee to mean "the callee is working on the whole tree", and
> discarding the parameter is robbing that clue from that point of
> view.
>
> So I am mildly opposed to most parts of this change, including not
> spelling out (void) as the list of parameters for a function that
> does not take any.
>
> I do think not passing "prefix" to init_revisions() would be the
> right thing.  In fact, that prefix is copied to rev, but the current
> end result is correct _only_ because the pathspec limit given by
> that "prefix" parameter to init_revisions() is not automatically
> copied to rev_info.diffopt, and the code is very misleading.

Another reason why it is more sensible to keep the prefix available,
but not use it to limit the extent of diff, to has_*_changes()
functions is that it would be easier for us to change our mind later
to allow the users to ask for more detailed output.  Instead of
"Cannot pull with rebase: You have unstaged changes, period.", you
may be asked to list which paths are dirty in such a case, and in
order to present the list relative to the directory where the user
started the command, you would need "prefix" available to the code
that calls into diff machinery somehow.
