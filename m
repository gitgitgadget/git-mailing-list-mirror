From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 6/6] gitweb: Make possible to run under mod_perl without ParseHeaders
Date: Thu, 28 Dec 2006 01:06:24 +0100
Message-ID: <200612280106.24331.jnareb@gmail.com>
References: <200612272355.31923.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 28 01:04:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzikd-0002G6-6D
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 01:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWL1ADs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 19:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWL1ADr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 19:03:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:55835 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbWL1ADl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 19:03:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4021264uga
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 16:03:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SS9UXOQEf9nY4FukNl9vpJVZ74GQXDoQfpyLAeDvCtZuLMfJgm7OWYKaeCpmheAAK113yFg6XSQI1Z5Jd3GKll24AhdsZIC+XUoVPVhWxvGx8ssqVcu+H30feiKsmOSm6DuP0fMI+5U/C+mbArGC/a84OB2K2sztjw2eY9H3M7Y=
Received: by 10.66.243.2 with SMTP id q2mr20751638ugh.1167264220533;
        Wed, 27 Dec 2006 16:03:40 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id j3sm19956330ugd.2006.12.27.16.03.39;
        Wed, 27 Dec 2006 16:03:40 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200612272355.31923.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35490>

Add mod_perl version of http_header, setting headers directly (both
for mod_perl 2.0 and 1.0); bits of code taken from CGI and CGI::Util
modules.  While at it add cache validation via $r->meets_conditions()
in mod_perl code.

Separate HTTP redirection into http_redirect subroutine and add
mod_perl version, setting headers directly.

All this is meant to allow gitweb to run under ModPerl::Registry (for
mod_perl 2.0) / Apache::Registry (for mod_perl 1.0) without need for
Apache to parse headers (without ParseHeaders), which should speed up
gitweb a bit.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch tries to add HTTP headers directly, allowing Apache to not
need to parse headers (without ParseHeaders), which should speed
up gitweb a bit. It also makes use of mod_perl meets_expectation
method to respond to If-Modified-Since: and If-None-Match: requests
for cache validation. Current state is a bit of mess as it is now.
Comments (and patches) appreciated.

It is not benchmarked because ApacheBench went crazy, showing *negative*
waiting time. Probably I did something wrong...

Not checked for warnings, only slightly tested: definitely an RFC.

 gitweb/gitweb.perl |  137 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 130 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2900ae6..12f1cb2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -35,13 +35,17 @@ BEGIN {
 		require Apache2::ServerRec;
 		require Apache2::Response;
 		require Apache2::Const;
+		require APR::Date;
 		Apache2::RequestRec->import();
 		Apache2::ServerRec->import();
 		Apache2::Const->import(-compile => qw(:common :http));
+		APR::Date->import();
 	} elsif (MP_GEN == 1) {
 		require Apache;
 		require Apache::Constants;
+		require Apache::File;
 		import Apache;
+		import Apache::File;
 		Apache::Constants->import(qw(:common :http));
 	}
 
