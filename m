From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] pack-bitmap: do not core dump
Date: Tue, 22 Apr 2014 15:53:02 -0700
Message-ID: <781073ea08e86301f62e708bc0b80fd@74d39fa044aa309eaea14b9f57fe79c>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:53:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcjZ0-0000dC-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbaDVWxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:53:13 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39622 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbaDVWxL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:53:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so104062pbb.19
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 15:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=usoe5EpGYPoCbmLJDbtVQjWglZppBnsO+ptFuvieZFQ=;
        b=rul2CqD4DCgzyzZgRNf6cTdun+8QwqK+6s2RXFOylsjRFFotTkQDMHihd7q8n1ai/t
         GDTVw4vMIEEFUbN81kCX9ZNLE/iachS+PBzXsYZK1r0/mQ5ReuWkuTrTtoO9YHY+SvhH
         5OS5BicaDz0rsz0Ez8OKjgEpRxFm9G3HAZDsSjtjhVoB54wxUjsdwU5GSoI5fK62BGa9
         P2iwP7VRjalPGfI0bw4z5qKcKlsnmZTX79Mi+wdI+PMVGGOCdVTtP8PjALDmiGkNABhD
         d/gEcHx9cCJISaLNlqOtGNa1eALLpexpyVgd8IomatAKPx0+33Ky/TO82YqUyb/oGEwE
         wERA==
X-Received: by 10.68.226.35 with SMTP id rp3mr48258590pbc.73.1398207190861;
        Tue, 22 Apr 2014 15:53:10 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id c6sm2375563pbt.38.2014.04.22.15.53.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 15:53:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246802>

So I was trying to use pack.writebitmaps=true and all I got was core dumps.

The fix with a real subject line ;) is below.  I think perhaps this should be
picked up for the 2.0.0 release.  (Patch is against master.)

--Kyle

---- >8 ----
Subject: [PATCH] ewah_bitmap.c: do not assume size_t and eword_t are the same size

When buffer_grow changes the size of the buffer using realloc,
it first computes and saves the rlw pointer's offset into the
buffer using (uint8_t *) math before the realloc but then
restores it using (eword_t *) math.

In order to do this it's necessary to convert the (uint8_t *)
offset into an (eword_t *) offset.  It was doing this by
dividing by the sizeof(size_t).  Unfortunately sizeof(size_t)
is not same as sizeof(eword_t) on all platforms.

This causes illegal memory accesses and other bad things to
happen when attempting to use bitmaps on those platforms.

Fix this by dividing by the sizeof(eword_t) instead which
will always be correct for all platforms.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 ewah/ewah_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 9ced2dad..fccb42b5 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -41,7 +41,7 @@ static inline void buffer_grow(struct ewah_bitmap *self, size_t new_size)
 	self->alloc_size = new_size;
 	self->buffer = ewah_realloc(self->buffer,
 		self->alloc_size * sizeof(eword_t));
-	self->rlw = self->buffer + (rlw_offset / sizeof(size_t));
+	self->rlw = self->buffer + (rlw_offset / sizeof(eword_t));
 }
 
 static inline void buffer_push(struct ewah_bitmap *self, eword_t value)
-- 
1.8.5
