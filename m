From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 2/2] gitweb: Refactor syntax highlighting support
Date: Sun, 28 Feb 2010 21:28:10 +0100
Message-ID: <1267388890-30305-2-git-send-email-jnareb@gmail.com>
References: <1267388890-30305-1-git-send-email-jnareb@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 21:28:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlpka-00008l-JI
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 21:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032024Ab0B1U2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 15:28:21 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:61659 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031985Ab0B1U2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 15:28:20 -0500
Received: by fxm19 with SMTP id 19so138669fxm.21
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 12:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QxkBO1Vpb+oiDhAnQRFZ/nkfyWTEup95g09KvZdWVIk=;
        b=Mp4xsPHeeiM4LSCKbrfobkg+lTbkakzYSqAUFrIjPFnYoIG8NpMqZ/sUC6oyhloD/c
         0D9y85pKHiwZ4/wz+83vyX2/cfUQHf4CUAEtsjyQJ5yRqhwkGIlz7iUhh842tfqGvZzr
         HXSXo4p3lgHDcR8h+cEBdZZnynbCDVgXCaKjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WvnAzvGi5kFYUcJyfDVIMdITslbv8uBHe8Ef4xRGJbSVB7R5HKnEGIM6dUhtRYcwn1
         gXiL+WCQL4CBARWrTqXpBOCDpaY+KsijFbuE74qO6oX/mJVi9AUa2xl3CPsDd/R3MXeD
         2UWK8RFQ+0L/Hw1c588SeZUs0zzGnxeudXRZE=
Received: by 10.87.36.30 with SMTP id o30mr5805707fgj.33.1267388898229;
        Sun, 28 Feb 2010 12:28:18 -0800 (PST)
Received: from localhost.localdomain (abwn28.neoplus.adsl.tpnet.pl [83.8.237.28])
        by mx.google.com with ESMTPS id l12sm2855592fgb.17.2010.02.28.12.28.16
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Feb 2010 12:28:17 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1267388890-30305-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141270>

This refactoring (adding blob_syntax_highlight and blob_highlight
subroutines) is meant to make it easier to add support for other syntax
highlighing solutions, or make it smarter by not re-running `git
cat-file` second time.

Instead of looping over list of regexps (keys of %highlight_type hash),
make use of the fact that choosing syntax is based either on full
basename, or on file extension.

Add some basic test of syntax highlighting (with 'highlight' as
prerequisite) to t/t9500-gitweb-standalone-no-errors.sh test.

While at it make git_blob Perl style prettier.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This probably could be squashed together with previous patch.

It is an RFC, because I am not sure about names blob_syntax_highlight
and blob_highlight for subroutines.

Note: if 'SConstruct', 'Program' and 'Library' must match path, and
not only basename to identify Python (py) program, then current
solution of using hash-table instead of loop over regexp to match
would be not possible.

[I probably should update comment and add some information to
gitweb/README and/or gitweb/INSTALL about syntax hightlight support.]

 gitweb/gitweb.perl                     |  106 ++++++++++++++++---------------
 t/t9500-gitweb-standalone-no-errors.sh |   29 +++++++++
 2 files changed, 84 insertions(+), 51 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5b85581..528ffe1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -227,36 +227,6 @@ our %avatar_size = (
 # Leave it undefined (or set to 'undef') to turn off load checking.
 our $maxload = 300;
 
-# syntax highlighting
-our %highlight_type = (
-	# match by basename
-	'SConstruct' => 'py',
-	'Program' => 'py',
-	'Library' => 'py',
-	'Makefile' => 'make',
-	# match by extension
-	'\.py$' => 'py', # Python
-	'\.c$' => 'c',
-	'\.h$' => 'c',
-	'\.cpp$' => 'cpp',
-	'\.cxx$' => 'cpp',
-	'\.rb$' => 'ruby',
-	'\.java$' => 'java',
-	'\.css$' => 'css',
-	'\.php3?$' => 'php',
-	'\.sh$' => 'sh', # Bash / shell script
-	'\.pl$' => 'pl', # Perl
-	'\.js$' => 'js', # JavaScript
-	'\.tex$' => 'tex', # TeX and LaTeX
-	'\.bib$' => 'bib', # BibTeX
-	'\.x?html$' => 'xml',
-	'\.xml$' => 'xml',
-	'\.awk$' => 'awk',
-	'\.bat$' => 'bat', # DOS Batch script
-	'\.ini$' => 'ini',
-	'\.spec$' => 'spec', # RPM Spec
-);
-
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -3192,6 +3162,55 @@ sub blob_contenttype {
 	return $type;
 }
 
+sub blob_syntax_highlight {
+	my ($highlight, $mimetype, $file_name) = @_;
+	return undef unless ($highlight && defined $file_name);
+
+	# match by basename
+	my %highlight_basename = (
+		#'SConstruct' => 'py',
+		#'Program' => 'py',
+		#'Library' => 'py',
+		'Makefile' => 'make',
+	);
+	# match by extension
+	my %highlight_ext = (
+		# see files in /usr/share/highlight/langDefs/ directory
+		map { $_ => $_ }
+		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl),
+		# alternate extensions, see /etc/highlight/filetypes.conf
+		'h' => 'c',
+		'cxx' => 'cpp', 'c++' => 'cpp',
+		'php3' => 'php', 'php4' => 'php',
+		'perl' => 'pl', 'pm' => 'pl',
+		'mak' => 'make',
+		'xhtml' => 'xml', 'html' => 'xml', 'htm' => 'xml',
+	);
+
+	my $basename = basename($file_name, '.in');
+	return $highlight_basename{$basename}
+		if exists $highlight_basename{$basename};
+
+	$basename =~ /\.([^.]*)$/;
+	my $ext = $1 or return undef;
+	return $highlight_ext{$ext}
+		if exists $highlight_ext{$ext};
+
+	return undef;
+}
+
+sub blob_highlight {
+	my ($fd, $highlight, $syntax) = @_;
+	return $fd unless ($highlight && defined $syntax);
+
+	close $fd
+		or die_error(404, "Reading blob failed");
+	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
+	          "highlight --xhtml --fragment --syntax $syntax |"
+		or die_error(500, "Couldn't open file or run syntax highlighter");
+	return $fd;
+}
+
 ## ======================================================================
 ## functions printing HTML: header, footer, error page
 
