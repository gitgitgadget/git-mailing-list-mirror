From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH] Check order when reading index
Date: Thu, 21 Aug 2014 15:43:26 +0200
Message-ID: <1408628606-12975-1-git-send-email-jsorianopastor@gmail.com>
References: <CAPuZ2NEksZzt29XpAaszK8oc4iXH4OTGzRSsHUrtwgrv6bU_0Q@mail.gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 15:43:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKSee-0006M9-K1
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 15:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbaHUNns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 09:43:48 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:58686 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782AbaHUNnr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 09:43:47 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so9122691wgh.17
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qiZ0QqSuwy+CpfIkShs8FzmCpjHYmW+ILo44xCiIE1A=;
        b=GijcSYM+tKiFcK9P6jTAR+cEtfB+ssKz9Qxr/UCm8glL4tqY0QuM4icubQYQWglizj
         0G6A1XwMS0OJm52Hsa5vXjgm89eJexrP3ClIF8dG0pvZLDGDUPZJOBvA/0SBrt1VJFKj
         OyGMMoKAc0I9bbL7I1df02zqZa2qLShs40raX7J2KQgDvbeXVARnM/mOmlP5fAo58+kL
         KkojRA3XbVT1gA8bw0sWlTiMEb9FIlMUlGmWDhM+pAP+psK4jEI+KVBzH+0nWMNfSnXy
         dEkORKh4LF9M+Qajo7o6dMKRz6cW0AHySkDn5TromVpJKdnrRMf9x1DPxS8AqarGBqtx
         cDeA==
X-Received: by 10.194.2.12 with SMTP id 12mr66179371wjq.54.1408628626213;
        Thu, 21 Aug 2014 06:43:46 -0700 (PDT)
Received: from ubuntu-jsoriano.tuenti.local (50.red-80-26-152.adsl.static.ccgg.telefonica.net. [80.26.152.50])
        by mx.google.com with ESMTPSA id wi9sm66863527wjc.23.2014.08.21.06.43.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 Aug 2014 06:43:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.dirty
In-Reply-To: <CAPuZ2NEksZzt29XpAaszK8oc4iXH4OTGzRSsHUrtwgrv6bU_0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255612>

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 read-cache.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 7f5645e..e117d3a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1438,6 +1438,21 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
+void check_next_ce(struct cache_entry *ce, struct cache_entry *next_ce) {
+	if (!ce || !next_ce)
+		return;
+	if (cache_name_compare(ce->name, ce_namelen(ce),
+						   next_ce->name, ce_namelen(next_ce)) > 1)
+		die("Unordered stage entries in index");
+	if (ce_same_name(ce, next_ce)) {
+		if (!ce_stage(ce))
+			die("Multiple stage entries for merged file '%s'",
+				ce->name);
+		if (ce_stage(ce) >= ce_stage(next_ce))
+			die("Unordered stage entries for '%s'", ce->name);
+	}
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1499,6 +1514,9 @@ int read_index_from(struct index_state *istate, const char *path)
 		ce = create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
 
+		if (i > 0)
+			check_next_ce(istate->cache[i-1], ce);
+
 		src_offset += consumed;
 	}
 	strbuf_release(&previous_name_buf);
-- 
2.0.4.dirty
