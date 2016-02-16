From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PULL] svn pathnameencoding for git svn dcommit
Date: Tue, 16 Feb 2016 06:33:57 +0000
Message-ID: <20160216063357.GA17455@dcvr.yhbt.net>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
 <20160208225806.GA3487@dcvr.yhbt.net>
 <20160215005210.GA31141@dcvr.yhbt.net>
 <56C297A9.2080705@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alex.crezoff@gmail.com
To: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:34:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVZD0-0007ik-BR
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 07:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbcBPGd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 01:33:59 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58172 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785AbcBPGd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 01:33:58 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 894CB20338;
	Tue, 16 Feb 2016 06:33:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56C297A9.2080705@f2.dion.ne.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286326>

Junio, sorry about basing on next, I somehow
thought I was going to need to depend on something there.
Updated pull below if Kazutoshi can run the test effectively.

Kazutoshi Satoda <k_satoda@f2.dion.ne.jp> wrote:
> Thank you for the tests. But, on my environment, both of them failed
> unexpectedly. (Windows 7 SP1, x86_64 Cygwin, LANG=ja_JP.UTF-8)
> 
> For now, I don't have enough time to investigate this further. Let me
> just share the result.

<snip>

> > Untracked files:
> >         svnrepo/
> >         "\357\202\201\357\202\202"
> >         "\357\202\201\357\202\207"
> >

<snip>

> I can't see how "\357\202\201\357\202\202" came as output in the test.

I wonder if it's a shell or printf portability problem.  I've
repushed the branch against master and implemented the weird
character use inside Perl scripts.

Can you give it a try?

The following changes since commit 494398473714dcbedb38b1ac79b531c7384b3bc4:

  Sixth batch for the 2.8 cycle (2016-02-10 14:24:14 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn.git ks/svn-pathnameencoding

for you to fetch changes up to 7d7ea44ea5a1a38ee36402e6709e64c05650ba46:

  git-svn: apply "svn.pathnameencoding" before URL encoding (2016-02-16 06:25:01 +0000)

----------------------------------------------------------------
Kazutoshi Satoda (2):
      git-svn: enable "svn.pathnameencoding" on dcommit
      git-svn: apply "svn.pathnameencoding" before URL encoding

 perl/Git/SVN/Editor.pm                   |  4 +++-
 t/t9115-git-svn-dcommit-funky-renames.sh | 16 ++++++++++++++--
 t/t9115/inf.perl                         | 12 ++++++++++++
 t/t9115/neq.perl                         |  5 +++++
 4 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 t/t9115/inf.perl
 create mode 100644 t/t9115/neq.perl

 t/t9115-git-svn-dcommit-funky-renames.sh | 16 +++-------------
 t/t9115/inf.perl                         | 12 ++++++++++++
 t/t9115/neq.perl                         |  5 +++++
 3 files changed, 20 insertions(+), 13 deletions(-)

Interdiff of test changes:

diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 9828f05..94698fe 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -84,25 +84,15 @@ test_expect_success 'git svn rebase works inside a fresh-cloned repository' '
 		test -e test-rebase
 	)'
 
-test_expect_success 'svn.pathnameencoding=cp932 new file on dcommit' '
-	neq=$(printf "\201\202") &&
+test_expect_success PERL 'svn.pathnameencoding=cp932 new file on dcommit' '
 	git config svn.pathnameencoding cp932 &&
-	echo neq >"$neq" &&
-	git add "$neq" &&
+	"$PERL_PATH" -w "$TEST_DIRECTORY"/t9115/neq.perl &&
 	git commit -m "neq" &&
 	git svn dcommit
 '
 
 test_expect_success 'svn.pathnameencoding=cp932 rename on dcommit' '
-	inf=$(printf "\201\207") &&
-	git config svn.pathnameencoding cp932 &&
-	echo inf >"$inf" &&
-	git add "$inf" &&
-	git commit -m "inf" &&
-	git svn dcommit &&
-	git mv "$inf" inf &&
-	git commit -m "inf rename" &&
-	git svn dcommit
+	"$PERL_PATH" -w "$TEST_DIRECTORY"/t9115/inf.perl
 '
 
 stop_httpd
diff --git a/t/t9115/inf.perl b/t/t9115/inf.perl
new file mode 100644
index 0000000..0adcfc7
--- /dev/null
+++ b/t/t9115/inf.perl
@@ -0,0 +1,12 @@
+use strict;
+my $path = "\201\207";
+open my $fh, '>', $path or die $!;
+close $fh or die $!;
+sub run { system(@_) == 0 or die join(' ', @_) . ": $?" }
+run(qw(git config svn.pathnameencoding cp932));
+run(qw(git add), $path);
+run(qw(git commit -m inf));
+run(qw(git svn dcommit));
+run(qw(git mv), $path, 'inf');
+run(qw(git commit -m inf-rename));
+run(qw(git svn dcommit));
diff --git a/t/t9115/neq.perl b/t/t9115/neq.perl
new file mode 100644
index 0000000..91b1061
--- /dev/null
+++ b/t/t9115/neq.perl
@@ -0,0 +1,5 @@
+use strict;
+my $path = "\201\202";
+open my $fh, '>', $path or die $!;
+close $fh or die $!;
+exec(qw(git add), $path);
