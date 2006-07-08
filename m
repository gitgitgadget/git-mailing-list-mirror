From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb.cgi: Use File::MMagic; "a=blob" action knows the blob/file type
Date: Fri, 7 Jul 2006 21:10:21 -0700 (PDT)
Message-ID: <20060708041021.24704.qmail@web31804.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1086346298-1152331821=:23801"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Jul 08 06:10:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz49E-0002nb-F7
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 06:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWGHEKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 00:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWGHEKX
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 00:10:23 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:15185 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932508AbWGHEKW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 00:10:22 -0400
Received: (qmail 24706 invoked by uid 60001); 8 Jul 2006 04:10:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QsMDASXh6EvIQAyJsfjMqlBRvB6vFczYlr9lw3zu7JuOhPA/VBJVE25H0wLXyU+F9SYoLagq5mpIzznz+UNJIh7hseyES/mCEozpDbVvTTsmJgYYKS0WRZcyjM1/8b8OPdGmMe0XwsQmEZQehV8sFu1ID9dOxgNDdjnTgXLteis=  ;
Received: from [68.186.48.129] by web31804.mail.mud.yahoo.com via HTTP; Fri, 07 Jul 2006 21:10:21 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23477>

--0-1086346298-1152331821=:23801
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Use File::MMagic to determine the MIME type of a blob/file.
The variable magic_mime_file holds the location of the
"magic.mime" file, usually "/usr/share/file/magic.mime".
If not defined, the magic numbers internally stored in the
File::MMagic module are used.

Action "blob" knows the file type: if the file type is
not "text/*" then action "blob" defaults to "blob_plain",
i.e. the file is downloaded raw for the browser to interpret.
If the file type is "text/*", then "blob" defaults to the
current "cat -n"-like output, from which you can click
"plain", to get the "blob_plain" output.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |  140 +++++++++++++++++++++--------------------------------
 1 files changed, 56 insertions(+), 84 deletions(-)
--0-1086346298-1152331821=:23801
Content-Type: text/plain; name="patch.txt"
Content-Description: pat785262450
Content-Disposition: inline; filename="patch.txt"

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index cce0753..6798990 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -14,6 +14,8 @@ use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser);
 use Encode;
 use Fcntl ':mode';
+use File::MMagic;
+use FileHandle;
 binmode STDOUT, ':utf8';
 
 our $cgi = new CGI;
@@ -54,9 +56,15 @@ #our $projects_list = $projectroot;
 our $projects_list = "index/index.aux";
 
 # default blob_plain mimetype and default charset for text/plain blob
-our $default_blob_plain_mimetype = 'text/plain';
+our $default_blob_mimetype = 'text/plain';
 our $default_text_plain_charset  = undef;
 
+# magic_mime_file: if defined this file will be used by File::MMagic
+# to guess the file type, else the magic numbers stored internally
+# in File::MMagic will be used.  Either relative or absolute name
+# can be given.  E.g. "/usr/share/file/magic.mime".
+our $magic_mime_file = undef;
+
 # file to use for guessing MIME types before trying /etc/mime.types
 # (relative to the current git repository)
 our $mimetypes_file = undef;
@@ -1455,11 +1463,58 @@ sub git_get_hash_by_path {
 	}
 }
 
