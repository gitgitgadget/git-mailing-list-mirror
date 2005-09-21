From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Unexpected behavior in git-rev-list
Date: Wed, 21 Sep 2005 18:49:48 +0200
Message-ID: <20050921164948.GB23525@ebar091.ebar.dtu.dk>
References: <20050918144931.GA9561@ebar091.ebar.dtu.dk> <Pine.LNX.4.58.0509181013250.26803@g5.osdl.org> <20050918175847.GA10427@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 21 19:04:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7yD-0001aI-QR
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 19:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVIURBR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Sep 2005 13:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVIURBR
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 13:01:17 -0400
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:41097 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1751221AbVIURBQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 13:01:16 -0400
Received: (qmail 23954 invoked by uid 5842); 21 Sep 2005 16:49:48 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050918175847.GA10427@ebar091.ebar.dtu.dk>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9064>

On Sun, Sep 18, 2005 at 07:58:50PM +0200, Peter Eriksen wrote:
=2E..
> So my new challenge to myself: Given two commit objects A and B list =
all
> the tree and blob objects which are not in both A and B.=20

$ git-diff-tree -t A B

>=20
> After that I think writing a command which does the same as=20
> 'cvs annotate' would be a good exercise.

Ok, I have a prototype.  The algorithm has three steps:

1) traverse the commit DAG in breadth first order
2) for each commit in 1) find the diff against HEAD
3) for each diff from 2) accumulate the lines and
   commit ids that latest affected the current HEAD
4) print the commit ids found in 3), one for each
   line in HEAD.  =20

The command is used like this:
$ git-annotate-script.sh Documentation/git.txt >blame
$ cat blame
51017101c7a308745ba3c04944457f1dc6a55780
51017101c7a308745ba3c04944457f1dc6a55780
3db6b224cf36748b969acdd96b9fb2de641cd641
51017101c7a308745ba3c04944457f1dc6a55780
51017101c7a308745ba3c04944457f1dc6a55780
=2E..
51017101c7a308745ba3c04944457f1dc6a55780
51017101c7a308745ba3c04944457f1dc6a55780
51017101c7a308745ba3c04944457f1dc6a55780
51017101c7a308745ba3c04944457f1dc6a55780
$ paste -d ' ' blame - <Documentation/git.txt

The script runs in about 6 seconds on my machine.

Any comments?=20

Regards,

Peter



diff --git a/git-annotate-bfs.pl b/git-annotate-bfs.pl
new file mode 100755
--- /dev/null
+++ b/git-annotate-bfs.pl
@@ -0,0 +1,35 @@
+#!/usr/bin/env perl
+
+# 1) Bredde-f=F8rst-s=F8gning
+# 2) For hvert commit A i 1) find diff(parent(A), HEAD)
+# 3) Byg anklage-tabellen og skriv den ud.
+
+use strict;
+use warnings;
+
+my $v0 =3D $ARGV[0];
+
+my @Q;     # BFS helper queue of commit ids.
+my %C;     # BFS helper colours table. C[commit id] =3D colour.  1=3Dg=
rey,
2=3Dblack.
+my $v;
+
+$C{v0} =3D 1;
+push @Q, $v0;
+while (@Q) {
+    $v =3D shift @Q;
+    #print "$v\n"; ### DEBUG
+    open(PARENTS, "git-rev-list --parents --max-count=3D1 $v |");
+    chomp(my $commits =3D <PARENTS>);
+    close PARENTS;
+    my @parents =3D split(' ', $commits);
+    shift @parents;
+    my $v1;
+    foreach $v1 (@parents) {
+        #print ".";  ## DEBUG
+        if (not defined($C{$v1})) {
+            $C{$v1} =3D 1;
+            push @Q, $v1;
+        }
+    }
+    print "$commits\n"
+}
diff --git a/git-annotate-diff.sh b/git-annotate-diff.sh
new file mode 100755
--- /dev/null
+++ b/git-annotate-diff.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+# 1) Bredde-f=F8rst-s=F8gning
+# 2) For hvert commit A i 1) find diff(parent(A), HEAD)
+# 3) Byg anklage-tabellen og skriv den ud.
+
+FILEPATH=3D$1
+
+while read COMMITS; do
+    COMMIT=3D${COMMITS:0:40}
+    echo blame $COMMIT
+    for PARENT in ${COMMITS#* }; do
+       # Hvis HEAD har =E6ndret sig i forhold til $PARENT,
+       # skyldes det ikke $PARENT, men et senere commit,
+       # nemlig ${COMMITS:0:40}
+       DIFF=3D`git-diff-tree -r -m $PARENT $COMMIT $FILEPATH`
+       if [ -n "$DIFF" ]; then
+           git diff $PARENT HEAD $FILEPATH
+       fi
+    done
+done
diff --git a/git-annotate-script.sh b/git-annotate-script.sh
new file mode 100755
--- /dev/null
+++ b/git-annotate-script.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+FILEPATH=3D$1
+
+BLOB=3D`git-ls-files --stage | grep $FILEPATH | cut -c8-47`
+LENGTH=3D`git-cat-file blob $BLOB | wc -l`
+
+git-annotate-bfs.pl HEAD |   \
+#cut -c1-40 | git-diff-tree -r -m --stdin rev-list.c | grep "^[^:]" \
+git-annotate-diff.sh $FILEPATH | \
+git-annotate-table.pl $LENGTH
diff --git a/git-annotate-table.pl b/git-annotate-table.pl
new file mode 100755
--- /dev/null
+++ b/git-annotate-table.pl
@@ -0,0 +1,41 @@
+#!/usr/bin/env perl
+
+use strict;
+use warnings;
+
+
+# 1) Bredde-f=F8rst-s=F8gning
+# 2) For hvert commit A i 1) find diff(parent(A), HEAD)
+# 3) Byg anklage-tabellen og skriv den ud.
+
+my $len =3D $ARGV[0];
+
+my @T;     # Blame table. T[line number] =3D commit ids
+my $n =3D 0;
+my $blame;
+my $cln;
+my $state =3D "header";
+
+while (defined (my $line =3D <STDIN>) and $n < $len) {
+    if ($line =3D~ /^blame ([0-9a-fA-F]{40})/) { $blame =3D $1; $state=
 =3D
"header"; }
+    elsif ($line =3D~ /^diff --git/) { $state =3D "header"; }
+    elsif ($line =3D~ /^@@ -\d+,\d+ \+(\d+),/) { $cln =3D $1-1; $state=
 =3D
"chunks"; }
+    elsif ($state eq "chunks") {
+        if ($line =3D~ /^\+/) {
+            if (not defined $T[$cln]) { $T[$cln] =3D $blame; $n++; }
#print "$cln $blame\n"; }
+            $cln++;
+       }
+        elsif ($line =3D~ /^-/) { }
+        elsif ($line =3D~ /^ /) { $cln++; }
+        else {
+            print "line =3D $line\n";
+            print "state =3D $state\n";
+            print "cln =3D $cln\n";
+            die "I'm not supposed to read this line.";
+       }
+    }
+}
+
+foreach (@T) {
+    print "$_\n";
+}
