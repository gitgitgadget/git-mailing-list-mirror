From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 01/14] submodule: don't access the .gitmodules cache entry
 after removing it
Date: Thu, 07 Nov 2013 15:33:43 +0100
Message-ID: <527BA4C7.4020700@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQeX-0002jG-Ro
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab3KGOdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:33:42 -0500
Received: from mail-ee0-f43.google.com ([74.125.83.43]:43903 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab3KGOdl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:33:41 -0500
Received: by mail-ee0-f43.google.com with SMTP id b47so346396eek.2
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oMdVn/ajQwbKp/c53t8NN8Cqx1mZ3HXlX9R8pAq5XSE=;
        b=z1gIsq/YeVrq8vMCl18oUUl0p3JzdBPFCFkYV6c9/5pJcNNbOFPEZE9jEhd/OS/cGC
         OfhT4sa0NOsVZIytV7dm4BD+PV0uK+1N5YVIC/Z/Z58wwsRoE1YC1Y+kYxRZupuQEmrN
         TEahbQihck3yOL+7hceYBkymETAv39YF2/Mmkpq0Lu1zzVBlqjeKv3N8U9V5dOFQ6xFc
         Jkb25MSGxDExen1S1C2pZTma8sG3CAWEIyG4OgK0AvN3g06Dcl5t4q5rfeBiF62HbKPP
         ZPmCeLV+SAbPB8nwWfMxnPqxYaYP9PLTjjC1sUD1ylbfY/c5BnZxQpCaz/Feu0Ck8YoR
         p7Og==
X-Received: by 10.14.224.132 with SMTP id x4mr9897621eep.5.1383834820329;
        Thu, 07 Nov 2013 06:33:40 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id m54sm1697612eex.2.2013.11.07.06.33.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:33:39 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237396>

Commit 5fee995244e introduced the stage_updated_gitmodules() function to
add submodule configuration updates to the index. It assumed that even
after calling remove_cache_entry_at() the same cache entry would still be
valid. This was true in the old days, as cache entries could never be
freed, but that is not so sure in the present as there is ongoing work to
free removed cache entries, which makes this code segfault.

Fix that by calling add_file_to_cache() instead of open coding it. Also
remove the "could not find .gitmodules in index" warning, as that won't
happen in regular use cases (and by then just silently adding it to the
index we do the right thing).

Thanks-to: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1905d75..e388487 100644
--- a/submodule.c
+++ b/submodule.c
@@ -116,30 +116,7 @@ int remove_path_from_gitmodules(const char *path)
 
 void stage_updated_gitmodules(void)
 {
-	struct strbuf buf = STRBUF_INIT;
-	struct stat st;
-	int pos;
-	struct cache_entry *ce;
-	int namelen = strlen(".gitmodules");
-
-	pos = cache_name_pos(".gitmodules", namelen);
-	if (pos < 0) {
-		warning(_("could not find .gitmodules in index"));
-		return;
-	}
-	ce = active_cache[pos];
-	ce->ce_flags = namelen;
-	if (strbuf_read_file(&buf, ".gitmodules", 0) < 0)
-		die(_("reading updated .gitmodules failed"));
-	if (lstat(".gitmodules", &st) < 0)
-		die_errno(_("unable to stat updated .gitmodules"));
-	fill_stat_cache_info(ce, &st);
-	ce->ce_mode = ce_mode_from_stat(ce, st.st_mode);
-	if (remove_cache_entry_at(pos) < 0)
-		die(_("unable to remove .gitmodules from index"));
-	if (write_sha1_file(buf.buf, buf.len, blob_type, ce->sha1))
-		die(_("adding updated .gitmodules failed"));
-	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
+	if (add_file_to_cache(".gitmodules", 0))
 		die(_("staging updated .gitmodules failed"));
 }
 
-- 
1.8.4.msysgit.0.12.g88f5ed0
