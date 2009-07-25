From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git svn: the branch command no longer needs the full
	path
Date: Sat, 25 Jul 2009 04:10:44 -0700
Message-ID: <20090725111044.GA7969@dcvr.yhbt.net>
References: <7vd47r298e.fsf@alter.siamese.dyndns.org> <20090724093847.GA20338@dcvr.yhbt.net> <7vk51ykm42.fsf@alter.siamese.dyndns.org> <20090725103821.GA13534@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mattias Nissler <mattias.nissler@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 13:11:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUfA2-0006IF-RC
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 13:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbZGYLKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 07:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbZGYLKp
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 07:10:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50423 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbZGYLKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 07:10:45 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id D0B991F791;
	Sat, 25 Jul 2009 11:10:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090725103821.GA13534@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124003>

This was introduced in 0b2af457a49e3b00d47d556d5301934d27909db8
("Fix branch detection when repository root is inaccessible")
but reintroduced in the previous commit.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

  Also pushed out to git://git.bogomips.org/git-svn along with some
  other changes:

  # I removed the "-" in "git svn" in the pushed out version of
  # "git svn: revert default behavior for --minimize-url"
  Eric Wong (4):
        git svn: revert default behavior for --minimize-url
        git svn: the branch command no longer needs the full path
        t9142: remember to stop httpd if it was used
        git svn: avoid escaping '/' when renaming/copying files

  # I thought I had pushed this out earlier:
  Robert Allan Zeh (1):
        git svn: add gc command

 git-svn.perl                         |   19 ++++++++++++++++---
 t/t9141-git-svn-multiple-branches.sh |    8 ++++----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 10b77ad..9808597 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -666,9 +666,22 @@ sub cmd_branch {
 			}
 		}
 		unless (defined $glob) {
-			die "Unknown ",
-			    $_tag ? "tag" : "branch",
-			    " destination $_branch_dest\n";
+			my $dest_re = qr/\b\Q$_branch_dest\E\b/;
+			foreach my $g (@{$allglobs}) {
+				$g->{path}->{left} =~ /$dest_re/ or next;
+				if (defined $glob) {
+					die "Ambiguous destination: ",
+					    $_branch_dest, "\nmatches both '",
+					    $glob->{path}->{left}, "' and '",
+					    $g->{path}->{left}, "'\n";
+				}
+				$glob = $g;
+			}
+			unless (defined $glob) {
+				die "Unknown ",
+				    $_tag ? "tag" : "branch",
+				    " destination $_branch_dest\n";
+			}
 		}
 	}
 	my ($lft, $rgt) = @{ $glob->{path} }{qw/left right/};
diff --git a/t/t9141-git-svn-multiple-branches.sh b/t/t9141-git-svn-multiple-branches.sh
index cb9a6d2..3cd0671 100755
--- a/t/t9141-git-svn-multiple-branches.sh
+++ b/t/t9141-git-svn-multiple-branches.sh
@@ -99,22 +99,22 @@ test_expect_success 'Multiple branch or tag paths require -d' '
 
 test_expect_success 'create new branches and tags' '
 	( cd git_project &&
-		git svn branch -m "New branch 1" -d project/b_one New1 ) &&
+		git svn branch -m "New branch 1" -d b_one New1 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e b_one/New1/a.file ) &&
 
 	( cd git_project &&
-		git svn branch -m "New branch 2" -d project/b_two New2 ) &&
+		git svn branch -m "New branch 2" -d b_two New2 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e b_two/New2/a.file ) &&
 
 	( cd git_project &&
-		git svn branch -t -m "New tag 1" -d project/tags_A Tag1 ) &&
+		git svn branch -t -m "New tag 1" -d tags_A Tag1 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e tags_A/Tag1/a.file ) &&
 
 	( cd git_project &&
-		git svn tag -m "New tag 2" -d project/tags_B Tag2 ) &&
+		git svn tag -m "New tag 2" -d tags_B Tag2 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e tags_B/Tag2/a.file )
 '
-- 
Eric Wong
