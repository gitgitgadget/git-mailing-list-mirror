From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/18] rerere: stop looping unnecessarily
Date: Fri, 17 Jul 2015 15:24:29 -0700
Message-ID: <1437171880-21590-8-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE3z-00049A-9H
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169AbbGQWY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:24:56 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35700 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbbGQWYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:53 -0400
Received: by pactm7 with SMTP id tm7so67787476pac.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=otQzCh8HYad1e6wLuCn27hllEZTShxmSjGqv1lpHKWg=;
        b=h3BWlLwul5DVTI7SurXEcfJ8uZhZPjQ/kR8bRaY4sxeRxs0hjoIq7qDwpSbI4Jz6UL
         Ubii1qeizJQdGaazeG71TnCN0J+cuLlLS8FAcOmMl6EbKf6wgFGLcXeAptZ/9Q80oCiJ
         9s4e+c0RWLJpxTJdhbtswHVym/18yUNVxwnMVHbr2WViqcWGr1Al2RU6ue5cM3Fh4ohf
         xpLumRihrAoOCJn/k97KkEqzn6YvUMCOXblmybF+J7Hz4iBqvjosF5Ky0kw/PD7f3W47
         GIH9wLcIvmf24S99X2S5MwD6J7paezuO2rEASibe+6w+i2H+HYg06hkoOrZrPFB3QuTB
         4/4g==
X-Received: by 10.70.126.133 with SMTP id my5mr26399894pdb.14.1437171893428;
        Fri, 17 Jul 2015 15:24:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id vl1sm12379730pab.21.2015.07.17.15.24.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274114>

handle_cache() loops 3 times starting from an index entry that is
unmerged, while ignoring an entry for a path that is different from
what we are looking for.

As the index is sorted, once we see a different path, we know we saw
all stages for the path we are interested in.  Just loop while we
see the same path and then break, instead of continuing for 3 times.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/rerere.c b/rerere.c
index 4c45f55..7b1419c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -329,24 +329,21 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 		return -1;
 	pos = -pos - 1;
 
-	for (i = 0; i < 3; i++) {
+	while (pos < active_nr) {
 		enum object_type type;
 		unsigned long size;
-		int j;
 
-		if (active_nr <= pos)
-			break;
 		ce = active_cache[pos++];
 		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
-			continue;
-		j = ce_stage(ce) - 1;
-		mmfile[j].ptr = read_sha1_file(ce->sha1, &type, &size);
-		mmfile[j].size = size;
+			break;
+		i = ce_stage(ce) - 1;
+		mmfile[i].ptr = read_sha1_file(ce->sha1, &type, &size);
+		mmfile[i].size = size;
 	}
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < 3; i++)
 		if (!mmfile[i].ptr && !mmfile[i].size)
 			mmfile[i].ptr = xstrdup("");
-	}
+
 	/*
 	 * NEEDSWORK: handle conflicts from merges with
 	 * merge.renormalize set, too
-- 
2.5.0-rc2-340-g0cccc16
