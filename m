From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: [PATCH 1/2] git svn dcommit: new option --interactive.
Date: Sun,  4 Sep 2011 21:21:52 +0200
Message-ID: <1315164113-26539-2-git-send-email-frederic.heitzmann@gmail.com>
References: <1315164113-26539-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, normalperson@yhbt.net, jaysoffian@gmail.com,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 21:24:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0IJE-0004ad-8n
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 21:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120Ab1IDTYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Sep 2011 15:24:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63180 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab1IDTYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 15:24:43 -0400
Received: by wyh22 with SMTP id 22so3136191wyh.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=wm1RbuXZk9a/NQ62UlhZ57NbSx7NR5Xp+GSL8qcYo0E=;
        b=qRLTp9UCcb7iNhdDgVpRasl00TXfbWZaSjPl3w7VJ0vr61WZHqPdfBakBbhmOsIYc2
         PrU6QMdL0js4QWVWIygWwehyqnVIMY9ozakjp9YqpKTnjEr4qAlyJG/Z5PM/t9KmfvTL
         xJQ9J9dtsm/pedwKRoVn8oLru30riA8mTpcpQ=
Received: by 10.227.36.213 with SMTP id u21mr2031064wbd.70.1315164281782;
        Sun, 04 Sep 2011 12:24:41 -0700 (PDT)
Received: from localhost.localdomain (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id et17sm5825074wbb.0.2011.09.04.12.24.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Sep 2011 12:24:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.447.gb9176
In-Reply-To: <1315164113-26539-1-git-send-email-frederic.heitzmann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180699>

Allow the user to check the patch set before it is commited to SNV. It =
is then
possible to accept/discard one patch, accept all, or quit.

This interactive mode is similar with 'git send email' behaviour. Howev=
er,
'git svn dcommit' returns as soon as one patch is discarded.

Part of the code was taken from git-send-email.perl

Thanks-to: Eric Wong <normalperson@yhbt.net> for the initial idea.
Signed-off-by: Fr=C3=A9d=C3=A9ric Heitzmann <frederic.heitzmann@gmail.c=
om>
---

 I would have preferred not duplicating the code snippets taken from
 git-send-email ('ask' function, Term related code, ...) but I preferre=
d not
 to spoil Git.pm with it.
 Any comment on a better way to factor perl code would be appreciated.

 Documentation/git-svn.txt |    8 +++++
 git-svn.perl              |   71 +++++++++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ed5eca1..08188a5 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -214,6 +214,14 @@ discouraged.
 	version 1.5 can make use of it. 'git svn' currently does not use it
 	and does not set it automatically.
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
index 89f83fd..fd5eaa2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -87,7 +87,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format, $_commit_url, $_tag, $_merge_info);
+	$_git_format, $_commit_url, $_tag, $_merge_info, $_interactive);
 $Git::SVN::_follow_parent =3D 1;
 $_q ||=3D 0;
 my %remote_opts =3D ( 'username=3Ds' =3D> \$Git::SVN::Prompt::_usernam=
e,
@@ -158,6 +158,7 @@ my %cmd =3D (
 			  'revision|r=3Di' =3D> \$_revision,
 			  'no-rebase' =3D> \$_no_rebase,
 			  'mergeinfo=3Ds' =3D> \$_merge_info,
+			  'interactive|i' =3D> \$_interactive,
 			%cmt_opts, %fc_opts } ],
 	branch =3D> [ \&cmd_branch,
 	            'Create a branch in the SVN repository',
@@ -251,6 +252,27 @@ my %cmd =3D (
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
@@ -361,6 +383,31 @@ sub version {
 	exit 0;
 }
=20
+sub ask {
+	my ($prompt, %arg) =3D @_;
+	my $valid_re =3D $arg{valid_re};
+	my $default =3D $arg{default};
+	my $resp;
+	my $i =3D 0;
+	return defined $default ? $default : undef
+		unless defined $term->IN and defined fileno($term->IN) and
+		       defined $term->OUT and defined fileno($term->OUT);
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
@@ -546,6 +593,28 @@ sub cmd_dcommit {
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
 	Git::SVN::remove_username($expect_url);
 	while (1) {
--=20
1.7.6.447.gb9176
