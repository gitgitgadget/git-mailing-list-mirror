From: Rys Sommefeldt <rys@pixeltards.com>
Subject: Re: [cgit PATCH] Close file descriptor on error in readfile()
Date: Sat, 07 Nov 2009 12:23:37 +0000
Message-ID: <4AF566C9.5090106@pixeltards.com>
References: <4AF4D4EC.1040806@pixeltards.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: hjemli@gmail.com, steven@uplinklabs.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 13:23:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6kKf-0007j6-Dx
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 13:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbZKGMXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 07:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbZKGMXl
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 07:23:41 -0500
Received: from pixeltards.com ([64.22.109.241]:39702 "EHLO mail.pixeltards.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbZKGMXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 07:23:40 -0500
Received: by mail.pixeltards.com (Postfix, from userid 1009)
	id 1674B1037C; Sat,  7 Nov 2009 12:23:45 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on pixeltards.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from [192.168.2.3] (87-194-178-245.bethere.co.uk [87.194.178.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.pixeltards.com (Postfix) with ESMTPSA id A91F010365;
	Sat,  7 Nov 2009 12:23:41 +0000 (GMT)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
In-Reply-To: <4AF4D4EC.1040806@pixeltards.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132361>

All,

Sorry for the earlier HTML email, I'd misconfigured my mail client so 
accept my apologies for that (and thanks Steven).  Here's the reworked 
patch:

 From d928507bf4c8727c3848525f4744d7c8507de5e8 Mon Sep 17 00:00:00 2001
From: Rys Sommefeldt <rys@pixeltards.com>
Date: Sat, 7 Nov 2009 12:15:24 +0000
Subject: [PATCH] Close fd on error in readfile()

---
  shared.c |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/shared.c b/shared.c
index d7b2d5a..a676fa3 100644
--- a/shared.c
+++ b/shared.c
@@ -406,12 +406,15 @@ int readfile(const char *path, char **buf, size_t 
*size)
     fd = open(path, O_RDONLY);
     if (fd == -1)
         return errno;
-   if (fstat(fd, &st))
+   if (fstat(fd, &st)) {
+       close(fd);
         return errno;
+   }
     if (!S_ISREG(st.st_mode))
         return EISDIR;
     *buf = xmalloc(st.st_size + 1);
     *size = read_in_full(fd, *buf, st.st_size);
     (*buf)[*size] = '\0';
+   close(fd);
     return (*size == st.st_size ? 0 : errno);
  }
-- 
1.6.5.2
