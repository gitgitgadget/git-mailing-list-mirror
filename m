From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] Added an option to cvsimport to specify email domain
Date: Wed, 07 Sep 2005 10:00:02 +0200
Message-ID: <u5tzmqp8fzx.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 07 10:03:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECutA-00028c-Dx
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 10:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVIGICb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Sep 2005 04:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVIGICb
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 04:02:31 -0400
Received: from main.gmane.org ([80.91.229.2]:9196 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932073AbVIGICa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 04:02:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ECurr-0001sh-HS
	for git@vger.kernel.org; Wed, 07 Sep 2005 10:01:15 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 10:01:15 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 10:01:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:o0s1MuEsDn447afF7M/UFgf64lM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8167>

The authorship info in commits created by git-cvsimport-script
only contains the username of the CVS committer.  This patch
adds a flag -e <domain> to git-cvsimport-script that makes it
possible to specify an email domain that is added to all email
addresses in the commit "author" and "committer" fields.

---
I have stopped using cvsimport, because cvsps seems to produce bad
output on the repository I'm using it with, but I had already prepared
this patch.

 Documentation/git-cvsimport-script.txt |    8 +++++++-
 git-cvsimport-script                   |   18 +++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

cabbc2b5cae2dcd892d02a3c679698cdfb3b9de5
diff --git a/Documentation/git-cvsimport-script.txt b/Documentation/git=
-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -12,7 +12,9 @@ SYNOPSIS
 'git-cvsimport-script' [ -o <branch-for-HEAD> ] [ -h ] [ -v ]
 			[ -d <CVSROOT> ] [ -p <options-for-cvsps> ]
 			[ -C <GIT_repository> ] [ -i ] [ -k ]
-			[ -s <subst> ] [ -m ] [ -M regex ] [ <CVS_module> ]
+			[ -s <subst> ] [ -m ] [ -M regex ]
+			[ -e <domain> ]
+			[ <CVS_module> ]
=20
=20
 DESCRIPTION
@@ -86,6 +88,10 @@ OPTIONS
 -s <subst>::
 	Substitute the character "/" in branch names with <subst>
=20
+-e <domain>::
+        Append '@<domain>' to the author name to use as the email
+        address in commit objects.
+
 OUTPUT
 ------
 If '-v' is specified, the script reports what it is doing.
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -29,19 +29,20 @@ use IPC::Open2;
 $SIG{'PIPE'}=3D"IGNORE";
 $ENV{'TZ'}=3D"UTC";
=20
-our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$op=
t_i,$opt_s,$opt_m,$opt_M);
+our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$op=
t_i,$opt_s,$opt_m,$opt_M,$opt_e);
=20
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT]
        [-p opts-for-cvsps] [-C GIT_repository] [-z fuzz]
-       [-i] [-k] [-u] [-s subst] [-m] [-M regex] [CVS_module]
+       [-i] [-k] [-u] [-s subst] [-m] [-M regex] [ -e email-domain ]
+       [CVS_module]
 END
 	exit(1);
 }
=20
-getopts("hivmkuo:d:p:C:z:s:M:") or usage();
+getopts("hivmkuo:d:p:C:z:s:M:e:") or usage();
 usage if $opt_h;
=20
 @ARGV <=3D 1 or usage();
@@ -85,6 +86,13 @@ if ($opt_M) {
 	push (@mergerx, qr/$opt_M/);
 }
=20
+our $email_suffix;
+if ($opt_e) {
+    $email_suffix =3D "@"."$opt_e";
+} else {
+    $email_suffix =3D "";
+}
+
 select(STDERR); $|=3D1; select(STDOUT);
=20
=20
@@ -592,10 +600,10 @@ my $commit =3D sub {
=20
 		exec("env",
 			"GIT_AUTHOR_NAME=3D$author",
-			"GIT_AUTHOR_EMAIL=3D$author",
+			"GIT_AUTHOR_EMAIL=3D$author$email_suffix",
 			"GIT_AUTHOR_DATE=3D".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($dat=
e)),
 			"GIT_COMMITTER_NAME=3D$author",
-			"GIT_COMMITTER_EMAIL=3D$author",
+			"GIT_COMMITTER_EMAIL=3D$author$email_suffix",
 			"GIT_COMMITTER_DATE=3D".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($=
date)),
 			"git-commit-tree", $tree,@par);
 		die "Cannot exec git-commit-tree: $!\n";

--=20
David K=E5gedal
