From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 09/23] contrib/subtree: Teach push to abort if split fails
Date: Sun, 10 Mar 2013 23:41:17 +0000
Message-ID: <1362958891-26941-10-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Michael Hart <michael@adslot.com>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Matt Hoffman" <matt.hoffman@quantumretail.com>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:44:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpvC-0004Ja-DI
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab3CJXo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:44:27 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:34497 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab3CJXo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:44:26 -0400
Received: by mail-we0-f174.google.com with SMTP id r6so2932966wey.19
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=HcHHvAl+WjdA2geGlQDUDCDpV9HsqZPjBG8exR2tjfE=;
        b=Hw9TdUozg6rJxWhcCweSwUIIKRfJJhxcAv5fDwZvrHfVPXAtk5XqF4/R5qpJyK5D+7
         SWjqnsrtynNSMyBy1bjjfAtr5A2OyPooBoQeuVc81DROlAY3pKrtlrT1NdQSnhs/F1lM
         70W136WIvTMWMtbHTi2+IYKuzt4emtpEA9t7DwehkDSXG2IM0a+SlX+/xYcA1wA3pGCF
         kHKWfzKUKvVZ/fMpq3TGRrP/nz4q2JbItwbBYhNUNdriQBNGBtblQnOVbjsjrhNLOaSP
         iULYVq3uXSsM8eagDZU++1xsQAKjlgJLwhEfI5ygj4o7bh3YwiD6DZ1rPJUZsQsaCnIb
         RA/g==
X-Received: by 10.194.82.34 with SMTP id f2mr15657013wjy.25.1362959065691;
        Sun, 10 Mar 2013 16:44:25 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.44.19
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:44:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQntsu7LiaP9zVukIDV4ZVB9T0RrmTTsRoLXISVWDcNwB3KdkO4danGCOj/kKu3DXcURHBXS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217829>

From: Michael Hart <michael@adslot.com>

Added a check to ensure that split succeeds before trying to push.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8056851..ae9f87f 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -754,7 +754,12 @@ cmd_push()
         refspec=$(git config -f .gittrees subtree.$prefix.branch)
       fi
 	    echo "git push using: " $repository $refspec
-	    git push $repository $(git subtree split --prefix=$prefix):refs/heads/$refspec
+	    rev=$(git subtree split --prefix=$prefix)
+	    if [ -n "$rev" ]; then
+	        git push $repository $rev:refs/heads/$refspec
+	    else
+	        die "Couldn't push, 'git subtree split' failed."
+	    fi
 	else
 	    die "'$dir' must already exist. Try 'git subtree add'."
 	fi
-- 
1.8.2.rc1
