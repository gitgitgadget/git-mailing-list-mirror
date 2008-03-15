From: Jeff King <peff@peff.net>
Subject: [PATCH] t6000lib: re-fix tr portability
Date: Fri, 14 Mar 2008 20:32:33 -0400
Message-ID: <20080315003233.GA29209@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 01:33:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaKKt-0007sK-W5
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 01:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbYCOAch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 20:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbYCOAcg
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 20:32:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1764 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbYCOAcg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 20:32:36 -0400
Received: (qmail 11313 invoked by uid 111); 15 Mar 2008 00:32:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Mar 2008 20:32:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2008 20:32:33 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77297>

It seems that some implementations of tr don't like a
replacement string of '-----...'; they try to find the
double-dash option "---...".

Instead of this pipeline of tr and sed invocations, just use a
single perl invocation.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't see any complaints about increasing the use of perl in earlier
patches, so hopefully nobody minds. I think this is more portable, more
readable, and probably more efficient.

 t/t6000lib.sh |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t6000lib.sh b/t/t6000lib.sh
index b69f7c4..c0baaa5 100755
--- a/t/t6000lib.sh
+++ b/t/t6000lib.sh
@@ -97,10 +97,13 @@ check_output()
 # from front and back.
 name_from_description()
 {
-        tr "'" '-' |
-		tr '~`!@#$%^&*()_+={}[]|\;:"<>,/? ' \
-		   '------------------------------' |
-		tr -s '-' | tr '[A-Z]' '[a-z]' | sed "s/^-*//;s/-*\$//"
+	perl -pe '
+		s/[^A-Za-z0-9.]/-/g;
+		s/-+/-/g;
+		s/-$//;
+		s/^-//;
+		y/A-Z/a-z/;
+	'
 }
 
 
-- 
1.5.4.4.686.g851d
