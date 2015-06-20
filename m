From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH v5 07/10] send-email: reduce dependancies impact on parse_address_line
Date: Sun, 21 Jun 2015 01:17:50 +0200
Message-ID: <1434842273-30945-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
 <1434842273-30945-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 01:18:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6S1s-0007nJ-8J
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 01:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbbFTXSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 19:18:15 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:52352 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754859AbbFTXR7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Jun 2015 19:17:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 20E6036E5;
	Sun, 21 Jun 2015 01:17:58 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LFjdltguMMWC; Sun, 21 Jun 2015 01:17:58 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0612236B6;
	Sun, 21 Jun 2015 01:17:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 026EF20D6;
	Sun, 21 Jun 2015 01:17:58 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id liSFgasjbuXO; Sun, 21 Jun 2015 01:17:57 +0200 (CEST)
Received: from localhost.localdomain (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 7F12920DF;
	Sun, 21 Jun 2015 01:17:57 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1434842273-30945-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272249>

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

---

I've added the function in Git.pm as suggested. I've also added a test
named t9000-addresses.sh (I've read the README to name tests but I'm
not sure about the name of this test). I made a separated test
(t9000-addresses.sh) because I think it's better not to pollute
t9001-send-email with this.

About the test itself, file t/t9000-addresses.sh is just a copy/paste
of t/t0202-gettext-perl.sh. For the perl part, the TODO tests are
verbose: they print out commands whereas test_expect_success doesn't.
We can redirect todo_output to a variable but I've not found better...
(Maybe someone has the solution here ?). Also there's no summary at
the end of the test (as with other perl tests).

 git-send-email.perl  |  2 +-
 perl/Git.pm          | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t9000-addresses.sh | 25 ++++++++++++++++++
 t/t9000/test.pl      | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100755 t/t9000-addresses.sh
 create mode 100755 t/t9000/test.pl

diff --git a/git-send-email.perl b/git-send-email.perl
index a0cd7ff..bced78e 100755
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
index 9026a7b..97633e9 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1584,6 +1584,73 @@ sub DESTROY {
 	$self->_close_cat_blob();
 }
 
+=item parse_mailboxes
+
+Returns an array of mailboxes extracted from a string.
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
 
 # Pipe implementation for ActiveState Perl.
 
diff --git a/t/t9000-addresses.sh b/t/t9000-addresses.sh
new file mode 100755
index 0000000..280f2c5
--- /dev/null
+++ b/t/t9000-addresses.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+#
+# Copyright (c) 2015
+#
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
+test_external_has_tap=1
+
+test_external_without_stderr \
+	'Perl address parsing function' \
+	perl "$TEST_DIRECTORY"/t9000/test.pl
+
+test_done
diff --git a/t/t9000/test.pl b/t/t9000/test.pl
new file mode 100755
index 0000000..f8b7b34
--- /dev/null
+++ b/t/t9000/test.pl
@@ -0,0 +1,71 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use 5.008;
+use warnings;
+use strict;
+
+use Test::More;
+
+BEGIN {
+	Test::More->builder->no_ending(1);
+}
+
+BEGIN { use_ok('Git') }
+BEGIN { use_ok('Mail::Address') }
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
+my $is_passing = Test::More->builder->is_passing;
+exit($is_passing ? 0 : 1);
-- 
1.9.1
