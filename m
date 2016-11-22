Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA7B1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 14:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755427AbcKVOKh (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 09:10:37 -0500
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:40508 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755305AbcKVOKg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 09:10:36 -0500
Received: (qmail 25034 invoked from network); 22 Nov 2016 14:10:33 -0000
Received: (qmail 24000 invoked from network); 22 Nov 2016 14:10:33 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 22 Nov 2016 14:10:33 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1479823833.1956.7.camel@sapo.pt>
Subject: Re: [PATCH v6 01/16] Git.pm: add subroutines for commenting lines
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Date:   Tue, 22 Nov 2016 13:10:33 -0100
In-Reply-To: <20161111124541.8216-2-vascomalmeida@sapo.pt>
References: <20161111124541.8216-1-vascomalmeida@sapo.pt>
         <20161111124541.8216-2-vascomalmeida@sapo.pt>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Sex, 11-11-2016 às 11:45 -0100, Vasco Almeida escreveu:
> +=item comment_lines ( STRING [, STRING... ])
> +
> +Comments lines following core.commentchar configuration.
> +
> +=cut
> +
> +sub comment_lines {
> +       my $comment_line_char = config("core.commentchar") || '#';
> +       return prefix_lines("$comment_line_char ", @_);
> +}
> +

In light of the recent "Fix problems with rebase -i when
core.commentchar is defined" [1], I realized that this patch does not
handle the 'auto' value of core.commentchat configuration variable.

I propose to do the patch below in the next re-roll.

[1] http://www.mail-archive.com/git@vger.kernel.org/msg107818.html

-- >8 --
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3a6d846..8d33634 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1073,6 +1073,7 @@ sub edit_hunk_manually {
 	my $is_reverse = $patch_mode_flavour{IS_REVERSE};
 	my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') : ('+', '-');
 	my $comment_line_char = Git::config("core.commentchar") || '#';
+	$comment_line_char = '#' if ($comment_line_char eq 'auto');
 	print $fh Git::comment_lines sprintf(__ <<EOF, $remove_minus, $remove_plus, $comment_line_char),
 ---
 To remove '%s' lines, make them ' ' lines (context).
diff --git a/perl/Git.pm b/perl/Git.pm
index 69cd1dd..47b5899 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1459,6 +1459,7 @@ Comments lines following core.commentchar configuration.
 
 sub comment_lines {
 	my $comment_line_char = config("core.commentchar") || '#';
+	$comment_line_char = '#' if ($comment_line_char eq 'auto');
 	return prefix_lines("$comment_line_char ", @_);
 }
