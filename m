From: Charles McGarvey <chazmcgarvey@brokenzipper.com>
Subject: [PATCH] gitweb: fix problem causing erroneous project list
Date: Tue, 4 Jun 2013 22:44:28 -0600
Message-ID: <20130605043524.GA2453@compy.Home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 05 06:55:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk5l1-0003SM-2I
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 06:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268Ab3FEEz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 00:55:26 -0400
Received: from romulus.brokenzipper.com ([71.19.157.142]:65387 "EHLO
	romulus.brokenzipper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3FEEzP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 00:55:15 -0400
X-Greylist: delayed 643 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2013 00:55:15 EDT
Received: from vulcan.local (unknown [IPv6:2602:61:7edf:e300:0:ff:fe00:7701])
	by romulus.brokenzipper.com (Postfix) with ESMTP id 70FA252D65;
	Tue,  4 Jun 2013 22:44:31 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=brokenzipper.com;
	s=romulus; t=1370407471;
	bh=KKofYgE91D6xw4jk5ZAMImv5Cry9smJJiSXsndUXpI4=;
	h=Date:From:To:Cc:Subject;
	b=bovKh1kzuCYfK7xy9Zib3oMjz3rrUvNcSP0wg1k8tZ9F7bzGnkvDosT99kxe27OZx
	 EJXpwAFgV94hG1TP5l8Ml13qMgZw+q+UcOd43Oa+3uxZaGdQ5neaSTfA4+ltSh76aR
	 bVs7aXQNyd/tud6IE7p6G1NKteP/R7Si6lVbq1CE=
Received: from [2602:61:7edf:e300:0:ff:fe00:7700] (helo=compy)
	by vulcan.local with smtp (Exim 4.80)
	(envelope-from <chazmcgarvey@brokenzipper.com>)
	id 1Uk5ad-0003tP-LN; Tue, 04 Jun 2013 22:44:52 -0600
Received: by compy (sSMTP sendmail emulation); Tue, 04 Jun 2013 22:44:28 -0600
Content-Disposition: inline
OpenPGP: url=http://www.brokenzipper.com/chaz.asc
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226430>

The bug is manifest when running gitweb in a persistent process (e.g.
FastCGI, PSGI), and it's easy to reproduce.  If a gitweb request
includes the searchtext parameter (i.e. s), subsequent requests using
the project_list action--which is the default action--and without
a searchtext parameter will be filtered by the searchtext value of the
first request.  This is because the value of the $search_regexp global
(the value of which is based on the searchtext parameter) is currently
being persisted between requests.

Instead, clear $search_regexp before dispatching each request.

Signed-off-by: Charles McGarvey <chazmcgarvey@brokenzipper.com>
---
I don't think there are currently any persistent-process gitweb tests to
copy from, so writing a test for this seems to be non-trivial.

 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 80950c0..8d69ada 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1086,7 +1086,7 @@ sub evaluate_and_validate_params {
 	our $search_use_regexp = $input_params{'search_use_regexp'};
 
 	our $searchtext = $input_params{'searchtext'};
-	our $search_regexp;
+	our $search_regexp = undef;
 	if (defined $searchtext) {
 		if (length($searchtext) < 2) {
 			die_error(403, "At least two characters are required for search parameter");
-- 
1.8.1.5
