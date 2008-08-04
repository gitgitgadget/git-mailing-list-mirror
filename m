From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] Git.pm: localise $? in command_close_bidi_pipe()
Date: Mon, 4 Aug 2008 17:08:27 +0530
Message-ID: <20080804113827.GA1239@toroid.org>
References: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com> <20080804075313.21325.28396.stgit@localhost> <7vtze12oij.fsf@gitster.siamese.dyndns.org> <20080804082117.GI10151@machine.or.cz> <7vhca12n2l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 13:39:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPyPU-0000xK-PG
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 13:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbYHDLic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 07:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbYHDLic
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 07:38:32 -0400
Received: from fugue.toroid.org ([85.10.196.113]:48554 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753188AbYHDLib (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 07:38:31 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id E94E05583C6;
	Mon,  4 Aug 2008 13:38:29 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 114ABADC36D; Mon,  4 Aug 2008 17:08:27 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vhca12n2l.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91343>

Git::DESTROY calls _close_cat_blob and _close_hash_and_insert_object,
which in turn call command_close_bidi_pipe, which calls waitpid, which
alters $?. If this happens during global destruction, it may alter the
program's exit status unexpectedly. Making $? local to the function
solves the problem.

(The problem was discovered due to a failure of test #8 in
t9106-git-svn-commit-diff-clobber.sh.)

Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---

At 2008-08-04 01:37:06 -0700, gitster@pobox.com wrote:
>
> After queueing it, I actually had to revert it, because it seems to
> break git-svn (t9106-git-svn-commit-diff-clobber.sh, test #8), and I
> am about to go to bed.

This patch in addition to my earlier one should solve the problem.

For test #8 to fail, the "git svn dcommit" must succeed, but in both
cases (i.e. without my patch applied, or with), the rebase fails:

    rebase refs/remotes/git-svn: command returned error: 1

This results in a call to "fatal $@" on git-svn.perl:254, which calls
"exit 1", and test_must_fail is happy.

With my patch, however, Git::DESTROY calls the two _close functions
during global destruction, which in turn call command_close_bidi_pipe,
which calls waitpid with sensible arguments this time, which alters $?,
thus altering the exit status of the dcommit itself to 0. Oops.

All of "make test" passes for me after this change.

-- ams

 perl/Git.pm |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 2ef437f..3b6707b 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -417,6 +417,7 @@ have more complicated structure.
 =cut
 
 sub command_close_bidi_pipe {
+	local $?;
 	my ($pid, $in, $out, $ctx) = @_;
 	foreach my $fh ($in, $out) {
 		unless (close $fh) {
-- 
1.6.0.rc0.43.g2aa74