@@ -1727,11 +1731,129 @@ sub blob_mimetype {
 sub http_header {
 	my @header = @_;
 
-	print $cgi->header(@header);
+	if (MP_GEN) {
+		my %header = @header;
+		my $cache_validator;
+
+		## special cases ##
+		# -status
+		$r->status_line($header{-status})
+			if $header{-status};
+		delete $header{-status} if exists $header{-status};
+		# -type and -charset
+		if ($header{-type} || $header{-charset}) {
+			my $type = $header{-type} || 'text/html';
+			$type .= "; charset=$header{-charset}"
+				if $type =~ m!^text/! and $type !~ /\bcharset\b/ and $header{-charset};
+
+			$r->content_type($type);
+		}
+		delete $header{-type} if exists $header{-type};
+		delete $header{-charset} if exists $header{-charset};
+		# -content_encoding
+		$r->content_encoding($header{-content_encoding})
+			if $header{-content_encoding};
+		delete $header{-content_encoding} if exists $header{-content_encoding};
+		# -expires
+		if ($header{-expires}) {
+			my $expires = CGI::Util::expires($header{-expires}, 'http');
+			if (MP_GEN == 1) {
+				$r->header_out('Expires', $expires);
+			} else {
+				$r->headers_out->add('Expires', $expires);
+			}
+		}
+		delete $header{-expires} if exists $header{-expires};
+		# -last_modified
+		if ($header{-last_modified}) {
+			$cache_validator ||= 1;
+			if (MP_GEN == 1) {
+				$r->header_out('Last-Modified', $header{-last_modified});
+			} else {
+				$r->set_last_modified(APR::Date::parse_http($header{-last_modified}));
+			}
+		}
+		delete $header{-last_modified} if exists $header{-last_modified};
+
+		## other headers ##
+		while (my ($key, $value) = each %header) {
+			$key =~ s/^-//; # -content_disposition -> content_disposition
+			$key =~ s/_/-/; #  content_disposition -> content-disposition
+			$key =~ s/(\w)(\w*)/\u$1$2/g;
+			                #  content-disposition -> Content-Disposition
+
+			if (MP_GEN == 1) {
+				$r->header_out($key, $value);
+			} else {
+				$r->headers_out->add($key, $value);
+			}
+		}
+		$cache_validator ||= (exists $header{-ETag} || exists $header{-etag});
+
+		## send headers / flush ##
+		if (MP_GEN == 1) {
+			$r->send_http_headers();
+
+			## validate cache ##
+			if ($cache_validator &&
+			    (my $rc = $r->meets_conditions()) != Apache::Constant::OK) {
+				return $rc;
+			}
+		} else {
+			$r->rflush();
+
+			## validate cache ##
+			if ($cache_validator &&
+			    (my $rc = $r->meets_conditions()) != Apache2::Const::OK) {
+				return $rc;
+			}
+		}
+	} else {
+		print $cgi->header(@header);
+	}
 
 	# Optimization: skip generating the body if client asks only
 	# for HTTP header (e.g. cache validation).
-	return if ($cgi->request_method() eq 'HEAD');
+	if (MP_GEN == 2) {
+		return Apache2::Const::OK   if $r->header_only();
+	} elsif (MP_GEN == 1) {
+		return Apache::Constant::OK if $r->header_only();
+	} else {
+		return if ($cgi->request_method() eq 'HEAD');
+	}
+}
+
+sub http_redirect {
+	my @params = @_;
+	my %params;
+	if (@params % 2 == 0) {
+		%params = @params;
+	}
+	my $uri = $params{-uri} || $params{-url} || $params{-location}
+		|| $params[0] || $cgi->self_url;
+	my $status = $params{-status};
+
+	if (MP_GEN == 1) {
+		$r->header_out('Location', $uri);
+		if (defined $status) {
+			$r->status_line($status);
+		} else {
+			$r->status(Apache::Constant::REDIRECT);
+		}
+
+		$r->send_http_headers();
+	} elsif (MP_GEN == 2) {
+		$r->headers_out->add('Location', $uri);
+		if (defined $status) {
+			$r->status_line($status);
+		} else {
+			$r->status(Apache2::Const::REDIRECT);
+		}
+
+		$r->rflush();
+	} else {
+		print $cgi->redirect(@params);
+	}
 }
 
 sub git_header_html {
@@ -1854,7 +1976,8 @@ EOF
 		      $cgi->hidden(-name => "a") . "\n" .
 		      $cgi->hidden(-name => "h") . "\n" .
 		      $cgi->popup_menu(-name => 'st', -default => 'commit',
-				       -values => ['commit', 'author', 'committer', 'pickaxe']) .
+		                       -values => ['commit', 'author', 'committer',
+		                       gitweb_check_feature('pickaxe') ? 'pickaxe' : ()]) .
 		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
 		      " search:\n",
 		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
@@ -3901,10 +4024,10 @@ sub git_object {
 		die_error('404 Not Found', "Not enough information to find object");
 	}
 
-	print $cgi->redirect(-uri => href(action=>$type, -full=>1,
-	                                  hash=>$hash, hash_base=>$hash_base,
-	                                  file_name=>$file_name),
-	                     -status => '302 Found');
+	http_redirect(-uri => href(action=>$type, -full=>1,
+	                           hash=>$hash, hash_base=>$hash_base,
+	                           file_name=>$file_name),
+	              -status => '302 Found');
 }
 
 sub git_blobdiff {
-- 
1.4.4.3
