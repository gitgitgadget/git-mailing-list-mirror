Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925761F935
	for <e@80x24.org>; Wed, 21 Sep 2016 22:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933871AbcIUWTA (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:19:00 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59332 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932337AbcIUWS7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Sep 2016 18:18:59 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F1B3C20530;
        Wed, 21 Sep 2016 18:18:57 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 21 Sep 2016 18:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        cc:date:from:in-reply-to:message-id:references:subject:to
        :x-sasl-enc:x-sasl-enc; s=mesmtp; bh=2/TD0k95xMBt52Ul7zmknXTjylY
        =; b=tr4GFPev2MxCqdVbwckR4C5Y31DUdySv4Yzy5Hm/6bxWqmVEh4z7Q1K3bJr
        GvRhAcUJTQ6lANPHE82lRa2GCNh25rioZ18Zq45pj8CJo+1v+JCzOOKWdfNU4ejA
        7nWmNSkY6IfxdnR26cm3DsbBfc5dxJVz2RabeE9GLZP49wpk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=2/TD
        0k95xMBt52Ul7zmknXTjylY=; b=uQ/ujqflzcezptmYLBZC7nNLfxi0YoaaGI+P
        NabFk9AusoQZVq+RsvJ2MgovwJLs5qhq/L3glVcuqkxCCBqfgdh0LdMSNcFzOHhL
        MDjXUYeJuVkg9VAGjtsHA+Fytm+tj5zgUCv5bn8Yz2tJL65hQNa6Zw/c6sYiEotl
        p/h0GYs=
X-Sasl-enc: oP/Fbig11deAQorQB+0yU/scxVa2C4a/mTgVLzK2DNrD 1474496337
Received: from treetowl.lan (c-73-53-70-213.hsd1.wa.comcast.net [73.53.70.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A052F29CD;
        Wed, 21 Sep 2016 18:18:57 -0400 (EDT)
Received: by treetowl.lan (Postfix, from userid 1000)
        id B8D7A1C2859; Wed, 21 Sep 2016 15:18:56 -0700 (PDT)
From:   Ian Kelling <ian@iankelling.org>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com
Subject: [PATCH] gitweb: use highlight's shebang detection
Date:   Wed, 21 Sep 2016 15:18:56 -0700
Message-Id: <20160921221856.27830-1-ian@iankelling.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com>
References: <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The highlight binary can detect language by shebang when we can't tell
the syntax type by the name of the file. In that case, pass the blob
to "highlight --force" and the resulting html will have markup for
highlighting if the language was detected.

Document the feature and improve syntax highlight documentation, add
test to ensure gitweb doesn't crash when language detection is used,
and remove an unused parameter from gitweb_check_feature().

Signed-off-by: Ian Kelling <ian@iankelling.org>
---
 Documentation/gitweb.conf.txt          | 21 ++++++++++++++-------
 gitweb/gitweb.perl                     | 14 +++++++-------
 t/t9500-gitweb-standalone-no-errors.sh |  8 ++++++++
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index a79e350..e632089 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -246,13 +246,20 @@ $highlight_bin::
 	Note that 'highlight' feature must be set for gitweb to actually
 	use syntax highlighting.
 +
-*NOTE*: if you want to add support for new file type (supported by
-"highlight" but not used by gitweb), you need to modify `%highlight_ext`
-or `%highlight_basename`, depending on whether you detect type of file
-based on extension (for example "sh") or on its basename (for example
-"Makefile").  The keys of these hashes are extension and basename,
-respectively, and value for given key is name of syntax to be passed via
-`--syntax <syntax>` to highlighter.
+*NOTE*: for a file to be highlighted, its syntax type must be detected
+and that syntax must be supported by "highlight".  The default syntax
+detection is minimal, and there are many supported syntax types with no
+detection by default.  There are three options for adding syntax
+detection.  The first and second priority are `%highlight_basename` and
+`%highlight_ext`, which detect based on basename (the full filename, for
+example "Makefile") and extension (for example "sh").  The keys of these
+hashes are the basename and extension, respectively, and the value for a
+given key is the name of the syntax to be passed via `--syntax <syntax>`
+to "highlight".  The last priority is the "highlight" configuration of
+`Shebang` regular expressions to detect the language based on the first
+line in the file, (for example, matching the line "#!/bin/bash").  See
+the highlight documentation and the default config at
+/etc/highlight/filetypes.conf for more details.
 +
 For example if repositories you are hosting use "phtml" extension for
 PHP files, and you want to have correct syntax-highlighting for those
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 33d701d..44094f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3913,7 +3913,7 @@ sub blob_contenttype {
 # guess file syntax for syntax highlighting; return undef if no highlighting
 # the name of syntax can (in the future) depend on syntax highlighter used
 sub guess_file_syntax {
-	my ($highlight, $mimetype, $file_name) = @_;
+	my ($highlight, $file_name) = @_;
 	return undef unless ($highlight && defined $file_name);
 	my $basename = basename($file_name, '.in');
 	return $highlight_basename{$basename}
@@ -3931,15 +3931,16 @@ sub guess_file_syntax {
 # or return original FD if no highlighting
 sub run_highlighter {
 	my ($fd, $highlight, $syntax) = @_;
-	return $fd unless ($highlight && defined $syntax);
+	return $fd unless ($highlight);
 
 	close $fd;
+	my $syntax_arg = (defined $syntax) ? "--syntax $syntax" : "--force";
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
 	          quote_command($^X, '-CO', '-MEncode=decode,FB_DEFAULT', '-pse',
 	            '$_ = decode($fe, $_, FB_DEFAULT) if !utf8::decode($_);',
 	            '--', "-fe=$fallback_encoding")." | ".
 	          quote_command($highlight_bin).
-	          " --replace-tabs=8 --fragment --syntax $syntax |"
+	          " --replace-tabs=8 --fragment $syntax_arg |"
 		or die_error(500, "Couldn't open file or run syntax highlighter");
 	return $fd;
 }
@@ -7062,9 +7063,8 @@ sub git_blob {
 	$have_blame &&= ($mimetype =~ m!^text/!);
 
 	my $highlight = gitweb_check_feature('highlight');
-	my $syntax = guess_file_syntax($highlight, $mimetype, $file_name);
-	$fd = run_highlighter($fd, $highlight, $syntax)
-		if $syntax;
+	my $syntax = guess_file_syntax($highlight, $file_name);
+	$fd = run_highlighter($fd, $highlight, $syntax);
 
 	git_header_html(undef, $expires);
 	my $formats_nav = '';
@@ -7117,7 +7117,7 @@ sub git_blob {
 			$line = untabify($line);
 			printf qq!<div class="pre"><a id="l%i" href="%s#l%i" class="linenr">%4i</a> %s</div>\n!,
 			       $nr, esc_attr(href(-replay => 1)), $nr, $nr,
-			       $syntax ? sanitize($line) : esc_html($line, -nbsp=>1);
+			       $highlight ? sanitize($line) : esc_html($line, -nbsp=>1);
 		}
 	}
 	close $fd
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index e94b2f1..576db6d 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -709,6 +709,14 @@ test_expect_success HIGHLIGHT \
 	 git commit -m "Add test.sh" &&
 	 gitweb_run "p=.git;a=blob;f=test.sh"'
 
+test_expect_success HIGHLIGHT \
+	'syntax highlighting (highlighter language autodetection)' \
+	'git config gitweb.highlight yes &&
+	 echo "#!/usr/bin/ruby" > test &&
+	 git add test &&
+	 git commit -m "Add test" &&
+	 gitweb_run "p=.git;a=blob;f=test"'
+
 # ----------------------------------------------------------------------
 # forks of projects
 
-- 
2.9.3

