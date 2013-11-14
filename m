From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 01/14] submodule: don't access the .gitmodules cache entry
 after removing it
Date: Thu, 14 Nov 2013 20:17:16 +0100
Message-ID: <528521BC.8080908@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:17:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2Po-0006VS-M3
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375Ab3KNTRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:17:17 -0500
Received: from mail-we0-f175.google.com ([74.125.82.175]:51805 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab3KNTRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:17:16 -0500
Received: by mail-we0-f175.google.com with SMTP id t60so2486354wes.6
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4IbCUm/8WvZB//hV9i8W78NfMxo3kI9uhoViKhASzas=;
        b=FPEmyEwut63R3MVPuIhrzSAjvdjEo+5WGj4lO6k2AP206vfc9eoHKVcBWBfe71R5nY
         EPl+qsDJ/iftNK3TJqoJ+EdYt2WtIXsgA7jClVJx4XYO/hpv42elts6gxrfFAo/Tv1Kj
         K1PiQYnDKlKm3PqA+i3Zdg23kD+l+kbwBCb+MfFx/QPIWM6Op5krAAMFhVdjbIJ6hVbi
         zWzCmOs0x1/2m2E+lmO0vdW1chrp3hlJmi4OJzzdogZZzx3R7CZP6twi6cC0cIgUK9hI
         ScjyfPnXo73hPD3AkM2O+lDnwqEUanhTiRwTw2XwX32eJZU5yCICBdLFbruZfeJytgBb
         EvTw==
X-Received: by 10.180.198.5 with SMTP id iy5mr4221060wic.45.1384456634943;
        Thu, 14 Nov 2013 11:17:14 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id hv5sm1435802wib.2.2013.11.14.11.17.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:17:14 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237861>

From: Jens Lehmann <Jens.Lehmann@web.de>

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
1.8.5.rc0.333.g5394214
