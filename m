From: David Barr <davidbarr@google.com>
Subject: [PATCH v2 4/6] vcs-svn: prefer strstr over memmem
Date: Fri,  1 Jun 2012 00:41:28 +1000
Message-ID: <1338475290-22644-5-git-send-email-davidbarr@google.com>
References: <1338475290-22644-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 16:42:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6aA-0003gL-5m
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440Ab2EaOma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:42:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40687 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389Ab2EaOm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:42:28 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1378013dad.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bXGXRJZcJCz+qtaB11tFpq9vMwcKzjxNP+UzxaxpFx0=;
        b=mDIyLnmClzUtaa5rL93L+SdOWrS9j943cXwyhzetXlPujO+aBTb36PA5lKKbCCE2k5
         wppIrBClyx1TP7spcRr1Xth2L1gRt3eiAWPUuhYjosVfTIqNATZYHJcGfsrBMFGtyx/0
         6ZnapdTRVt8cX3JbdZnvPjpuD6MV9qzda8mW4Mou0tnCp+6luTnu8Ix7OrfQm0i6dGpl
         PTMHioYFRRhLBOT7l9tbkA2fBZBcvqazzbZX/0MPIPtl2DtVaJhs1ykUBntXGhKWmS3J
         So13/GEOfxvfr33Ae2yxIRZU/LywAdFXX+QXh0KF8fhU74XXp0cAV76XWAt7K5BJo7+i
         a+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=bXGXRJZcJCz+qtaB11tFpq9vMwcKzjxNP+UzxaxpFx0=;
        b=oQdA+asakMm3DkRtBBjrronopXAQBwNQkqklzuA/H1yWGX1PjGDYiNiKIanfelK7Qy
         ENeHnNDjRdWWysG194G7XPc0rIddE78qVIXKemdb2anjeDtvSq/NliwEZJpEW96HX+za
         PAoxsIVkpsEkogIm4vfdTOiVNSMbxIyZ+Vj+msKD862r10UzWNfFyCvqDKM597MvwDqo
         QWSslr8SuuwLgTa+/4QKxyHIoC3htMP1btgxPlFhtccMvmLaCf1aKjn4xNyqP4XCgAe5
         vYjTWsc9pYgLMr7o51SYl6gdFPcGptQM2MLKwfSJMaHWV0/dsB2AtSwbZxldy8KoUEXm
         op9g==
Received: by 10.68.225.170 with SMTP id rl10mr589782pbc.13.1338475347848;
        Thu, 31 May 2012 07:42:27 -0700 (PDT)
Received: by 10.68.225.170 with SMTP id rl10mr589737pbc.13.1338475347474;
        Thu, 31 May 2012 07:42:27 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id og6sm4376720pbb.42.2012.05.31.07.42.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:42:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1338475290-22644-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQm2e7fMGy30IDPTPLRIy7cvfM18ftawsYej3FnyD9VoURrPrO3V9WuRxxzn6iAqVzI5dIfXpn160ftUaKNH4y87q3hiFvVS9kAuSK1acsCPjB+fFQVShD+2R4JLeDm0qxBC7uKx8m3O03VrZSvEq9l6pfzRklmbXGLGxBFhGqT3ls2qf3s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198913>

The common pattern is to use strstr to match a fixed needle.
As a bonus, elimate dependency on memmem for upstream.

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/fast_export.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index b823b85..cda37dd 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -163,7 +163,7 @@ static int parse_cat_response_line(const char *header, off_t *len)
 
 	if (ends_with(header, headerlen, " missing"))
 		return error("cat-blob reports missing blob: %s", header);
-	type = memmem(header, headerlen, " blob ", strlen(" blob "));
+	type = strstr(header, " blob ");
 	if (!type)
 		return error("cat-blob header has wrong object type: %s", header);
 	n = strtoumax(type + strlen(" blob "), (char **) &end, 10);
-- 
1.7.10.2
