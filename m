From: Andy Spencer <andy753421@gmail.com>
Subject: [PATCH] tree_entry_interesting: match against all pathspecs
Date: Sat, 25 Jan 2014 22:06:46 +0000
Message-ID: <20140125220646.GA24370@pileus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 25 23:14:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7BUf-0003JI-FS
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 23:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbaAYWOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 17:14:21 -0500
Received: from mail-gg0-f176.google.com ([209.85.161.176]:43564 "EHLO
	mail-gg0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbaAYWOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 17:14:20 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jan 2014 17:14:20 EST
Received: by mail-gg0-f176.google.com with SMTP id b1so1670083ggn.7
        for <git@vger.kernel.org>; Sat, 25 Jan 2014 14:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=TiqY8LLYkHnB7FerhocW5dEHHk9N+z8t36s9Dwa+x8U=;
        b=hE102vGhmdIVS+AMrm5vukyvuYOb6i8QtRqc5czLQ4kNtyS346pw4UnCt2kq1NKUuP
         9c+N5bkGLAGefEjCtC9zx/faRB2p4U9nk/OnlobI8hjR+p28yhJfsHKE6Ajwew/6iAvi
         yiLepOh+0Bxzg27ZAYea4ZbI8fAM70jUbzJUUKvX0Qv/j/YnwH/5RLKJ904r0v8sYoEe
         5CceYyc27Buk4V0EqAmFAOs7D3xzSkOl1OdtP4UyCPCck/1436H/0Bka0xSabLfKmDm3
         892o9hN1xsXdHKCpiHf1yFzRAZbdWoftb/5bmAI2wi6CepnX5MKqDSRgfte9lfN6PvkF
         dc8g==
X-Received: by 10.236.131.163 with SMTP id m23mr207196yhi.61.1390687608862;
        Sat, 25 Jan 2014 14:06:48 -0800 (PST)
Received: from mail.pileus.org (76-219-180-192.lightspeed.irvnca.sbcglobal.net. [76.219.180.192])
        by mx.google.com with ESMTPSA id a67sm17289678yhj.10.2014.01.25.14.06.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2014 14:06:48 -0800 (PST)
Received: from andy by mail.pileus.org with local (Exim 4.80.1)
	(envelope-from <andy@pileus.org>)
	id 1W7BNG-0006Nx-Qm; Sat, 25 Jan 2014 22:06:46 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241076>

The current basedir compare aborts early in order to avoid futile
recursive searches. However, a match may still be found by another
pathspec. This can cause an error while checking out files from a branch
when using multiple pathspecs:

$ git checkout master -- 'a/*.txt' 'b/*.txt'
error: pathspec 'a/*.txt' did not match any file(s) known to git.

Signed-off-by: Andy Spencer <andy753421@gmail.com>
---
 tree-walk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tree-walk.c b/tree-walk.c
index 5ece8c3..e06f240 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -743,7 +743,7 @@ match_wildcards:
 
 		if (item->nowildcard_len &&
 		    !match_wildcard_base(item, base_str, baselen, &matched))
-			return entry_not_interesting;
+			continue;
 
 		/*
 		 * Concatenate base and entry->path into one and do
-- 
1.8.5.3
