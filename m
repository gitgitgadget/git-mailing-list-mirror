From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH] read_index_from(): catch out of order entries when reading an index file
Date: Fri, 29 Aug 2014 10:54:41 +0200
Message-ID: <1409302481-4914-1-git-send-email-jsorianopastor@gmail.com>
References: <CAPig+cS__Sw1gNj3Pz20OC51QBsuxBEXTzMStAerwfMuT2afQg@mail.gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 10:56:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNHyg-0005sA-IP
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 10:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbaH2I4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 04:56:09 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:36150 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaH2I4H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 04:56:07 -0400
Received: by mail-we0-f178.google.com with SMTP id u57so1900856wes.37
        for <git@vger.kernel.org>; Fri, 29 Aug 2014 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q4MH8Kq0ns3658/4rixrXo1v7MMlz0cibQ35V2CahQo=;
        b=r0Jmi8M82qQs1kjrSdxdhhGy6P/vEEi9Xg7c73hNehM4wkABOInljpD5T5RMzphZhi
         J1nFRHls1v4Ce8lMiY+E3zdZN+wvlF9NmEyuPNi8kyuHsw5n378HqvnqzHd11idqNW0s
         N7xxNx9jgjpBRiQuXe1z5SRHjrFE9ADpz6Gpi9ISbf9Lgm6B8ZHjw1Lxh1qUWz6f1Wee
         fkJYP38jwn0hRyFBs9MRf3wd5YWV+rWmoFWjC7ZbdByNJ3CZtxHr72228w4a0oBXEbZ1
         r1qshMTXOwf9rzKlo4slqMzaGTEU2EzmiX2cWazsFNi082dpysv6I36qa6yfX+wTd6u4
         qAHA==
X-Received: by 10.194.59.42 with SMTP id w10mr11897918wjq.15.1409302565879;
        Fri, 29 Aug 2014 01:56:05 -0700 (PDT)
Received: from ubuntu-jsoriano.tuenti.local (240.red-80-28-193.adsl.static.ccgg.telefonica.net. [80.28.193.240])
        by mx.google.com with ESMTPSA id s14sm24034566wik.23.2014.08.29.01.56.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 Aug 2014 01:56:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.1.gca370f9.dirty
In-Reply-To: <CAPig+cS__Sw1gNj3Pz20OC51QBsuxBEXTzMStAerwfMuT2afQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256139>

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 read-cache.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 5d3c8bd..023d6d7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1465,6 +1465,21 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
+static void check_ce_order(struct cache_entry *ce, struct cache_entry *next_ce)
+{
+	int name_compare = strcmp(ce->name, next_ce->name);
+	if (0 < name_compare)
+		die("unordered stage entries in index");
+	if (!name_compare) {
+		if (!ce_stage(ce))
+			die("multiple stage entries for merged file '%s'",
+				ce->name);
+		if (ce_stage(ce) > ce_stage(next_ce))
+			die("unordered stage entries for '%s'",
+				ce->name);
+	}
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -1526,6 +1541,9 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		ce = create_from_disk(disk_ce, &consumed, previous_name);
 		set_index_entry(istate, i, ce);
 
+		if (i > 0)
+			check_ce_order(istate->cache[i - 1], ce);
+
 		src_offset += consumed;
 	}
 	strbuf_release(&previous_name_buf);
-- 
2.0.4.1.gca370f9.dirty
