Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669D11FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 17:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbcLIRTU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 12:19:20 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:56197 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933531AbcLIRTT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 12:19:19 -0500
Received: (qmail 22010 invoked from network); 9 Dec 2016 17:19:16 -0000
Received: (qmail 23376 invoked from network); 9 Dec 2016 17:19:16 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 9 Dec 2016 17:19:16 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1481303956.4934.8.camel@sapo.pt>
Subject: Re: [PATCH v6 01/16] Git.pm: add subroutines for commenting lines
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Fri, 09 Dec 2016 16:19:16 -0100
In-Reply-To: <xmqqoa17quls.fsf@gitster.mtv.corp.google.com>
References: <20161111124541.8216-1-vascomalmeida@sapo.pt>
         <20161111124541.8216-2-vascomalmeida@sapo.pt>
         <1479823833.1956.7.camel@sapo.pt>
         <xmqqoa17quls.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Ter, 22-11-2016 às 09:42 -0800, Junio C Hamano escreveu:
> The incremental update below looks sensible.  We'd also want to
> protect this codepath from a misconfigured two-or-more byte sequence
> in core.commentchar, I would suspect, to be consistent.

Are the below changes alright for what you propose? It just checks if
the length of core.commentchar's value is 1, otherwise use '#' as the
comment_line_char.
As a note, when I set core.commentchar with "git config
core.commentChar 'batata'", I get the following error message when I
issue "git add -i":

error: core.commentChar should only be one character
fatal: bad config variable 'core.commentchar' in file '.git/config' at line 6

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
index 69cd1dd..e4da913 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1451,6 +1451,20 @@ sub prefix_lines {
 	return $string;
 }
 
+=item get_comment_line_char ( )
+
+Gets the core.commentchar configuration value.
+The value fallbacks to # if core.commentchar is set to 'auto'.
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
 
