From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH v3] git svn dcommit: new option --interactive.
Date: Fri, 16 Sep 2011 23:02:01 +0200
Message-ID: <1316206921-29311-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, normalperson@yhbt.net,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 16 23:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4fYG-0007cl-Sv
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 23:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206Ab1IPVCU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 17:02:20 -0400
Received: from mail-wy0-f180.google.com ([74.125.82.180]:40991 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571Ab1IPVCT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 17:02:19 -0400
Received: by wyj26 with SMTP id 26so5182215wyj.11
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=UdbrjcX0bUNPGChBbGe0TZduRJzh+XdApPPFByMiKa0=;
        b=r5VNRSBw3c4KgL9ochN6HYGWi7d3WM+ffWEIxzFZTS557ArCep9b0G1ZB+eiUVeQBa
         kSarM42m3SyZj13T/RgcsjuOTMIGaEFezHPE1YWBzmlr5H2Sv4RDFM5T5Pqh4irugzJX
         vCf6g7vLNaVugvJwqdKhIEPWUrdDviLkur+wY=
Received: by 10.227.27.82 with SMTP id h18mr2076544wbc.9.1316206937579;
        Fri, 16 Sep 2011 14:02:17 -0700 (PDT)
Received: from localhost.localdomain (dra38-7-88-179-84-80.fbx.proxad.net. [88.179.84.80])
        by mx.google.com with ESMTPS id h20sm8576009wbo.22.2011.09.16.14.02.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Sep 2011 14:02:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.200.g2f9e2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181557>

Allow the user to check the patch set before it is commited to SNV. It =
is
then possible to accept/discard one patch, accept all, or quit.

This interactive mode is similar with 'git send email' behaviour. Howev=
er,
'git svn dcommit' returns as soon as one patch is discarded.
Part of the code was taken from git-send-email.perl (see 'ask' function=
)

Tests several combinations of potential answers to
'git svn dcommit --interactive'. For each of them, test whether patches
were commited to SVN or not.

Thanks-to Eric Wong <normalperson@yhbt.net> for the initial idea.

Reviewed-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.c=
om>
---
 Minor change from v2 : rename t9160... to t9162... to avoid name
 collision
 ref: <1316202903-5085-1-git-send-email-frederic.heitzmann@gmail.com>

 Documentation/git-svn.txt              |    8 +++
 git-svn.perl                           |   76 ++++++++++++++++++++++++=
+++++++-
 t/t9162-git-svn-dcommit-interactive.sh |   64 ++++++++++++++++++++++++=
+++
 3 files changed, 147 insertions(+), 1 deletions(-)
 create mode 100644 t/t9162-git-svn-dcommit-interactive.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 08cad6d..c8f0883 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -234,6 +234,14 @@ svn:mergeinfo property in the SVN repository when =
possible. Currently, this can
 only be done when dcommitting non-fast-forward merges where all parent=
s but the
 first have already been pushed into SVN.
=20
+--interactive;;
+	Ask the user to confirm that a patch set should actually be sent to S=
VN.
+	For each patch, one may answer "yes" (accept this patch), "no" (disca=
rd this
+	patch), "all" (accept all patches), or "quit".
+	+
+	'git svn dcommit' returns immediately if answer if "no" or "quit", wi=
thout
+	commiting anything to SVN.
+
 'branch'::
 	Create a branch in the SVN repository.
=20
diff --git a/git-svn.perl b/git-svn.perl
index 351e743..121332d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -87,7 +87,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format, $_commit_url, $_tag, $_merge_info);
+	$_git_format, $_commit_url, $_tag, $_merge_info, $_interactive);
 $Git::SVN::_follow_parent =3D 1;
 $SVN::Git::Fetcher::_placeholder_filename =3D ".gitignore";
 $_q ||=3D 0;
@@ -163,6 +163,7 @@ my %cmd =3D (
 			  'revision|r=3Di' =3D> \$_revision,
 			  'no-rebase' =3D> \$_no_rebase,
 			  'mergeinfo=3Ds' =3D> \$_merge_info,
+			  'interactive|i' =3D> \$_interactive,
 			%cmt_opts, %fc_opts } ],
 	branch =3D> [ \&cmd_branch,
 	            'Create a branch in the SVN repository',
@@ -256,6 +257,27 @@ my %cmd =3D (
 		{} ],
 );
