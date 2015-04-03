From: Daniel Bingham <daniel@dbingham.com>
Subject: [PATCH] git-p4: Fetch the proper revision of utf16 files
Date: Fri,  3 Apr 2015 14:13:47 -0700
Message-ID: <1428095627-8772-2-git-send-email-git@dbingham.com>
References: <1428095627-8772-1-git-send-email-git@dbingham.com>
Cc: luke@diamond.org, pw@padd.com, Daniel Bingham <git@dbingham.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 23:15:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye8wY-0000nl-A3
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbbDCVPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 17:15:53 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:36544 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbDCVPx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 17:15:53 -0400
Received: by qgeb100 with SMTP id b100so59032751qge.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 14:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=utdDufx3/22rkCn2VV7WAmppMv3UXN5A62Ud7KDV+Zc=;
        b=MzGYtbrAKywi2yyfxRB9/eTl5z56cTu+/s1WbeoaVqnuvT5Px5iOsHe2N3TIoF8+gw
         RbY17lIBdk/ouTWg/BjvPkpbo0OBQmvublG5xckIdceupQKGO+97cn3CbjOA3oliDUPM
         LCM5UMtEg1YPKYf9tbW7kJbu+L4OinVNXk8/CuAwn3/ZgSLdDScwAo+mA0S99A/kAbsL
         CVjWUbIl7ZtZA5eJbfGMxi82eQ/uzJ9/358NbgwVaa0hd6pgcESRp+JcYPBRnHpxJU0u
         bNRkzplSBAlOWpcznXLvtFWtF4KnyPb90Idy8clR5D73KahrNge3PrzpFECwDFfJisl2
         uLtg==
X-Gm-Message-State: ALoCoQliXFVJpvT9VCJrgReiEZroauVuLyVOXsF3Xh5fMZf5tX6SSFqarfdUTZfnQYQR0QxlLlQL
X-Received: by 10.140.85.137 with SMTP id n9mr4646408qgd.40.1428095752761;
        Fri, 03 Apr 2015 14:15:52 -0700 (PDT)
Received: from dbingham-rmbp.ca.com (c-73-181-209-250.hsd1.wa.comcast.net. [73.181.209.250])
        by mx.google.com with ESMTPSA id z93sm6438038qgd.45.2015.04.03.14.15.51
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2015 14:15:52 -0700 (PDT)
X-Google-Original-From: Daniel Bingham <git@dbingham.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1428095627-8772-1-git-send-email-git@dbingham.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266728>

git-p4 always fetches the latest revision of UTF16
files from P4 rather than the revision at the commit being sync'd.

The print command should, instead, specify the revision number from the
commit in question using the file#revision syntax.

The file#revision syntax is preferable over file@changelist for
consistency with how streamP4Files formats the fileArgs list.

Signed-off-by: Daniel Bingham <git@dbingham.com>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index ff132b2..156f3a4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2101,7 +2101,8 @@ class P4Sync(Command, P4UserMap):
             # them back too.  This is not needed to the cygwin windows version,
             # just the native "NT" type.
             #
-            text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])
+            ufile = "%s#%s" % (file['depotFile'], file['rev'])
+            text = p4_read_pipe(['print', '-q', '-o', '-', ufile])
             if p4_version_string().find("/NT") >= 0:
                 text = text.replace("\r\n", "\n")
             contents = [ text ]
-- 
2.3.5
