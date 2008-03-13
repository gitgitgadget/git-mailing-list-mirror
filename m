From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] git-p4: Unset P4DIFF environment variable when using 'p4 -du diff'
Date: Wed, 12 Mar 2008 19:03:23 -0500
Message-ID: <1205366604-12970-1-git-send-email-shawn.bohrer@gmail.com>
Cc: simon@lst.de, Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 01:04:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZavw-00031o-SR
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 01:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbYCMADy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 20:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbYCMADx
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 20:03:53 -0400
Received: from el-out-1112.google.com ([209.85.162.177]:47912 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYCMADx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 20:03:53 -0400
Received: by el-out-1112.google.com with SMTP id v27so2071481ele.17
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 17:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TbvWC8P04JHFoa5zTEklR+ixnJD3bXUiMK5IkXeYhc0=;
        b=L4gA3QyUjGf0pObGyZ2ac6ivOJ0NDbRvdN+NUfSW46xA/1G8S1j+f7UEpgUCvqMr6QfbgaeX5j6uRjldZn2aROcekV0SxhBIQbK5HiPEB+6yg9UAYIWazGJPZNcFHYHETmDOHc8wFYtiXaCLddgMiBk/J1mVIvYk/p4FZs1h7kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p9yEH0xXmOBsp8ZdSVnG5dZZw7ozl8jX2m4JvNXyEHxVgbOQqDbv0HPzeBc3xo8AEGGbw7SgYa6wcVmnHHo/FoYDowdj0bQPh7Wfgh2lmaWbcHsEn4qm1EdhdjdCCRGjOoOo7VvblTpe3NQ/Mv64lrTXb2aAZW+Va+cK2LBMl/I=
Received: by 10.150.155.1 with SMTP id c1mr4925595ybe.85.1205366631707;
        Wed, 12 Mar 2008 17:03:51 -0700 (PDT)
Received: from lintop ( [70.112.149.232])
        by mx.google.com with ESMTPS id k77sm1669573rnb.13.2008.03.12.17.03.47
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Mar 2008 17:03:50 -0700 (PDT)
Received: by lintop (sSMTP sendmail emulation); Wed, 12 Mar 2008 19:03:24 -0500
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77029>

A custom diffing utility can be specified for the 'p4 diff' command by
setting the P4DIFF environment variable.  However when using a custom
diffing utility such as 'vimdiff' passing options like -du can cause
unexpected behavior.

Since the goal is to generate a unified diff of the changes and attach
them to the bottom of the p4 submit log we should unset P4DIFF if it
has been set in order to generate the diff properly.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 contrib/fast-import/git-p4 |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 650ea34..0b46084 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -627,6 +627,8 @@ class P4Submit(Command):
 
         if self.interactive:
             submitTemplate = self.prepareLogMessage(template, logMessage)
+            if os.environ.has_key("P4DIFF"):
+                del(os.environ["P4DIFF"])
             diff = read_pipe("p4 diff -du ...")
 
             for newFile in filesToAdd:
-- 
1.5.4.3
