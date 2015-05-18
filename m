From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] pack-bitmaps: plug memory leak, fix allocation size for recent_bitmaps
Date: Tue, 19 May 2015 01:24:09 +0200
Message-ID: <555A7499.7090900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 19 01:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuUOk-0005cy-DS
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 01:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbbERXYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 19:24:33 -0400
Received: from mout.web.de ([212.227.17.11]:54001 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866AbbERXYc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 19:24:32 -0400
Received: from [192.168.178.27] ([79.253.146.148]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MZlZK-1YbB7j2guc-00LXDa; Tue, 19 May 2015 01:24:29
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Provags-ID: V03:K0:5knSsxaOCGGan+UV5m10xG/eAPSpuZ220Hq6eXkkcPW39C73hso
 Eya3NBJqcyAp76jKT2WsBsa9Db51FYx14XG1JP6ku0jOZpEdE+SER1ZTPmCshhIKlZ6akdg
 CN/IK8wMrKdPFQ6ZphUGcDsdXuwdXmoFlubcD0cwjv7G6TuRjVT29vi/78MBJgM9Crpe/e8
 bW4oNIE2hMw+2kxB1FHWw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269330>

Use an automatic variable for recent_bitmaps, an array of pointers.
This way we don't allocate too much and don't have to free the memory
at the end.  The old code over-allocated because it reserved enough
memory to store all of the structs it is only pointing to and never
freed it.  160 64-bit pointers take up 1280 bytes, which is not too
much to be placed on the stack.

MAX_XOR_OFFSET is turned into a preprocessor constant to make it
constant enough for use in an non-variable array declaration.

Noticed-by: Stefan Beller <stefanbeller@gmail.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This seems to have fallen through the cracks, or did I just miss it?

 pack-bitmap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 62a98cc..e5abb8a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -209,14 +209,12 @@ static inline uint8_t read_u8(const unsigned char *buffer, size_t *pos)
 	return buffer[(*pos)++];
 }
 
+#define MAX_XOR_OFFSET 160
+
 static int load_bitmap_entries_v1(struct bitmap_index *index)
 {
-	static const size_t MAX_XOR_OFFSET = 160;
-
 	uint32_t i;
-	struct stored_bitmap **recent_bitmaps;
-
-	recent_bitmaps = xcalloc(MAX_XOR_OFFSET, sizeof(struct stored_bitmap));
+	struct stored_bitmap *recent_bitmaps[MAX_XOR_OFFSET] = { NULL };
 
 	for (i = 0; i < index->entry_count; ++i) {
 		int xor_offset, flags;
-- 
2.4.1
