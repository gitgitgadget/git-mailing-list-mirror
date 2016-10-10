Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URIBL_PH_SURBL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23DEB20986
	for <e@80x24.org>; Mon, 10 Oct 2016 12:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbcJJMz7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 08:55:59 -0400
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:37607 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752319AbcJJMz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 08:55:58 -0400
Received: (qmail 11551 invoked from network); 10 Oct 2016 12:55:57 -0000
Received: (qmail 16384 invoked from network); 10 Oct 2016 12:55:54 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 10 Oct 2016 12:55:49 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 05/14] i18n: add--interactive: mark plural strings
Date:   Mon, 10 Oct 2016 12:54:40 +0000
Message-Id: <20161010125449.7929-6-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.396.g621fe23
In-Reply-To: <20161010125449.7929-1-vascomalmeida@sapo.pt>
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark plural strings for translation.  Unfold each action case in one
entire sentence.

Pass new keyword for xgettext to extract.

Update test to include new subroutine __n() for plural strings handling.

Update documentation to include a description of the new __n() subroutine.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 Makefile                  |  3 ++-
 git-add--interactive.perl | 27 ++++++++++++++++++---------
 perl/Git/I18N.pm          |  9 ++++++++-
 t/t0202/test.pl           | 11 ++++++++++-
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 1aad150..4ef0344 100644
--- a/Makefile
+++ b/Makefile
@@ -2111,7 +2111,8 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
-XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
+XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
+	--keyword=__ --keyword="__n:1,2"
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-parse-remote.sh
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index d05ac60..cd61783 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -669,12 +669,18 @@ sub status_cmd {
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
+		printf(__n("added %d path\n", "added %d paths\n",
+			   $cnt), $cnt);
+	} elsif ($did eq 'updated') {
+		printf(__n("updated %d path\n", "updated %d paths\n",
+			   $cnt), $cnt);
+	} elsif ($did eq 'reverted') {
+		printf(__n("reverted %d path\n", "reverted %d paths\n",
+			   $cnt), $cnt);
+	} else {
+		printf(__n("touched %d path\n", "touched %d paths\n",
+			   $cnt), $cnt);
 	}
 }
 
@@ -1423,7 +1429,8 @@ sub patch_update_file {
 				} elsif (0 < $response && $response <= $num) {
 					$ix = $response - 1;
 				} else {
-					error_msg "Sorry, only $num hunks available.\n";
+					error_msg sprintf(__n("Sorry, only %d hunk available.\n",
+							      "Sorry, only %d hunks available.\n", $num), $num);
 				}
 				next;
 			}
@@ -1518,8 +1525,10 @@ sub patch_update_file {
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
 				if (1 < @split) {
-					print colored $header_color, "Split into ",
-					scalar(@split), " hunks.\n";
+					print colored $header_color, sprintf(
+						__n("Split into %d hunk.\n",
+						    "Split into %d hunks.\n",
+						    scalar(@split)), scalar(@split));
 				}
 				splice (@hunk, $ix, 1, @split);
 				$num = scalar @hunk;
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index f889fd6..3f7ac25 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -13,7 +13,7 @@ BEGIN {
 	}
 }
 
-our @EXPORT = qw(__);
+our @EXPORT = qw(__ __n);
 our @EXPORT_OK = @EXPORT;
 
 sub __bootstrap_locale_messages {
@@ -44,6 +44,7 @@ BEGIN
 	eval {
 		__bootstrap_locale_messages();
 		*__ = \&Locale::Messages::gettext;
+		*__n = \&Locale::Messages::ngettext;
 		1;
 	} or do {
 		# Tell test.pl that we couldn't load the gettext library.
@@ -51,6 +52,7 @@ BEGIN
 
 		# Just a fall-through no-op
 		*__ = sub ($) { $_[0] };
+		*__n = sub ($$$) { $_[2] == 1 ? $_[0] : $_[1] };
 	};
 }
 
@@ -70,6 +72,8 @@ Git::I18N - Perl interface to Git's Gettext localizations
 
 	printf __("The following error occurred: %s\n"), $error;
 
+	printf __n("commited %d file", "commited %d files", $files), $files;
+
 =head1 DESCRIPTION
 
 Git's internal Perl interface to gettext via L<Locale::Messages>. If
@@ -87,6 +91,9 @@ it.
 L<Locale::Messages>'s gettext function if all goes well, otherwise our
 passthrough fallback function.
 
+=head2 __n($$$)
+L<Locale::Messages>'s ngettext function or passthrough fallback function.
+
 =head1 AUTHOR
 
 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail.com>
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 2c10cb4..4101833 100755
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
+		__n	$$$
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
+	is(__n($got_singular, $got_plural, 1), $expect_singular,
+		"Get singular string through __n() in C locale");
+	is(__n($got_singular, $got_plural, 2), $expect_plural,
+		"Get plural string through __n() in C locale");
 }
 
 # Test a basic message on different locales
-- 
2.7.4

