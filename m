Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E924203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 10:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbcLJKIV (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 05:08:21 -0500
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:56972 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752881AbcLJKIT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 05:08:19 -0500
Received: (qmail 12435 invoked from network); 10 Dec 2016 10:08:17 -0000
Received: (qmail 12584 invoked from network); 10 Dec 2016 10:08:17 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 10 Dec 2016 10:08:17 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1481364496.1993.14.camel@sapo.pt>
Subject: Re: [PATCH v6 01/16] Git.pm: add subroutines for commenting lines
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Sat, 10 Dec 2016 09:08:16 -0100
In-Reply-To: <xmqqk2b8rbbb.fsf@gitster.mtv.corp.google.com>
References: <20161111124541.8216-1-vascomalmeida@sapo.pt>
         <20161111124541.8216-2-vascomalmeida@sapo.pt>
         <1479823833.1956.7.camel@sapo.pt>
         <xmqqoa17quls.fsf@gitster.mtv.corp.google.com>
         <1481303956.4934.8.camel@sapo.pt>
         <alpine.DEB.2.20.1612091832310.23160@virtualbox>
         <xmqqk2b8rbbb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Sex, 09-12-2016 às 14:23 -0800, Junio C Hamano escreveu:
> > This is exactly the same issue I fixed for rebase -i recently.
> 
> Yes, but the patch we see here punts "core.commentChar is not a
> single-byte single-letter--panic!" case differently.  I think you
> did "just take the first one" in "rebase -i", which I think is more
> in line with the rest of the system, and this addition to Git.pm
> should do the same, I think.

I hope the changes below are in line with the rest of the system. If
so, I will send a new re-roll with them.

I wonder why this is important when Git errors out when
core.commentChar is set to more than 1 characters or 0 characters. Is
it just to be consistent with "rebase -i" changes introduced
by Johannes Schindelin?

I am not sure what does "if (length($comment_line_char) != 1)" check.
Whether it checks single-byte or single-letter or both...

-- >8 --
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3a6d846..4e0ab5a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1072,7 +1072,7 @@ sub edit_hunk_manually {
 	print $fh @$oldtext;
 	my $is_reverse = $patch_mode_flavour{IS_REVERSE};
 	my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') :
('+', '-');
-	my $comment_line_char = Git::config("core.commentchar") ||
'#';
+	my $comment_line_char = Git::get_comment_line_char;
 	print $fh Git::comment_lines sprintf(__ <<EOF, $remove_minus,
$remove_plus, $comment_line_char),
 ---
 To remove '%s' lines, make them ' ' lines (context).
diff --git a/perl/Git.pm b/perl/Git.pm
index 69cd1dd..3211650 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1451,6 +1451,23 @@ sub prefix_lines {
 	return $string;
 }
 
+=item get_comment_line_char ( )
+
+Gets the core.commentchar configuration value.
+The value falls-back to # if core.commentchar is set to 'auto'.
+
+=cut
+
+sub get_comment_line_char {
+	my $comment_line_char = config("core.commentchar") || '#';
+	$comment_line_char = '#' if ($comment_line_char eq 'auto');
+	if (length($comment_line_char) != 1) {
+		# use first character
+		$comment_line_char = substr($comment_line_char, 0, 1);
+	}
+	return $comment_line_char;
+}
+
 =item comment_lines ( STRING [, STRING... ])
 
 Comments lines following core.commentchar configuration.
@@ -1458,7 +1475,7 @@ Comments lines following core.commentchar
configuration.
 =cut
 
 sub comment_lines {
-	my $comment_line_char = config("core.commentchar") || '#';
+	my $comment_line_char = get_comment_line_char;
 	return prefix_lines("$comment_line_char ", @_);
 }
 
