From: Faiz Kothari <faiz.off93@gmail.com>
Subject: [PATCH] Problem in bulk-checkin.c:finish_bulk_checkin() Unable to fix
Date: Fri, 28 Feb 2014 05:34:09 +0530
Message-ID: <1393545849-26775-1-git-send-email-faiz.off93@gmail.com>
Cc: artagnon@gmail.com, Faiz Kothari <faiz.off93@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 01:04:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJAwJ-0002A4-D1
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 01:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbaB1AE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 19:04:27 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:42788 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaB1AE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 19:04:26 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so3183121pad.41
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 16:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=n0CnT5DgsfPX7Mk6CgELhSu3kFcMIfnsBKWUe+1DkiI=;
        b=jWrOJTLCLdJPD/7CmCI7CzUEhrxUtqbsZAUKiuF8I7qNxp9TSleluf3BkoIv9eLEtk
         Ssj12cRRUWvlUPdW+ypp/KqWg8FSwXbnlerjlElvlyyJBMpC7gqSO7B8U78qrngc6FW5
         YRv017YjoSKKPR/RCPFTcNw/ci4JPs3Pi2CbkV7O5gp3iLvPWqoPXdHocbgt2kKOGLnD
         yKuqH2sObEsYJWx4P39YTrl38a4qS4+5UDHVCW/xVEVgLmaQLOHzOMpNMlWN8A2LT/sa
         EgRX7uyLIniUhhUzZUxDwHLTGtHG9mL2rKVXJuMXRI2bdFvxi4POQsyXvHOWodvK4uGY
         QaqA==
X-Received: by 10.68.191.200 with SMTP id ha8mr16346413pbc.66.1393545866047;
        Thu, 27 Feb 2014 16:04:26 -0800 (PST)
Received: from dj-pc.bits-goa.ac.in ([115.248.130.148])
        by mx.google.com with ESMTPSA id c7sm17580426pbt.0.2014.02.27.16.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 16:04:25 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242877>

Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
---
Compiles without errors.
Fails in test t/t1050-large.sh ,fails 12/15 tests. Dumps memory map and backtrace.
Somewhere its not able to free(): invalid pointer.
Please somone pointout where I am doing it wrong.
Help is really appreciated.
Thanks.

 bulk-checkin.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 118c625..c76cd6b 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -23,7 +23,7 @@ static struct bulk_checkin_state {
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
 	unsigned char sha1[20];
-	char packname[PATH_MAX];
+	struct strbuf packname = STRBUF_INIT;
 	int i;
 
 	if (!state->f)
@@ -42,9 +42,8 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 					 state->offset);
 		close(fd);
 	}
-
-	sprintf(packname, "%s/pack/pack-", get_object_directory());
-	finish_tmp_packfile(packname, state->pack_tmp_name,
+	strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
+	finish_tmp_packfile(packname.buf, state->pack_tmp_name,
 			    state->written, state->nr_written,
 			    &state->pack_idx_opts, sha1);
 	for (i = 0; i < state->nr_written; i++)
@@ -53,6 +52,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 clear_exit:
 	free(state->written);
 	memset(state, 0, sizeof(*state));
+	strbuf_release(&packname);
 
 	/* Make objects we just wrote available to ourselves */
 	reprepare_packed_git();
-- 
1.7.9.5
