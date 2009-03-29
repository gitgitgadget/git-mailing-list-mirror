X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix ls-tree usage with dash-prefixed paths
Date: Sat, 28 Mar 2009 23:10:45 -0700
Message-ID: <20090329061045.GA29721@dcvr.yhbt.net>
References: <22719363.post@talk.nabble.com> <20090326130213.GC3114@atjola.homenet> <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com> <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com> <20090329060858.GB15773@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Mar 2009 06:11:02 +0000 (UTC)
Cc: git@vger.kernel.org, Anton Gyllenberg <anton@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Content-Disposition: inline
In-Reply-To: <20090329060858.GB15773@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1LnoFm-0007wJ-J6 for gcvg-git-2@gmane.org; Sun, 29 Mar 2009
 08:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751928AbZC2GKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009
 02:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZC2GKr
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 02:10:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38060 "EHLO dcvr.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751404AbZC2GKr
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 02:10:47 -0400
Received: from localhost (unknown [127.0.2.5]) by dcvr.yhbt.net (Postfix)
 with ESMTP id C2722113088; Sun, 29 Mar 2009 06:10:45 +0000 (UTC)
Sender: git-owner@vger.kernel.org

To find the blob object name given a tree and pathname, we were
incorrectly calling "git ls-tree" with a "--" argument followed
by the pathname of the file we wanted to get.

  git ls-tree <TREE> -- --dashed/path/name.c

Unlike many command-line interfaces, the "--" alone does not
symbolize the end of non-option arguments on the command-line.

ls-tree interprets the "--" as a prefix to match against, thus
the entire contents of the --dashed/* hierarchy would be
returned because the "--" matches "--dashed" and every path
under it.

Thanks to Anton Gyllenberg for pointing me toward the
Twisted repository as a real-world example of this case.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Junio: This can go to maint.  Thanks

 git-svn.perl |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 8be6be0..f21cfb4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3387,15 +3387,18 @@ sub delete_entry {
 	return undef if ($gpath eq '');
 
 	# remove entire directories.
-	if (command('ls-tree', $self->{c}, '--', $gpath) =~ /^040000 tree/) {
+	my ($tree) = (command('ls-tree', '-z', $self->{c}, "./$gpath")
+	                 =~ /\A040000 tree ([a-f\d]{40})\t\Q$gpath\E\0/);
+	if ($tree) {
 		my ($ls, $ctx) = command_output_pipe(qw/ls-tree
 		                                     -r --name-only -z/,
-				                     $self->{c}, '--', $gpath);
+				                     $tree);
 		local $/ = "\0";
 		while (<$ls>) {
 			chomp;
-			$self->{gii}->remove($_);
-			print "\tD\t$_\n" unless $::_q;
+			my $rmpath = "$gpath/$_";
+			$self->{gii}->remove($rmpath);
+			print "\tD\t$rmpath\n" unless $::_q;
 		}
 		print "\tD\t$gpath/\n" unless $::_q;
 		command_close_pipe($ls, $ctx);
@@ -3414,8 +3417,8 @@ sub open_file {
 	goto out if is_path_ignored($path);
 
 	my $gpath = $self->git_path($path);
-	($mode, $blob) = (command('ls-tree', $self->{c}, '--', $gpath)
-	                     =~ /^(\d{6}) blob ([a-f\d]{40})\t/);
+	($mode, $blob) = (command('ls-tree', '-z', $self->{c}, "./$gpath")
+	                     =~ /\A(\d{6}) blob ([a-f\d]{40})\t\Q$gpath\E\0/);
 	unless (defined $mode && defined $blob) {
 		die "$path was not found in commit $self->{c} (r$rev)\n";
 	}
-- 
