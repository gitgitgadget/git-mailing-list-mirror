From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 3/5] tree-walk: micro-optimization in tree_entry_interesting
Date: Wed, 30 Mar 2011 20:37:59 -0500
Message-ID: <1301535481-1085-3-git-send-email-dpmcgee@gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:38:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56qQ-0003Um-EC
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878Ab1CaBiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:38:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933830Ab1CaBiK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:38:10 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so1864765iwn.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=I0VrZsjUCGyeCq/+xv/MrcjTjVspVtlLPoUs5VHztGk=;
        b=KNVzv3vRlW1ZjFOfOy7B/fTGDrp3pltV7Xoazr59mZdOBdhKJKCIVN8hUZL2KWHb+9
         oFmPZfKw3gIQpt4Ya1NZU7Vz2buXWxQegYhrJfQlxmVH7JRKfEpZqW1Ru/THIcH2s1LB
         kTgQ4UTgL3RiqaNn6p7HeiBOA4UGCXClwdiA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=csmCovNVeZMTiFPFCMvRU4iTtsyNpAP/faYvpdMJzh0ZoGwWsdoQHrXEbcTKlNBkA1
         BnEnG8ZX9B6Pt9zfdwUgI/TPLZGXzV0dqzi9MN1mL+gednE8qLTzVnu9C/UozvllSz4B
         vY2rZSBVwlw3yiObgmqSe9MT9DZjuF/b7hSNQ=
Received: by 10.42.77.8 with SMTP id g8mr1891048ick.478.1301535490119;
        Wed, 30 Mar 2011 18:38:10 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id vr5sm281563icb.12.2011.03.30.18.38.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:38:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170445>

In the case of a wide breadth top-level tree (~2400 entries, all trees
in this case), we can see a noticeable cost in the profiler calling
strncmp() here. Most of the time we are at the base level of the
repository, so base is "" and baselen == 0, which means we will always
test true. Break out this one tiny case so we can short circuit the
strncmp() call.

This resulted in an ~11% improvement (43 to 38 secs) for a reasonable
log operation on the Arch Linux Packages SVN clone repository, which
contained 117220 commits and the aforementioned 2400 top-level objects:
    git log -- autogen/trunk pacman/trunk/ wget/trunk/

Negligible slowdown was noted with other repositories (e.g. linux-2.6).

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 tree-walk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 9be8007..f386151 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -591,8 +591,8 @@ int tree_entry_interesting(const struct name_entry *entry,
 					      ps->max_depth);
 		}
 
-		/* Does the base match? */
-		if (!strncmp(base_str, match, baselen)) {
+		/* Either there must be no base, or the base must match. */
+		if (baselen == 0 || !strncmp(base_str, match, baselen)) {
 			if (match_entry(entry, pathlen,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
-- 
1.7.4.2
