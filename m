From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 5/5] Date Mode: Tests
Date: Wed, 20 Apr 2011 02:45:23 +0000
Message-ID: <bbf61df6-b7fa-429e-866e-899354953cbd-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 04:58:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCNd5-0005HF-6U
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 04:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab1DTC6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 22:58:54 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44807 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab1DTC6x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 22:58:53 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so82338eyx.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 19:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:in-reply-to
         :references;
        bh=tXrM/uPwtYWtVo7bVn5wrAYmCxbPggYDD0U9v+ty9S0=;
        b=gnPR7uXcDUf1iGrZqHlHu2ZKnQwlKajAcBxAtwoUAh7MvaEcG+X36tIFhQa0/HQoOA
         yyVzhzFW6Y36fMLMuwCZFD+AIypCKYvFksIeJ7m4RLXm69KwJxCGA25BEQbk9iAU3nev
         xHHOJqcI3vjtVYrhdFfiuhY8+OGNWvJ/M6/PA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:in-reply-to:references;
        b=L/HhSy93DuyKLfhd7BwIe8P1iLQZwVOVKppqFkKVyPLUOYzFR8n9IGvIaWtVch1C3o
         QhVdf+d7w3XiT9cr/hSaC92RkzMbHeoFL3OjkQNNjaYPEeShbhpSRgCN10m895Oi5/bs
         mETI8BycVgthwjfHvqaTv8GYMXO0bHz6bsxl0=
Received: by 10.14.133.139 with SMTP id q11mr2193619eei.11.1303268333021;
        Tue, 19 Apr 2011 19:58:53 -0700 (PDT)
Received: from gmail.com (server105708.santrex.net [188.165.236.117])
        by mx.google.com with ESMTPS id u1sm335979eeh.6.2011.04.19.19.58.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 19:58:52 -0700 (PDT)
In-Reply-To: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171836>

