From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v8 07/10] send-email: reduce dependencies impact on parse_address_line
Date: Tue,  7 Jul 2015 15:38:15 +0200
Message-ID: <1436276295-694-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq8uasqeru.fsf@anie.imag.fr>
Cc: git@vger.kernel.org, tboegi@web.de,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 07 15:38:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCT51-0005DR-KG
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 15:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280AbbGGNic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 09:38:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51290 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbbGGNiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 09:38:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t67DcF3j020127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 7 Jul 2015 15:38:16 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t67DcHXO004502;
	Tue, 7 Jul 2015 15:38:17 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZCT4j-000198-1g; Tue, 07 Jul 2015 15:38:17 +0200
X-Mailer: git-send-email 2.5.0.rc0.7.ge1edd74.dirty
In-Reply-To: <vpq8uasqeru.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 07 Jul 2015 15:38:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t67DcF3j020127
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436881099.96007@mjhZQQMqCRHQ9gOPkLqNlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273502>

From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>

parse_address_line had not the same behavior whether the user had
Mail::Address or not. Teach parse_address_line to behave like
Mail::Address.

When the user input is correct, this implementation behaves
exactly like Mail::Address except when there are quotes
inside the name:

  "Jane Do"e <jdoe@example.com>

In this case the result of parse_address_line is:

  With M::A : "Jane Do" e <jdoe@example.com>
  Without   : "Jane Do e" <jdoe@example.com>

When the user input is not correct, the behavior is also mostly
the same.

Unlike Mail::Address, this doesn't parse groups and recursive
commentaries.

Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Since v7: portability fix on the final exit() in the perl script.

 git-send-email.perl  |  2 +-
 perl/Git.pm          | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t9000-addresses.sh | 27 +++++++++++++++++++++
 t/t9000/test.pl      | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100755 t/t9000-addresses.sh
 create mode 100755 t/t9000/test.pl

diff --git a/git-send-email.perl b/git-send-email.perl
index 09ecad8..486cb36 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -478,7 +478,7 @@ sub parse_address_line {
 	if ($have_mail_address) {
 		return map { $_->format } Mail::Address->parse($_[0]);
 	} else {
-		return split_addrs($_[0]);
+		return Git::parse_mailboxes($_[0]);
 	}
 }
 
diff --git a/perl/Git.pm b/perl/Git.pm
index 9026a7b..19ef081 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -864,6 +864,73 @@ sub ident_person {
 	return "$ident[0] <$ident[1]>";
 }
 
