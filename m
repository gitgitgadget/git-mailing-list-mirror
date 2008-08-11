From: Marcus Griep <marcus@griep.us>
Subject: [PATCH 3/3] git-svn: Reduce temp file usage when dealing with non-links
Date: Mon, 11 Aug 2008 11:53:55 -0400
Message-ID: <1218470035-13864-4-git-send-email-marcus@griep.us>
References: <489DBB8A.2060207@griep.us>
 <1218470035-13864-1-git-send-email-marcus@griep.us>
 <1218470035-13864-2-git-send-email-marcus@griep.us>
 <1218470035-13864-3-git-send-email-marcus@griep.us>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 17:55:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSZk8-00080k-3p
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797AbYHKPyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755785AbYHKPx6
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:53:58 -0400
Received: from boohaunt.net ([209.40.206.144]:33691 "EHLO boohaunt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755720AbYHKPx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:53:57 -0400
Received: by boohaunt.net (Postfix, from userid 1000)
	id E6CED1878CE8; Mon, 11 Aug 2008 11:53:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc2.6.g8eda3
In-Reply-To: <1218470035-13864-3-git-send-email-marcus@griep.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91950>

Currently, in sub 'close_file', git-svn creates a temporary file and
copies the contents of the blob to be written into it. This is useful
for symlinks because svn stores symlinks in the form:

link $FILE_PATH

Git creates a blob only out of '$FILE_PATH' and uses file mode to
indicate that the blob should be interpreted as a symlink.

As git-hash-object is invoked with --stdin-paths, a duplicate of the
link from svn must be created that leaves off the first five bytes,
i.e. 'link '. However, this is wholly unnecessary for normal blobs,
though, as we already have a temp file with their contents. Copying
the entire file gains nothing, and effectively requires a file to be
written twice before making it into the object db.

This patch corrects that issue, holding onto the substr-like
duplication for symlinks, but skipping it altogether for normal blobs
by reusing the existing temp file.

Signed-off-by: Marcus Griep <marcus@griep.us>
---
 git-svn.perl |   43 ++++++++++++++++++++-----------------------
 1 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0937918..f53afaa 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3281,36 +3281,33 @@ sub close_file {
 				    "expected: $exp\n    got: $got\n";
 			}
 		}
-		sysseek($fh, 0, 0) or croak $!;
 		if ($fb->{mode_b} == 120000) {
-			eval {
-				sysread($fh, my $buf, 5) == 5 or croak $!;
-				$buf eq 'link ' or die "$path has mode 120000",
-						       " but is not a link";
-			};
-			if ($@) {
-				warn "$@\n";
-				sysseek($fh, 0, 0) or croak $!;
-			}
-		}
-
-		my $tmp_fh = Git::temp_acquire('svn_hash');
-		my $result;
-		while ($result = sysread($fh, my $string, 1024)) {
-			my $wrote = syswrite($tmp_fh, $string, $result);
-			defined($wrote) && $wrote == $result
-				or croak("write $tmp_fh->filename: $!\n");
-		}
-		defined $result or croak $!;
+			sysseek($fh, 0, 0) or croak $!;
+			sysread($fh, my $buf, 5) == 5 or croak $!;
 
+			unless ($buf eq 'link ') {
+				warn "$path has mode 120000",
+						" but is not a link\n";
+			} else {
+				my $tmp_fh = Git::temp_acquire('svn_hash');
+				my $result;
+				while ($result = sysread($fh, my $string, 1024)) {
+					my $wrote = syswrite($tmp_fh, $string, $result);
+					defined($wrote) && $wrote == $result
+						or croak("write $tmp_fh->filename: $!\n");
+				}
+				defined $result or croak $!;
 
-		Git::temp_release($fh, 1);
+				($fh, $tmp_fh) = ($tmp_fh, $fh);
+				Git::temp_release($tmp_fh, 1);
+			}
+		}
 
-		$hash = $::_repository->hash_and_insert_object($tmp_fh->filename);
+		$hash = $::_repository->hash_and_insert_object($fh->filename);
 		$hash =~ /^[a-f\d]{40}$/ or die "not a sha1: $hash\n";
 
 		Git::temp_release($fb->{base}, 1);
-		Git::temp_release($tmp_fh, 1);
+		Git::temp_release($fh, 1);
 	} else {
 		$hash = $fb->{blob} or die "no blob information\n";
 	}
-- 
1.6.0.rc2.6.g8eda3
