From: Oswald Buddenhagen <ossi@kde.org>
Subject: Re: Bringing a bit more sanity to =?utf-8?b?JEdJVF9ESVIvb2JqZWN0cy9pbmZvL2FsdGVybmF0ZXM/?=
Date: Mon, 27 Aug 2012 22:39:23 +0000 (UTC)
Message-ID: <loom.20120827T233125-780@post.gmane.org>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 00:39:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T67yD-0004s6-4P
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 00:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab2H0Wji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 18:39:38 -0400
Received: from plane.gmane.org ([80.91.229.3]:40360 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab2H0Wjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 18:39:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1T67y3-0004mI-UP
	for git@vger.kernel.org; Tue, 28 Aug 2012 00:39:36 +0200
Received: from i59F75C97.versanet.de ([89.247.92.151])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 00:39:35 +0200
Received: from ossi by i59F75C97.versanet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 00:39:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.247.92.151 (Mozilla/5.0 (X11; Linux x86_64; rv:10.0.5) Gecko/20100101 Firefox/10.0.5 Iceweasel/10.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204376>

hi,

Junio C Hamano <gitster <at> pobox.com> writes:
> The "alternates" mechanism [...]

sorry for the somewhat late response - i found this thread only now.

at qt-project.org we have a somewhat peculiar setup: we have the qt4 repository,
and a bunch of qt5 repositories which resulted from a split. qt5 is under active
development, but qt4 is still maintained. that means that we need to cherry-pick
between those repositories quite a lot. for an optimal cherry-picking experience
one needs three-way-merging, which means we need shared object stores. which is
where the problems start:

my first approach was just a common objects/ directory with all repositories
symlinking into it. problems:
- the object store can never be garbage-collected. with a lot of heavy rebasing
and temporarily added remotes, it gets messy after a while.
- there is a constant risk of destroying the object store by inadvertently
running git gc - which is particularly likely with git-gui, as it seems to be
retarded enough to ignore the auto-gc setting.

so the second approach is the "bare aggregator repo" which adds all other repos
as remotes, and the other repos link back via alternates. problems:
- to actually share objects, one always needs to push to the aggregator
- tags having a shared namespace doesn't actually work, because the repos have
the same tags on different commits (they are independent repos, after all)
- one still cannot safely garbage-collect the aggregator, as the refs don't
include the stashes and the index, so rebasing may invalidate these more
transient objects.

i would re-propose hallvard's "volatile" alternates (at least i think that's
what he was talking about two weeks ago): they can be used to obtain objects,
but every object which is in any way referenced from the current clone must be
available locally (or from a "regular" alternate). that means that diffing, etc.
would get objects only temporarily, while cherry-picking would actually copy
(some of) the objects. this would make it possible to "cross-link" repositories,
safely and without any "3rd parties".

thoughts?

regards
