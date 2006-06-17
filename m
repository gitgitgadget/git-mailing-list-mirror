From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: safely output binary files for 'blob_plain' action
Date: Sun, 18 Jun 2006 00:01:06 +0200
Message-ID: <20060617220106.GJ2609@pasky.or.cz>
References: <200606171332.15591.jnareb@gmail.com> <20060617153540.GI2609@pasky.or.cz> <7v8xnv8ozp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Kay Sievers <kay.sievers@vrfy.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 00:00:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Friq3-0005FC-8F
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 00:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWFQWAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 18:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWFQWAL
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 18:00:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63659 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750984AbWFQWAJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 18:00:09 -0400
Received: (qmail 7616 invoked by uid 2001); 18 Jun 2006 00:01:06 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xnv8ozp.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22036>

Dear diary, on Sat, Jun 17, 2006 at 11:13:30PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  - we might want to have a configuration mechanism in place
>    before enhancing gitweb.  My gut feeling is that we can use
>    [gitweb] section in project.git/config (and probably
>    duplicate first and deprecate later existing "description" as
>    well).

Agreed. (I planned to back this up with a patch, then looked at the
clock.)

Hmm, after I'm over my exam period, since there's now another .pl thing
in the git tree I might start working on some kind of universal Git.pm
interface. I'm gonna need it for Cogito in the longer term anyway. ;-)

>  - the blob charset should be per path -- otherwise the feature
>    would be not useful for projects that maintains bunch of po
>    files.
> 
> In other words, something like this:
> 
>   (in torvalds/linux-2.6.git/config)
> 
> 	[gitweb]
>         description = "Linus's kernel tree"
>         ; defaultblobcharset = "latin1"
>         blobmimemapfile = "mime-map"
> 
>   (in torvalds/linux-2.6.git/mime-map, first match decides)
> 
> 	fs/nls/nls_euc-jp.c	text/plain; charset=euc_jp
>         *.c	text/plain; charset=utf-8
>         *.h     text/plain; charset=utf-8

You could as well just support the mime.types format and load
/etc/mime.types for this kind of mapping (see below for a patch). The
advantage is that this pretty much covers all the MIME types you will
need, the disadvantage is that it's less flexible and the charset part
wouldn't probably fit in nicely.

We could obviously do both. :-)

---
[PATCH] Support for the standard mime.types map in gitweb

gitweb will try to look up the filename mimetype in /etc/mime.types
and optionally a user-configured mime.types map as well.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Depends on Jakub's mime patches.

 gitweb/gitweb.cgi |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 9250548..0116531 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -46,6 +46,11 @@ # default blob_plain mimetype and defaul
 my $default_blob_plain_mimetype = 'text/plain';
 my $default_text_plain_charset  = undef;       # was: 'utf-8'
 
+# file to use for guessing MIME types before trying /etc/mime.types
+# (relative to the current git repository)
+my $mimetypes_file              = undef;
+
+
 # input validation and dispatch
 my $action = $cgi->param('a');
 if (defined $action) {
@@ -1414,6 +1419,40 @@ sub git_blob {
 	git_footer_html();
 }
 
+sub mimetype_guess_file {
+	my $filename = shift;
+	my $mimemap = shift;
+	-r $mimemap or return undef;
+
+	my %mimemap;
+	open(MIME, $mimemap) or return undef;
+	while (<MIME>) {
+		my ($mime, $exts) = split(/\t+/);
+		my @exts = split(/\s+/, $exts);
+		foreach my $ext (@exts) {
+			$mimemap{$ext} = $mime;
+		}
+	}
+	close(MIME);
+
+	$filename =~ /\.(.*?)$/;
+	return $mimemap{$1};
+}
+
+sub mimetype_guess {
+	my $filename = shift;
+	my $mime;
+	$filename =~ /\./ or return undef;
+
+	if ($mimetypes_file) {
+		my $file = $mimetypes_file;
+		$file =~ m#^/# or $file = "$projectroot/$path/$file";
+		$mime = mimetype_guess_file($filename, $file);
+	}
+	$mime ||= mimetype_guess_file($filename, '/etc/mime.types');
+	return $mime;
+}
+
 sub git_blob_plain_mimetype {
 	my $fd = shift;
 	my $filename = shift;
@@ -1421,6 +1460,11 @@ sub git_blob_plain_mimetype {
 	# just in case
 	return $default_blob_plain_mimetype unless $fd;
 
+	if ($filename) {
+		my $mime = mimetype_guess($filename);
+		$mime and return $mime;
+	}
+
 	if (-T $fd) {
 		return 'text/plain' .
 		       ($default_text_plain_charset ? '; charset='.$default_text_plain_charset : '');

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