+=item parse_mailboxes
+
+Return an array of mailboxes extracted from a string.
+
+=cut
+
+sub parse_mailboxes {
+	my $re_comment = qr/\((?:[^)]*)\)/;
+	my $re_quote = qr/"(?:[^\"\\]|\\.)*"/;
+	my $re_word = qr/(?:[^]["\s()<>:;@\\,.]|\\.)+/;
+
+	# divide the string in tokens of the above form
+	my $re_token = qr/(?:$re_quote|$re_word|$re_comment|\S)/;
+	my @tokens = map { $_ =~ /\s*($re_token)\s*/g } @_;
+
+	# add a delimiter to simplify treatment for the last mailbox
+	push @tokens, ",";
+
+	my (@addr_list, @phrase, @address, @comment, @buffer) = ();
+	foreach my $token (@tokens) {
+		if ($token =~ /^[,;]$/) {
+			# if buffer still contains undeterminated strings
+			# append it at the end of @address or @phrase
+			if (@address) {
+				push @address, @buffer;
+			} else {
+				push @phrase, @buffer;
+			}
+
+			my $str_phrase = join ' ', @phrase;
+			my $str_address = join '', @address;
+			my $str_comment = join ' ', @comment;
+
+			# quote are necessary if phrase contains
+			# special characters
+			if ($str_phrase =~ /[][()<>:;@\\,.\000-\037\177]/) {
+				$str_phrase =~ s/(^|[^\\])"/$1/g;
+				$str_phrase = qq["$str_phrase"];
+			}
+
+			# add "<>" around the address if necessary
+			if ($str_address ne "" && $str_phrase ne "") {
+				$str_address = qq[<$str_address>];
+			}
+
+			my $str_mailbox = "$str_phrase $str_address $str_comment";
+			$str_mailbox =~ s/^\s*|\s*$//g;
+			push @addr_list, $str_mailbox if ($str_mailbox);
+
+			@phrase = @address = @comment = @buffer = ();
+		} elsif ($token =~ /^\(/) {
+			push @comment, $token;
+		} elsif ($token eq "<") {
+			push @phrase, (splice @address), (splice @buffer);
+		} elsif ($token eq ">") {
+			push @address, (splice @buffer);
+		} elsif ($token eq "@") {
+			push @address, (splice @buffer), "@";
+		} elsif ($token eq ".") {
+			push @address, (splice @buffer), ".";
+		} else {
+			push @buffer, $token;
+		}
+	}
+
+	return @addr_list;
+}
 
 =item hash_object ( TYPE, FILENAME )
 
diff --git a/t/t9000-addresses.sh b/t/t9000-addresses.sh
new file mode 100755
index 0000000..a1ebef6
--- /dev/null
+++ b/t/t9000-addresses.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='compare address parsing with and without Mail::Address'
+. ./test-lib.sh
+
+if ! test_have_prereq PERL; then
+	skip_all='skipping perl interface tests, perl not available'
+	test_done
+fi
+
+perl -MTest::More -e 0 2>/dev/null || {
+	skip_all="Perl Test::More unavailable, skipping test"
+	test_done
+}
+
+perl -MMail::Address -e 0 2>/dev/null || {
+	skip_all="Perl Mail::Address unavailable, skipping test"
+	test_done
+}
+
+test_external_has_tap=1
+
+test_external_without_stderr \
+	'Perl address parsing function' \
+	perl "$TEST_DIRECTORY"/t9000/test.pl
+
+test_done
diff --git a/t/t9000/test.pl b/t/t9000/test.pl
new file mode 100755
index 0000000..2d05d3e
--- /dev/null
+++ b/t/t9000/test.pl
@@ -0,0 +1,67 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use 5.008;
+use warnings;
+use strict;
+
+use Test::More qw(no_plan);
+use Mail::Address;
+
+BEGIN { use_ok('Git') }
+
+my @success_list = (q[Jane],
+	q[jdoe@example.com],
+	q[<jdoe@example.com>],
+	q[Jane <jdoe@example.com>],
+	q[Jane Doe <jdoe@example.com>],
+	q["Jane" <jdoe@example.com>],
+	q["Doe, Jane" <jdoe@example.com>],
+	q["Jane@:;\>.,()<Doe" <jdoe@example.com>],
+	q[Jane!#$%&'*+-/=?^_{|}~Doe' <jdoe@example.com>],
+	q["<jdoe@example.com>"],
+	q["Jane jdoe@example.com"],
+	q[Jane Doe <jdoe    @   example.com  >],
+	q[Jane       Doe <  jdoe@example.com  >],
+	q[Jane @ Doe @ Jane @ Doe],
+	q["Jane, 'Doe'" <jdoe@example.com>],
+	q['Doe, "Jane' <jdoe@example.com>],
+	q["Jane" "Do"e <jdoe@example.com>],
+	q["Jane' Doe" <jdoe@example.com>],
+	q["Jane Doe <jdoe@example.com>" <jdoe@example.com>],
+	q["Jane\" Doe" <jdoe@example.com>],
+	q[Doe, jane <jdoe@example.com>],
+	q["Jane Doe <jdoe@example.com>],
+	q['Jane 'Doe' <jdoe@example.com>]);
+
+my @known_failure_list = (q[Jane\ Doe <jdoe@example.com>],
+	q["Doe, Ja"ne <jdoe@example.com>],
+	q["Doe, Katarina" Jane <jdoe@example.com>],
+	q[Jane@:;\.,()<>Doe <jdoe@example.com>],
+	q[Jane jdoe@example.com],
+	q[<jdoe@example.com> Jane Doe],
+	q[Jane <jdoe@example.com> Doe],
+	q["Jane "Kat"a" ri"na" ",Doe" <jdoe@example.com>],
+	q[Jane Doe],
+	q[Jane "Doe <jdoe@example.com>"],
+	q[\"Jane Doe <jdoe@example.com>],
+	q[Jane\"\" Doe <jdoe@example.com>],
+	q['Jane "Katarina\" \' Doe' <jdoe@example.com>]);
+
+foreach my $str (@success_list) {
+	my @expected = map { $_->format } Mail::Address->parse("$str");
+	my @actual = Git::parse_mailboxes("$str");
+	is_deeply(\@expected, \@actual, qq[same output : $str]);
+}
+
+TODO: {
+	local $TODO = "known breakage";
+	foreach my $str (@known_failure_list) {
+		my @expected = map { $_->format } Mail::Address->parse("$str");
+		my @actual = Git::parse_mailboxes("$str");
+		is_deeply(\@expected, \@actual, qq[same output : $str]);
+	}
+}
+
+my $is_passing = eval { Test::More->is_passing };
+exit($is_passing ? 0 : 1) unless $@ =~ /Can't locate object method/;
-- 
2.5.0.rc0.7.ge1edd74.dirty
