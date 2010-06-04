From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [RFC/PATCH] gitweb: Create Gitweb::Escape module
Date: Fri,  4 Jun 2010 14:37:17 +0530
Message-ID: <1275642437-4846-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Fri Jun 04 11:07:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKSsI-0003uU-2X
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 11:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab0FDJH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 05:07:28 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50480 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab0FDJH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 05:07:27 -0400
Received: by pxi8 with SMTP id 8so183678pxi.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=EJu+UpxbAWhFZUzBi9/CHkjat2esD7Dm8hWzhM6l1Hc=;
        b=aOPAP6gDZNx7FG3unWx/EJz4BmVUNFbIn8Ez4jMmhGIWQ6bz0tHlPq8ruUQPLVvXGV
         KVM5nVlgKByCXg177JJglMxLRFVVlRawwsBFarvLV2X6ANPiNYoU/YwX4i7nNQ8YHfPK
         +XIDgYkws2/GBDUqOlvzm2huVn1lEqvwVUEuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=k4dVJjViKMAId6hyqc2YBtCxYjiRnCPVa/glM0w4o6I4LUg8WpEZLUY7jezzCkf3gu
         NvAquZfBdJA87WTPwXoBhOthbQ8QpbsA1xJvML0yAQGmrF3MAR18BC9/a49AHNvOufGK
         Uyp7iEwi0XpZKN7OWwhVvd8sYEiXLdoHRFuFI=
Received: by 10.114.32.31 with SMTP id f31mr8327681waf.195.1275642446539;
        Fri, 04 Jun 2010 02:07:26 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id d16sm6999247wam.12.2010.06.04.02.07.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 02:07:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.447.g2b98e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148389>

Create a Gitweb::Escape module in 'gitweb/lib/Gitweb/Escape.pm'
to store all the quoting/unquoting and escaping subroutines
regarding the gitweb.perl script.

Subroutines moved:
	to_utf8
	esc_param
	esc_url
	esc_html
	esc_path
	quot_cec
	quot_upr
	unquote
	untabify

Subroutines yet to move: (Contains not yet packaged subs & vars)
	None

Update gitweb/Makefile to install gitweb modules alongside gitwe

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile             |    1 +
 gitweb/gitweb.perl          |  157 +--------------------------------------
 gitweb/lib/Gitweb/Escape.pm |  175 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 156 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Escape.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 15646b2..4343396 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -114,6 +114,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 # Files: gitweb/lib/Gitweb
 GITWEB_LIB_GITWEB += lib/Gitweb/Config.pm
 GITWEB_LIB_GITWEB += lib/Gitweb/Request.pm
+GITWEB_LIB_GITWEB += lib/Gitweb/Escape.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b30ac48..9e54983 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -12,7 +12,6 @@ use warnings;
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
-use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
@@ -27,6 +26,7 @@ use lib __DIR__ . "/lib";
 
 use Gitweb::Config;
 use Gitweb::Request;
+use Gitweb::Escape;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -762,161 +762,6 @@ sub validate_project {
 	}
 }
 
