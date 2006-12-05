X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/5] git-svn: make test for SVK mirror path import
Date: Tue, 5 Dec 2006 00:40:05 -0800
Message-ID: <20061205084005.GA27236@soma>
References: <20061205051738.16552.8987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 08:40:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061205051738.16552.8987.stgit@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33318>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrVqV-0003zK-Qf for gcvg-git@gmane.org; Tue, 05 Dec
 2006 09:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968090AbWLEIkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 03:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968089AbWLEIkI
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 03:40:08 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43065 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968090AbWLEIkH
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 03:40:07 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 8F8A12DC034; Tue,  5 Dec 2006 00:40:05 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  5 Dec 2006
 00:40:05 -0800
To: Sam Vilain <sam@vilain.net>
Sender: git-owner@vger.kernel.org

Sam Vilain <sam@vilain.net> wrote:
> From:  <sam@vilain.net>
> 
> A manual test that sets up a repository that looks like an SVK depot,
> and then imports it to check that it looks like we mirrored the
> 'original' source.
> 
> There is also a minor modification to the git-svn test library shell
> file which sets a variable for the subversion repository's filesystem
> path.
> ---
> 
>  t/lib-git-svn.sh                   |    3 -
>  t/t9107-git-svn-svk-mirrorpaths.sh |   92 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+), 2 deletions(-)
> 
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 63c6703..dffd1fb 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -45,6 +45,5 @@ else
>  	svnadmin create "$svnrepo"
>  fi
>  
> +rawsvnrepo="$svnrepo"
>  svnrepo="file://$svnrepo"
> -
> -
> diff --git a/t/t9107-git-svn-svk-mirrorpaths.sh b/t/t9107-git-svn-svk-mirrorpaths.sh
> new file mode 100755
> index 0000000..130e786
> --- /dev/null
> +++ b/t/t9107-git-svn-svk-mirrorpaths.sh
> @@ -0,0 +1,92 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2006 Eric Wong

Huh? I didn't write this test.

> +test_description='git-svn on SVK mirror paths'
> +. ./lib-git-svn.sh
> +
> +if test -n "$GIT_SVN_NO_LIB" && test "$GIT_SVN_NO_LIB" -ne 0
> +then
> +	echo 'Skipping: only implemented with SVN libraries'
> +	test_done
> +	exit 0
> +fi
> +
> +# ok, people who don't have SVK installed probably don't care about
> +# this test.
> +
> +# we set up the repository manually, because even if SVK is installed
> +# it is difficult to use it in a way that is idempotent.
> +
> +# we are not yet testing merge tickets..
> +
> +uuid=b00bface-b1ff-c0ff-f0ff-b0bafe775e1e 
> +url=https://really.slow.server.com/foobar 

I had to use --whitespace=strip with git-am above.

> +test_expect_success 'multi-fetch an SVK mirror path' "git-svn multi-fetch"

I had to use the following patch to get the multi-fetch test to pass
with GIT_SVN_DELTA_FETCH=1. (I discovered it while running make -C t
full-svn-test)

Is it safe to assume that svk-mirrored URLs will _always_ be file://?
If so, then the delta fetching code should never be needed.

--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3017,8 +3017,7 @@ sub libsvn_fetch_delta {
 	my $ed = SVN::Git::Fetcher->new({ c => $last_commit, q => $_q });
 	my $reporter = $SVN->do_update($rev, '', 1, $ed, $pool);
 	my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
-	my (undef, $last_rev, undef) = cmt_metadata($last_commit);
-	$reporter->set_path('', $last_rev, 0, @lock, $pool);
+	$reporter->set_path('', ($rev - 1), 0, @lock, $pool);
 	$reporter->finish_report($pool);
 	$pool->clear;
 	unless ($ed->{git_commit_ok}) {

Also, unconditionally setting ($rev - 1) in the above patch disables the
ability to do squashed history[1] imports (not sure if anybody cares about
them, though).

[1] - like shallow clone, but shallow in the middle of history

> +test_expect_success 'got tag history OK' "test \`git-log --pretty=oneline remotes/tags/blah-1.0 | wc -l \` = 3"

But the above test breaks this one...

-- 
