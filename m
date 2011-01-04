From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 2.5/9] gitweb: Make die_error just die, and use send_error to create error pages
Date: Tue, 4 Jan 2011 01:35:07 +0100
Message-ID: <201101040135.08638.jnareb@gmail.com>
References: <20101222234843.7998.87068.stgit@localhost.localdomain> <20101222235525.7998.99816.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 01:35:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZuru-0004J0-Lm
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 01:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014Ab1ADAfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 19:35:12 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47850 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab1ADAfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 19:35:10 -0500
Received: by wyb28 with SMTP id 28so13860299wyb.19
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 16:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bPvQzFF+qBlZk/Ldb1FzSYSIny2KbqWqYj1hMZZlfuc=;
        b=L7T/IMHo4e1WAxIpQ73YMC/i+qdeMW8PiB04ReeoTLS9P8vtJSpq6eNzl+6SC1YH8v
         GamQGQMFsHD3HbJMzSEUIuBq7Gu7EDlNjIHHTcRylUhSfV6Fg0amCofTSd++/dYDuSpK
         E4GPmIgxzvYMlb+BcIRbi+EfbUs598rRHk1Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=c3HCjZAo1JTNBkxFZfzaHWXgx+7+7+uBZ/GKMAsAxoxztv34/7sql39Vdfef5WkXBn
         JuUtYpYPHx2ml1mPAdVg5dnCUipo5H3CJFKlocV8Iwe9UCAdxvcs5DQ9m0HZ2IImoXiK
         kqSWMh+BDbe0uWwIwj3OxGbtA5utJAO5WmJc8=
Received: by 10.227.162.194 with SMTP id w2mr12207961wbx.203.1294101309514;
        Mon, 03 Jan 2011 16:35:09 -0800 (PST)
Received: from [192.168.1.13] (abvw52.neoplus.adsl.tpnet.pl [83.8.220.52])
        by mx.google.com with ESMTPS id f35sm14591000wbf.14.2011.01.03.16.35.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 16:35:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101222235525.7998.99816.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164466>

Unify error handling by treating errors from Perl (and thrown early in
process using 'die STRING'), and errors from gitweb in the same way.
This means that in both cases error page is generated after an error
is caught in run() subroutine.

die_error() subroutine is now split into three: gen_error() which
massages parameters (escaping HTML, turning HTTP status number into
full HTTP status code), die_error() which uses gen_error() and just
throws an error (and does not generate an error page), and
send_error() which catually generate error page based on provided
error / exception.


Sidenote: probably in the future instead of using simple hash for
throwing gitweb exception, gitweb would use some custom error class,
e.g. derivative of Exception::Class (like SVN::Web does it).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is sent early to facilitate early comments.  It passes test suite,
but it was not extensively tested.

Now die_error() functions mode like 'die'...

 gitweb/gitweb.perl |   47 ++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c7a1892..5854f73 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1153,9 +1154,13 @@ sub run {
 			if $pre_dispatch_hook;
 
 		eval { run_request() };
-		if (defined $@ && !ref($@)) {
+		my $error = $@;
+		if ($error) {
 			# some Perl error, but not one thrown by die_error
-			die_error(undef, undef, $@, -error_handler => 1);
+			$error = gen_error(undef, undef, $error)
+				unless ref($error);
+
+			send_error($error);
 		}
 
 	DONE_REQUEST:
@@ -3730,11 +3735,14 @@ sub git_footer_html {
 #      an unknown error occurred (e.g. the git binary died unexpectedly).
 # 503: The server is currently unavailable (because it is overloaded,
 #      or down for maintenance).  Generally, this is a temporary state.
-sub die_error {
+
+# gen_error()  generates error object from parameters
+# die_error()  uses gen_error() to generate error object and dies
+# send_error() generates an error page from provided error object
+sub gen_error {
 	my $status = shift || 500;
 	my $error = esc_html(shift) || "Internal Server Error";
 	my $extra = shift;
-	my %opts = @_;
 
 	my %http_responses = (
 		400 => '400 Bad Request',
@@ -3743,23 +3751,40 @@ sub die_error {
 		500 => '500 Internal Server Error',
 		503 => '503 Service Unavailable',
 	);
-	git_header_html($http_responses{$status}, undef, %opts);
+
+	my $err = {
+		'status' => $status,
+		'http_status' => $http_responses{$status},
+		'error'  => $error,
+		'extra'  => $extra,
+	};
+	return $err;
+}
+
+sub die_error {
+	my $error = gen_error(@_);
+	print STDERR Dumper($error);
+	die $error;
+}
+
+sub send_error {
+	my $error = shift;
+
+	git_header_html($error->{'http_status'}, undef);
+
 	print <<EOF;
 <div class="page_body">
 <br /><br />
-$status - $error
+$error->{'status'} - $error->{'error'}
 <br />
 EOF
-	if (defined $extra) {
+	if (defined $error->{'extra'}) {
 		print "<hr />\n" .
-		      "$extra\n";
+		      "$error->{'extra'}\n";
 	}
 	print "</div>\n";
 
 	git_footer_html();
-
-	die {'status' => $status, 'error' => $error}
-		unless ($opts{'-error_handler'});
 }
 
 ## ----------------------------------------------------------------------
-- 
1.7.3
