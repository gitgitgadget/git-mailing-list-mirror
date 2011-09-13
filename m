From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated submodules
Date: Tue, 13 Sep 2011 21:13:10 +0200
Message-ID: <4E6FAB46.30508@web.de>
References: <20110912195652.GA27850@sigill.intra.peff.net> <7vr53l5u7h.fsf@alter.siamese.dyndns.org> <20110912224934.GA28994@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 21:13:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3YQ5-0001SG-Lg
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 21:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344Ab1IMTNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 15:13:17 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:48037 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328Ab1IMTNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 15:13:16 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 93BA01971B669;
	Tue, 13 Sep 2011 21:13:10 +0200 (CEST)
Received: from [79.247.241.245] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1R3YPu-0000He-00; Tue, 13 Sep 2011 21:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <20110912224934.GA28994@sigill.intra.peff.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+UbTI5rINjCOHX+L8+LR7786Yv/Y9esYA3MQt8
	ERKdDzfB0ST+Hp976Hzv9UIsWsbgONZ8cRML4vXFf6CJGL0MA0
	de5IrBv6r7y91SfgUKDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181302>

Am 13.09.2011 00:49, schrieb Jeff King:
> So with a set of changes like:
> 
>   [assume submodule at commit A, superproject at commit B]
> 
>   1. Make commit C in submodule repo.
> 
>   2. Make commit D in superproject repo.
> 
>   3. Make commit E in submodule repo.
> 
>   4. Make commit F in superproject repo.
> 
> what does it buy us to find out that the submodule changed from "A" to
> "C"? We can't actually fetch it. We can only fetch the tips of the
> submodule and hope that they include everything we wanted (i.e., both C
> and E; which might not be the case of E rewound and is not a descendant
> of C).

Yes. But working with submodules in my experience only then works well
when you never drop a submodule commit recorded in any superproject. At
my dayjob we have the convention: You may only record commits that are
on the submodule's master - or another never to be rewound integration
branch - in the superproject. That gives us all needed commits in a
simple fetch.

> So since we must accept that we can't necessarily get every intermediate
> step, I wonder if we are simply better off diffing the "before" and
> "after" state of a particular ref, rather than traversing. It's way
> cheaper, and is just as likely to give us the same information (i.e.,
> which submodule paths had changed commits).

The real world use case I have for that is that when a bug introduced by
a new submodule commit is detected later on, the superproject's fix
records an older submodule commit to remove the problematic change from
the superproject. But the submodule's branch isn't rewound (as that is
most probably master) but a fix is applied on top of it. Then that one
gets tested and - if it was found ok - recorded in the superproject.

Changes like this could be overlooked if you only compare "before" and
"after" instead of traversing, leading to not fetching a submodule which
does have new commits that are used in the newly fetched superproject's
commits. I'd like to have on-demand fetch keep the correct solution of
traversing unless we have good reasons against it, especially as teaching
checkout & friends to recursively update submodules too depends on all
needed commits being present.
