From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 2/2] gitweb: Refactor syntax highlighting support
Date: Tue, 27 Apr 2010 21:34:45 +0200
Message-ID: <1272396885-30609-3-git-send-email-jnareb@gmail.com>
References: <1272396885-30609-1-git-send-email-jnareb@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 21:35:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6qZG-0003lB-OT
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 21:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710Ab0D0TfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 15:35:17 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:55535 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690Ab0D0TfN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 15:35:13 -0400
Received: by mail-pz0-f204.google.com with SMTP id 42so9225398pzk.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rm/oqYa9j1Z2x2AUlxQRWgLT5d9GtHCXZWHmt1HEd4Y=;
        b=Dzizhzc7so1fkIBaI8DJ8zbppQ/CYZU95oGUio4HGX+gz1aGlwtvdJ2NWus6GVGiuv
         txoV4xAmDHHvDNUkuVnvumpK/FxWDUm6bpnvofmWNcp59f9uEub0eLVKiU22MPCWL5rq
         qcGnE2alCA4EAYikUSViX2jWCQ0G8C4DGRwXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ahjMMTA1yF1OLU6d0Gu/HBo0UvrCcFmA+H1ZFRuUoDAgybMZRqonH8esAkh5HZoLjP
         5l7mUxO/vRi7usD6MK+yGTSdv8GqFkGChzjtJMtMZQIJWqI8vioMs6udu4gDyvGflDcn
         /kLtZRltxlhoYP14CJgqEzxC9UVm5dIrjVjR4=
Received: by 10.142.209.5 with SMTP id h5mr3557272wfg.85.1272396913317;
        Tue, 27 Apr 2010 12:35:13 -0700 (PDT)
Received: from localhost.localdomain ([72.14.241.6])
        by mx.google.com with ESMTPS id s21sm832756wff.0.2010.04.27.12.35.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 12:35:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1272396885-30609-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145936>

This refactoring (adding guess_file_syntax and run_highlighter
subroutines) is meant to make it easier in the future to add support
for other syntax highlighing solutions, or make it smarter by not
re-running `git cat-file` second time.

Instead of looping over list of regexps (keys of %highlight_type hash),
make use of the fact that choosing syntax is based either on full
basename (%highlight_basename), or on file extension (%highlight_ext).

Add some basic test of syntax highlighting (with 'highlight' as
prerequisite) to t/t9500-gitweb-standalone-no-errors.sh test.

While at it make git_blob Perl style prettier.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Compared to previous version, blob_syntax_highlight is now named
guess_file_syntax, and blob_highlight is now named run_highlighter.

Some comments were added, and some improved. %highlight_ext is now
in larger part generated.

 gitweb/gitweb.perl                     |  116 +++++++++++++++++---------------
 t/t9500-gitweb-standalone-no-errors.sh |   29 ++++++++
 2 files changed, 92 insertions(+), 53 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index de18ebf..7d9b660 100755
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
@@ -478,8 +448,8 @@ our %feature = (
 
 	# Syntax highlighting support. This is based on Daniel Svensson's
 	# and Sham Chukoury's work in gitweb-xmms2.git.
-	# It requires the 'highlight' program, and therefore is disabled
-	# by default.
+	# It requires the 'highlight' program present in $PATH,
+	# and therefore is disabled by default.
 
 	# To enable system wide have in $GITWEB_CONFIG
 	# $feature{'highlight'}{'default'} = [1];
@@ -3198,6 +3168,61 @@ sub blob_contenttype {
 	return $type;
 }
 
+# guess file syntax for syntax highlighting; return undef if no highlighting
+# the name of syntax can (in the future) depend on syntax highlighter used
+sub guess_file_syntax {
+	my ($highlight, $mimetype, $file_name) = @_;
+	return undef unless ($highlight && defined $file_name);
+
+	# configuration for 'highlight' (http://www.andre-simon.de/)
+	# match by basename
+	my %highlight_basename = (
+		#'Program' => 'py',
+		#'Library' => 'py',
+		'SConstruct' => 'py', # SCons equivalent of Makefile
+		'Makefile' => 'make',
+	);
+	# match by extension
+	my %highlight_ext = (
+		# main extensions, defining name of syntax;
+		# see files in /usr/share/highlight/langDefs/ directory
+		map { $_ => $_ }
+			qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl),
+		# alternate extensions, see /etc/highlight/filetypes.conf
+		'h' => 'c',
+		map { $_ => 'cpp' } qw(cxx c++ cc),
+		map { $_ => 'php' } qw(php3 php4),
+		map { $_ => 'pl'  } qw(perl pm), # perhaps also 'cgi'
+		'mak' => 'make',
+		map { $_ => 'xml' } qw(xhtml html htm),
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
+# run highlighter and return FD of its output,
+# or return original FD if no highlighting
+sub run_highlighter {
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
 
@@ -5397,24 +5422,10 @@ sub git_blob {
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
+	my $syntax = guess_file_syntax($highlight, $mimetype, $file_name);
+	$fd = run_highlighter($fd, $highlight, $syntax)
+		if $syntax;
 
 	git_header_html(undef, $expires);
 	my $formats_nav = '';
@@ -5465,9 +5476,8 @@ sub git_blob {
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
index 63b6b06..4f2b9b0 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -647,4 +647,33 @@ test_expect_success \
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
1.7.0.1
