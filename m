From: David Turner <dturner@twopensource.com>
Subject: [PATCH] verify_pack: do not ignore return value of verification function
Date: Mon, 30 Nov 2015 17:47:42 -0500
Message-ID: <1448923662-24725-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Mon Nov 30 23:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3XEk-0003ZL-Cr
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 23:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbbK3Wry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 17:47:54 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33534 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbbK3Wrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 17:47:53 -0500
Received: by igcmv3 with SMTP id mv3so81495411igc.0
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 14:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WFN9VzU+uaBE17nblm21leF0l7/qWSwO63kKLL4ItTY=;
        b=eYbqZS2aUsM8pOuf+6h+T5wTEbrt1EW3p63gondbbKs3zfTkpegTKp85NfGZow6nax
         IM0jPo2UmdxlCu20UtjLR/jSrJMh/75U/qmNU9JwjEt4vCc6osb2c/jskNJdpnkKIIY3
         ApWkeHPBMPnQbkeRZiy2cNJEWpNvx2mqnwncBKkyLbTYD3Gpx5nGh2g1zohA6x9WilGw
         ohquHhx+376R6NXvzO7pmqWZiV19BY9Knld4fKfTK81LjJpfR7GQzv2rxataVRo3PsmB
         9RNja+ufLGiMUmkFhLjcHVBqU+CeCEkBOeh7MOWq+GIU5Ix9gtMyaeYYm+yFkWzGtmyB
         zkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WFN9VzU+uaBE17nblm21leF0l7/qWSwO63kKLL4ItTY=;
        b=hTHyM7zMUkCVR2/GVVxguRByOlzNWx/SSfljBDxhhy5r3gf4yft19A+GVZpHQmOoFr
         bF+dmMW0V74imLKqjloQdIlSPmStmZnvCgyfbT8NasbO7P9Ma4dPOhQK5JQ+VFp1fYwx
         mPD/aUb1xLPkR04iF1q6uw1HUCSjlhsp8ILNZrs7kvA4f8J9ao5TWsVSgUE8yl0Pwi5x
         agOs5RUhptSyueZI6a2rhG3CCk+HW9/VHUYWy0nd01UzBCurd0oP/kUz3erquzT8Z6U2
         uBT3q3Gq8ZZsmef8iu5anw7OuElSJOIsT4AXlSuiA49g5xKPRVrGPg2cDOoOXAL++QNy
         fgWQ==
X-Gm-Message-State: ALoCoQmByJeNzVX3ADwy5ypqS3ZeW49HUN10kVfWudDW0Gjr1BFIeK8cXHKbFgV8r2ISIUrmGzau
X-Received: by 10.50.127.148 with SMTP id ng20mr11541704igb.32.1448923673011;
        Mon, 30 Nov 2015 14:47:53 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id b3sm8711043igf.17.2015.11.30.14.47.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Nov 2015 14:47:52 -0800 (PST)
X-Mailer: git-send-email 2.4.2.736.g391bb05-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281822>

In verify_pack, a caller-supplied verification function is called.
The function returns an int.  If that return value is non-zero,
verify_pack should fail.

The only caller of verify_pack is in builtin/fsck.c, whose verify_fn
returns a meaningful error code (which was then ignored).  Now, fsck
might return a different error code (with more detail).  This would
happen in the unlikely event that a commit or tree that is a valid git
object but not a valid instance of its type gets into a pack.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 pack-check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-check.c b/pack-check.c
index 63a595c..433bd86 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -126,7 +126,7 @@ static int verify_packfile(struct packed_git *p,
 				    sha1_to_hex(entries[i].sha1), p->pack_name);
 		else if (fn) {
 			int eaten = 0;
-			fn(entries[i].sha1, type, size, data, &eaten);
+			err |= fn(entries[i].sha1, type, size, data, &eaten);
 			if (eaten)
 				data = NULL;
 		}
-- 
2.4.2.736.g391bb05-twtrsrc
