From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 11/9] [PoC] gitweb/lib - HTTP-aware output caching
Date: Wed, 5 Jan 2011 03:26:59 +0100
Message-ID: <201101050327.00450.jnareb@gmail.com>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 03:27:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaJ5y-0006xy-JF
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 03:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283Ab1AEC1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 21:27:07 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61851 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab1AEC1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 21:27:06 -0500
Received: by wwa36 with SMTP id 36so15833512wwa.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 18:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kaQ5WX386mw3jVIcteIvKrcLkWTrpdIMQ/g5XEpFC/E=;
        b=TiqMOqJ9JpsM1FoQ25IoxdTwNyl0U9UzXU80OX5CDC/flnsBAXWLDXpP6cAfu24cN1
         D9tw9mYsPO5A6/0SkV9SrCbGmPt5D7ixoOp4D2WMnChgGUcUa14eNQG4ipn8sU8Klycl
         hB3Rlgc2LWp5wGDV9yUOXTrQWDI3Vw/QQoLRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=f6XtzVWoqM6LVPfn/mO/vGE42kQuOQjtWnYb9PXu8Zso0YO/Iaew6f6J3WaatWn6CI
         GJjqnOdeAMlglJU0AR7p1buMyEUMUvfEFr4pozNfikoFsTZrKR/DhNZyxpyJgTN+uwx1
         qACzC9FD37KtbAVkUOzBhIG2A2hGRZaQ/gcBI=
Received: by 10.216.168.67 with SMTP id j45mr25011597wel.101.1294194424928;
        Tue, 04 Jan 2011 18:27:04 -0800 (PST)
Received: from [192.168.1.13] (abwq27.neoplus.adsl.tpnet.pl [83.8.240.27])
        by mx.google.com with ESMTPS id m6sm10902425wej.34.2011.01.04.18.27.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 18:27:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164540>

This commit adds new option, -http_output, to cache_output()
subroutine from GitwebCache::CacheOutput module.  When this subroutine
is called as cache_output(..., -http_output => 1), it assumes that
cached output is HTTP response, consisting of HTTP headers separated
by CR LF pair from the HTTP body (contents of the page).  It adds then
Expires and Cache-Control: max-age headers if they do not exist based
on current cache entry expiration time, and Content-Length header
based on the size of cache entry file.

New subtest in t9512 includes basic tests for this feature.

Enable it in gitweb, via $cache_options{'cache_output'} hashref.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is intended as proof of concept about making output caching
in gitweb make use of the fact that we cache HTTP response.  In this
patch the "smarts" (the "HTTP awareness") was added to the part of code
responsible by sending response to client.  Alternate solution would
be to add such "smarts" to saving captured output to cache file, or even
to caching engine itself.  Each of those solutions has its advantages
and disadvantages.

J.H., among others this patch is meant to illustrate that you don't need
treat output of 'snapshot' and 'blob_plain' views in a special way; you
can add Content-Length header in a action-agnostic way.

This patch replaces controversial "[RFC PATCH v7 11/9] [PoC] gitweb/lib
- tee, i.e. print and capture during cache entry generation" for
simplicity, though it is fairly independent, and probably would apply
without problems after it.


NOTE: This is only RFC, and while it passes t9512, I haven't done extensive
testing with it.

 gitweb/gitweb.perl                             |    3 ++
 gitweb/lib/GitwebCache/CacheOutput.pm          |   32 ++++++++++++++++++++++++
 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   24 ++++++++++++++++++
 t/t9512/test_cache_output.pl                   |   25 ++++++++++++++++++
 4 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e3f02b0..f3c14a9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -360,6 +360,9 @@ our %cache_options = (
 		# pages will be cached if were generated in detached process).
 		# Default is undef.
 		'-cache_errors' => undef,
+		# Mark that we are caching HTTP response, and that we want extra treatment,
+		# i.e. automatic adding of Expires/Cache-Control and Content-Length headers
+		'-http_output' => 1,
 	},
 );
 # You define site-wide options for "Generating..." page (if enabled) here
diff --git a/gitweb/lib/GitwebCache/CacheOutput.pm b/gitweb/lib/GitwebCache/CacheOutput.pm
index 188d4ab..e9884ca 100644
--- a/gitweb/lib/GitwebCache/CacheOutput.pm
+++ b/gitweb/lib/GitwebCache/CacheOutput.pm
@@ -19,6 +19,7 @@ use warnings;
 
 use File::Copy qw();
 use Symbol qw(qualify_to_ref);
