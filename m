From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] sh-setup: add new peel_committish() helper
Date: Thu, 13 Jun 2013 23:46:01 +0530
Message-ID: <1371147362-26962-3-git-send-email-artagnon@gmail.com>
References: <1371147362-26962-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:18:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnC65-000878-61
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758884Ab3FMSSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:18:04 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:55130 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758873Ab3FMSSB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:18:01 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so8226817pad.23
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WUA9cFh31zLblNL68jAMPITj5dNGTdZ5w8+o+52hg6Y=;
        b=KIQLKIm+PopxlDgX2lH1I016zZawRfRUBZFl6/0gKDIfSaF9jsgvqnNAGKnaPhCLbo
         JXxKnXGTB7nYKfBmFkAzIhrN5PafMdn0bZn15wtzFAFIm9b28mjHAhX2pYqiHuay024N
         KVhE1nHnfDjRHa/egX7Q46dPKJn7AUBGeYXqQxpAlCivzm9SvHd7xgkUJ4KsRdunmqR5
         J+mAeFvR5i1c2cRHja4SbiDV7X1K5Mm1aLPG+jMOxSj2HnvjbJ5eIObg+hPojwPm+Yez
         9dxmb7D1jGlSTpA5VX7xSD4CCjKAqu0bDhaDLKi78sjFfxAppV9iFuIRgyWtJRr+sm07
         0ZKw==
X-Received: by 10.66.228.98 with SMTP id sh2mr3926896pac.80.1371147481196;
        Thu, 13 Jun 2013 11:18:01 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pm7sm24250605pbb.31.2013.06.13.11.17.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 11:18:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.g31c8856.dirty
In-Reply-To: <1371147362-26962-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227766>

The normal way to check whether a certain revision resolves to a valid
commit is:

  $ git rev-parse --verify $REV^0

Unfortunately, this does not work when $REV is of the type :/quuxery.
Write a helper to work around this limitation.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-sh-setup.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 2f78359..6ae19a6 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -313,3 +313,16 @@ then
 	}
 	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
 fi
+
+peel_committish () {
+	test $# -gt 1 && quiet="--quiet" || quiet=""
+	case "$1" in
+	:/*)
+		peeltmp=$(git rev-parse --verify $quiet "$1") &&
+		git rev-parse --verify "${peeltmp}^0"
+		;;
+	*)
+		git rev-parse --verify "${1}^0"
+		;;
+	esac
+}
-- 
1.8.3.1.381.g31c8856.dirty
