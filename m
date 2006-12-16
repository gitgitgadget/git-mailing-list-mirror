X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH (take 3)] gitweb: Add some mod_perl specific support
Date: Sat, 16 Dec 2006 17:12:55 +0100
Message-ID: <11662855752162-git-send-email-jnareb@gmail.com>
References: <11662174851575-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sat, 16 Dec 2006 16:13:19 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JSzke7rXr7S6psBm3pWABtdKSHfcB9KAn+4uLOCzYw6jRGJ9s0O5AYqzzHA0LBEtg6Qu2H+VjUntzbcz/5u7igt80xUcginrereUBfZnTcuTbFBbk/mje7gljSHhMMlRwih8wwSAi+m1Lg4GhEpDpRIDz/KasPMANrBqO0ZoMYk=
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11662174851575-git-send-email-jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34623>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvc9y-000298-Hl for gcvg-git@gmane.org; Sat, 16 Dec
 2006 17:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161086AbWLPQNL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 11:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbWLPQNL
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 11:13:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62937 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1161086AbWLPQNK (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 11:13:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1112192uga for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 08:13:08 -0800 (PST)
Received: by 10.67.121.15 with SMTP id y15mr2066062ugm.1166285588674; Sat, 16
 Dec 2006 08:13:08 -0800 (PST)
Received: from roke.D-201 ( [81.190.25.107]) by mx.google.com with ESMTP id
 u1sm6198351uge.2006.12.16.08.13.06; Sat, 16 Dec 2006 08:13:08 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kBGGCvvU025975; Sat, 16 Dec 2006 17:12:59 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kBGGCtcq025974; Sat, 16 Dec 2006 17:12:55 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Add $r variable which holds Apache2::RequestRec if script is run under
mod_perl (if $ENV{MOD_PERL} is defined). It is used as argument to
constructor of CGI object (needs CGI module version at least 2.93).
It is needed for further mod_perl support, for example adding
headers using Apache2::RequestRec methods instead of making Apache
to have to parse headers (to add it's own HTTP headers like Server:
header).

Following advice from CGI(3pm) man page, precompile all CGI routines
for mod_perl.

All this makes gitweb slightly faster under mod_perl (436 +/-  23.9 ms
for summary of git.git before, 429 +/- 12.0 ms after, according to
'ab -n 10 -k "http://localhost/perl/gitweb/gitweb.cgi?p=git.git"').

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The idea is to have gitweb run under CGI and under mod_perl 1.0 and 2.0
without modifications, but making use of mod_perl features which make script
faster, like for example adding headers via mod_perl API and not via parsing
headers by Apache.  In the future the plan is to be able to run gitweb under
not only current ModPerl::Registry (or Apache::Registry in mod_perl 1.0) but
also as a mod_perl handler, and as a FastCGI script using CGI::Fast.

Current portion of mod_perl cpecific additions is mod_perl version agnostic,
and avoids loading any mod_perl Perl modules.

I'd like to have it (and further mod_perl patches) reviewed by someone
better versed in mod_perl.

 gitweb/gitweb.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 902c514..f834c64 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -18,11 +18,18 @@ use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
 
-our $cgi = new CGI;
+# mod_perl request
+my $r;
+$r = shift @_ if $ENV{MOD_PERL};
+
+our $cgi = new CGI($r);
 our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 
+# speeding up mod_perl and FastCGI (later)
+$cgi->compile() if $r;
+
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
 our $GIT = "++GIT_BINDIR++/git";
-- 
1.4.4.1
