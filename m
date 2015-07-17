From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/18] rerere: write out each record of MERGE_RR in one go
Date: Fri, 17 Jul 2015 15:24:26 -0700
Message-ID: <1437171880-21590-5-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:24:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE3u-00046y-1r
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157AbbGQWYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:24:53 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34393 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbbGQWYt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:49 -0400
Received: by pacan13 with SMTP id an13so67686201pac.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=H0ye38vB0na6Yrk8DctoGALm3Ijd2kHZaKxtTeXVp/8=;
        b=YOH8ktEXjPblUuCEw1ELpThtaXuWk8cCKMgwvjjOED9SDBe2nQuHZkipHWK/AJFI/O
         1zwxqehtk/iUxhaae31j43dQWpDNLhxGGGk55CuXgRS6ug+/qRvNH2iBfmHtfe8WDVDv
         ssGAk0xKXIY8sdeVrVh3weps0D9l7JUqxpXLNVYYgPA+aw8lhOIhnvF/N8zed7ph5WVP
         Zn/UgpESUdNNXb3eLo+edrhJdUhl9CDeRPuCAbIWC9yi7NjxlYj2iSwtfP+Sc2OJnw27
         ytCBOZqkBplj+eI4UGFcskFFkA2upz3cWdqmcYLTXRlN2skBf8BqT+5ghyeFcytTPn/c
         Vpdw==
X-Received: by 10.66.136.172 with SMTP id qb12mr8629097pab.84.1437171888790;
        Fri, 17 Jul 2015 15:24:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id oa14sm12342928pdb.47.2015.07.17.15.24.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:48 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274112>

Instead of writing the hash for a conflict, a HT, and the path
with three separate write_in_full() calls, format them into a
single record into a strbuf and write it out in one go.

As a more recent "rerere remaining" codepath abuses the .util field
of the merge_rr data to store a sentinel token, make sure that
codepath does not call into this function (of course, "remaining" is
a read-only operation and currently does not call it).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/rerere.c b/rerere.c
index e854985..27b287d 100644
--- a/rerere.c
+++ b/rerere.c
@@ -65,16 +65,18 @@ static int write_rr(struct string_list *rr, int out_fd)
 {
 	int i;
 	for (i = 0; i < rr->nr; i++) {
-		const char *path;
-		int length;
+		struct strbuf buf = STRBUF_INIT;
+
+		assert(rr->items[i].util != RERERE_RESOLVED);
 		if (!rr->items[i].util)
 			continue;
-		path = rr->items[i].string;
-		length = strlen(path) + 1;
-		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
-		    write_str_in_full(out_fd, "\t") != 1 ||
-		    write_in_full(out_fd, path, length) != length)
+		strbuf_addf(&buf, "%s\t%s%c",
+			    (char *)rr->items[i].util,
+			    rr->items[i].string, 0);
+		if (write_in_full(out_fd, buf.buf, buf.len) != buf.len)
 			die("unable to write rerere record");
+
+		strbuf_release(&buf);
 	}
 	if (commit_lock_file(&write_lock) != 0)
 		die("unable to write rerere record");
-- 
2.5.0-rc2-340-g0cccc16
