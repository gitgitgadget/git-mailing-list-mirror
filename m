From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] contrib: Make remotes2config.sh script more robust
Date: Sun,  2 Dec 2007 20:40:43 +0100
Message-ID: <1196624443-32382-1-git-send-email-jnareb@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 20:41:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyuge-0003Ry-Qg
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 20:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbXLBTkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 14:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbXLBTkt
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 14:40:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:33579 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbXLBTks (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 14:40:48 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2563917nfb
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 11:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Cb9Cx7Y1cX1bxIKzqTMPJvvnyFDWT/dcOmF4A/V06C4=;
        b=C8JXianQSF8hjWfUCnw2SzKqGijU1/wspn5BUB6X/PPrfUL647UbDvJR7xxbpbaFZaIye2Z9b1TXFpFTAcDySIyGvSH31UFvwK0v53fkrmwgYhDDk515F8Ave5HZOfcto0mUpi6jwNStt8TXxNmHpPDV9w5ddZRySnzqh0M8ltw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=exCix/gQv0VgU4mGQQ4mwAp6O44/saOUmudNq8q7piPlIf44Wx9SCaU54W8UG/1rfbn7Mz5vXIK/LdHmEluZynt09Q8mZNSWed7yjx9UZQch5EmRDpofzeW+E8Lr4LIQUWH3ofl/9eMi0XTIIIvtR8VL09pnxRvTOqollrTqNuo=
Received: by 10.86.50.8 with SMTP id x8mr9784176fgx.1196624446338;
        Sun, 02 Dec 2007 11:40:46 -0800 (PST)
Received: from roke.D-201 ( [83.8.251.146])
        by mx.google.com with ESMTPS id l12sm5633552fgb.2007.12.02.11.40.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2007 11:40:45 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB2JejAI032398;
	Sun, 2 Dec 2007 20:40:45 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB2Jeiac032397;
	Sun, 2 Dec 2007 20:40:44 +0100
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66814>

The remotes2config.sh script replaced all 'unsafe' characters in repo
name with '.'; include '-' in the 'safe' characters set (the set is
probably even larger).

Script required also space after "URL:", "Push:" and "Pull:" in
remotes file. This for example made the following remote
  URL: git://git.kernel.org/pub/scm/git/git.git
  Pull: refs/heads/master:refs/heads/origin
  Pull:+refs/heads/pu:refs/heads/pu
miss 'pu' branch (forced branch) in config file after conversion.
Allow for any number of whitespace after "URL:", "Push:", "Pull:".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 contrib/remotes2config.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 contrib/remotes2config.sh

diff --git a/contrib/remotes2config.sh b/contrib/remotes2config.sh
old mode 100644
new mode 100755
index 5838b3a..1cda19f
--- a/contrib/remotes2config.sh
+++ b/contrib/remotes2config.sh
@@ -11,11 +11,11 @@ if [ -d "$GIT_DIR"/remotes ]; then
 	{
 		cd "$GIT_DIR"/remotes
 		ls | while read f; do
-			name=$(printf "$f" | tr -c "A-Za-z0-9" ".")
+			name=$(printf "$f" | tr -c "A-Za-z0-9-" ".")
 			sed -n \
-			-e "s/^URL: \(.*\)$/remote.$name.url \1 ./p" \
-			-e "s/^Pull: \(.*\)$/remote.$name.fetch \1 ^$ /p" \
-			-e "s/^Push: \(.*\)$/remote.$name.push \1 ^$ /p" \
+			-e "s/^URL:[ 	]*\(.*\)$/remote.$name.url \1 ./p" \
+			-e "s/^Pull:[ 	]*\(.*\)$/remote.$name.fetch \1 ^$ /p" \
+			-e "s/^Push:[ 	]*\(.*\)$/remote.$name.push \1 ^$ /p" \
 			< "$f"
 		done
 		echo done
-- 
1.5.3.6