+use CGI::Util qw(expires);
 
 use Exporter qw(import);
 our @EXPORT      = qw(cache_output);
@@ -69,6 +70,37 @@ sub cache_output {
 		$filename ||= $capture_filename;
 	}
 
+	if ($opts{'-http_output'}) {
+		# we need filehandle; filename is not enough
+		open $fh, '<', $filename unless defined $fh;
+
+		# get HTTP headers first
+		my (@headers, %norm_headers);
+		while (my $line = <$fh>) {
+			last if $line eq "\r\n";
+			push @headers, $line;
+			if ($line =~ /^([^:]+:)\s+(.*)$/) {
+				(my $header = lc($1)) =~ s/_/-/;
+				$norm_headers{$header} = $2;
+			}
+		}
+		print join('', @headers);
+
+		# extra headers
+		if (!exists $norm_headers{lc('Expires')} &&
+		    !exists $norm_headers{lc('Cache-Control')}) {
+			my $expires_in = $cache->expires_in($key);
+			print "Expires: " . expires($expires_in, 'http')."\r\n".
+			      "Cache-Control: max-age=$expires_in\r\n";
+		}
+		if (!exists $norm_headers{lc('Content-Length')}) {
+			my $length = (-s $fh) - (tell $fh);
+			print "Content-Length: $length\r\n" if $length;
+		}
+
+		print "\r\n"; # separates headers from body
+	}
+
 	if (defined $fh || defined $filename) {
 		# set binmode only if $fh is defined (is a filehandle)
 		# File::Copy::copy opens files given by filename in binary mode
diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index 291526e..813331a 100644
--- a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -457,6 +457,30 @@ sub is_valid {
 	return (($now - $mtime) < $expires_in);
 }
 
+# $cache->expires_in($key)
+#
+# Returns number of seconds an entry would be valid, or undef
+# if cache entry for given $key does not exists.
+sub expires_in {
+	my ($self, $key) = @_;
+
+	my $path = $self->path_to_key($key);
+
+	# does file exists in cache?
+	return undef unless -f $path;
+	# get its modification time
+	my $mtime = (stat(_))[9] # _ to reuse stat structure used in -f test
+		or $self->_handle_error("Couldn't stat file '$path' for key '$key': $!");
+
+	my $expires_in = $self->get_expires_in();
+
+	my $now = time();
+	print STDERR __PACKAGE__."now=$now; mtime=$mtime; ".
+		"expires_in=$expires_in; diff=".($now - $mtime)."\n";
+
+	return $expires_in == 0 ? 0 : ($self->get_expires_in() - ($now - $mtime));
+}
+
 # Getting and setting
 
 # ($fh, $filename) = $cache->compute_fh($key, $code);
diff --git a/t/t9512/test_cache_output.pl b/t/t9512/test_cache_output.pl
index 758848c..3492dcf 100755
--- a/t/t9512/test_cache_output.pl
+++ b/t/t9512/test_cache_output.pl
@@ -6,6 +6,8 @@ use strict;
 
 use Test::More;
 
+use CGI qw(:standard);
+
 # test source version
 use lib $ENV{GITWEBLIBDIR} || "$ENV{GIT_BUILD_DIR}/gitweb/lib";
 
@@ -158,5 +160,28 @@ subtest 'errors are cached with -cache_errors => 1' => sub {
 };
 
 
+# caching HTTP output
+subtest 'HTTP output' => sub {
+	$cache->remove($key);
+	$cache->set_expires_in(60);
+
+	my $header =
+		header(-status=>'200 OK', -type=>'text/plain', -charset => 'utf-8');
+	my $data = "1234567890";
+	$action_output = $header.$data;
+	$test_data = capture_output_of_cache_output(\&action, '-http_output' => 1);
+
+	$header =~ s/\r\n$//;
+	my $length = do { use bytes; length($data); };
+	like($test_data, qr/^\Q$header\E/, 'http: starts with provided http header');
+	like($test_data, qr/\Q$data\E$/,   'http: ends with body (payload)');
+	like($test_data, qr/^Expires: /m,  'http: some "Expires:" header added');
+	like($test_data, qr/^Cache-Control: max-age=\d+\r\n/m,
+	                                   'http: "Cache-Control:" with max-age added');
+	like($test_data, qr/^Content-Length: $length\r\n/m,
+	                                   'http: "Content-Length:" header with correct value'); 
+};
+
+
 done_testing();
 __END__
-- 
1.7.3
