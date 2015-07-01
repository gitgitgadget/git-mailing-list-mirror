From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/13] rerere: write out each record of MERGE_RR in one go
Date: Tue, 30 Jun 2015 23:04:50 -0700
Message-ID: <1435730699-9124-5-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:05:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB9B-0004Kz-W4
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbbGAGFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:19 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35440 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbGAGFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:06 -0400
Received: by iecuq6 with SMTP id uq6so27808538iec.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=WTyfcSK2vFyuCocqF2lZ/J1Bi/PfDnOCEVc/47XMEsc=;
        b=gkBt/w+zrSK9TLuGREVoyDTJLEAFSHfHKRwucXWdn0YRu/w6wkaM44THiiIQtf9EPS
         /m7X0126wsT84h3ui12t8OCuM2MVWSgI3JBol/SW3HL5B5tUFtPk7KgPhxL3Ba0DOsuF
         rAlVp+4HEAjK7h7qPVO2aO43f1dyZ5EzAUt5NnhnSAQZ/R4U+HMJMRmyXW0eIlVs0eLQ
         m335RuAirGsjgCZBXJPpH3cStm3kBch0FSNhlqbhhDw1o5CgFgsWUl6JoJVJqA+8PdEf
         Bf7d86xZ33cmUeebYGsHi183M6sDn2s+ni159Ul0VKrIa5GBUvGwDcMfH/Yw2n/Wa3xj
         NtxA==
X-Received: by 10.50.20.200 with SMTP id p8mr2354403ige.28.1435730706558;
        Tue, 30 Jun 2015 23:05:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id g1sm696548iog.4.2015.06.30.23.05.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273122>

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
2.5.0-rc0-209-g5e1f148