+#
+# Strangely enough the File::MMagic package, version 1.27, has a bug
+# whereby reading from a piped filehandle (e.g. STDIN, or "-|") always
+# returns 'text/plain', but reading from a file on a file system (as it
+# would be the case for the checktype_filename() method) properly
+# determines the file type.
+#
+sub get_blob_mimetype {
+	my $blob_file = "$git_temp/blob-$hash";
+	if (! -r $blob_file) {
+	    open my $fd_in, "-|", "$gitbin/git-cat-file blob $hash" or return $default_blob_mimetype;
+	    open my $fd_out, "> $blob_file";
+	    my @file = <$fd_in>;
+	    print $fd_out @file;
+	    close $fd_out;
+	    close $fd_in;
+	}
+	my $mm = $magic_mime_file ? File::MMagic->new($magic_mime_file) : new File::MMagic;
+	my $mime = $mm->checktype_filename($blob_file);
+	return $mime;
+}
+
+sub git_blob_plain {
+	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or return;
+	my $mimetype = get_blob_mimetype();
+
+	# save as filename, even when no $file_name is given
+	my $save_as = "$hash";
+	if (defined $file_name) {
+		$save_as = $file_name;
+	} elsif ($mimetype =~ m/^text\//) {
+		$save_as .= '.txt';
+	}
+
+	print $cgi->header(-type => "$mimetype", '-content-disposition' => "inline; filename=\"$save_as\"");
+	undef $/;
+	binmode STDOUT, ':raw';
+	print <$fd>;
+	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	$/ = "\n";
+	close $fd;
+}
+
 sub git_blob {
 	if (!defined $hash && defined $file_name) {
 		my $base = $hash_base || git_read_head($project);
 		$hash = git_get_hash_by_path($base, $file_name, "blob") || die_error(undef, "Error lookup file.");
 	}
+	my $mimetype = get_blob_mimetype();
+	if ($mimetype !~ m/^text\//) {
+		return git_blob_plain();
+	}
 	my $have_blame = git_get_project_config_bool ('blame');
 	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or die_error(undef, "Open failed.");
 	git_header_html();
@@ -1510,89 +1565,6 @@ sub git_blob {
 	git_footer_html();
 }
 
-sub mimetype_guess_file {
-	my $filename = shift;
-	my $mimemap = shift;
-	-r $mimemap or return undef;
-
-	my %mimemap;
-	open(MIME, $mimemap) or return undef;
-	while (<MIME>) {
-		my ($mime, $exts) = split(/\t+/);
-		my @exts = split(/\s+/, $exts);
-		foreach my $ext (@exts) {
-			$mimemap{$ext} = $mime;
-		}
-	}
-	close(MIME);
-
-	$filename =~ /\.(.*?)$/;
-	return $mimemap{$1};
-}
-
-sub mimetype_guess {
-	my $filename = shift;
-	my $mime;
-	$filename =~ /\./ or return undef;
-
-	if ($mimetypes_file) {
-		my $file = $mimetypes_file;
-		#$file =~ m#^/# or $file = "$projectroot/$path/$file";
-		$mime = mimetype_guess_file($filename, $file);
-	}
-	$mime ||= mimetype_guess_file($filename, '/etc/mime.types');
-	return $mime;
-}
-
-sub git_blob_plain_mimetype {
-	my $fd = shift;
-	my $filename = shift;
-
-	# just in case
-	return $default_blob_plain_mimetype unless $fd;
-
-	if ($filename) {
-		my $mime = mimetype_guess($filename);
-		$mime and return $mime;
-	}
-
-	if (-T $fd) {
-		return 'text/plain' .
-		       ($default_text_plain_charset ? '; charset='.$default_text_plain_charset : '');
-	} elsif (! $filename) {
-		return 'application/octet-stream';
-	} elsif ($filename =~ m/\.png$/i) {
-		return 'image/png';
-	} elsif ($filename =~ m/\.gif$/i) {
-		return 'image/gif';
-	} elsif ($filename =~ m/\.jpe?g$/i) {
-		return 'image/jpeg';
-	} else {
-		return 'application/octet-stream';
-	}
-}
-
-sub git_blob_plain {
-	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or return;
-	my $type = git_blob_plain_mimetype($fd, $file_name);
-
-	# save as filename, even when no $file_name is given
-	my $save_as = "$hash";
-	if (defined $file_name) {
-		$save_as = $file_name;
-	} elsif ($type =~ m/^text\//) {
-		$save_as .= '.txt';
-	}
-
-	print $cgi->header(-type => "$type", '-content-disposition' => "inline; filename=\"$save_as\"");
-	undef $/;
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-	$/ = "\n";
-	close $fd;
-}
-
 sub git_tree {
 	if (!defined $hash) {
 		$hash = git_read_head($project);
-- 
1.4.1.g2f3c


--0-1086346298-1152331821=:23801--