Date: Mon, 14 Mar 2011 20:39:44 +0000
This commit introduces infrastructure for testing nearly all
combinations of date mode input (only the format `relative'
is currently excluded); test scripts source a date mode shell
library to set up the environment and define the general date
mode testing driver that is then started with a test-specific
callback and optional parameters.

Care was taken to reduce the amount of runtime overhead,
particularly by only updating the values of git configuration
variables when necessary.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 t/date-modes-lib.sh          |  168 ++++++++++++++++++++++++++++++++++++++++++
 t/date-modes-permutator.perl |   94 +++++++++++++++++++++++
 t/t4202-log.sh               |    3 +
 t/t6300-for-each-ref.sh      |   11 +++
 t/t8002-blame.sh             |    9 ++
 5 files changed, 285 insertions(+), 0 deletions(-)
 create mode 100755 t/date-modes-lib.sh
 create mode 100755 t/date-modes-permutator.perl

diff --git a/t/date-modes-lib.sh b/t/date-modes-lib.sh
new file mode 100755
index 0000000..5ff6192
--- /dev/null
+++ b/t/date-modes-lib.sh
@@ -0,0 +1,168 @@
+#!/bin/sh
+#
+# Copyright (c) 2011 Michael F Witten
+
+if ! test_have_prereq PERL; then
+	skip_all='skipping all date mode tests; perl not available'
+	test_done
+fi
+
+date_mode_file=d.$$
+
+test_expect_success 'date mode: prepare reference commit' "
+	time='2131675200 -0400'
+
+	export GIT_COMMITTER_DATE=\"\$time\"  \
+	       GIT_COMMITTER_NAME=C           \
+	       GIT_COMMITTER_EMAIL=C@test.git \
+	       GIT_AUTHOR_DATE=\"\$time\"     \
+	       GIT_AUTHOR_NAME=A              \
+	       GIT_AUTHOR_EMAIL=A@test.git
+
+	d=$date_mode_file
+
+	echo > \$d && git add \$d && git commit -am d
+"
+
+date_mode_perm=$TEST_DIRECTORY/date-modes-permutator.perl
+
+# $1 : Configuration section (the command name being configured, such as
+#      the `log' in `log.date', etc.).
+#
+date_mode_unset_configs()
+{
+	var_t=$1.timezone
+	var_d=$1.date
+
+	test_expect_success "date mode: unset configs: '$var_t' and '$var_d'" "
+		git config --unset-all $var_t
+		git config --unset-all $var_d
+		! git config $var_t &&
+		! git config $var_d
+	"
+
+	return 0
+}
+
+# $1    : `section.variable'
+#
+# stdin : One line that is a value that is suitable for setting "$1";
+#         an empty line commands that "$1" be unset.
+#
+date_mode_set_config()
+{
+	read -r v || return 1
+
+	if [ -z "$v" ]; then
+		test_expect_success \
+			"date mode: unset config '$1'" \
+			"git config --unset-all '$1';! git config '$1'"
+	else
+		test_expect_success \
+			"date mode: set config: '$1 = $v'" \
+			"git config '$1' '$v'"
+	fi
+
+	return 0
+}
+
+date_mode_set_configs()
+{
+	date_mode_set_config "$1.timezone" &&
+	read -r; # skip `=' line
+	date_mode_set_config "$1.date"
+}
+
+# $1    : A value that is suitable as a date mode time zone.
+#
+# stdin : 2 lines:
+#
+#           A value that is suitable as a date mode format.
+#
+#           Expected output from running "$date_mode_test_code" (see below)
+#
+#         If "$1" or the first line is empty, then the corresponding option
+#         is not used.
+#
+# Global variable `date_mode_test_code':
+#
+#         Shell code that can accept the arguments "$1" and the value of the
+#         first line of stdin, and then output a date that is equal to the
+#         second line of stdin.
+#
+date_mode_run_test()
+{
+	read -r format   &&
+	read -r expected || return 1
+
+	test_expect_success "date mode:${1:+ '$1'}${format:+ '$format'}" "
+		$date_mode_test_code '$1' '$format' > actual   &&
+		echo '$expected'                    > expected &&
+		test_cmp expected actual
+	"
+
+	return 0
+}
+
+date_mode_error()
+{
+	error "date mode: The test is in a confused state; aborting..."
+}
+
+# $1    : Shell code that can accept the following input (empty strings
+#         represent no specified value):
+#
+#           $1 : A value suitable as a date mode time zone.
+#           $2 : A value suitable as a date mode format.
+#
+#         and then output a date.
+#
+# $2    : Configuration section (the command name being configured, such as
+#         the `log' in `log.date', etc.); this may be the empty string, in
+#         which case git configuration variables are not tested.
+#
+# $3    : The date format that is the default; the default is `default'.
+# $4    : The date timzezone that is the default; the default is `default'.
+#
+# stdin : See the "$date_mode_perm" script.
+#
+date_mode_run_tests()
+{
+	date_mode_test_code=$1
+
+	if [ -z "$2" ]; then
+
+		"$PERL_PATH" "$date_mode_perm" '' "$3" "$4" |
+		while read -r line; do
+			date_mode_run_test "$line" || date_mode_error
+		done
+
+	else
+		date_mode_unset_configs "$2"
+
+		"$PERL_PATH" "$date_mode_perm" config "$3" "$4" |
+		while read -r line; do
+
+			if   [ "$line" = = ]; then
+				date_mode_set_config  "$2.date" && read -r line
+			elif [ "$line" = - ]; then
+				date_mode_set_configs "$2"      && read -r line
+			fi &&
+
+			date_mode_run_test "$line" || date_mode_error
+
+		done
+	fi
+
+	return 0
+}
+
+date_mode_std_args()
+{
+	echo "_date_mode_std_args '$(echo "$1" | sed "s/'/'\\\\''/g")'";
+}
+
+_date_mode_std_args()
+{
+	eval "$1${2:+ --time-zone='$2'}${3:+ --date='$3'}"
+}
diff --git a/t/date-modes-permutator.perl b/t/date-modes-permutator.perl
new file mode 100755
index 0000000..729e3e7
--- /dev/null
+++ b/t/date-modes-permutator.perl
@@ -0,0 +1,94 @@
+#!/usr/bin/perl
+#
+# Copyright (c) 2011 Michael F Witten
+
+use strict;
+use warnings;
+
+# The values expected to be generated by the test
+# when the given {zone}{format} is in use;
+my %expected = ();
+
+#########   ZONES    FORMATS            EXPECTED
+$expected {default} {default} = 'Mon Jul 20 00:00:00 2037 -0400';
+$expected {default} {  ''   } = $expected{default}{default};
+$expected {default} {rfc2822} = 'Mon, 20 Jul 2037 00:00:00 -0400';
+$expected {default} {  rfc  } = $expected{default}{rfc2822};
+$expected {default} {iso8601} = '2037-07-20 00:00:00 -0400';
+$expected {default} {  iso  } = $expected{default}{iso8601};
+$expected {default} { short } = '2037-07-20';
+$expected {default} {  raw  } = '2131675200 -0400';
+$expected {default} { local } = 'Mon Jul 20 04:00:00 2037 +0000';
+$expected {  ''   }           = $expected{default};
+$expected { local } {default} = 'Mon Jul 20 04:00:00 2037 +0000';
+$expected { local } {  ''   } = $expected{local}{default};
+$expected { local } {rfc2822} = 'Mon, 20 Jul 2037 04:00:00 +0000';
+$expected { local } {  rfc  } = $expected{local}{rfc2822};
+$expected { local } {iso8601} = '2037-07-20 04:00:00 +0000';
+$expected { local } {  iso  } = $expected{local}{iso8601};
+$expected { local } { short } = '2037-07-20';
+$expected { local } {  raw  } = '2131675200 -0400';
+$expected { local } { local } = 'Mon Jul 20 04:00:00 2037 +0000';
+
+my @zones   = keys %expected;
+my @formats = keys %{$expected{$zones[0]}}; # Assuming unvarying formats
+
+my ($config_zone, $config_format);
+
+sub print_option_sets_and_expected_outputs
+{
+	foreach my $z (@zones)
+	{
+		foreach my $f (@formats)
+		{
+			print $z, "\n", $f, "\n";
+			print $expected { $z ||  $config_zone  }
+					{ $f || $config_format },
+					"\n";
+		}
+	}
+}
+
+sub print_config_sets_and_option_sets_and_expected_outputs
+{
+	foreach (@zones)
+	{
+		$config_zone = $_;
+		print "-\n", $_, "\n";
+
+		foreach (@formats)
+		{
+			$config_format = $_;
+			print "=\n", $_, "\n";
+			print_option_sets_and_expected_outputs();
+		}
+	}
+}
+
+#########################
+#### Start of Output ####
+#########################
+
+if (defined $ARGV[1])
+{
+	foreach (@zones)
+	{
+		my $e = $expected{$_};
+		$e->{''} = $e->{$ARGV[1]};
+	}
+}
+
+if (defined $ARGV[2])
+{
+	foreach (@formats) {
+		$expected{''} = $expected{$ARGV[2]};
+	}
+}
+
+
+if (defined $ARGV[0] && $ARGV[0] eq 'config') {
+	print_config_sets_and_option_sets_and_expected_outputs();
+} else {
+	$config_zone = $config_format = '';
+	print_option_sets_and_expected_outputs();
+}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2fcc31a..cdfea8b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -463,4 +463,7 @@ test_expect_success 'show added path under "--follow -M"' '
 	)
 '
 
