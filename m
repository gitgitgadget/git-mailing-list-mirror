From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: git performance
Date: Fri, 24 Oct 2008 00:55:59 -0700
Message-ID: <49017F8F.3000908@pcharlan.com>
References: <000801c93483$2fdad340$8f9079c0$@com> <20081022203624.GA4585@coredump.intra.peff.net> <000901c93490$e0c40ed0$a24c2c70$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Edward Ned Harvey <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 09:57:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtHY3-00055v-5k
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 09:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbYJXH4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 03:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbYJXH4B
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 03:56:01 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:43589 "EHLO
	swarthymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751939AbYJXH4A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 03:56:00 -0400
Received: from [192.168.0.101] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a4.g.dreamhost.com (Postfix) with ESMTP id B3EC0129A98;
	Fri, 24 Oct 2008 00:55:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <000901c93490$e0c40ed0$a24c2c70$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99018>

Edward Ned Harvey wrote:
> > Yes, it does stat all the files. How many files are you talking about,
> > and what platform?  From a warm cache on Linux, the 23,000 files kernel
> > repo takes about a tenth of a second to stat all files for me (and this
>
> I'm talking about 40-50,000 files, on multi-user production linux,
> which means the cache is never warm, except when I'm benchmarking.
> Specifically RHEL 4 with the files on NFS mount.  Cold cache "svn
> st" takes ~10 mins.  Warm cache 20-30 sec.  Surprisingly to me,

I did some tests with a repo with ~32k files, and git was slightly
slower than svn with a cold cache (10.2s vs 8.4s), and around twice as
fast with a warm cache (.5s vs 1s).

Git 1.6.0.2, svn 1.4.6. Cache made cold with
"echo 1 >/proc/sys/vm/drop_caches".  Timings best of 5 runs.

(I did various benchmarks with svn 1.5.3 also, but there's something
awfully wrong with svn 1.5.x's merging, which takes pathologically
long compared with 1.4 (minutes instead of seconds), and it wasn't
noticeably faster than 1.4 at anything I tested.)

> performance was approx the same for files on local disk versus NFS.

10 minutes seems like a crazy amount of time for 40-50k files.  If you
didn't say you'd tested it on local disks, it would really sound like
a bad NFS interaction more than an svn problem.

> Out of curiosity, what are they talking about, when they say "git is
> fast?"

In my comparisons between svn and git, the operation "checkout
revision N of the tree" (i.e., "svn update -r 40000" vs "git checkout
302c7476") took five minutes on subversion and ten seconds using git.
The tests were all local, so git wasn't benefiting from being a DVCS,
it was just eerily fast on some things.  Svn was even that slow when
the revisions were 1 commit different, if it was a large enough
commit.

I don't check out whole revisions like that very often, but switching
between branches is a similar operation.  It doesn't usually take five
minutes in svn but it's an interruption, and with git it isn't.

For almost everything I tried git was faster, but status wasn't really
one of them.  The compelling cases were the number of things that were
faster _enough_ to no longer be an interruption, and being a DVCS, and
rebase, and rebase -i, and gitk, and a smarter blame, and
branching/merging support like it's something you'd do all day long,
not just when you were forced to.

HTH,

--Pete
