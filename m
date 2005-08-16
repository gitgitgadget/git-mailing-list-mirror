From: martin@ng.eduforge.org (Martin Langhoff)
Subject: [PATCH] Add -k kill keyword expansion option to git-cvsimport - revised
Date: Tue, 16 Aug 2005 17:39:29 +1200 (NZST)
Message-ID: <20050816053929.A97DD3300AD@ng.eduforge.org>
X-From: git-owner@vger.kernel.org Tue Aug 16 07:40:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4uAj-0004vQ-Jv
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 07:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVHPFjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 01:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbVHPFjc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 01:39:32 -0400
Received: from 34.70-85-230.reverse.theplanet.com ([70.85.230.34]:917 "EHLO
	ng.eduforge.org") by vger.kernel.org with ESMTP id S965116AbVHPFjb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 01:39:31 -0400
Received: by ng.eduforge.org (Postfix, from userid 3373)
	id A97DD3300AD; Tue, 16 Aug 2005 17:39:29 +1200 (NZST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Add -k kill keyword expansion option to git-cvsimport - revised

Early versions of git-cvsimport defaulted to using preexisting keyword
expansion settings. This change preserves compatibility with existing cvs
imports and allows new repository migrations to kill keyword expansion.

After exploration of the different -k modes in the cvs protocol, we use -kk
which kills keyword expansion wherever possible. Against the protocol
spec, -ko and -kb will sometimes expand keywords.

Should improve our chances of detecting merges and reduce imported
repository size.

Signed-off: Martin Langhoff <martin.langhoff@gmail.com>
---

 Documentation/git-cvsimport-script.txt |    7 ++++++-
 git-cvsimport-script                   |   12 +++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

3be96ff6fee32974b66fe1743eb701e93032fee5
diff --git a/Documentation/git-cvsimport-script.txt b/Documentation/git-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 --------
 'git-cvsimport-script' [ -o <branch-for-HEAD> ] [ -h ] [ -v ]
 			[ -d <CVSROOT> ] [ -p <options-for-cvsps> ]
-			[ -C <GIT_repository> ] [ -i ] [ <CVS_module> ]
+			[ -C <GIT_repository> ] [ -i ] [ -k ] [ <CVS_module> ]
 
 
 DESCRIPTION
@@ -38,6 +38,11 @@ OPTIONS
 	ensures the working directory and cache remain untouched and will
 	not create them if they do not exist.
 
+-k::
+	Kill keywords: will extract files with -kk from the CVS archive
+	to avoid noisy changesets. Highly recommended, but off by default
+	to preserve compatibility with early imported trees. 
+
 -o <branch-for-HEAD>::
 	The 'HEAD' branch from CVS is imported to the 'origin' branch within
 	the git repository, as 'HEAD' already has a special meaning for git.
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -28,19 +28,19 @@ use POSIX qw(strftime dup2);
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i);
+our($opt_h,$opt_o,$opt_v,$opt_k,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
        [ -o branch-for-HEAD ] [ -h ] [ -v ] [ -d CVSROOT ]
        [ -p opts-for-cvsps ] [ -C GIT_repository ] [ -z fuzz ]
-       [ -i ] [ CVS_module ]
+       [ -i ] [ -k ] [ CVS_module ]
 END
 	exit(1);
 }
 
-getopts("hivo:d:p:C:z:") or usage();
+getopts("hivko:d:p:C:z:") or usage();
 usage if $opt_h;
 
 @ARGV <= 1 or usage();
@@ -218,8 +218,10 @@ sub _file {
 	my($self,$fn,$rev) = @_;
 	$self->{'socketo'}->write("Argument -N\n") or return undef;
 	$self->{'socketo'}->write("Argument -P\n") or return undef;
-	# $self->{'socketo'}->write("Argument -ko\n") or return undef;
-	# -ko: Linus' version doesn't use it
+	# -kk: Linus' version doesn't use it - defaults to off
+	if ($opt_k) {
+	    $self->{'socketo'}->write("Argument -kk\n") or return undef;
+	}
 	$self->{'socketo'}->write("Argument -r\n") or return undef;
 	$self->{'socketo'}->write("Argument $rev\n") or return undef;
 	$self->{'socketo'}->write("Argument --\n") or return undef;
