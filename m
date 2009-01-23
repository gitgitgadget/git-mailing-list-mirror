From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Add "partial commit" tests during a conflicted merge
Date: Thu, 22 Jan 2009 23:16:43 -0800
Message-ID: <7vab9i331g.fsf@gitster.siamese.dyndns.org>
References: <4978202C.3090703@viscovery.net>
 <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
 <49779521.9040208@drmicha.warpmail.net>
 <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
 <20090123094509.6117@nanako3.lavabit.com>
 <7viqo64kfo.fsf@gitster.siamese.dyndns.org>
 <7vbpty4kby.fsf_-_@gitster.siamese.dyndns.org>
 <49796D0C.5070408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 08:18:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQGJ6-0005qG-GE
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 08:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbZAWHQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 02:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbZAWHQ4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 02:16:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZAWHQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 02:16:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DA4991D16A;
	Fri, 23 Jan 2009 02:16:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7E41D1D162; Fri,
 23 Jan 2009 02:16:45 -0500 (EST)
In-Reply-To: <49796D0C.5070408@viscovery.net> (Johannes Sixt's message of
 "Fri, 23 Jan 2009 08:09:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CFAC9940-E91D-11DD-B1CA-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106846>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> +test_expect_success 'reject --only during a merge' '
>> +	git checkout HEAD^0 &&
>> +	git reset --hard the-other-side-says-nitfol &&
>> +	test_must_fail git merge one-side-says-frotz &&
>> +	echo yomin-only >file &&
>> +	test_must_fail git commit -m merge --only file &&
>
> I don't see why this must fail: 'file' is the only file that is different
> from HEAD. Yes, currently we fail; but if something is about to be
> changed, then this can change as well.

Not at all.

Avoiding --only is to prevent a much more dangerous glitch.

Suppose you and the other have two paths diverged, and one merges cleanly
and the other results in conflict.  When "git merge" gives control back to
you, the cleanly merged result is ALREADY IN THE INDEX.

Now you futz with the other path, and say

	git commit --only other

What --only tells git is "I do not care what I've staged in the index.
Start from the contents of HEAD commit, and update the index entry at these
paths (and these path _ONLY_), and commit the contents registered in the
index.

That is why --include is the only sane semantics during a conflicted
merge.  I thought you should know better, as you were the one who gave the
explanation to Nathan, which triggered Nana's response, which resulted in
this series.
