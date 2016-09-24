Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678A51F935
	for <e@80x24.org>; Sat, 24 Sep 2016 22:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965393AbcIXWdC (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 18:33:02 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37468 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754294AbcIXWdA (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Sep 2016 18:33:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 59D8F20571;
        Sat, 24 Sep 2016 18:32:59 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Sat, 24 Sep 2016 18:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        cc:content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=FlzbQLYnKh520kzaeJoLVSsf3sA=; b=S4hROz
        C9Wu1ouG2Rwl9vI6RuqFERZI4umL4yqOywYOmM+nVzPtmsUKXEwZT5/lfVQTdqxn
        L0QHXD7yb0AHORfx8U4ZKF4DGWifE2WQd4Hu0JISOhXo+T8/4FGqwpGwkMaPwgdc
        lL1UC7Xi1JMM3QUIzD8KQNQ+YznMdKZdKq/f0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=FlzbQLYnKh520kz
        aeJoLVSsf3sA=; b=rRO7NbXQt+DUnzxEEtDbzb7ssVvsH/LnjAzwUl9EbzgAjnN
        uVlGt1WhhDyT0r/KfW0njmwsbUmlynj08z6fwagUqxtLQOudHWlfr6ppmlQO1Q7q
        pIPF+ZmLVq4PfMmM2Xvrx9YHQ2VnrWdVmnGLnv8nhmtg91mpjURx+7uPnmqQ=
X-Sasl-enc: w0LusClArSlO9R5IdQ1V3DudPQN0Jr+88o46Ys95o4Dt 1474756378
Received: from treetowl.lan (c-73-53-70-213.hsd1.wa.comcast.net [73.53.70.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id CBC6BCCEAB;
        Sat, 24 Sep 2016 18:32:58 -0400 (EDT)
Received: by treetowl.lan (Postfix, from userid 1000)
        id 0EE371C4E44; Sat, 24 Sep 2016 15:32:58 -0700 (PDT)
From:   Ian Kelling <ian@iankelling.org>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com
Subject: [PATCH v4 2/2] gitweb: use highlight's shebang detection
Date:   Sat, 24 Sep 2016 15:32:58 -0700
Message-Id: <20160924223258.9449-2-ian@iankelling.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160924223258.9449-1-ian@iankelling.org>
References: <20160923090846.3086-2-ian@iankelling.org>
 <20160924223258.9449-1-ian@iankelling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "highlight" binary can, in some cases, determine the language type
by the means of file contents, for example the shebang in the first line
for some scripting languages.  Make use of this autodetection for files
which syntax is not known by gitweb.  In that case, pass the blob
contents to "highlight --force"; the parameter is needed to make it
always generate HTML output (which includes HTML-escaping).

Although we now run highlight on files which do not end up highlighted,
performance is virtually unaffected because when we call highlight, it
is used for escaping HTML.  In the case that highlight is used, gitweb
calls sanitize() instead of esc_html(), and the latter is significantly
slower (it does more, being roughly a superset of sanitize()).  Simple
benchmark comparing performance of 'blob' view of files without syntax
highlighting in gitweb before and after this change indicates ±1%
difference in request time for all file types.  Benchmark was performed
on local instance on Debian, using Apache/2.4.23 web server and CGI.

Document the feature and improve syntax highlight documentation, add
test to ensure gitweb doesn't crash when language detection is used.

Signed-off-by: Ian Kelling <ian@iankelling.org>
---

Notes:
    The only change from v3 is the commit message as suggested by Jakub
    Narębski

 Documentation/gitweb.conf.txt          | 21 ++++++++++++++-------
 gitweb/gitweb.perl                     | 10 +++++-----
 t/t9500-gitweb-standalone-no-errors.sh |  8 ++++++++
 3 files changed, 27 insertions(+), 12 deletions(-)

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
index 6cb4280..44094f4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
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
@@ -7063,8 +7064,7 @@ sub git_blob {
 
 	my $highlight = gitweb_check_feature('highlight');
 	my $syntax = guess_file_syntax($highlight, $file_name);
-	$fd = run_highlighter($fd, $highlight, $syntax)
-		if $syntax;
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
index e94b2f1..6d06ed9 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -709,6 +709,14 @@ test_expect_success HIGHLIGHT \
 	 git commit -m "Add test.sh" &&
 	 gitweb_run "p=.git;a=blob;f=test.sh"'
 
+test_expect_success HIGHLIGHT \
+	'syntax highlighting (highlighter language autodetection)' \
+	'git config gitweb.highlight yes &&
+	 echo "#!/usr/bin/perl" > test &&
+	 git add test &&
+	 git commit -m "Add test" &&
+	 gitweb_run "p=.git;a=blob;f=test"'
+
 # ----------------------------------------------------------------------
 # forks of projects
 
-- 
2.9.3