=20
+use Term::ReadLine;
+package FakeTerm;
+sub new {
+	my ($class, $reason) =3D @_;
+	return bless \$reason, shift;
+}
+sub readline {
+	my $self =3D shift;
+	die "Cannot use readline on FakeTerm: $$self";
+}
+package main;
+
+my $term =3D eval {
+	$ENV{"GIT_SVN_NOTTY"}
+		? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
+		: new Term::ReadLine 'git-svn';
+};
+if ($@) {
+	$term =3D new FakeTerm "$@: going non-interactive";
+}
+
 my $cmd;
 for (my $i =3D 0; $i < @ARGV; $i++) {
 	if (defined $cmd{$ARGV[$i]}) {
@@ -366,6 +388,36 @@ sub version {
 	exit 0;
 }
=20
+sub ask {
+	my ($prompt, %arg) =3D @_;
+	my $valid_re =3D $arg{valid_re};
+	my $default =3D $arg{default};
+	my $resp;
+	my $i =3D 0;
+
+	if ( !( defined($term->IN)
+            && defined( fileno($term->IN) )
+            && defined( $term->OUT )
+            && defined( fileno($term->OUT) ) ) ){
+		return defined($default) ? $default : undef;
+	}
+
+	while ($i++ < 10) {
+		$resp =3D $term->readline($prompt);
+		if (!defined $resp) { # EOF
+			print "\n";
+			return defined $default ? $default : undef;
+		}
+		if ($resp eq '' and defined $default) {
+			return $default;
+		}
+		if (!defined $valid_re or $resp =3D~ /$valid_re/) {
+			return $resp;
+		}
+	}
+	return undef;
+}
+
 sub do_git_init_db {
 	unless (-d $ENV{GIT_DIR}) {
 		my @init_db =3D ('init');
@@ -746,6 +798,28 @@ sub cmd_dcommit {
 		     "If these changes depend on each other, re-running ",
 		     "without --no-rebase may be required."
 	}
+
+	if (defined $_interactive){
+		my $ask_default =3D "y";
+		foreach my $d (@$linear_refs){
+			print "debug : d =3D $d\n";
+			my ($fh, $ctx) =3D command_output_pipe(qw(show --summary), "$d");
+			while (<$fh>){
+				print $_;
+			}
+			command_close_pipe($fh, $ctx);
+			$_ =3D ask("Commit this patch to SVN? ([y]es (default)|[n]o|[q]uit|=
[a]ll): ",
+			         valid_re =3D> qr/^(?:yes|y|no|n|quit|q|all|a)/i,
+			         default =3D> $ask_default);
+			die "Commit this patch reply required" unless defined $_;
+			if (/^[nq]/i) {
+				exit(0);
+			} elsif (/^a/i) {
+				last;
+			}
+		}
+	}
+
 	my $expect_url =3D $url;
=20
 	my $push_merge_info =3D eval {
diff --git a/t/t9162-git-svn-dcommit-interactive.sh b/t/t9162-git-svn-d=
commit-interactive.sh
new file mode 100644
index 0000000..e38d9fa
--- /dev/null
+++ b/t/t9162-git-svn-dcommit-interactive.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 Fr=C3=A9d=C3=A9ric Heitzmann
+
+test_description=3D'git svn dcommit --interactive series'
+. ./lib-git-svn.sh
+
+test_expect_success 'initialize repo' '
+	svn_cmd mkdir -m"mkdir test-interactive" "$svnrepo/test-interactive" =
&&
+	git svn clone "$svnrepo/test-interactive" test-interactive &&
+	cd test-interactive &&
+	touch foo && git add foo && git commit -m"foo: first commit" &&
+	git svn dcommit
+	'
+
+test_expect_success 'answers: y [\n] yes' '
+	(
+		echo "change #1" >> foo && git commit -a -m"change #1" &&
+		echo "change #2" >> foo && git commit -a -m"change #2" &&
+		echo "change #3" >> foo && git commit -a -m"change #3" &&
+		( echo "y
+
+y" | GIT_SVN_NOTTY=3D1 git svn dcommit --interactive ) &&
+		test $(git rev-parse HEAD) =3D $(git rev-parse remotes/git-svn)
+	)
+	'
+
+test_expect_success 'answers: yes yes no' '
+	(
+		echo "change #1" >> foo && git commit -a -m"change #1" &&
+		echo "change #2" >> foo && git commit -a -m"change #2" &&
+		echo "change #3" >> foo && git commit -a -m"change #3" &&
+		( echo "yes
+yes
+no" | GIT_SVN_NOTTY=3D1 git svn dcommit --interactive ) &&
+		test $(git rev-parse HEAD^^^) =3D $(git rev-parse remotes/git-svn) &=
&
+		git reset --hard remotes/git-svn
+	)
+	'
+
+test_expect_success 'answers: yes quit' '
+	(
+		echo "change #1" >> foo && git commit -a -m"change #1" &&
+		echo "change #2" >> foo && git commit -a -m"change #2" &&
+		echo "change #3" >> foo && git commit -a -m"change #3" &&
+		( echo "yes
+quit" | GIT_SVN_NOTTY=3D1 git svn dcommit --interactive ) &&
+		test $(git rev-parse HEAD^^^) =3D $(git rev-parse remotes/git-svn) &=
&
+		git reset --hard remotes/git-svn
+	)
+	'
+
+test_expect_success 'answers: all' '
+	(
+		echo "change #1" >> foo && git commit -a -m"change #1" &&
+		echo "change #2" >> foo && git commit -a -m"change #2" &&
+		echo "change #3" >> foo && git commit -a -m"change #3" &&
+		( echo "all" | GIT_SVN_NOTTY=3D1 git svn dcommit --interactive ) &&
+		test $(git rev-parse HEAD) =3D $(git rev-parse remotes/git-svn) &&
+		git reset --hard remotes/git-svn
+	)
+	'
+
+test_done
--=20
1.7.7.rc0.200.g2f9e2e
