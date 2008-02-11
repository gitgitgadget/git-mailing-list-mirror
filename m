From: Junio C Hamano <gitster@pobox.com>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 10 Feb 2008 17:44:08 -0800
Message-ID: <7vd4r4clnb.fsf@gitster.siamese.dyndns.org>
References: <200802102007.38838.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 02:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JONj6-00040O-Ph
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 02:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbYBKBoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 20:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbYBKBoX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 20:44:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbYBKBoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 20:44:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C475C383B;
	Sun, 10 Feb 2008 20:44:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 19C38383A;
	Sun, 10 Feb 2008 20:44:15 -0500 (EST)
In-Reply-To: <200802102007.38838.lenb@kernel.org> (Len Brown's message of
	"Sun, 10 Feb 2008 20:07:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73451>

Len Brown <lenb@kernel.org> writes:

> A couple of hours ago I pulled my reference copy of Linux tree,
> which brought the tip here:
>
> commit 7cf712db6087342e5e7e259d3883a7b5ac3212d1
> Merge: 58a14ee... 30ddb15...
> Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
> Date:   Sun Feb 10 12:03:57 2008 -0800
>
>     Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
>
> Then, 10 minutes ago I did a pull to bring the head here:
>
> commit 19af35546de68c872dcb687613e0902a602cb20e
> Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
> Date:   Sun Feb 10 14:18:14 2008 -0800
>
>     Linux 2.6.25-rc1
>
> But this second pull seems to have re-downloaded 172MB,
> when it should have only needed the last few commits.
>
> thanks,

Thanks.  This is very puzzling.

> [lenb@d975xbx2 linus (master)]$ git pull
> remote: Counting objects: 447, done.
> remote: Compressing objects: 100% (39/39), done.
> remote: Total 328 (delta 291), reused 325 (delta 289)

This part looks quite sane.

	$ git rev-list --objects ^7cf712d v2.6.25-rc1^0 | wc -l
	328

> Receiving objects: 100% (328/328), 60.81 KiB, done.
> Resolving deltas: 100% (291/291), completed with 97 local objects.

and the number of received objects exactly match.

> warning: no common commits

This is however very unexpected.  The sequence internally should
be doing the equivalent of:

  - fetch the objects to complete the branches we track
    (i.e. what the above "rev-list" that fetches to complete the
    commit pointed by the v2.6.25-rc1 tag based on your earlier
    tip 7cf712d);

  - store the tip (19af355 = v2.6.25-rc1^0) to the tracking
    branch;

  - run another "git fetch" to retrieve objects to complete the
    v2.6.25-rc1 tag itself, based on our available refs (which
    includes the commit 19af355).

which should result in transferring only one object, which would
say something like:

    From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
       7cf712d..19af355  master     -> linus
    remote: Counting objects: 1, done.
    remote: Total 1 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (1/1), done.
    From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
     * [new tag]         v2.6.25-rc1 -> v2.6.25-rc1
    Updating 7cf712d..19af355

We would need a bit more digging to reproduce it, as I do not
seem to be able to.
