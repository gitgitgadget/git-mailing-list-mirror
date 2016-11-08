Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_PH_SURBL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2862022A
	for <e@80x24.org>; Tue,  8 Nov 2016 12:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932977AbcKHMMR (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 07:12:17 -0500
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:43094 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933145AbcKHMLt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 07:11:49 -0500
Received: (qmail 6850 invoked from network); 8 Nov 2016 12:11:47 -0000
Received: (qmail 8987 invoked from network); 8 Nov 2016 12:11:47 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Nov 2016 12:11:47 -0000
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
Subject: [PATCH v5 07/16] i18n: add--interactive: mark patch prompt for translation
Date:   Tue,  8 Nov 2016 11:08:14 -0100
Message-Id: <20161108120823.11204-8-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.rc0.23.g8236252
In-Reply-To: <20161108120823.11204-1-vascomalmeida@sapo.pt>
References: <20161108120823.11204-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark prompt message assembled in place for translation, unfolding each
use case for each entry in the %patch_modes hash table.

Previously, this script relied on whether $patch_mode was set to run the
command patch_update_cmd() or show status and loop the main loop. Now,
it uses $cmd to indicate we must run patch_update_cmd() and $patch_mode
is used to tell which flavor of the %patch_modes are we on.  This is
introduced in order to be able to mark and unfold the message prompt
knowing in which context we are.

The tracking of context was done previously by point %patch_mode_flavour
hash table to the correct entry of %patch_modes, focusing only on value
of %patch_modes. Now, we are also interested in the key ('staged',
'stash', 'checkout_head', ...).

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 Makefile                  |  2 +-
 git-add--interactive.perl | 54 ++++++++++++++++++++++++++++++++++++++++-------
 perl/Git/I18N.pm          | 11 +++++++++-
 t/t0202/test.pl           |  5 ++++-
 4 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 328151dd6..ee89c0624 100644
--- a/Makefile
+++ b/Makefile
@@ -2114,7 +2114,7 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
-	--keyword=__ --keyword="__n:1,2"
+	--keyword=__ --keyword=N__ --keyword="__n:1,2"
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
 LOCALIZED_SH += git-parse-remote.sh
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index cd617837b..b7d382b10 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -93,6 +93,7 @@ sub colored {
 }
 
 # command line options
+my $cmd;
 my $patch_mode;
 my $patch_mode_revision;
 
@@ -173,7 +174,8 @@ my %patch_modes = (
 	},
 );
 
-my %patch_mode_flavour = %{$patch_modes{stage}};
+$patch_mode = 'stage';
+my %patch_mode_flavour = %{$patch_modes{$patch_mode}};
 
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
@@ -1311,6 +1313,44 @@ sub display_hunks {
 	return $i;
 }
 
+my %patch_update_prompt_modes = (
+	stage => {
+		mode => N__("Stage mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Stage deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Stage this hunk [y,n,q,a,d,/%s,?]? "),
+	},
+	stash => {
+		mode => N__("Stash mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Stash deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Stash this hunk [y,n,q,a,d,/%s,?]? "),
+	},
+	reset_head => {
+		mode => N__("Unstage mode change [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Unstage deletion [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Unstage this hunk [y,n,q,a,d,/%s,?]? "),
+	},
+	reset_nothead => {
+		mode => N__("Apply mode change to index [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Apply deletion to index [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Apply this hunk to index [y,n,q,a,d,/%s,?]? "),
+	},
+	checkout_index => {
+		mode => N__("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "),
+	},
+	checkout_head => {
+		mode => N__("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "),
+	},
+	checkout_nothead => {
+		mode => N__("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "),
+		deletion => N__("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "),
+		hunk => N__("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "),
+	},
+);
+
 sub patch_update_file {
 	my $quit = 0;
 	my ($ix, $num);
@@ -1383,12 +1423,9 @@ sub patch_update_file {
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, $patch_mode_flavour{VERB},
-		  ($hunk[$ix]{TYPE} eq 'mode' ? ' mode change' :
-		   $hunk[$ix]{TYPE} eq 'deletion' ? ' deletion' :
-		   ' this hunk'),
-		  $patch_mode_flavour{TARGET},
-		  " [y,n,q,a,d,/$other,?]? ";
+		print colored $prompt_color,
+			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}), $other);
+
 		my $line = prompt_single_character;
 		last unless defined $line;
 		if ($line) {
@@ -1644,6 +1681,7 @@ sub process_args {
 		die sprintf(__("invalid argument %s, expecting --"),
 			       $arg) unless $arg eq "--";
 		%patch_mode_flavour = %{$patch_modes{$patch_mode}};
+		$cmd = 1;
 	}
 	elsif ($arg ne "--") {
 		die sprintf(__("invalid argument %s, expecting --"), $arg);
@@ -1680,7 +1718,7 @@ sub main_loop {
 
 process_args();
 refresh();
-if ($patch_mode) {
+if ($cmd) {
 	patch_update_cmd();
 }
 else {
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 617d8c2a1..c41425c8d 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -13,7 +13,7 @@ BEGIN {
 	}
 }
 
-our @EXPORT = qw(__ __n);
+our @EXPORT = qw(__ __n N__);
 our @EXPORT_OK = @EXPORT;
 
 sub __bootstrap_locale_messages {
@@ -54,6 +54,8 @@ BEGIN
 		*__ = sub ($) { $_[0] };
 		*__n = sub ($$$) { $_[2] == 1 ? $_[0] : $_[1] };
 	};
+
+	sub N__($) { return shift; }
 }
 
 1;
@@ -74,6 +76,7 @@ Git::I18N - Perl interface to Git's Gettext localizations
 
 	printf __n("commited %d file\n", "commited %d files\n", $files), $files;
 
+
 =head1 DESCRIPTION
 
 Git's internal Perl interface to gettext via L<Locale::Messages>. If
@@ -95,6 +98,12 @@ passthrough fallback function.
 
 L<Locale::Messages>'s ngettext function or passthrough fallback function.
 
+=head2 N__($)
+
+No-operation that only returns its argument. Use this if you want xgettext to
+extract the text to the pot template but do not want to trigger retrival of the
+translation at run time.
+
 =head1 AUTHOR
 
 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail.com>
diff --git a/t/t0202/test.pl b/t/t0202/test.pl
index 4101833a8..2cbf7b959 100755
--- a/t/t0202/test.pl
+++ b/t/t0202/test.pl
@@ -4,7 +4,7 @@ use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
 use warnings;
 use POSIX qw(:locale_h);
-use Test::More tests => 11;
+use Test::More tests => 13;
 use Git::I18N;
 
 my $has_gettext_library = $Git::I18N::__HAS_LIBRARY;
@@ -32,6 +32,7 @@ is_deeply(\@Git::I18N::EXPORT, \@Git::I18N::EXPORT_OK, "sanity: Git::I18N export
 	my %prototypes = (qw(
 		__	$
 		__n	$$$
+		N__	$
 	));
 	while (my ($sub, $proto) = each %prototypes) {
 		is(prototype(\&{"Git::I18N::$sub"}), $proto, "sanity: $sub has a $proto prototype");
@@ -55,6 +56,8 @@ is_deeply(\@Git::I18N::EXPORT, \@Git::I18N::EXPORT_OK, "sanity: Git::I18N export
 		"Get singular string through __n() in C locale");
 	is(__n($got_singular, $got_plural, 2), $expect_plural,
 		"Get plural string through __n() in C locale");
+
+	is(N__($got), $expect, "Passing a string through N__() in the C locale works");
 }
 
 # Test a basic message on different locales
-- 
2.11.0.rc0.23.g8236252

