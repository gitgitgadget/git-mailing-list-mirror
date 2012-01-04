From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] gitweb: accept trailing "/" in $project_list
Date: Wed,  4 Jan 2012 11:07:45 +0100
Message-ID: <1325671665-16847-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 04 11:33:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiO9Z-00065K-1f
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 11:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727Ab2ADKdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 05:33:00 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35315 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab2ADKc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 05:32:58 -0500
X-Greylist: delayed 1477 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jan 2012 05:32:58 EST
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q04A7F6O018295
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Jan 2012 11:07:15 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1RiNlZ-0005sc-C0; Wed, 04 Jan 2012 11:08:17 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1RiNlZ-0004QP-8h; Wed, 04 Jan 2012 11:08:17 +0100
X-Mailer: git-send-email 1.7.8.384.g29bb3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Jan 2012 11:07:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q04A7F6O018295
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1326276435.91279@p/CLjSRaxREqifQCK01DdQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187919>

The current code is removing the trailing "/", but computing the string
length on the previous value, i.e. with the trailing "/". Later in the
code, we do

  my $path = substr($File::Find::name, $pfxlen + 1);

And the "$pfxlen + 1" is supposed to mean "the length of the prefix, plus
1 for the / separating the prefix and the path", but with an incorrect
$pfxlen, this basically eats the first character of the path, and yields
"404 - No projects found".

While we're there, also fix $pfxdepth to use $dir, although a change of 1
in the depth shouldn't really matter.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I'm not fluent in Perl, and not familiar at all with gitweb, but this
sounds a rather obvious (too obvious?) fix.

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f80f259..4512b89 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2835,8 +2835,8 @@ sub git_get_projects_list {
 		my $dir = $projects_list;
 		# remove the trailing "/"
 		$dir =~ s!/+$!!;
-		my $pfxlen = length("$projects_list");
-		my $pfxdepth = ($projects_list =~ tr!/!!);
+		my $pfxlen = length("$dir");
+		my $pfxdepth = ($dir =~ tr!/!!);
 		# when filtering, search only given subdirectory
 		if ($filter) {
 			$dir .= "/$filter";
-- 
1.7.8.384.g29bb3