+. "$TEST_DIRECTORY"/date-modes-lib.sh
+date_mode_run_tests "$(date_mode_std_args 'git log -1 --format=%ad')" log
+
 test_done
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 050ed7d..d6ac4dd 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -359,4 +359,15 @@ test_expect_success 'an unusual tag with an incomplete line' '
 
 '
 
+. "$TEST_DIRECTORY"/date-modes-lib.sh
+date_mode_run_tests '
+	b()
+	{
+		git for-each-ref \
+			--count=1 \
+			--format="%(authordate${2:+:$2}${1:+@$1})" \
+			"$(git symbolic-ref HEAD)"
+	}
+	b'
+
 test_done
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index d3a51e1..f049439 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -11,4 +11,13 @@ test_expect_success 'Blame --show-email works' '
     check_count "<A@test.git>" 1 "<B@test.git>" 1 "<B1@test.git>" 1 "<B2@test.git>" 1 "<author@example.com>" 1 "<C@test.git>" 1 "<D@test.git>" 1
 '
 
+. "$TEST_DIRECTORY"/date-modes-lib.sh
+date_mode_run_tests "$(date_mode_std_args "
+	b()
+	{
+		git blame -c -L1,1 \"\$@\" '$date_mode_file' |
+			awk -F'\t' '{print \$3}'
+	}
+	b")" blame iso8601
+
 test_done
-- 
1.7.4.18.g68fe8
