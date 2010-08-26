From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 5/8] tree_entry_interesting(): Make return value more specific
Date: Thu, 26 Aug 2010 00:21:48 -0600
Message-ID: <1282803711-10253-6-git-send-email-newren@gmail.com>
References: <1282803711-10253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 08:21:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVpV-0002cj-Nl
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 08:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab0HZGUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 02:20:35 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47237 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0HZGUe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 02:20:34 -0400
Received: by ywh1 with SMTP id 1so200832ywh.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 23:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RDceEYxIzggVPMmbnt26wQI6MR5S7WgeuflBWSwi7LM=;
        b=M/MsSG2RwlzsAe28rLwJKTyAWYovdeN7ehia72sidjOwLCtO/qOfzrYk0P4rkDtkS9
         Lo7Nqm979nkv7LWzHy1pCohemAkJaRsHlAz/vaP4NYtqCTYDWwKh88hok0kt/KAvGLyo
         EVBmstDPKkxrNsDDaoJQAfrxroI73BLXuIU5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UGnXydqKCYlHykLXRlu5pEtTLIWZ5kH/IXF6ooLDsi4dizC7BrOoa6h3Gl3e6GaYtZ
         akH4xv4WlMLKxeV31H4mhzjEwqscmf4HGa1u/ThigiLirtGfPyD3SOCpXXD0iJac+NO7
         pGR/HIHlLq+LKiXNcXtYqeacKUBWeM0dXzW2E=
Received: by 10.151.78.6 with SMTP id f6mr9444020ybl.240.1282803633343;
        Wed, 25 Aug 2010 23:20:33 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t20sm7160156ybm.5.2010.08.25.23.20.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 23:20:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.45.ga60f
In-Reply-To: <1282803711-10253-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154522>

tree_entry_interesting() can signal to its callers not only if the given
entry matches one of the specified paths, but whether all remaining paths
will (or will not) match.  When no paths are specified, all paths are
considered interesting, so intead of returning 1 (this path is interesting)
return 2 (all paths are interesting).

This will allow the caller to avoid calling tree_entry_interesting() again,
which theoretically should speed up tree walking.  I am not able to measure
any actual gains in practice, but it certainly can not hurt and seems to
make the code more readable to me.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 tree-diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 75b1480..bac5008 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -103,7 +103,7 @@ int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen
 	int never_interesting = -1;
 
 	if (!opt->nr_paths)
-		return 1;
+		return 2;
 
 	sha1 = tree_entry_extract(desc, &path, &mode);
 
-- 
1.7.2.2.45.ga60f
