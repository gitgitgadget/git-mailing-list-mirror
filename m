From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] Add "partial commit" tests during a conflicted merge
Date: Fri, 23 Jan 2009 08:09:00 +0100
Message-ID: <49796D0C.5070408@viscovery.net>
References: <4978202C.3090703@viscovery.net> <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net> <49779521.9040208@drmicha.warpmail.net> <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com> <20090123094509.6117@nanako3.lavabit.com> <7viqo64kfo.fsf@gitster.siamese.dyndns.org> <7vbpty4kby.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 08:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQGCK-0004gt-53
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 08:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbZAWHJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 02:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbZAWHJI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 02:09:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15055 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbZAWHJH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 02:09:07 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LQGA0-0003nj-Bi; Fri, 23 Jan 2009 08:09:00 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2658D6EF; Fri, 23 Jan 2009 08:09:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vbpty4kby.fsf_-_@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106845>

Junio C Hamano schrieb:
> +test_expect_success 'setup merge commit with paths test' '
> +	git reset --hard &&
> +	git checkout HEAD^0 &&
> +	echo frotz >file &&
> +	test_tick &&
> +	git add file &&
> +	git commit -a -m "one side says frotz" &&
> +	git tag one-side-says-frotz &&
> +	git reset --hard HEAD^ &&
> +	echo nitfol >file &&
> +	test_tick &&
> +	git add file &&
> +	git commit -a -m "the other side says nitfol" &&
> +	git tag the-other-side-says-nitfol
> +'
> +
> +test_expect_success 'reject --only during a merge' '
> +	git checkout HEAD^0 &&
> +	git reset --hard the-other-side-says-nitfol &&
> +	test_must_fail git merge one-side-says-frotz &&
> +	echo yomin-only >file &&
> +	test_must_fail git commit -m merge --only file &&

I don't see why this must fail: 'file' is the only file that is different
from HEAD. Yes, currently we fail; but if something is about to be
changed, then this can change as well.

> +	git reset --hard
> +'
> +
> +test_expect_success 'allow --include during a merge' '
> +	git checkout HEAD^0 &&
> +	git reset --hard the-other-side-says-nitfol &&
> +	test_must_fail git merge one-side-says-frotz &&
> +	echo yomin-include >file &&
> +	git commit -m merge --include file &&
> +	git reset --hard
> +'
> +
> +test_expect_failure 'assume --include during a merge' '
> +	git checkout HEAD^0 &&
> +	git reset --hard the-other-side-says-nitfol &&
> +	test_must_fail git merge one-side-says-frotz &&
> +	echo yomin-assumed >file &&
> +	git add file &&
> +	git commit -m merge file &&
> +	git reset --hard
> +'

If I read the test case correctly, there is only 'file' that is different
from HEAD, and it had a conflict. But IMO, the test should stress the
point that after the conflicted merge there are at least two files that
are different from HEAD, one was trivially merged, and the other had a
conflict.

-- Hannes
