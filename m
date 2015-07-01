From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/13] rerere: fix an off-by-one non-bug
Date: Tue, 30 Jun 2015 23:04:47 -0700
Message-ID: <1435730699-9124-2-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:05:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB92-0004E7-Mk
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbbGAGFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:12 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35400 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbbGAGFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:03 -0400
Received: by iecuq6 with SMTP id uq6so27807578iec.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=YqrUnp8DcTtAawAaZYGJoCrpfOiR4RbfVhhCol353Uw=;
        b=SZSi45/qGtpq48lJUWL53/fojE+n/wSQ50t8/c4Bc0ChR/3piX7zuoRG582TtsX7Cz
         +DgZ1Mgd4waT30HoSAqhLlv5ALdE7xNI0gfFEFC/Doddek58TlKYAwajGKIbAtOi+81r
         hy0mARoOVnQmsxW/gRrcIb+jqDv4X8jbK7yHht5t4wcICPmx6D4AyYLMaLcpVfCJ/s05
         +ypyMpuom3E7Z1n7Qsa7CH/QrKvWWlAxwmAjZum3FHEypiGmr98tRXbC7huTZoqFJHPb
         odjL2+dySkU11s0J/Ej+hp70+bZyWmakQuKV90Z5jbmSFWMl+MfnoSx8h7dfFZ0QnLWe
         y2yg==
X-Received: by 10.50.30.196 with SMTP id u4mr2368155igh.11.1435730702258;
        Tue, 30 Jun 2015 23:05:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id 196sm681143ioe.23.2015.06.30.23.05.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:01 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273120>

When ac49f5ca (rerere "remaining", 2011-02-16) split out a new
helper function check_one_conflict() out of find_conflict()
function, so that the latter will use the returned value from the
new helper to update the loop control variable that is an index into
active_cache[], the new variable incremented the index by one too
many when it found a path with only stage #1 entry at the very end
of active_cache[].

This "strange" return value does not have any effect on the loop
control of two callers of this function, as they all notice that
active_nr+2 is larger than active_nr just like active_nr+1 is, but
nevertheless it puzzles the readers when they are trying to figure
out what the function is trying to do.

In fact, there is no need to do an early return.  The code that
follows after skipping the stage #1 entry is fully prepared to
handle a case where the entry is at the very end of active_cache[].

Help future readers from unnecessary confusion by dropping an early
return.  We skip the stage #1 entry, and if there are stage #2 and
stage #3 entries for the same path, we diagnose the path as
THREE_STAGED (otherwise we say PUNTED), and then we skip all entries
for the same path.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rerere.c b/rerere.c
index 31644de..e307711 100644
--- a/rerere.c
+++ b/rerere.c
@@ -369,10 +369,8 @@ static int check_one_conflict(int i, int *type)
 	}
 
 	*type = PUNTED;
-	if (ce_stage(e) == 1) {
-		if (active_nr <= ++i)
-			return i + 1;
-	}
+	if (ce_stage(e) == 1)
+		i++;
 
 	/* Only handle regular files with both stages #2 and #3 */
 	if (i + 1 < active_nr) {
-- 
2.5.0-rc0-209-g5e1f148
