From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 1/4] contrib/subtree: Teach push to abort if split fails
Date: Wed, 13 Mar 2013 22:32:40 +0000
Message-ID: <1363213963-4065-2-git-send-email-pcampbell@kemitix.net>
References: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Michael Hart <michael@adslot.com>,
	Paul Campbell <pcampbell@kemitix.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 23:34:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFuFF-0005L5-5F
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 23:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934332Ab3CMWdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 18:33:35 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56130 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934325Ab3CMWde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 18:33:34 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr12so1440615wgb.23
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 15:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=ujl9Gnhl4Bw//05ovnbuKrNVqGVDiZQUOjd7sI7Du7w=;
        b=NQscJqK1Q7asjrYWec3aBvlYbugpuJe8VTJW4arAMTq07J7SRdb7UV95Ff0xFcvhVu
         sI/8DbKLWbXswXko4k49jXgdJAC6pwRFSt/ujAfZ+9rs7pjYc/bSgv0EVXZsMkgUvvTs
         GrwX4sGXjIBBedvzzarASpw8HjLetkUevULSaeRdCnFigr8GcWM8NGlPnu4Zc8JljQMR
         yUlU2pb/6oTCAK3RsS6BOMmWEATQ9CNYHGcyu4wdOWCIFrFiM0UoIC4ZxHaI7iM9+0Tc
         1MEGJcQMHS9nLblw6Pq9rg/gTdTvEmp9+e1LWIxw/MYjZ197IfZj7YQzcVKzfZvf5LFA
         NpAQ==
X-Received: by 10.194.21.233 with SMTP id y9mr29690wje.47.1363214013319;
        Wed, 13 Mar 2013 15:33:33 -0700 (PDT)
Received: from coyote.home (host-2-102-86-203.as13285.net. [2.102.86.203])
        by mx.google.com with ESMTPS id c15sm330641wiw.3.2013.03.13.15.33.31
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 15:33:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363213963-4065-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQkJc+hjuicTJ/hts5oKaN7AcBINbrc2TMuZvJ/G5ZrhevM+Wytg26Z4zbyvJcdejdYeXGxm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218098>

From: Michael Hart <michael@adslot.com>

If the subtree split fails it doesn't return the SHA that should be
pushed to the other repository.

Added a check to ensure that split succeeds before trying to push
and display an error message.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..c68cc6f 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -715,7 +715,12 @@ cmd_push()
 	    repository=$1
 	    refspec=$2
 	    echo "git push using: " $repository $refspec
-	    git push $repository $(git subtree split --prefix=$prefix):refs/heads/$refspec
+	    rev=$(git subtree split --prefix=$prefix)
+	    if [ -n "$rev" ]; then
+		git push $repository $rev:refs/heads/$refspec
+	    else
+		die "Couldn't push, 'git subtree split' failed."
+	    fi
 	else
 	    die "'$dir' must already exist. Try 'git subtree add'."
 	fi
-- 
1.8.2
