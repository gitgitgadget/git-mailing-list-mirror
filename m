From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: understand grafts when doing dcommit
Date: Sat, 8 Sep 2007 16:33:08 -0700
Message-ID: <20070908233308.GA14915@mayonaise>
References: <20070908050146.GA28855@soma> <045501c7f23f$c359c450$5267a8c0@Jocke> <7vfy1pyluy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:52:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIP0-0004Ds-Sr
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:44:22 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IU9or-0007Uy-As
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 01:34:29 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IU9ol-0007fD-D3
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 01:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbXIHXdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 19:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbXIHXdL
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 19:33:11 -0400
Received: from hand.yhbt.net ([66.150.188.102]:36664 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbXIHXdK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 19:33:10 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 70EEA2DC08D;
	Sat,  8 Sep 2007 16:33:08 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 08 Sep 2007 16:33:08 -0700
Content-Disposition: inline
In-Reply-To: <7vfy1pyluy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.0, required=12.0, autolearn=disabled, UIO_VGER=-3)
X-UiO-Scanned: 1425C07E6CC99ED0EE7490690408CF87E750BDFD
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -29 maxlevel 200 minaction 2 bait 0 mail/h: 21 total 517778 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58150>

Use the rev-list --parents functionality to read the parents
of the commit.  cat-file only shows the raw object with the
original parents and doesn't take into account grafts; so
we'll rely on rev-list machinery for the smarts here.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Junio C Hamano <gitster@pobox.com> wrote:
  > "Joakim Tjernlund" <joakim.tjernlund@transmode.se> writes:
  > 
  > > hmm, I think git-cat-file is to blame.
  > > git-cat-file commit da783cce390ce013b19f1d308ea6813269c6a6b5 does
  > > not list list any parent...
  > 
  > The plumbing cat-file does not deal with grafts and this is
  > deliberate.  Otherwise you would not be able to find the true
  > set of parents when you'd want to.
  > 
  > So do not blame cat-file, but blame the Porcelain that uses
  > cat-file to read a commit object, without annotating what it
  > read with what is in grafts, in this case your command line
  > experiment ;-).
  > 
  > The log family of commands and rev-list plumbing while
  > traversing commit ancestry chain do take grafts into account.
  > 
  > One caveat is pretty=raw output format shows true parents
  > without grafts on "parent " header line, while the "commit "
  > fake header prepended in the output for each commit shows the
  > parents that takes into account.
  > 
  > To illustrate, if you forge the history and say the parent of
  > 1ddea77 is 5da1606 (when the true parent is 820eca68) with
  > grafts mechanism, here is what happens:
  > 
  >     $ echo '1ddea77e449ef28d8a7c74521af21121ab01abc0 5da1606d0bf5b970fadfa0ca91618a1e871f6755' >.git/info/grafts
  >     $ git show -s --pretty=raw --parents 1ddea77
  >     commit 1ddea77e449ef28d8a7c74521af21121ab01abc0 5da1606d0bf5b970fadfa0ca91618a1e871f6755
  >     tree e9e61bc801438062978ff47b0963c536ed1e51a9
  >     parent 820eca68c2577d7499d203d7f4f7ae479b577683
  >     author Nick Hengeveld <nickh@reactrix.com> 1127757131 -0700
  >     committer Junio C Hamano <junkio@cox.net> 1127805558 -0700
  > 
  >         [PATCH] Return CURL error message when object transfer fails
  > 
  >         Return CURL error message when object transfer fails
  >         ...

  Interesting.  I didn't know about the --parents option before.

 git-svn.perl |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index fbd4691..f818160 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -841,14 +841,9 @@ sub working_head_info {
 
 sub read_commit_parents {
 	my ($parents, $c) = @_;
-	my ($fh, $ctx) = command_output_pipe(qw/cat-file commit/, $c);
-	while (<$fh>) {
-		chomp;
-		last if '';
-		/^parent ($sha1)/ or next;
-		push @{$parents->{$c}}, $1;
-	}
-	close $fh; # break the pipe
+	chomp(my $p = command_oneline(qw/rev-list --parents -1/, $c));
+	$p =~ s/^($c)\s*// or die "rev-list --parents -1 $c failed!\n";
+	@{$parents->{$c}} = split(/ /, $p);
 }
 
 sub linearize_history {
-- 
Eric Wong
