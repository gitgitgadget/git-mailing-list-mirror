From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv3 01/10] gitweb: href(..., -path_info => 0|1)
Date: Tue, 16 Feb 2010 20:36:36 +0100
Message-ID: <1266349005-15393-2-git-send-email-jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:37:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTES-0002Gw-3H
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933125Ab0BPThA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:37:00 -0500
Received: from mail-bw0-f213.google.com ([209.85.218.213]:38796 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757054Ab0BPTg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:36:58 -0500
Received: by bwz5 with SMTP id 5so2281058bwz.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 11:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vV4dctcOu0gMW+ufoY793EY4KIVHbYWlD52XKmK1mzA=;
        b=F/8YlsxUjPRAGOf++U2ii6odxlOPrZg9i+o5xdmQVbaaKIY3SgWxwjRygUH1FXCKAN
         RFoR+YUHJZkHqh9o1nsL/2MzPIiAwsOE7mNBe+ZDgF745jKugl4BcOK0W56vdAuWl1O4
         RPS2h3NsIF7VBqsM2BQ1nqcLPh+O/QNR1PwN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ePvcPqe0kscQNO0+EBoYV4yAJBACIbaVkXUk2o4m7Uid3I0rGSAneZRNaUZt172t0d
         zXAB1C+p6CvB0juYNkAT1D/NrXjaRyKuXcKEfmNHpCosJOQ8Vs5njl2IJ1I8pm0L2Clh
         GPEojHRhqgF49eDTHOAJg4vtvynIjAjGBxPr4=
Received: by 10.204.5.216 with SMTP id 24mr4614910bkw.141.1266349014502;
        Tue, 16 Feb 2010 11:36:54 -0800 (PST)
Received: from localhost.localdomain (abvy197.neoplus.adsl.tpnet.pl [83.8.222.197])
        by mx.google.com with ESMTPS id 15sm3243751bwz.12.2010.02.16.11.36.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 11:36:53 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1266349005-15393-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140139>

If named boolean option -path_info is passed to href() subroutine, it
would use its value to decide whether to generate path_info URL form.
If this option is not passed, href() queries 'pathinfo' feature to
check whether to generate path_info URL (if generating path_info link
is possible at all).

href(-replay=>1, -path_info=>0) is meant to be used to generate a key
for caching gitweb output; alternate solution would be to use freeze()
from Storable (core module) on %input_params hash (or its reference),
e.g.:
  $key = freeze \%input_params;
or other serialization of %input_params.

While at it document extra options/flags to href().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
There is no change in the patch with v3, as compared to v2.


Note that in the caching patch by J.H. from "Gitweb caching v5" thread
(and top commit in git://git.kernel.org/pub/scm/git/warthog9/gitweb.git,
gitweb-ml-v5 branch) the key was generated as "$my_url?".$ENV{'QUERY_STRING'}
which wouldn't work with path_info URLs, but on the other hand gitweb
at git.kernel.org doesn't use path_info URLs (perhaps even doesn't
support them).

Using href(replay=>1,full=>1,path_info=>0) has additional advantage
over using $cgi->self_url() in that it also does not depend on
ordering of parameters in handcrafted URLs.

 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1f6978a..97ea3ec 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -970,6 +970,10 @@ exit;
 ## ======================================================================
 ## action links
 
+# possible values of extra options
+# -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
+# -replay => 1      - start from a current view (replay with modifications)
+# -path_info => 0|1 - don't use/use path_info URL (if possible)
 sub href {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
@@ -986,7 +990,8 @@ sub href {
 	}
 
 	my $use_pathinfo = gitweb_check_feature('pathinfo');
-	if ($use_pathinfo and defined $params{'project'}) {
+	if (defined $params{'project'} &&
+	    (exists $params{-path_info} ? $params{-path_info} : $use_pathinfo)) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action
-- 
1.6.6.1
