Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4DD1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 19:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935357AbcIFTBb (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 15:01:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44436 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935319AbcIFTAj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2016 15:00:39 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F3FE205F5;
        Tue,  6 Sep 2016 15:00:38 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 06 Sep 2016 15:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        cc:date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=
        mesmtp; bh=fz4NGuzQYqoljlGKt7tch4elQyw=; b=R+efca9GPSSnoe8n13qTU
        dWvbOeJzgwal6D86FvqeD/f2PcVSo8p4oVXBkUDp4WRb3PFjDszCWylA4ZD4hQos
        4ndGXTMcRPYWluqoIVJuE+cpPSyAE8bUtUgYiNOl5I/YE8h7WrL8XojmaWV93zVy
        q41IBqcsx4WKkEhQMYkpxw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-sasl-enc:x-sasl-enc; s=smtpout; bh=fz4NGuzQYqoljlGKt7tch4elQy
        w=; b=cCSdYm1TIY8f+nfte064AwCxZ/4YUZwl+mppGHwHdZmAUDUYor/YcEqieT
        nBoHJ3UKF1BQH+IbsCVO3/Y4Pw17PSi2pfJCKbK4k2e8bFItDKkc9jh+cyY8ViWB
        TpiTdUQ5/8icMQNnaauiBr51M68pFG9sQDu15Fu63XG27Kbso=
X-Sasl-enc: 1cwuOqIzi4fgZy1ctid2xPUf2+zhj4bACHk1bl4HPuMh 1473188438
Received: from treetowl.lan (c-73-53-70-213.hsd1.wa.comcast.net [73.53.70.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2A34DCCE94;
        Tue,  6 Sep 2016 15:00:38 -0400 (EDT)
Received: by treetowl.lan (Postfix, from userid 1000)
        id 62D621B21D5; Tue,  6 Sep 2016 12:00:37 -0700 (PDT)
From:   Ian Kelling <ian@iankelling.org>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com
Subject: [PATCH] gitweb: use highlight's shebang detection
Date:   Tue,  6 Sep 2016 12:00:37 -0700
Message-Id: <20160906190037.12442-1-ian@iankelling.org>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The highlight binary can detect language by shebang when we can't tell
the syntax type by the name of the file. To use highlight's shebang
detection, add highlight to the pipeline whenever highlight is enabled.

Document the shebang detection and add a test which exercises it in
t/t9500-gitweb-standalone-no-errors.sh.

Signed-off-by: Ian Kelling <ian@iankelling.org>
---

Notes:
    I wondered if adding highlight to the pipeline would make viewing a blob
    with no highlighting take longer but it did not on my computer. I found
    no noticeable impact on small files and strangely, on a 159k file, it
    took 7% less time averaged over several requests.

 Documentation/gitweb.conf.txt          | 21 ++++++++++++++-------
 gitweb/gitweb.perl                     | 10 +++++-----
 t/t9500-gitweb-standalone-no-errors.sh | 18 +++++++++++++-----
 3 files changed, 32 insertions(+), 17 deletions(-)

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
index 33d701d..a672181 100755
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
 	my $syntax = guess_file_syntax($highlight, $mimetype, $file_name);
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
index e94b2f1..9e5fcfe 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -702,12 +702,20 @@ test_expect_success HIGHLIGHT \
 	 gitweb_run "p=.git;a=blob;f=file"'
 
 test_expect_success HIGHLIGHT \
-	'syntax highlighting (highlighted, shell script)' \
+	'syntax highlighting (highlighted, shell script shebang)' \
 	'git config gitweb.highlight yes &&
-	 echo "#!/usr/bin/sh" > test.sh &&
-	 git add test.sh &&
-	 git commit -m "Add test.sh" &&
-	 gitweb_run "p=.git;a=blob;f=test.sh"'
+	 echo "#!/usr/bin/sh" > test &&
+	 git add test &&
+	 git commit -m "Add test" &&
+	 gitweb_run "p=.git;a=blob;f=test"'
+
+test_expect_success HIGHLIGHT \
+	'syntax highlighting (highlighted, header file)' \
+	'git config gitweb.highlight yes &&
+	 echo "#define ANSWER 42" > test.h &&
+	 git add test.h &&
+	 git commit -m "Add test.h" &&
+	 gitweb_run "p=.git;a=blob;f=test.h"'
 
 # ----------------------------------------------------------------------
 # forks of projects
-- 
2.9.3