-# decode sequences of octets in utf8 into Perl's internal form,
-# which is utf-8 with utf8 flag set if needed.  gitweb writes out
-# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
-sub to_utf8 {
-	my $str = shift;
-	return undef unless defined $str;
-	if (utf8::valid($str)) {
-		utf8::decode($str);
-		return $str;
-	} else {
-		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
-	}
-}
-
-# quote unsafe chars, but keep the slash, even when it's not
-# correct, but quoted slashes look too horrible in bookmarks
-sub esc_param {
-	my $str = shift;
-	return undef unless defined $str;
-	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
-	$str =~ s/ /\+/g;
-	return $str;
-}
-
-# quote unsafe chars in whole URL, so some charactrs cannot be quoted
-sub esc_url {
-	my $str = shift;
-	return undef unless defined $str;
-	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&=])/sprintf("%%%02X", ord($1))/eg;
-	$str =~ s/\+/%2B/g;
-	$str =~ s/ /\+/g;
-	return $str;
-}
-
-# replace invalid utf8 character with SUBSTITUTION sequence
-sub esc_html {
-	my $str = shift;
-	my %opts = @_;
-
-	return undef unless defined $str;
-
-	$str = to_utf8($str);
-	$str = $cgi->escapeHTML($str);
-	if ($opts{'-nbsp'}) {
-		$str =~ s/ /&nbsp;/g;
-	}
-	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
-	return $str;
-}
-
-# quote control characters and escape filename to HTML
-sub esc_path {
-	my $str = shift;
-	my %opts = @_;
-
-	return undef unless defined $str;
-
-	$str = to_utf8($str);
-	$str = $cgi->escapeHTML($str);
-	if ($opts{'-nbsp'}) {
-		$str =~ s/ /&nbsp;/g;
-	}
-	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
-	return $str;
-}
-
-# Make control characters "printable", using character escape codes (CEC)
-sub quot_cec {
-	my $cntrl = shift;
-	my %opts = @_;
-	my %es = ( # character escape codes, aka escape sequences
-		"\t" => '\t',   # tab            (HT)
-		"\n" => '\n',   # line feed      (LF)
-		"\r" => '\r',   # carrige return (CR)
-		"\f" => '\f',   # form feed      (FF)
-		"\b" => '\b',   # backspace      (BS)
-		"\a" => '\a',   # alarm (bell)   (BEL)
-		"\e" => '\e',   # escape         (ESC)
-		"\013" => '\v', # vertical tab   (VT)
-		"\000" => '\0', # nul character  (NUL)
-	);
-	my $chr = ( (exists $es{$cntrl})
-		    ? $es{$cntrl}
-		    : sprintf('\%2x', ord($cntrl)) );
-	if ($opts{-nohtml}) {
-		return $chr;
-	} else {
-		return "<span class=\"cntrl\">$chr</span>";
-	}
-}
-
-# Alternatively use unicode control pictures codepoints,
-# Unicode "printable representation" (PR)
-sub quot_upr {
-	my $cntrl = shift;
-	my %opts = @_;
-
-	my $chr = sprintf('&#%04d;', 0x2400+ord($cntrl));
-	if ($opts{-nohtml}) {
-		return $chr;
-	} else {
-		return "<span class=\"cntrl\">$chr</span>";
-	}
-}
-
-# git may return quoted and escaped filenames
-sub unquote {
-	my $str = shift;
-
-	sub unq {
-		my $seq = shift;
-		my %es = ( # character escape codes, aka escape sequences
-			't' => "\t",   # tab            (HT, TAB)
-			'n' => "\n",   # newline        (NL)
-			'r' => "\r",   # return         (CR)
-			'f' => "\f",   # form feed      (FF)
-			'b' => "\b",   # backspace      (BS)
-			'a' => "\a",   # alarm (bell)   (BEL)
-			'e' => "\e",   # escape         (ESC)
-			'v' => "\013", # vertical tab   (VT)
-		);
-
-		if ($seq =~ m/^[0-7]{1,3}$/) {
-			# octal char sequence
-			return chr(oct($seq));
-		} elsif (exists $es{$seq}) {
-			# C escape sequence, aka character escape code
-			return $es{$seq};
-		}
-		# quoted ordinary character
-		return $seq;
-	}
-
-	if ($str =~ m/^"(.*)"$/) {
-		# needs unquoting
-		$str = $1;
-		$str =~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;
-	}
-	return $str;
-}
-
-# escape tabs (convert tabs to spaces)
-sub untabify {
-	my $line = shift;
-
-	while ((my $pos = index($line, "\t")) != -1) {
-		if (my $count = (8 - ($pos % 8))) {
-			my $spaces = ' ' x $count;
-			$line =~ s/\t/$spaces/;
-		}
-	}
-
-	return $line;
-}
-
 sub project_in_list {
 	my $project = shift;
 	my @list = git_get_projects_list();
diff --git a/gitweb/lib/Gitweb/Escape.pm b/gitweb/lib/Gitweb/Escape.pm
new file mode 100644
index 0000000..f6ea209
--- /dev/null
+++ b/gitweb/lib/Gitweb/Escape.pm
@@ -0,0 +1,175 @@
+#!/usr/bin/perl
+#
+# Gitweb::Escape -- gitweb's quoting/unquoting, escaping package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::Escape;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @ISA = qw(Exporter);
+our @EXPORT = qw(&to_utf8 &esc_param &esc_url &esc_html &esc_path &quot_cec &quot_upr &unquote &untabify);
+
+use Encode;
+use Gitweb::Config;
+use Gitweb::Request;
+
+# decode sequences of octets in utf8 into Perl's internal form,
+# which is utf-8 with utf8 flag set if needed.  gitweb writes out
+# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
+sub to_utf8 {
+	my $str = shift;
+	return undef unless defined $str;
+	if (utf8::valid($str)) {
+		utf8::decode($str);
+		return $str;
+	} else {
+		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
+	}
+}
+
+# quote unsafe chars, but keep the slash, even when it's not
+# correct, but quoted slashes look too horrible in bookmarks
+sub esc_param {
+	my $str = shift;
+	return undef unless defined $str;
+	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
+	$str =~ s/ /\+/g;
+	return $str;
+}
+
+# quote unsafe chars in whole URL, so some charactrs cannot be quoted
+sub esc_url {
+	my $str = shift;
+	return undef unless defined $str;
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&=])/sprintf("%%%02X", ord($1))/eg;
+	$str =~ s/\+/%2B/g;
+	$str =~ s/ /\+/g;
+	return $str;
+}
+
+# replace invalid utf8 character with SUBSTITUTION sequence
+sub esc_html {
+	my $str = shift;
+	my %opts = @_;
+
+	return undef unless defined $str;
+
+	$str = to_utf8($str);
+	$str = $cgi->escapeHTML($str);
+	if ($opts{'-nbsp'}) {
+		$str =~ s/ /&nbsp;/g;
+	}
+	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
+	return $str;
+}
+
+# quote control characters and escape filename to HTML
+sub esc_path {
+	my $str = shift;
+	my %opts = @_;
+
+	return undef unless defined $str;
+
+	$str = to_utf8($str);
+	$str = $cgi->escapeHTML($str);
+	if ($opts{'-nbsp'}) {
+		$str =~ s/ /&nbsp;/g;
+	}
+	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
+	return $str;
+}
+
+# Make control characters "printable", using character escape codes (CEC)
+sub quot_cec {
+	my $cntrl = shift;
+	my %opts = @_;
+	my %es = ( # character escape codes, aka escape sequences
+		"\t" => '\t',   # tab            (HT)
+		"\n" => '\n',   # line feed      (LF)
+		"\r" => '\r',   # carrige return (CR)
+		"\f" => '\f',   # form feed      (FF)
+		"\b" => '\b',   # backspace      (BS)
+		"\a" => '\a',   # alarm (bell)   (BEL)
+		"\e" => '\e',   # escape         (ESC)
+		"\013" => '\v', # vertical tab   (VT)
+		"\000" => '\0', # nul character  (NUL)
+	);
+	my $chr = ( (exists $es{$cntrl})
+		    ? $es{$cntrl}
+		    : sprintf('\%2x', ord($cntrl)) );
+	if ($opts{-nohtml}) {
+		return $chr;
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
+}
+
+# Alternatively use unicode control pictures codepoints,
+# Unicode "printable representation" (PR)
+sub quot_upr {
+	my $cntrl = shift;
+	my %opts = @_;
+
+	my $chr = sprintf('&#%04d;', 0x2400+ord($cntrl));
+	if ($opts{-nohtml}) {
+		return $chr;
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
+}
+
+# git may return quoted and escaped filenames
+sub unquote {
+	my $str = shift;
+
+	sub unq {
+		my $seq = shift;
+		my %es = ( # character escape codes, aka escape sequences
+			't' => "\t",   # tab            (HT, TAB)
+			'n' => "\n",   # newline        (NL)
+			'r' => "\r",   # return         (CR)
+			'f' => "\f",   # form feed      (FF)
+			'b' => "\b",   # backspace      (BS)
+			'a' => "\a",   # alarm (bell)   (BEL)
+			'e' => "\e",   # escape         (ESC)
+			'v' => "\013", # vertical tab   (VT)
+		);
+
+		if ($seq =~ m/^[0-7]{1,3}$/) {
+			# octal char sequence
+			return chr(oct($seq));
+		} elsif (exists $es{$seq}) {
+			# C escape sequence, aka character escape code
+			return $es{$seq};
+		}
+		# quoted ordinary character
+		return $seq;
+	}
+
+	if ($str =~ m/^"(.*)"$/) {
+		# needs unquoting
+		$str = $1;
+		$str =~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;
+	}
+	return $str;
+}
+
+# escape tabs (convert tabs to spaces)
+sub untabify {
+	my $line = shift;
+
+	while ((my $pos = index($line, "\t")) != -1) {
+		if (my $count = (8 - ($pos % 8))) {
+			my $spaces = ' ' x $count;
+			$line =~ s/\t/$spaces/;
+		}
+	}
+
+	return $line;
+}
+
+1;
-- 
1.7.1.447.g2b98e.dirty
