From: Brian Harring <ferringb@gmail.com>
Subject: [PATCH] fix hang in git fetch if pointed at a 0 length bundle
Date: Mon, 2 Jan 2012 17:13:52 -0800
Message-ID: <20120103011352.GA13825@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 02:14:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhsx0-0000xF-PX
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 02:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124Ab2ACBN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 20:13:57 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51861 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab2ACBN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 20:13:56 -0500
Received: by iaeh11 with SMTP id h11so30049028iae.19
        for <git@vger.kernel.org>; Mon, 02 Jan 2012 17:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=XjV8xb31Tw9N0MQlq+BMGgfVahmGYLgxbCGGWdi9Ez0=;
        b=ngWMnyZ6Eq4lMw9p5UI3LpIF4SLwFagzQkfhhPgmMS6js0M7vxOhMgUgYkU+kktUPx
         soiioqJ4hViPD8hY4XZxeQYJBvODsKNBdq6aHmDEuxapAM2/KqjM9Ot9a40Wpi0N6M5P
         YtzACEWL1+hv7iGHkOpgwpHrQN6XdepJ1hGeg=
Received: by 10.50.157.229 with SMTP id wp5mr61027642igb.22.1325553235449;
        Mon, 02 Jan 2012 17:13:55 -0800 (PST)
Received: from smtp.gmail.com:587 (74-95-192-101-SFBA.hfc.comcastbusiness.net. [74.95.192.101])
        by mx.google.com with ESMTPS id r5sm72511411igl.3.2012.01.02.17.13.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 Jan 2012 17:13:54 -0800 (PST)
Received: by smtp.gmail.com:587 (sSMTP sendmail emulation); Mon, 02 Jan 2012 17:13:52 -0800
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187852>

git-repo if interupted at the exact wrong time will generate zero
length bundles- literal empty files.  git-repo is wrong here, but
git fetch shouldn't effectively spin loop if pointed at a zero
length bundle.

Signed-off-by: Brian Harring <ferringb@chromium.org>
---
 bundle.c          |    2 +-
 t/t5704-bundle.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4742f27..ac9cc20 100644
--- a/bundle.c
+++ b/bundle.c
@@ -31,7 +31,7 @@ static int strbuf_readline_fd(struct strbuf *sb, int fd)
 	while (1) {
 		char ch;
 		ssize_t len = xread(fd, &ch, 1);
-		if (len < 0)
+		if (len <= 0)
 			return -1;
 		strbuf_addch(sb, ch);
 		if (ch == '\n')
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index 728ccd8..75ce5b8 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -53,4 +53,14 @@ test_expect_failure 'bundle --stdin <rev-list options>' '
 
 '
 
+test_expect_success 'die if bundle file is empty' '
+
+   echo -n > empty-bundle
+   timeout 5 git fetch empty-bundle
+   ret=$?
+   [ $ret == 128 ] && return 0
+   return $ret
+
+'
+
 test_done
-- 
1.7.8.2
