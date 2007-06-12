From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH 3/3] gitview: Catch exception from rindex
Date: Tue, 12 Jun 2007 23:29:40 +0530
Message-ID: <11816711802519-git-send-email-aneesh.kumar@gmail.com>
References: <392459374618773353ea560d021dd3211d143d86.1181671162.git.aneesh.kumar@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 20:00:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyAf0-0006Xx-Nk
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 20:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947AbXFLR7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 13:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755121AbXFLR7v
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 13:59:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:31503 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbXFLR7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 13:59:50 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1869158wxc
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 10:59:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:message-id:in-reply-to:references;
        b=NASGrkg898YUSlUtmLOi2oXovezwKwtU73vHaSa+UzzDkQcYTDTONPjmuEyPhAOvMCAo0yPX1RO8HkTJhCDbKa8DrfZr4GHdiat9COPh6yxDRb9YPuBoMDpXt9csEJqQ1pu3AWhnkt4vREj3+Rz8Gza3TGlNY34QNJNsZSfxmMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tecSyC06VwFuglWQQT7qcxOqrERtAKbQkI2QiJmwRdzM1DNE+d5K1U02SuwZbdTOudOiVTfJT4mNCZlnc4sqLK3ZNfV6eAW3EprrLWXH3hrvstAzCzPRMJpDckpAdd1NN5bGDjf8dhqNQu5dVhEqEZ2GeotDhhLvETvRziwQHVs=
Received: by 10.90.25.3 with SMTP id 3mr5820410agy.1181671186668;
        Tue, 12 Jun 2007 10:59:46 -0700 (PDT)
Received: from localhost ( [122.167.198.224])
        by mx.google.com with ESMTP id i5sm5764662nzi.2007.06.12.10.59.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2007 10:59:46 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.1.239.g75d8-dirty
Message-Id: <fb2158f4deca7f23a86c6b3dbc80758de90cde10.1181671162.git.aneesh.kumar@gmail.com>
In-Reply-To: <392459374618773353ea560d021dd3211d143d86.1181671162.git.aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If we have really short read the input buffer will not
have a new line and rindex with through the ValueError
exception. Handle the same gracefully

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/gitview/gitview |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 01128f4..4f39ddd 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -421,8 +421,13 @@ class AnnotateWindow(object):
 				self.prev_read = ""
 
 			if (buffer[len(buffer) -1] != '\n'):
-				self.prev_read = buffer[buffer.rindex("\n"):(len(buffer))]
-				buffer = buffer[0:buffer.rindex("\n")]
+				try:
+					newline_index = buffer.rindex("\n")
+				except ValueError:
+					newline_index = 0
+
+				self.prev_read = buffer[newline_index:(len(buffer))]
+				buffer = buffer[0:newline_index]
 
 			for buff in buffer.split("\n"):
 				annotate_line = re.compile('^([0-9a-f]{40}) (.+) (.+) (.+)$')
-- 
1.5.2.1.239.g75d8-dirty