@@ -5391,24 +5410,10 @@ sub git_blob {
 	# we can have blame only for text/* mimetype
 	$have_blame &&= ($mimetype =~ m!^text/!);
 
-	my $have_highlight = gitweb_check_feature('highlight');
-	my $syntax;
-	if ($have_highlight && defined($file_name)) {
-		my $basename = basename($file_name, '.in');
-		foreach my $regexp (keys %highlight_type) {
-			if ($basename =~ /$regexp/) {
-				$syntax = $highlight_type{$regexp};
-				last;
-			}
-		}
-
-		if ($syntax) {
-			close $fd;
-			open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
-			          "highlight --xhtml --fragment -t 8 --syntax $syntax |"
-				or die_error(500, "Couldn't open file or run syntax highlighter");
-		}
-	}
+	my $highlight = gitweb_check_feature('highlight');
+	my $syntax = blob_syntax_highlight($highlight, $mimetype, $file_name);
+	$fd = blob_highlight($fd, $highlight, $syntax)
+		if $syntax;
 
 	git_header_html(undef, $expires);
 	my $formats_nav = '';
@@ -5459,9 +5464,8 @@ sub git_blob {
 			chomp $line;
 			$nr++;
 			$line = untabify($line);
-			printf "<div class=\"pre\"><a id=\"l%i\" href=\"" . href(-replay => 1)
-				. "#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
-			       $nr, $nr, $nr, $syntax ? $line : esc_html($line, -nbsp=>1);
+			printf qq!<div class="pre"><a id="l%i" href="%s#l%i" class="linenr">%4i</a> %s</div>\n!,
+			       $nr, href(-replay => 1), $nr, $nr, $syntax ? $line : esc_html($line, -nbsp=>1);
 		}
 	}
 	close $fd
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 2fc7fdb..0fe9beb 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -639,4 +639,33 @@ test_expect_success \
 	 gitweb_run "p=.git;a=summary"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# syntax highlighting
+
+cat >>gitweb_config.perl <<\EOF
+$feature{'highlight'}{'override'} = 1;
+EOF
+
+highlight --version >/dev/null 2>&1
+if [ $? -eq 127 ]; then
+	say "Skipping syntax highlighting test, because 'highlight' was not found"
+else
+	test_set_prereq HIGHLIGHT
+fi
+
+test_expect_success HIGHLIGHT \
+	'syntax highlighting (no highlight)' \
+	'git config gitweb.highlight yes &&
+	 gitweb_run "p=.git;a=blob;f=file"'
+test_debug 'cat gitweb.log'
+
+test_expect_success HIGHLIGHT \
+	'syntax highlighting (highlighted)' \
+	'git config gitweb.highlight yes &&
+	 echo "#!/usr/bin/sh" > test.sh &&
+	 git add test.sh &&
+	 git commit -m "Add test.sh" &&
+	 gitweb_run "p=.git;a=blob;f=test.sh"'
+test_debug 'cat gitweb.log'
+
 test_done
-- 
1.6.6.1
