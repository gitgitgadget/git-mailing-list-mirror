From: Jeff King <peff@peff.net>
Subject: [PATCH] gitweb: hack around CGI's list-context param() handling
Date: Tue, 18 Nov 2014 12:10:22 -0500
Message-ID: <20141118171022.GA18799@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 18:10:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqmIT-0001KK-Kx
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 18:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbaKRRK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 12:10:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:41752 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754445AbaKRRKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 12:10:25 -0500
Received: (qmail 20423 invoked by uid 102); 18 Nov 2014 17:10:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 11:10:24 -0600
Received: (qmail 17680 invoked by uid 107); 18 Nov 2014 17:10:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 12:10:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 12:10:22 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of CGI.pm's 4.08 release, the behavior to call
CGI::param() in a list context is deprecated (because it can
be potentially unsafe if called inside a hash constructor).
This cause gitweb to issue a warning for some of our code,
which in turn causes the tests to fail.

Our use is in fact _not_ one of the dangerous cases, as we
are intentionally using a list context. The recommended
route by 4.08 is to use the new CGI::multi_param() call to
make it explicit that we know what we are doing.
However, that function is only available in 4.08, which is
about a month old; we cannot rely on having it.

One option would be to set $CGI::LIST_CONTEXT_WARN globally,
which turns off the warning. However, that would eliminate
the protection these newer releases are trying to provide.
We want to annotate each site as OK using the new function.

So instead, let's check whether CGI provides the
multi_param() function, and if not, provide an
implementation that just wraps param(). That will work on
both old and new versions of CGI. Sadly, we cannot just
check defined(\&CGI::multi_param), because CGI uses the
autoload feature, which claims that all functions are
defined. Instead, we just do a version check.

Signed-off-by: Jeff King <peff@peff.net>
---
Without this patch, all of the gitweb tests consistently fail on Debian
testing/unstable when you have libcgi-pm-perl installed (it works
without that package installed, because an older version of CGI.pm is in
the perl base). I tested with both versions.

Another approach would be to live with the warning, but teach the tests
to be less meticulous. I think it probably makes sense to keep them
pedantic, though, because it can catch potential errors.

 gitweb/gitweb.perl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ccf7516..7a5b23a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -20,6 +20,10 @@ use File::Basename qw(basename);
 use Time::HiRes qw(gettimeofday tv_interval);
 binmode STDOUT, ':utf8';
 
+if (!defined($CGI::VERSION) || $CGI::VERSION < 4.08) {
+	eval 'sub CGI::multi_param { CGI::param(@_) }'
+}
+
 our $t0 = [ gettimeofday() ];
 our $number_of_git_cmds = 0;
 
@@ -871,7 +875,7 @@ sub evaluate_query_params {
 
 	while (my ($name, $symbol) = each %cgi_param_mapping) {
 		if ($symbol eq 'opt') {
-			$input_params{$name} = [ map { decode_utf8($_) } $cgi->param($symbol) ];
+			$input_params{$name} = [ map { decode_utf8($_) } $cgi->multi_param($symbol) ];
 		} else {
 			$input_params{$name} = decode_utf8($cgi->param($symbol));
 		}
-- 
2.1.2.596.g7379948
