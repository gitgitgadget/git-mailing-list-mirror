From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/3 (edit v2)] gitweb: Cache $parent_commit info in
	git_blame()
Date: Wed, 17 Dec 2008 09:19:35 +0100
Message-ID: <20081217081935.GC3640@machine.or.cz>
References: <20081209224622.28106.89325.stgit@localhost.localdomain> <200812101439.18526.jnareb@gmail.com> <7v7i67zsgj.fsf@gitster.siamese.dyndns.org> <200812110133.33124.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 09:21:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCreQ-0003Rr-Bc
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbYLQITj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 03:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755504AbYLQITi
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:19:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56368 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641AbYLQITh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 03:19:37 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 559B639396C5; Wed, 17 Dec 2008 09:19:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200812110133.33124.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103314>

On Thu, Dec 11, 2008 at 01:33:29AM +0100, Jakub Narebski wrote:
> Luben Tuikov changed 'lineno' link from leading to commit which gave
> current version of given block of lines, to leading to parent of this
> commit in 244a70e (Blame "linenr" link jumps to previous state at
> "orig_lineno").  This made possible data mining using 'blame' view.
> 
> The current implementation calls rev-parse once per each blamed line
> to find parent revision of blamed commit, even when the same commit
> appears more than once, which is inefficient.
> 
> This patch attempts to mitigate this issue by storing (caching)
> $parent_commit info in %metainfo, which makes gitweb call
> git-rev-parse only once per each unique commit in blame output.
> 
> 
> In the tables below you can see simple benchmark comparing gitweb
> performance before and after this patch
> 
> File               | L[1] | C[2] || Time0[3] | Before[4] | After[4]
> ====================================================================
> blob.h             |   18 |    4 || 0m1.727s |  0m2.545s |  0m2.474s
> GIT-VERSION-GEN    |   42 |   13 || 0m2.165s |  0m2.448s |  0m2.071s
> README             |   46 |    6 || 0m1.593s |  0m2.727s |  0m2.242s
> revision.c         | 1923 |  121 || 0m2.357s | 0m30.365s |  0m7.028s
> gitweb/gitweb.perl | 6291 |  428 || 0m8.080s | 1m37.244s | 0m20.627s
> 
> File               | L/C  | Before/After
> =========================================
> blob.h             |  4.5 |         1.03
> GIT-VERSION-GEN    |  3.2 |         1.18
> README             |  7.7 |         1.22
> revision.c         | 15.9 |         4.32
> gitweb/gitweb.perl | 14.7 |         4.71
> 
> As you can see the greater ratio of lines in file to unique commits
> in blame output, the greater gain from the new implementation.
> 
> Footnotes:
> ~~~~~~~~~~
> [1] Lines:
>     $ wc -l <file>
> [2] Individual commits in blame output:
>     $ git blame -p <file> | grep author-time | wc -l
> [3] Time for running "git blame -p" (user time, single run):
>     $ time git blame -p <file> >/dev/null
> [4] Time to run gitweb as Perl script from command line:
>     $ gitweb-run.sh "p=.git;a=blame;f=<file>" > /dev/null 2>&1
> 
> The gitweb-run.sh script includes slightly modified (with adjusted
> pathnames) code from gitweb_run() function from the test script
> t/t9500-gitweb-standalone-no-errors.sh; gitweb config file
> gitweb_config.perl contents (again up to adjusting pathnames; in
> particular $projectroot variable should point to top directory of git
> repository) can be found in the same place.
> 
> 
> Alternate solutions:
> ~~~~~~~~~~~~~~~~~~~~
> Alternate solution would be to open bidi pipe to "git cat-file
> --batch-check", (like in Git::Repo in gitweb caching by Lea Wiemann),
> feed $long_rev^ to it, and parse its output which has the following
> form:
> 
>   926b07e694599d86cec668475071b32147c95034 commit 637
> 
> This would mean one call to git-cat-file for the whole 'blame' view,
> instead of one call to git-rev-parse per each unique commit in blame
> output.
> 
> 
> Yet another solution would be to change use of validate_refname() to
> validate_revision() when checking script parameters (CGI query or
> path_info), with validate_revision being something like the following:
> 
>   sub validate_revision {
>         my $rev = shift;
>         return validate_refname(strip_rev_suffixes($rev));
>   }
> 
> so we don't need to calculate $long_rev^, but can pass "$long_rev^" as
> 'hb' parameter.
> 
> This solution has the advantage that it can be easily adapted to
> future incremental blame output.
> 
> Acked-by: Luben Tuikov <ltuikov@yahoo.com>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>

(though I think the commit message is total overkill for such an obvious
change ;-)
