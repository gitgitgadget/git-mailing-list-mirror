From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] gitweb.js: fix null object exception in initials calculation
Date: Thu, 19 Nov 2009 11:44:46 -0800
Message-ID: <1258659887-5244-2-git-send-email-bebarino@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:45:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBCwD-0006Hd-2B
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 20:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbZKSTov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 14:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZKSTov
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 14:44:51 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:46664 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbZKSTov (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 14:44:51 -0500
Received: by bwz27 with SMTP id 27so2739714bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 11:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=G5BzOG4xuImFwEE113kMbljGyiyIk3hsBa05OfKwQSg=;
        b=xxJCY2qW9B/yTyRx06mQK3OEUMIen3W/72/kLzH1Yd/o51DkkG3D9kJ8SSnhKk3VI5
         20N9z36yqdikAue4mMjZxFyMeu6gFHjstamB+DC+eX7iy3hgi3rYCbHl2t4c70Lg2ZJ+
         UAIloNEIS+3a9mrFYnd57UJ4PQsmLiWey+lQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rmYj2Y16nDooI3KCHdS/D+0hdMbttY+rwTyvIjBOLbuAW/bwr/3SBjY4v8s22pPNEq
         GUvUbPKngNIiOUXDFbyL0wUGUeM/r40Xv+93taNzLoMhOzK83//CvVydAbDqDMSZ1BFw
         QRyojQNbZAUkYq34nEOjuBU6zz3+75s6H85MU=
Received: by 10.103.81.12 with SMTP id i12mr206325mul.37.1258659896120;
        Thu, 19 Nov 2009 11:44:56 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id b9sm3804838mug.9.2009.11.19.11.44.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 11:44:55 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Thu, 19 Nov 2009 11:44:50 -0800
X-Mailer: git-send-email 1.6.5.3.433.g11067
In-Reply-To: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133249>

Currently handleLine() assumes that a commit author name will always
start with a capital letter. It's possible that the author name is
user@example.com and therefore calling a match() on the name will fail
to return any matches. Subsequently joining these matches will cause an
exception. Fix by checking that we have a match before trying to join
the results into a set of initials for the author.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 gitweb/gitweb.js |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index 22570f5..02454d8 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -532,8 +532,11 @@ function handleLine(commit, group) {
 			if (group.numlines >= 2) {
 				var fragment = document.createDocumentFragment();
 				var br   = document.createElement("br");
-				var text = document.createTextNode(
-					commit.author.match(/\b([A-Z])\B/g).join(''));
+				var match = commit.author.match(/\b([A-Z])\B/g);
+				if (match) {
+					var text = document.createTextNode(
+							match.join(''));
+				}
 				if (br && text) {
 					var elem = fragment || td_sha1;
 					elem.appendChild(br);
-- 
1.6.5.3.433.g11067
