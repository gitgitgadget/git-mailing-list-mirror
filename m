From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Sun, 03 Aug 2008 13:45:07 -0700
Message-ID: <7vhca1u8to.fsf@gitster.siamese.dyndns.org>
References: <1217684549.8296.10.camel@heerbeest>
 <20080802172742.GT32184@machine.or.cz>
 <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org>
 <1217701021.8296.35.camel@heerbeest>
 <7v4p63dstc.fsf@gitster.siamese.dyndns.org>
 <1217765241.6178.11.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun Aug 03 22:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPkT5-0001MM-3Y
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 22:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246AbYHCUpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 16:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbYHCUpR
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 16:45:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756246AbYHCUpP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 16:45:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CA30949C03;
	Sun,  3 Aug 2008 16:45:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4B7EA49C02; Sun,  3 Aug 2008 16:45:08 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1309A5BA-619D-11DD-9987-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91269>

Jan Nieuwenhuizen <janneke-list@xs4all.nl> writes:

>  Documentation/RelNotes-1.6.0.txt   |    3 +

Nice try, but after -rc1 we won't take feature enhancements on the
'master' branch.  The earliest this will appear is in 1.6.1.

Thanks for clean-up, and starting tests, but I have a few more comments:

 * Documentation; introduce this with heading --clean-changelog=<style>; I
   kept the list of supported styles in-line, but we may later want to
   have other supported styles at which time it might become easier to
   read if it were a separate itemized list.

   You seem to have taken the "arbitrary Perl snippet" part of my patch as
   well, but it is not described here...

 * Script; two separate _clean_changelog and _clean_log_message variables
   are not necessary (I removed the extra variable in the patch below).

 * Tests.

   Your new tests do not seem to check these, but I think you should:

   - what should happen without --clean-changelog=gnu?  (iow, additional
     code does not regress the behaviour when this shiny new toy is not
     used).

   - what should happen when an unknown style is given e.g. --clean-changelog=yak?

   We prefer to use "test_cmp" for comparing expected and actual result,
   not bare "cmp".

Here is what I tested and based the above comments on after minor fixes to
ask comments from Eric.

-- >8 --
From: Jan Nieuwenhuizen <janneke@gnu.org>
Subject: git-svn: --clean-changelog=<style> to sanitize messages

Some projects write ChangeLog entries and use those for Subverison commit
messages.  Converting such a repository makes for a most uninteresting git
log --pretty=oneline output:

    482cfc6... 2008-08-01  Kohei Yoshida  <kyoshida@novell.com>
    90c16d7... 2008-08-01  Fong Lin  <pflin@novell.com> 	* patches/dev300/cws-npow
    ...

The --clean-changelog=<style> option can be used to remove useless bits
when reading log messages from Subversion side, to produce more readable
result:

    44e7784... patches/dev300/apply: added upstream issue numbers to some of my  p
    1a19026... patches/dev300/cws-npower11.diff: Add vba events stuff.
    ...

Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-svn.txt          |    4 +
 git-svn.perl                       |   37 +++++++-
 t/t9125-git-svn-clean-changelog.sh |  187 ++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+), 1 deletions(-)
 create mode 100755 t/t9125-git-svn-clean-changelog.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f230125..04b44c6 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -118,6 +118,10 @@ accept.  However, '--fetch-all' only fetches from the current
 Like 'git-rebase'; this requires that the working tree be clean
 and have no uncommitted changes.
 
+--clean-changelog=<style>;;
+	Manipulate SVN commit log messages to produce clean commit
+	messages.  Supported styles are: 'gnu', which strips
+	GNU ChangeLog bits.
 -l;;
 --local;;
 	Do not fetch remotely; only run 'git-rebase' against the
