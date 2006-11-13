X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Rework cvsexportcommit to handle binary files for all cases.
Date: Mon, 13 Nov 2006 21:40:01 +0100
Message-ID: <200611132140.01578.robin.rosenberg@dewire.com>
References: <200611121629.43104.robin.rosenberg@dewire.com> <7vmz6wark9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hgNWFDPX1oDDsB0"
NNTP-Posting-Date: Mon, 13 Nov 2006 20:38:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <7vmz6wark9.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31321>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjiZV-00039A-U3 for gcvg-git@gmane.org; Mon, 13 Nov
 2006 21:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755275AbWKMUiX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 15:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbWKMUiW
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 15:38:22 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12884 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1755275AbWKMUiW (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 15:38:22 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id C54B3802654; Mon, 13 Nov 2006 21:34:51 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 22612-04; Mon, 13 Nov
 2006 21:34:51 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 15F3F800784; Mon, 13 Nov 2006 21:34:51 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

--Boundary-00=_hgNWFDPX1oDDsB0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

And the updated fix for spaces in file names

-- robin

--Boundary-00=_hgNWFDPX1oDDsB0
Content-Type: text/plain;
  charset="iso-8859-1";
  name="0002-Make-cvsexportcommit-work-with-filenames-containing-spaces.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Make-cvsexportcommit-work-with-filenames-containing-spaces.txt"

=46rom bf4030e88bfd5b5f1a84b19a1be36f8178f2b24a Mon Sep 17 00:00:00 2001
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Mon, 13 Nov 2006 21:29:06 +0100
Subject: [PATCH] Make cvsexportcommit work with filenames containing spaces.

Binary files are except to this so far.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index facb4667eefe79cbd4d29e542ec5e8111a7a973c..017648c8c252e60151320f09a42=
8f0bff6ae46de 100755
=2D-- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -4,7 +4,7 @@ # Known limitations:
 # - does not propagate permissions
 # - tells "ready for commit" even when things could not be completed
 #   (not sure this is true anymore, maybe more testing is needed)
=2D# - does not handle whitespace in pathnames at all.
+# - Fedora/RHEL uses patch 2.5.4 which doesn't handles spaces in file names
=20
 use strict;
 use Getopt::Std;
@@ -121,7 +121,14 @@ #print @files;
 $? && die "Error in git-diff-tree";
 foreach my $f (@files) {
     chomp $f;
=2D    my @fields =3D split(m!\s+!, $f);
+    $f =3D~ m/^(\S+) (\S+) (\S+) (\S+) (\S+)	(.*)/;
+    my @fields =3D ();
+    $fields[++$#fields] =3D $1;
+    $fields[++$#fields] =3D $2;
+    $fields[++$#fields] =3D $3;
+    $fields[++$#fields] =3D $4;
+    $fields[++$#fields] =3D $5;
+    $fields[++$#fields] =3D $6;
     if ($fields[4] eq 'A') {
         my $path =3D $fields[5];
 	push @afiles, $path;
@@ -256,7 +263,19 @@ my $fuzz =3D $opt_p ? 0 : 2;
 print "Patching non-binary files\n";
=20
 if (scalar(@afiles)+scalar(@dfiles)+scalar(@mfiles) !=3D scalar(@bfiles)) {
=2D    print `(git-diff-tree -p $parent -p $commit | patch -p1 -F $fuzz ) 2=
>&1`;
+    my $saveslash =3D $/;
+    undef $/;
+
+    open DIFF, "git-diff-tree -p $parent -p $commit|" || die "Cannot diff";
+    open PATCH, "|tee \$\$.diff|patch -p1 -F $fuzz" || die "Cannot patch";
+    my $delta =3D <DIFF>;
+    close DIFF || die "Could not diff";
+    unless (defined $ENV{'GIT_CVSEXPORTCOMMIT_NO_SPACES'}) {
+        $delta =3D~ s/\n(index [^\n]*)\n(--- [^\n]*)\n(\+\+\+ [^\n]*)\n(@@=
[^\n]*@@)\n/$1\n$2\t\n$3\t\n$4\n/sg
+    }
+    print PATCH $delta;
+    close PATCH || die "Could not patch";
+    $/ =3D $saveslash;
 }
=20
 my $dirtypatch =3D 0;
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 0ae03f80694a5d4ca3e61b40f6787a89fe8a496e..bf40d12f27ddde562da8f852634=
9df1784a48ae8 100755
=2D-- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -142,4 +142,28 @@ test_expect_success \
      diff F/newfile6.png ../F/newfile6.png
      )'=20
=20
+test_expect_success \
+     'New file with spaces in file name' \
+     'mkdir G &&
+      echo ok then >"G/with spaces.txt" &&
+      git add "G/with spaces.txt" && \
+      git commit -a -m "With spaces" &&
+      id=3D$(git rev-list --max-count=3D1 HEAD) &&
+      (cd "$CVSWORK" &&
+      git-cvsexportcommit -c $id &&
+      test $(cat G/CVS/Entries|wc -l) =3D 1
+      )'
+
+test_expect_success \
+     'Update file with spaces in file name' \
+     'echo Ok then >>"G/with spaces.txt" &&
+      git add "G/with spaces.txt" &&
+      git commit -a -m "Update with spaces" &&
+      id=3D$(git rev-list --max-count=3D1 HEAD) &&
+      (cd "$CVSWORK" &&
+      git-cvsexportcommit -c $id &&
+      test $(cat G/CVS/Entries|wc -l) =3D 1
+      )'
+    =20
+
 test_done
=2D-=20
1.4.2


