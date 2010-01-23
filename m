From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 02/10] gitweb: href(..., -path_info => 0|1)
Date: Sat, 23 Jan 2010 01:27:25 +0100
Message-ID: <f71ad6f178dc424571fc3c6c77d18557752bfeeb.1264198194.git.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:28:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTrn-0002dP-1U
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415Ab0AWA2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756455Ab0AWA1t
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:27:49 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:64315 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425Ab0AWA1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:27:44 -0500
Received: by fxm20 with SMTP id 20so1932491fxm.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=hl443CUJbep2v9w/TI39/y+5c02He7l1rQr6H9w/Itc=;
        b=R4BHZO32knw7q7HqsrPObwFFfVH+2f3fXSNkdW4vjkQkaKhyDA0alJhj2BolEqzHPH
         37c/v+D165EHAZ+bdLNQu6OntC+DMpLYcI5QaE1WhUbbQYrREfPVuFLd0ZIX33wmtIhM
         jAWyBH9ydFpfNdfrsZp5AZVOQfypTUENBRJcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ho0aYo+vxKkwOEtBB3r10CtGzMJixkGIbLYm/Uvuyk4jaN+3+RFxgPmoWiyMI6X8bk
         8NJnUE7fgNbD7ZXMwPRRmtAdzNrRAVMYtf0D03V60Kb50yfLYVOwEoApE4Utl1NriNqq
         brUoo/VU8xMj1on/h/JYo7/3fPQVI7Oc0I3/0=
Received: by 10.103.80.34 with SMTP id h34mr194656mul.20.1264206461859;
        Fri, 22 Jan 2010 16:27:41 -0800 (PST)
Received: from localhost.localdomain (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id s11sm11094697mue.19.2010.01.22.16.27.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:27:41 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137803>

If named boolean option -path_info is passed to href() subroutine, use
its value, instead of querying 'pathinfo' feature to check whether to
generate path_info URL (if generating path_info link is possible at all).

href(-replay=>1, -path_info=>0) is meant to be used to generate a key
for caching gitweb output; alternate solution would be to use freeze()
from Storable (core module) on %input_params hash (or its reference),
e.g.:
  $key = freeze \%input_params;
or other serialization technique.

While at it document extra options/flags to href().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Actually after discussion with J.H.
  http://thread.gmane.org/gmane.comp.version-control.git/136913/focus=137061
I have changed my mind and now I think that good human-readable key
for output caching is href(-replay=>1, -full=>1, -path_info=>0);

The reason behind -path_info=>0 is that we want to have the same cache
entry (the same cache file) regardless of whether we use path_info
URL, or non-path_info URL.

The reason behind -full_path=>1 (from what I understand from
J.H. argument) is that you can have two gitweb deployments sharing the
same cache root, but in which the same project name can point to
different projects (different $projectsroot).

 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2f6a8e1..cd5073c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1004,6 +1004,10 @@ exit;
 ## ======================================================================
 ## action links
 
+# possible values of extra options
+# -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
+# -replay => 1      - start from a current view (replay with modifications)
+# -path_info => 0|1 - don't use/use path_info URL (if possible)
 sub href {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
@@ -1020,7 +1024,8 @@ sub href {
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
