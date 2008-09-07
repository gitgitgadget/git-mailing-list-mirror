From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Use GIT_COMMITTER_IDENT instead of hardcoded values in import-tars.perl
Date: Sun,  7 Sep 2008 10:52:11 +0200
Message-ID: <1220777531-28934-1-git-send-email-mh@glandium.org>
References: <7v3arixm8h.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 07 10:53:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcG1U-0002Wf-Cu
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 10:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbYIGIw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 04:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbYIGIwZ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 04:52:25 -0400
Received: from vuizook.err.no ([194.24.252.247]:48239 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbYIGIwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 04:52:25 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KcG0G-0005qg-JK; Sun, 07 Sep 2008 10:52:22 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KcG0B-0007XQ-HD; Sun, 07 Sep 2008 10:52:11 +0200
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <7v3arixm8h.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95130>

Signed-off-by: Mike Hommey <mh@glandium.org>
---

http://marc.info/?l=git&m=120385776127178&w=2:
> >  And that made me wonder if it wouldn't be worth, actually, to have
> > git config user.name and git config user.email return the "magic" values
> > gotten from guessing in ident.c when no value is in the config. That would
> > allow scripts, which have no other simple means to get the user name and
> > email, to have the same feature as builtins.
>
> Or perhaps use "git var GIT_COMMITTER_IDENT"?

The only problem I see with this approach is that lots of uses of
GIT_COMMITTER_IDENT require regex'ing the output to remove the date
(see git-am, old git-commit and git-tag...)

Maybe adding another variable not containing the date would be a
good idea?

 contrib/fast-import/import-tars.perl |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 23aeb25..814fb73 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -14,8 +14,9 @@ die "usage: import-tars *.tar.{gz,bz2,Z}\n" unless @ARGV;
 
 my $branch_name = 'import-tars';
 my $branch_ref = "refs/heads/$branch_name";
-my $committer_name = 'T Ar Creator';
-my $committer_email = 'tar@example.com';
+chomp(my $committer_ident = `git var GIT_COMMITTER_IDENT`);
+die 'You need to set user name and email'
+	unless ($committer_ident =~ s/(.+ <[^>]+>).*/\1/);
 
 open(FI, '|-', 'git', 'fast-import', '--quiet')
 	or die "Unable to start git fast-import: $!\n";
@@ -100,7 +101,7 @@ foreach my $tar_file (@ARGV)
 
 	print FI <<EOF;
 commit $branch_ref
-committer $committer_name <$committer_email> $commit_time +0000
+committer $committer_ident $commit_time +0000
 data <<END_OF_COMMIT_MESSAGE
 Imported from $tar_file.
 END_OF_COMMIT_MESSAGE
@@ -119,7 +120,7 @@ EOF
 	print FI <<EOF;
 tag $tar_name
 from $branch_ref
-tagger $committer_name <$committer_email> $commit_time +0000
+tagger $committer_ident $commit_time +0000
 data <<END_OF_TAG_MESSAGE
 Package $tar_name
 END_OF_TAG_MESSAGE
-- 
1.6.0.2.g2ebc0
