From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 04/10] t4018: convert perl pattern tests to the new infrastructure
Date: Fri, 21 Mar 2014 22:07:16 +0100
Message-ID: <1953f0c353a2fb5b51db53722d222d548a09fe72.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:09:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6gV-0003PF-VH
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbaCUVIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:08:53 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:49466 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750807AbaCUVIv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:08:51 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.105])
	by lbmfmo03.bon.at (Postfix) with ESMTP id D6B1ECEA70
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:08:50 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F36A51300AD;
	Fri, 21 Mar 2014 22:08:38 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8804219F6A4;
	Fri, 21 Mar 2014 22:08:38 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244742>

There is one subtlety: The old test case 'perl pattern gets full line of
POD header' does not have its own new test case, but the feature is
tested nevertheless by placing the RIGHT tag at the end of the expected
hunk header in t4018/perl-skip-sub-in-pod.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4018-diff-funcname.sh             | 88 ------------------------------------
 t/t4018/perl-skip-end-of-heredoc     |  8 ++++
 t/t4018/perl-skip-forward-decl       | 10 ++++
 t/t4018/perl-skip-sub-in-pod         | 18 ++++++++
 t/t4018/perl-sub-definition          |  4 ++
 t/t4018/perl-sub-definition-kr-brace |  4 ++
 6 files changed, 44 insertions(+), 88 deletions(-)
 create mode 100644 t/t4018/perl-skip-end-of-heredoc
 create mode 100644 t/t4018/perl-skip-forward-decl
 create mode 100644 t/t4018/perl-skip-sub-in-pod
 create mode 100644 t/t4018/perl-sub-definition
 create mode 100644 t/t4018/perl-sub-definition-kr-brace

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index b467d9e..c94a5f4 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -29,69 +29,6 @@ public class Beer
 }
 EOF
 sed 's/beer\\/beer,\\/' <Beer.java >Beer-correct.java
-cat >Beer.perl <<\EOT
-package Beer;
-
-use strict;
-use warnings;
-use parent qw(Exporter);
-our @EXPORT_OK = qw(round finalround);
-
-sub other; # forward declaration
-
-# hello
-
-sub round {
-	my ($n) = @_;
-	print "$n bottles of beer on the wall ";
-	print "$n bottles of beer\n";
-	print "Take one down, pass it around, ";
-	$n = $n - 1;
-	print "$n bottles of beer on the wall.\n";
-}
-
-sub finalround
-{
-	print "Go to the store, buy some more\n";
-	print "99 bottles of beer on the wall.\n");
-}
-
-sub withheredocument {
-	print <<"EOF"
-decoy here-doc
-EOF
-	# some lines of context
-	# to pad it out
-	print "hello\n";
-}
-
-__END__
-
-=head1 NAME
-
-Beer - subroutine to output fragment of a drinking song
-
-=head1 SYNOPSIS
-
-	use Beer qw(round finalround);
-
-	sub song {
-		for (my $i = 99; $i > 0; $i--) {
-			round $i;
-		}
-		finalround;
-	}
-
-	song;
-
-=cut
-EOT
-sed -e '
-	s/hello/goodbye/
-	s/beer\\/beer,\\/
-	s/more\\/more,\\/
-	s/song;/song();/
-' <Beer.perl >Beer-correct.perl
 
 test_expect_funcname () {
 	lang=${2-java}
@@ -139,7 +76,6 @@ done
 test_expect_success 'set up .gitattributes declaring drivers to test' '
 	cat >.gitattributes <<-\EOF
 	*.java diff=java
-	*.perl diff=perl
 	EOF
 '
 
@@ -147,30 +83,6 @@ test_expect_success 'preset java pattern' '
 	test_expect_funcname "public static void main("
 '
 
-test_expect_success 'preset perl pattern' '
-	test_expect_funcname "sub round {\$" perl
-'
-
-test_expect_success 'perl pattern accepts K&R style brace placement, too' '
-	test_expect_funcname "sub finalround\$" perl
-'
-
-test_expect_success 'but is not distracted by end of <<here document' '
-	test_expect_funcname "sub withheredocument {\$" perl
-'
-
-test_expect_success 'perl pattern is not distracted by sub within POD' '
-	test_expect_funcname "=head" perl
-'
-
-test_expect_success 'perl pattern gets full line of POD header' '
-	test_expect_funcname "=head1 SYNOPSIS\$" perl
-'
-
-test_expect_success 'perl pattern is not distracted by forward declaration' '
-	test_expect_funcname "package Beer;\$" perl
-'
-
 test_expect_success 'custom pattern' '
 	test_config diff.java.funcname "!static
 !String
diff --git a/t/t4018/perl-skip-end-of-heredoc b/t/t4018/perl-skip-end-of-heredoc
new file mode 100644
index 0000000..c22d39b
--- /dev/null
+++ b/t/t4018/perl-skip-end-of-heredoc
@@ -0,0 +1,8 @@
+sub RIGHTwithheredocument {
+	print <<"EOF"
+decoy here-doc
+EOF
+	# some lines of context
+	# to pad it out
+	print "ChangeMe\n";
+}
diff --git a/t/t4018/perl-skip-forward-decl b/t/t4018/perl-skip-forward-decl
new file mode 100644
index 0000000..a98cb8b
--- /dev/null
+++ b/t/t4018/perl-skip-forward-decl
@@ -0,0 +1,10 @@
+package RIGHT;
+
+use strict;
+use warnings;
+use parent qw(Exporter);
+our @EXPORT_OK = qw(round finalround);
+
+sub other; # forward declaration
+
+# ChangeMe
diff --git a/t/t4018/perl-skip-sub-in-pod b/t/t4018/perl-skip-sub-in-pod
new file mode 100644
index 0000000..e39f024
--- /dev/null
+++ b/t/t4018/perl-skip-sub-in-pod
@@ -0,0 +1,18 @@
+=head1 NAME
+
+Beer - subroutine to output fragment of a drinking song
+
+=head1 SYNOPSIS_RIGHT
+
+	use Beer qw(round finalround);
+
+	sub song {
+		for (my $i = 99; $i > 0; $i--) {
+			round $i;
+		}
+		finalround;
+	}
+
+	ChangeMe;
+
+=cut
diff --git a/t/t4018/perl-sub-definition b/t/t4018/perl-sub-definition
new file mode 100644
index 0000000..a507d1f
--- /dev/null
+++ b/t/t4018/perl-sub-definition
@@ -0,0 +1,4 @@
+sub RIGHT {
+	my ($n) = @_;
+	print "ChangeMe";
+}
diff --git a/t/t4018/perl-sub-definition-kr-brace b/t/t4018/perl-sub-definition-kr-brace
new file mode 100644
index 0000000..330b3df
--- /dev/null
+++ b/t/t4018/perl-sub-definition-kr-brace
@@ -0,0 +1,4 @@
+sub RIGHT
+{
+	print "ChangeMe\n";
+}
-- 
1.8.5.2.244.g9fb3fb1
