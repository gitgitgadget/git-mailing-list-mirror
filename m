From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/5] ewah_bitmap.c: Fix printf format warnings on MinGW
Date: Thu, 07 Nov 2013 22:12:57 +0000
Message-ID: <527C1069.1080000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 07 23:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXrP-0000TZ-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 23:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612Ab3KGWPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 17:15:23 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:47527 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755674Ab3KGWPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 17:15:16 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 0615F400D00;
	Thu,  7 Nov 2013 22:15:14 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 8DA00401499;
	Thu,  7 Nov 2013 22:15:13 +0000 (GMT)
Received: from [192.168.254.4] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu,  7 Nov 2013 22:15:12 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237437>


On MinGW, gcc complains as follows:

        CC ewah/ewah_bitmap.o
    ewah/ewah_bitmap.c: In function 'ewah_dump':
    ewah/ewah_bitmap.c:389: warning: unknown conversion type \
        character 'z' in format
    ewah/ewah_bitmap.c:389: warning: unknown conversion type \
        character 'z' in format
    ewah/ewah_bitmap.c:389: warning: too many arguments for format
    ewah/ewah_bitmap.c:392: warning: unknown conversion type \
        character 'l' in format
    ewah/ewah_bitmap.c:392: warning: too many arguments for format

In order to suppress the warnings, use the PRIuMAX and PRIx64 macros
from the <inttypes.h> header file.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 ewah/ewah_bitmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 625f5a6..1e363b9 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -22,6 +22,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdio.h>
+#include <inttypes.h>
 
 #include "ewok.h"
 #include "ewok_rlw.h"
@@ -386,10 +387,11 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
 void ewah_dump(struct ewah_bitmap *self)
 {
 	size_t i;
-	fprintf(stderr, "%zu bits | %zu words | ", self->bit_size, self->buffer_size);
+	fprintf(stderr, "%"PRIuMAX" bits | %"PRIuMAX" words | ",
+		(uintmax_t)self->bit_size, (uintmax_t)self->buffer_size);
 
 	for (i = 0; i < self->buffer_size; ++i)
-		fprintf(stderr, "%016llx ", (unsigned long long)self->buffer[i]);
+		fprintf(stderr, "%016"PRIx64" ", (unsigned long long)self->buffer[i]);
 
 	fprintf(stderr, "\n");
 }
-- 
1.8.4