diff --git a/git-svn.perl b/git-svn.perl
index cf6dbbc..ff17457 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -66,7 +66,7 @@ my ($_stdin, $_help, $_edit,
 	$_version, $_fetch_all, $_no_rebase,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
-	$_git_format);
+	$_git_format, $_clean_changelog);
 $Git::SVN::_follow_parent = 1;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -109,9 +109,11 @@ my %cmd = (
 	fetch => [ \&cmd_fetch, "Download new revisions from SVN",
 			{ 'revision|r=s' => \$_revision,
 			  'fetch-all|all' => \$_fetch_all,
+			  'clean-changelog=s' => \$_clean_changelog,
 			   %fc_opts } ],
 	clone => [ \&cmd_clone, "Initialize and fetch revisions",
 			{ 'revision|r=s' => \$_revision,
+			  'clean-changelog=s' => \$_clean_changelog,
 			   %fc_opts, %init_opts } ],
 	init => [ \&cmd_init, "Initialize a repo for tracking" .
 			  " (requires URL argument)",
@@ -178,6 +180,7 @@ my %cmd = (
 			  'local|l' => \$_local,
 			  'fetch-all|all' => \$_fetch_all,
 			  'dry-run|n' => \$_dry_run,
+			  'clean-changelog=s' => \$_clean_changelog,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
 	                   'Commit a diff between two trees',
@@ -238,6 +241,35 @@ my $rv = GetOptions(%opts, 'help|H|h' => \$_help, 'version|V' => \$_version,
                        $Git::SVN::default_repo_id = $_[1] });
 exit 1 if (!$rv && $cmd && $cmd ne 'log');
 
+my %canned_changelog_cleaner =
+(
+ 'gnu' => sub {
+	 local ($_) = @_;
+	 s/(^|\n)\s*((\n|\s)*(199[0-9]|20[0-1][0-9])(-[0-9]{2}){2}\s+.*<.*>\s*\n\s+)?/$1/g;
+	 s/(^|\n)\* /\n$1/g;
+	 s/^[\n\s]*//;
+	 s/[\n\s]*$//;
+	 s/\n\s*/ /g if length ($_) < 81;
+	 $_ . "\n";
+ }
+);
+
+if (defined $_clean_changelog) {
+	my $ccl = $_clean_changelog;
+	if (exists $canned_changelog_cleaner{$_clean_changelog}) {
+		$_clean_changelog = $canned_changelog_cleaner{$_clean_changelog};
+	} elsif ($_clean_changelog ne '') {
+		$_clean_changelog = eval "
+			sub { local(\$_) = \@_; $_clean_changelog; return \$_; }
+		";
+		if ($@) {
+			die "$!: $ccl";
+		}
+	} else {
+		die "$ccl: unknown way to clean log message";
+	}
+}
+
 usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
@@ -2463,6 +2495,9 @@ sub make_log_entry {
 	close $un or croak $!;
 
 	$log_entry{date} = parse_svn_date($log_entry{date});
+	if ($_clean_changelog) {
+		$log_entry{log} = $_clean_changelog->($log_entry{log});
+	}
 	$log_entry{log} .= "\n";
 	my $author = $log_entry{author} = check_author($log_entry{author});
 	my ($name, $email) = defined $::users{$author} ? @{$::users{$author}}
diff --git a/t/t9125-git-svn-clean-changelog.sh b/t/t9125-git-svn-clean-changelog.sh
new file mode 100755
index 0000000..f6a02b8
--- /dev/null
+++ b/t/t9125-git-svn-clean-changelog.sh
@@ -0,0 +1,187 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Jan Nieuwenhuizen <janneke@gnu.org>
+
+test_description='git-svn fetch --clean-changelog'
+
+. ./lib-git-svn.sh
+
+cat >dumpfile.svn <<\EOF
+SVN-fs-dump-format-version: 2
+
+UUID: 3e54420c-6148-11dd-bf80-b901c556354a
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2008-08-03T10:38:00.279529Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 231
+Content-length: 231
+
+K 7
+svn:log
+V 128
+2008-08-03  Jan Nieuwenhuizen  <janneke@gnu.org>
+
+	* one: New file.  This adds the `one' file to the svn
+          repository.
+
+
+K 10
+svn:author
+V 7
+janneke
+K 8
+svn:date
+V 27
+2008-08-03T10:42:21.211246Z
+PROPS-END
+
+Node-path: one
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 4
+Text-content-md5: 5bbf5a52328e7439ae6e719dfe712200
+Content-length: 14
+
+PROPS-END
+one
+
+
+Revision-number: 2
+Prop-content-length: 217
+Content-length: 217
+
+K 7
+svn:log
+V 114
+2008-08-03  Jan Nieuwenhuizen  <janneke@gnu.org>
+
+	* one: Change to numeral.
+	* /path/to/two (foo, bar): Update.
+
+
+K 10
+svn:author
+V 7
+janneke
+K 8
+svn:date
+V 27
+2008-08-03T10:47:11.023749Z
+PROPS-END
+
+Node-path: one
+Node-kind: file
+Node-action: change
+Text-content-length: 2
+Text-content-md5: b026324c6904b2a9cb4b88d6d61c81d1
+Content-length: 2
+
+1
+
+
+Node-path: two
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 4
+Text-content-md5: c193497a1a06b2c72230e6146ff47080
+Content-length: 14
+
+PROPS-END
+two
+
+
+Revision-number: 3
+Prop-content-length: 192
+Content-length: 192
+
+K 7
+svn:log
+V 90
+    * three: Add yet another commit that is too long to fit on one
+line, i.e., 81 chars.
+
+
+K 10
+svn:author
+V 7
+janneke
+K 8
+svn:date
+V 27
+2008-08-03T10:51:21.214317Z
+PROPS-END
+
+Node-path: three
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 6
+Text-content-md5: febe6995bad457991331348f7b9c85fa
+Content-length: 16
+
+PROPS-END
+three
+
+
+EOF
+
+test_expect_success 'load svn dumpfile' '
+	svnadmin load "$PWD/svnrepo" <dumpfile.svn
+'
+
+test_expect_success 'clone revision from svn' '
+	git-svn clone --clean-changelog=gnu -r0 "file://$PWD/svnrepo" test-git
+'
+
+test_expect_success 'fetch revision from svn' '
+	(cd test-git && git-svn fetch --clean-changelog=gnu)
+'
+
+test_expect_success 'rebase revision from svn' '
+	(cd test-git && git-svn rebase --clean-changelog=gnu)
+'
+
+test_expect_success 'get log' '
+	(cd test-git && git log | grep -Ev "^(commit|Author)" >git-log.output)
+'
+
+sed -e 's/|$//' >git-log.expect <<EOF
+Date:   Sun Aug 3 10:51:21 2008 +0000
+
+    three: Add yet another commit that is too long to fit on one
+    line, i.e., 81 chars.
+    |
+    |
+    git-svn-id: file://$PWD/svnrepo@3 3e54420c-6148-11dd-bf80-b901c556354a
+
+Date:   Sun Aug 3 10:47:11 2008 +0000
+
+    one: Change to numeral. /path/to/two (foo, bar): Update.
+    |
+    |
+    git-svn-id: file://$PWD/svnrepo@2 3e54420c-6148-11dd-bf80-b901c556354a
+
+Date:   Sun Aug 3 10:42:21 2008 +0000
+
+    one: New file.  This adds the \`one' file to the svn repository.
+    |
+    |
+    git-svn-id: file://$PWD/svnrepo@1 3e54420c-6148-11dd-bf80-b901c556354a
+EOF
+
+test_expect_success 'git svn clone/fetch --changelog=gnu' '
+	test_cmp git-log.expect test-git/git-log.output
+'
+
+test_done
-- 
1.6.0.rc1.58.g807d8
