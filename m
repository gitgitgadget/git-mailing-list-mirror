From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Easier adding/changing parameters to current URL
Date: Thu,  1 Nov 2007 13:06:27 +0100
Message-ID: <1193918789-16421-3-git-send-email-jnareb@gmail.com>
References: <1193918789-16421-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 13:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYmk-0008UE-Jb
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 13:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbXKAMEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755200AbXKAMEF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:04:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:35100 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbXKAMEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:04:01 -0400
Received: by ug-out-1314.google.com with SMTP id z38so453891ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ssibdnXSmLDnGBeERSaOefRGaLmse0EQeNDDwOch8uk=;
        b=lUPtgNtyDJMxl/OIi7Jtj3vQq3ZCoNIi4SZBhI/fnXZZzpUHvN/rBt1skrph7jYtFSShV7P+zL3ZvRJj4QSfqSqxzc0YcKE1YTGQmG8UNcDfBhFI3oE+CVwqB5OA2xrHVrpsrpd51QEHy2kHCC9dihHfEfCxplsHEcV43aLav0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UPNH309fvCBka706AHhK/BeaWdsRPPShNGCDP0XXjV2qi9NDhdID8XJNUCGAtK+ViaqOxyyup/pB5dRPZbqSHSjzHKxTo26V6tXIBTSKa5pS+2NKV7VVhQO/bKoieMgHoJn4s5tdPYJi9JYXknGW7+KrAaWg85KePIdOCm5OeqM=
Received: by 10.66.221.6 with SMTP id t6mr2413869ugg.1193918639811;
        Thu, 01 Nov 2007 05:03:59 -0700 (PDT)
Received: from roke.D-201 ( [83.8.199.125])
        by mx.google.com with ESMTPS id q1sm5787483uge.2007.11.01.05.03.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 05:03:58 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA1C6V4Y016534;
	Thu, 1 Nov 2007 13:06:31 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA1C6VDb016533;
	Thu, 1 Nov 2007 13:06:31 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1193918789-16421-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62941>

Add boolean option '-replay' to href() subroutine, which is used to
generate links in gitweb.  This option "replays" current URL,
overriding it with provided parameters.  It means that current value
of each CGI parameter is used unless otherwise provided.

This change is meant to make it easier to generate links which differ
from current page URL only by one parameter, for example the same view
but sorted by different column:
  href(-replay=>1, order=>"age")
or view which differs by some option, e.g. in log views
  href(-replay=>1, extra_options=>"--no-merges")
or alternate view of the same object, e.g. in the 'blob' view
  href(-replay=>1, action=>"blob_plain")

Actual use of this functionality is left for later.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e36dec1..eaab895 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -611,6 +611,15 @@ sub href(%) {
 	);
 	my %mapping = @mapping;
 
+	if ($params{-replay}) {
+		while (my ($name, $symbol) = each %mapping) {
+			if (!exists $params{$name}) {
+				# to allow for multivalued params we use arrayref form
+				$params{$name} = [ $cgi->param($symbol) ];
+			}
+		}
+	}
+
 	$params{'project'} = $project unless exists $params{'project'};
 
 	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
-- 
1.5.3.4
