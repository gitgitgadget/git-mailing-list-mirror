From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: post-fetch, tweak-fetch hook
Date: Sun, 06 May 2012 19:10:17 -0400
Message-ID: <201205062310.q46NAHnM022630@no.baka.org>
References: <CAKLmikNaqVRb=pGUhbvVQTX2tYWT0HSS2R6Ezmico3X0rMgvYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Mitar <mmitar@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 01:10:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRAb3-0007nK-Ve
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 01:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab2EFXKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 19:10:21 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:42569 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168Ab2EFXKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 19:10:21 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q46NAIuV003968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 6 May 2012 19:10:18 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q46NAHnM022630;
	Sun, 6 May 2012 19:10:18 -0400
In-reply-to: <CAKLmikNaqVRb=pGUhbvVQTX2tYWT0HSS2R6Ezmico3X0rMgvYQ@mail.gmail.com>
Comments: In reply to a message from "Mitar <mmitar@gmail.com>" dated "Sun, 06 May 2012 22:52:53 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197220>


In message <CAKLmikNaqVRb=pGUhbvVQTX2tYWT0HSS2R6Ezmico3X0rMgvYQ@mail.gmail.com>, Mitar writes:

    I am a git newbie, but after few hours or reading and searching I have
    not found a simple way to get a list of revisions retrieved by a
    fetch

The output of fetch seems to do that, quite nicely.

----------------------------------------------------------------------
> git fetch
remote: Counting objects: 24155, done.
remote: Compressing objects: 100% (6651/6651), done.
remote: Total 21446 (delta 15831), reused 20146 (delta 14640)
Receiving objects: 100% (21446/21446), 6.78 MiB | 239 KiB/s, done.
Resolving deltas: 100% (15831/15831), completed with 574 local objects.
From git://git.kernel.org/pub/scm/git/git
   ea2c69e..edf1412  maint      -> origin/maint
   ae4479d..8275905  master     -> origin/master
 + b6b16ad...8a79d96 next       -> origin/next  (forced update)
 + 47db9a0...30b8c95 pu         -> origin/pu  (forced update)
   ce29fc8..3ca5cbc  todo       -> origin/todo
----------------------------------------------------------------------

OK, ignoring that output:

----------------------------------------------------------------------
> git branch -r | grep -v ' -> ' | while read b; do git reflog -n 1 "$b"; done
edf1412 refs/remotes/origin/maint@{0}: fetch: fast-forward
ea2c69e 8275905 refs/remotes/origin/master@{0}: fetch: fast-forward
ae4479d 8a79d96 refs/remotes/origin/next@{0}: fetch: forced-update
b6b16ad 30b8c95 refs/remotes/origin/pu@{0}: fetch: forced-update
47db9a0 3ca5cbc refs/remotes/origin/todo@{0}: fetch: fast-forward
----------------------------------------------------------------------

The reflog, of course, only gives you the latest change for each
branch, which means that two fetches in a row will return the same
output if no changes were received.  Of course there is the classic:

----------------------------------------------------------------------
git for-each-ref | pcregrep 'commit\srefs/remotes/' > /tmp/old
git fetch
git for-each-ref | pcregrep 'commits\srefs/remotes/' > /tmp/new
diff /tmp/old /tmp/new
----------------------------------------------------------------------

I'm in favor of more git hooks myself, but there is a solution to your
needs without it.

    Even if there is a way to reconstruct data passed to post-receive (to
    be given to post-fetch), I am concerned about race-condition of this.

If you care about race conditions (and really, a lockfile(1) call can
take care of that easily enough), then parse the output of fetch which
will make it clear what *this* call did.

					-Seth Robertson
