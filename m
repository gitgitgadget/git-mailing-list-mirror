From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 05/44] builtin/apply: make parse_chunk() return a negative integer on error
Date: Fri, 10 Jun 2016 22:10:39 +0200
Message-ID: <20160610201118.13813-6-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSoY-0004eF-55
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbcFJUNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:13:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36752 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbcFJULs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id m124so1033186wme.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qv6HszpWB/y06lIP12FNw4JRtmS/hv8Hqth/3S+Nj3E=;
        b=RRekamaOmzb2j4Zf2iCmpKI3AXVnIgSZp+SxcvzI+InwP06GuDeZ4PQ3tW+eduUAwu
         FgGpk1QB6FEgXTgng64Fml1DLDyAQOapcE5Z9SNRvS2M0L4TfHn81cRbDtyY0StCvYwH
         oZB/vWEJddpNaAnp+Zy/7iaSCbz8gMV+wQer+2sHWdmVTOC/hiwGwyEmg0j2KtMEbzap
         v1JVYDInvNUG0rJMpEvHd/mIpyjdi10m3SrEH8yhTykOXMANIW42U/QWdi5GorHULnU/
         zGVETjUFTAfEW8aOfbCxzipT+NQWmS3dGd/z80ukOQH6CMt/nhDeWW5ly1Lxq0rbvjM+
         QsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qv6HszpWB/y06lIP12FNw4JRtmS/hv8Hqth/3S+Nj3E=;
        b=kdIMlKekRG6GbLtytN0flQKJ7qqL6v4Ug6b81ELIMXfZxIWp27/cSz+xUGdGsCw2ks
         VSyN3ebzPrGgZn9J2chtP7DmY/1CeAMdi+ME9MEQbaAUSBd1TzMmfd1kEqsRwGFLn2FT
         SeAQU15JEaBMqJDBpaUhvnYtGC5J3Tx8TC951XQuxfZEIHTq2c3KHKLzMdymw39DQida
         9hGqu4cB9kOFCSKJFFztd45SlcfdO25hX7YwMgWZRR8+/i7fkBdGzrW7WxMk/EbNyht3
         002Xs52EtMaNOi+3XcY9mNCHWjqfHNTlCcTdrZCl6jyJISusgypPFgjjpsBR8wfd+UMN
         0tIw==
X-Gm-Message-State: ALyK8tL89vEpRFavA68z8U7z1lQ5rrQksqUjTyWP6u6+4p2mk1O73YkmpH1ThhOqhAqrRg==
X-Received: by 10.28.23.143 with SMTP id 137mr651615wmx.89.1465589506781;
        Fri, 10 Jun 2016 13:11:46 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:46 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297066>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing or exit()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, parse_chunk() should return -1 instead of calling
die() or exit().

As parse_chunk() is called only by apply_patch() which already
returns -1 when an error happened, let's make apply_patch() return -1
when parse_chunk() returns -1.

If find_header() returns -2 because no patch header has been found, it
is ok for parse_chunk() to also return -2. If find_header() returns -1
because an error happened, it is ok for parse_chunk() to do the same.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 630c01c..a160338 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1991,22 +1991,22 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	return !state->has_include;
 }
 
-
 /*
  * Read the patch text in "buffer" that extends for "size" bytes; stop
  * reading after seeing a single patch (i.e. changes to a single file).
  * Create fragments (i.e. patch hunks) and hang them to the given patch.
- * Return the number of bytes consumed, so that the caller can call us
- * again for the next patch.
+ *
+ * Returns:
+ *   -1 on error,
+ *   -2 if no header was found,
+ *   the number of bytes consumed otherwise,
+ *     so that the caller can call us again for the next patch.
  */
 static int parse_chunk(struct apply_state *state, char *buffer, unsigned long size, struct patch *patch)
 {
 	int hdrsize, patchsize;
 	int offset = find_header(state, buffer, size, &hdrsize, patch);
 
-	if (offset == -1)
-		exit(1);
-
 	if (offset < 0)
 		return offset;
 
@@ -2067,7 +2067,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		 */
 		if ((state->apply || state->check) &&
 		    (!patch->is_binary && !metadata_changes(patch)))
-			die(_("patch with only garbage at line %d"), state->linenr);
+			return error(_("patch with only garbage at line %d"), state->linenr);
 	}
 
 	return offset + hdrsize + patchsize;
@@ -4449,6 +4449,10 @@ static int apply_patch(struct apply_state *state,
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
+			if (nr == -1) {
+				res = -1;
+				goto end;
+			}
 			break;
 		}
 		if (state->apply_in_reverse)
-- 
2.9.0.rc2.362.g3cd93d0
