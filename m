From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 2/4] contrib/subtree: Allow stale .gitsubtree entries to be replaced
Date: Tue, 12 Feb 2013 23:23:14 +0000
Message-ID: <CALeLG_=t1E9uemehqPD48r+2JrRSToJJcSBuOQn=Qz7730=4-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "David A. Greene" <greened@obbligato.org>,
	Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 00:23:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5PCN-000415-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213Ab3BLXXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:23:15 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:37431 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab3BLXXO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:23:14 -0500
Received: by mail-ob0-f173.google.com with SMTP id dn14so661250obc.4
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 15:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=gZZ7+DBL1QIvfVWZlq4e9DI+0VO3J7owDIgAKoLVhHw=;
        b=EN0CHZsFlcmEepL/etcJ4TI4z2y1K753VXaMJ3YqHC7/0dOmB8NjfULvBDAI27d9N+
         LfMLfc++/pKAwfctA7pe6WbzxCXDiqwUQUf6R5kYfdrENDaVL2wi4TL5qttLQc3xZwz0
         XLQpRIBPot4+nnKfTLUWRT2T0sokf+KAycfs8hf9xLC/tEuzKFpvMx03D4dilHeYoJcO
         si1/RYisZsxGEhU0FXMZ+BH242t+md/Zv5np9mrB1OSqKgXybkNqFvPHTpOnjXdg5twD
         0YziOAEVT6EMIHov5PM7J7HraNisECYErrtSP0oj3ykDCUS8UQTnPnNQpKTRJdc6Hf+o
         tL+A==
X-Received: by 10.60.2.129 with SMTP id 1mr15430131oeu.9.1360711394285; Tue,
 12 Feb 2013 15:23:14 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Tue, 12 Feb 2013 15:23:14 -0800 (PST)
X-Originating-IP: [2.102.85.14]
X-Gm-Message-State: ALoCoQnIV0UsBd/YysIYVMOgdFwdA0ksf4mV5+9h/2vuVpsrWkOicIRx6bC7s3UzCYlqV9ddmOWD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216224>

Should .gitsubtree have a <prefix> listed that doesn't exist on disk, allow
it to be replaced/updated by a git subtree add.

Ideally I would have aborted the operation if there was an existing entry
and required the user to edit the .gitsubtree file by hand, but that
behaviour broke a lot of the tests.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 02aae30..4f21902 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -490,7 +490,13 @@ ensure_clean()

 subtree_memorize()
 {
-	if [ $# -eq 1 ] ; then
+	if ( grep "^$dir " .gitsubtree ); then
+		# remove $dir from .gitsubtree - there's probably a clever way to
do this with sed
+		grep -v "^$dir " .gitsubtree > .gitsubtree.temp
+		rm .gitsubtree
+		mv .gitsubtree.temp .gitsubtree
+	fi
+	if [ $# -eq 1 ]; then
 		echo "$dir . $@" >> .gitsubtree
 	elif [ $# -eq 2 ]; then
 		echo "$dir $@" >> .gitsubtree
-- 
1.8.1.3.566.gaa39828
