Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417D91F859
	for <e@80x24.org>; Wed, 31 Aug 2016 12:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933950AbcHaMdC (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 08:33:02 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:51884 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932516AbcHaMdA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 08:33:00 -0400
Received: (qmail 3042 invoked from network); 31 Aug 2016 12:32:58 -0000
Received: (qmail 6588 invoked from network); 31 Aug 2016 12:32:58 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 31 Aug 2016 12:32:53 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 04/11] i18n: add--interactive: mark plural strings
Date:   Wed, 31 Aug 2016 12:31:23 +0000
Message-Id: <1472646690-9699-5-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark plural strings for translation.  Unfold each action case in one
entire sentence.

Pass new keyword for xgettext to extract.

Update test to include new subrotine Q__() for plural strings handling.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 Makefile                  |  3 ++-
 git-add--interactive.perl | 24 ++++++++++++++++--------
 perl/Git/I18N.pm          |  4 +++-
 t/t0202/test.pl           | 11 ++++++++++-
 4 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index de5a030..eedf1fa 100644
--- a/Makefile
+++ b/Makefile
@@ -2061,7 +2061,8 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
-XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
+XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
+	--keyword=__ --keyword="Q__:1,2"
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH) git-parse-remote.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 4e1e857..08badfa 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -666,12 +666,18 @@ sub status_cmd {
 sub say_n_paths {
 	my $did = shift @_;
 	my $cnt = scalar @_;
-	print "$did ";
-	if (1 < $cnt) {
-		print "$cnt paths\n";
-	}
-	else {
-		print "one path\n";
+	if ($did eq 'added') {
+		printf(Q__("added one path\n", "added %d paths\n",
+			   $cnt), $cnt);
+	} elsif ($did eq 'updated') {
+		printf(Q__("updated one path\n", "updated %d paths\n",
+			   $cnt), $cnt);
+	} elsif ($did eq 'reversed') {
+		printf(Q__("reversed one path\n", "reversed %d paths\n",
+			   $cnt), $cnt);
+	} else {
+		printf(Q__("touched one path\n", "touched %d paths\n",
+			   $cnt), $cnt);
 	}
 }
 
@@ -1508,8 +1514,10 @@ sub patch_update_file {
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
 				if (1 < @split) {
-					print colored $header_color, "Split into ",
-					scalar(@split), " hunks.\n";
+					print colored $header_color, sprintf(
+						Q__("Split into %d hunk.\n",
+						    "Split into %d hunks.\n",
+						    scalar(@split)), scalar(@split));
 				}
 				splice (@hunk, $ix, 1, @split);
 				$num = scalar @hunk;
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index f889fd6..5a75dd5 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -13,7 +13,7 @@ BEGIN {
 	}
 }
 
-our @EXPORT = qw(__);
+our @EXPORT = qw(__ Q__);
 our @EXPORT_OK = @EXPORT;
 
 sub __bootstrap_locale_messages {
@@ -44,6 +44,7 @@ BEGIN
 	eval {
 		__bootstrap_locale_messages();
 		*__ = \&Locale::Messages::gettext;
+		*Q__ = \&Locale::Messages::ngettext;
 		1;
 	} or do {
 		# Tell test.pl that we couldn't load the gettext library.
@@ -51,6 +52,7 @@ BEGIN
 
 		# Just a fall-through no-op
 		*__ = sub ($) { $_[0] };
+		*Q__ = sub ($$$) { $_[2] == 1 ? $_[0] : $_[1] };
 	};
 }
 
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 2c10cb4..98aa9a3 100755
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -4,7 +4,7 @@ use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
 use warnings;
 use POSIX qw(:locale_h);
-use Test::More tests => 8;
+use Test::More tests => 11;
 use Git::I18N;
 
 my $has_gettext_library = $Git::I18N::__HAS_LIBRARY;
@@ -31,6 +31,7 @@ is_deeply(\@Git::I18N::EXPORT, \@Git::I18N::EXPORT_OK, "sanity: Git::I18N export
 	# more gettext wrapper functions.
 	my %prototypes = (qw(
 		__	$
+		Q__	$$$
 	));
 	while (my ($sub, $proto) = each %prototypes) {
 		is(prototype(\&{"Git::I18N::$sub"}), $proto, "sanity: $sub has a $proto prototype");
@@ -46,6 +47,14 @@ is_deeply(\@Git::I18N::EXPORT, \@Git::I18N::EXPORT_OK, "sanity: Git::I18N export
 	my ($got, $expect) = (('TEST: A Perl test string') x 2);
 
 	is(__($got), $expect, "Passing a string through __() in the C locale works");
+
+	my ($got_singular, $got_plural, $expect_singular, $expect_plural) =
+		(('TEST: 1 file', 'TEST: n files') x 2);
+
+	is(Q__($got_singular, $got_plural, 1), $expect_singular,
+		"Get singular string through Q__() in C locale");
+	is(Q__($got_singular, $got_plural, 2), $expect_plural,
+		"Get plural string through Q__() in C locale");
 }
 
 # Test a basic message on different locales
-- 
2.7.4

