From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH v2 (amend)] gitweb: Do not show 'patch' link for merge commits
Date: Fri, 9 Oct 2009 14:26:44 +0200
Message-ID: <200910091426.44976.jnareb@gmail.com>
References: <20090930201953.22301.73887.stgit@localhost.localdomain> <200910091410.15904.jnareb@gmail.com> <200910091423.51286.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 14:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwEdS-0004Ye-B3
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 14:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbZJIM2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 08:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbZJIM2j
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 08:28:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:3529 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbZJIM2i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 08:28:38 -0400
Received: by fg-out-1718.google.com with SMTP id 22so2175261fge.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PWaoOzZuRWDEnKyZ71LChxV3kfVyhLmPVs/mPqErvsI=;
        b=TlSSPZLjgoILMmJ5hE8Ok/sD2NEw5NSmIE6S+NgB7JDPw3yeA7YsQlzTwFp9U62vsj
         Mn0NIGHyBPHk2YCw1OAzSgENH7CQe3okM+dNu+s2CKA1lBnZ2irypLLyb2RMFxl0o8js
         hcyLlm+F7vYp15CDa3UrilnxABo3gLA6LasmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HVgIJn7EP8MSctF3DA4mwgN1IIzgsBt7/nRgXOYSOqo96BXav8tf5LMJGJoi2JH4ii
         ZMHHpfLx4xJYEs4m0kPTjQID6RoXWR7vCiwb1A8Bru/ZDMMHY8lc1zsmsXk0HS+DHuJl
         WkffErp+dbs0dlnYx6uQ/L37hB98cEhI8+Iwk=
Received: by 10.86.225.38 with SMTP id x38mr2300187fgg.59.1255091209800;
        Fri, 09 Oct 2009 05:26:49 -0700 (PDT)
Received: from ?192.168.1.13? (abve46.neoplus.adsl.tpnet.pl [83.8.202.46])
        by mx.google.com with ESMTPS id d4sm391147fga.4.2009.10.09.05.26.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 05:26:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200910091423.51286.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129794>

The 'patch' view is about generating text/plain patch that can be
given to "git am", and "git am" doesn't understand merges anyway.
Therefore link to 'patch' view should not be shown for merge commits.

Also call to git-format-patch inside the 'patch' action would fail
when 'patch' action is called for a merge commit, with "Reading
git-format-patch failed" text as 'patch' view body.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes since v1:
 * Do not show 'patch' link for merge commits not only in 'commit'
   view, but also in 'commitdiff' view (more complete)
 * 'patch' link is shown also for root (parentless) commits; it
   works correctly thanks to passing '--root' option to git-format-patch
   (remove unnecessary restriction)
 * better commit message thanks to discussion with Jeff King

 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..14f31dc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5328,7 +5328,7 @@ sub git_commit {
 			} @$parents ) .
 			')';
 	}
-	if (gitweb_check_feature('patches')) {
+	if (gitweb_check_feature('patches') && @$parents <= 1) {
 		$formats_nav .= " | " .
 			$cgi->a({-href => href(action=>"patch", -replay=>1)},
 				"patch");
@@ -5616,7 +5616,7 @@ sub git_commitdiff {
 		$formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
 			        "raw");
-		if ($patch_max) {
+		if ($patch_max && @{$co{'parents'}} <= 1) {
 			$formats_nav .= " | " .
 				$cgi->a({-href => href(action=>"patch", -replay=>1)},
 					"patch");
@@ -5824,7 +5824,7 @@ sub git_commitdiff_plain {
 
 # format-patch-style patches
 sub git_patch {
-	git_commitdiff(-format => 'patch', -single=> 1);
+	git_commitdiff(-format => 'patch', -single => 1);
 }
 
 sub git_patches {
-- 
1.6.4.2
