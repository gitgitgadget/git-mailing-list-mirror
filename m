From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH] git-svnimport: Don't assume that copied files haven't changed
Date: Fri, 07 Apr 2006 08:06:09 +0200
Message-ID: <20060407060609.9487.83229.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Apr 07 08:06:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRk6w-00064V-5m
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 08:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWDGGGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 02:06:19 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWDGGGT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 02:06:19 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:16114 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932289AbWDGGGS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Apr 2006 02:06:18 -0400
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060407060611.ZGGB16061.mxfep01.bredband.com@backpacker.hemma.treskal.com>
          for <git@vger.kernel.org>; Fri, 7 Apr 2006 08:06:11 +0200
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id EE3BC16BC
	for <git@vger.kernel.org>; Fri,  7 Apr 2006 08:06:09 +0200 (CEST)
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18492>

Don't assume that a file that SVN claims was copied from somewhere
else is bit-for-bit identical with its parent, since SVN allows
changes to copied files before they are committed.

Without this fix, such copy-modify-commit operations causes the
imported file to lack the "modify" part -- that is, we get subtle data
corruption.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 git-svnimport.perl |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index 114784f..4d5371c 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -616,9 +616,7 @@ sub commit {
 			}
 			if(($action->[0] eq "A") || ($action->[0] eq "R")) {
 				my $node_kind =3D node_kind($branch,$path,$revision);
-				if($action->[1]) {
-					copy_path($revision,$branch,$path,$action->[1],$action->[2],$node=
_kind,\@new,\@parents);
-				} elsif ($node_kind eq $SVN::Node::file) {
+				if ($node_kind eq $SVN::Node::file) {
 					my $f =3D get_file($revision,$branch,$path);
 					if ($f) {
 						push(@new,$f) if $f;
@@ -627,8 +625,15 @@ sub commit {
 						print STDERR "$revision: $branch: could not fetch '$opath'\n";
 					}
 				} elsif ($node_kind eq $SVN::Node::dir) {
-					get_ignore(\@new, \@old, $revision,
-						   $branch,$path);
+					if($action->[1]) {
+						copy_path($revision, $branch,
+							  $path, $action->[1],
+							  $action->[2], $node_kind,
+							  \@new, \@parents);
+					} else {
+						get_ignore(\@new, \@old, $revision,
+							   $branch, $path);
+					}
 				}
 			} elsif ($action->[0] eq "D") {
 				push(@old,$path);
