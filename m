From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn woes
Date: Fri, 27 Feb 2009 20:09:49 -0800
Message-ID: <20090228040949.GA13863@dcvr.yhbt.net>
References: <alpine.LFD.2.00.0902271442270.5511@xanadu.home> <86d4c5e00902271253y50eaef01x8ca837d3a0ed7ef6@mail.gmail.com> <20090228033108.GB28606@dcvr.yhbt.net> <7vtz6fgrdi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Deskin Miller <deskinm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 05:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdGXo-00021n-Jl
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 05:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbZB1EJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 23:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754508AbZB1EJv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 23:09:51 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44520 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341AbZB1EJv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 23:09:51 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477C21F799;
	Sat, 28 Feb 2009 04:09:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vtz6fgrdi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111747>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > I've been poking around at this for a bit, I am pretty confused
> > by this, too.  It's been a rough week, so I could be missing
> > something obvious...
> >
> > Junio: since 1.6.2 might be out the door before we have time to resolve
> > this, I'm leaning towards disabling the broken-symlink-workaround by
> > default for the release. It seems far more people are negatively
> > affected by the attempted fix around this rare problem than helped.
> 
> I agree that unfortunately is the message I am getting from the list ever
> since the feature was introduced.

OK, here goes:

>From 0985d9190d0f85b1285de4f23f87bdfd9e0c0fff Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Fri, 27 Feb 2009 19:40:16 -0800
Subject: [PATCH] git-svn: disable broken symlink workaround by default

Even though this will break things for some extremely rare
repositories used by broken Windows clients, it's probably not
worth enabling this by default as it has negatively affected
many more users than it has helped from what we've seen so far.

The extremely rare repositories that have broken symlinks in
them will be silently corrupted in import; but users can still
reenable this option and restart the import.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                     |    2 +-
 t/t9131-git-svn-empty-symlink.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 55702d0..959eb52 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3297,7 +3297,7 @@ sub new {
 sub _mark_empty_symlinks {
 	my ($git_svn, $switch_path) = @_;
 	my $bool = Git::config_bool('svn.brokenSymlinkWorkaround');
-	return {} if (defined($bool) && ! $bool);
+	return {} if (!defined($bool)) || (defined($bool) && ! $bool);
 
 	my %ret;
 	my ($rev, $cmt) = $git_svn->last_rev_commit;
diff --git a/t/t9131-git-svn-empty-symlink.sh b/t/t9131-git-svn-empty-symlink.sh
index 20529a8..8f35e29 100755
--- a/t/t9131-git-svn-empty-symlink.sh
+++ b/t/t9131-git-svn-empty-symlink.sh
@@ -83,6 +83,8 @@ EOF
 '
 
 test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" x'
+test_expect_success 'enable broken symlink workaround' \
+  '(cd x && git config svn.brokenSymlinkWorkaround true)'
 test_expect_success '"bar" is an empty file' 'test -f x/bar && ! test -s x/bar'
 test_expect_success 'get "bar" => symlink fix from svn' \
 		'(cd x && git svn rebase)'
@@ -97,4 +99,12 @@ test_expect_success 'get "bar" => symlink fix from svn' \
 		'(cd y && git svn rebase)'
 test_expect_success '"bar" does not become a symlink' '! test -L y/bar'
 
+# svn.brokenSymlinkWorkaround is unset
+test_expect_success 'clone using git svn' 'git svn clone -r1 "$svnrepo" z'
+test_expect_success '"bar" is an empty file' 'test -f z/bar && ! test -s z/bar'
+test_expect_success 'get "bar" => symlink fix from svn' \
+		'(cd z && git svn rebase)'
+test_expect_success '"bar" does not become a symlink' '! test -L z/bar'
+
+
 test_done
-- 
1.6.2.rc2.5.g0c347
