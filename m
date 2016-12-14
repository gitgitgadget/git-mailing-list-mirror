Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_PH_SURBL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238E31FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 12:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755669AbcLNMzs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 07:55:48 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:56596 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755507AbcLNMzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 07:55:42 -0500
Received: (qmail 2047 invoked from network); 14 Dec 2016 12:55:37 -0000
Received: (qmail 25852 invoked from network); 14 Dec 2016 12:55:37 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 14 Dec 2016 12:55:37 -0000
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
Subject: [PATCH v7 00/16] Mark strings in Perl scripts for translation
Date:   Wed, 14 Dec 2016 11:54:23 -0100
Message-Id: <20161214125439.8822-1-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.44.g7d42c6c
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes is this re-roll v7:
* Add get_comment_line_char subroutine to perl/Git.pm and use it.
* get_comment_line_char gets the value of core.commentchar configuration
  variable. It handles the 'auto' value taking '#' in this case as the
  comment line character.
* When core.commentchar is not set to one single character, take '#' as the
  comment line character. This follows the system behaviour programmed in
  config.c::git_default_core_config.

Interdiff from v6 included below.

Vasco Almeida (16):
  Git.pm: add subroutines for commenting lines
  i18n: add--interactive: mark strings for translation
  i18n: add--interactive: mark simple here-documents for translation
  i18n: add--interactive: mark strings with interpolation for
    translation
  i18n: clean.c: match string with git-add--interactive.perl
  i18n: add--interactive: mark plural strings
  i18n: add--interactive: mark patch prompt for translation
  i18n: add--interactive: i18n of help_patch_cmd
  i18n: add--interactive: mark edit_hunk_manually message for
    translation
  i18n: add--interactive: remove %patch_modes entries
  i18n: add--interactive: mark status words for translation
  i18n: send-email: mark strings for translation
  i18n: send-email: mark warnings and errors for translation
  i18n: send-email: mark string with interpolation for translation
  i18n: send-email: mark composing message for translation
  i18n: difftool: mark warnings for translation

 Makefile                  |   3 +-
 builtin/clean.c           |  10 +-
 git-add--interactive.perl | 329 ++++++++++++++++++++++++++++++----------------
 git-difftool.perl         |  22 ++--
 git-send-email.perl       | 191 +++++++++++++++------------
 perl/Git.pm               |  38 ++++++
 perl/Git/I18N.pm          |  19 ++-
 t/t0202/test.pl           |  14 +-
 8 files changed, 408 insertions(+), 218 deletions(-)

-- >8 --
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3a6d846..4e0ab5a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1072,7 +1072,7 @@ sub edit_hunk_manually {
 	print $fh @$oldtext;
 	my $is_reverse = $patch_mode_flavour{IS_REVERSE};
 	my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') : ('+', '-');
-	my $comment_line_char = Git::config("core.commentchar") || '#';
+	my $comment_line_char = Git::get_comment_line_char;
 	print $fh Git::comment_lines sprintf(__ <<EOF, $remove_minus, $remove_plus, $comment_line_char),
 ---
 To remove '%s' lines, make them ' ' lines (context).
diff --git a/perl/Git.pm b/perl/Git.pm
index 69cd1dd..bfce1f7 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1451,6 +1451,20 @@ sub prefix_lines {
 	return $string;
 }
 
+=item get_comment_line_char ( )
+
+Gets the core.commentchar configuration value.
+The value falls-back to '#' if core.commentchar is set to 'auto'.
+
+=cut
+
+sub get_comment_line_char {
+	my $comment_line_char = config("core.commentchar") || '#';
+	$comment_line_char = '#' if ($comment_line_char eq 'auto');
+	$comment_line_char = '#' if (length($comment_line_char) != 1);
+	return $comment_line_char;
+}
+
 =item comment_lines ( STRING [, STRING... ])
 
 Comments lines following core.commentchar configuration.
@@ -1458,7 +1472,7 @@ Comments lines following core.commentchar configuration.
 =cut
 
 sub comment_lines {
-	my $comment_line_char = config("core.commentchar") || '#';
+	my $comment_line_char = get_comment_line_char;
 	return prefix_lines("$comment_line_char ", @_);
 }
 
-- >8 --

-- 
2.11.0.44.g7d42c6c

