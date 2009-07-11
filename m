From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] tm_to_time_t(): allow times in year 1969
Date: Fri, 10 Jul 2009 20:20:06 -0700
Message-ID: <7vfxd3rjmh.fsf_-_@alter.siamese.dyndns.org>
References: <4A5680B5.2090405@necel.com> <4A56B060.7090106@mips.com>
 <20090710104743.GB1288@linux-mips.org>
 <7vhbxkv7ax.fsf@alter.siamese.dyndns.org>
 <7vk52frjv9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 05:20:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPT8O-0005Wo-EZ
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 05:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbZGKDUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 23:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbZGKDUO
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 23:20:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbZGKDUN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 23:20:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 10A8D279E0;
	Fri, 10 Jul 2009 23:20:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4030E279DF; Fri,
 10 Jul 2009 23:20:08 -0400 (EDT)
In-Reply-To: <7vk52frjv9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 10 Jul 2009 20\:14\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BDF5E8CE-6DC9-11DE-9C5B-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123095>

We used to reject anything older than January 1st 1970 regardless of the
timezone, but in order to parse UNIX epoch in zones west of GMT, we need
to allow the time without zone to be a little bit into 1969.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 date.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/date.c b/date.c
index 409a17d..5d259af 100644
--- a/date.c
+++ b/date.c
@@ -6,6 +6,7 @@
 
 #include "cache.h"
 
+#define BAD_STRUCT_TM (-400*24*60*60)
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
  */
@@ -18,10 +19,10 @@ time_t tm_to_time_t(const struct tm *tm)
 	int month = tm->tm_mon;
 	int day = tm->tm_mday;
 
-	if (year < 0 || year > 129) /* algo only works for 1970-2099 */
-		return -1;
+	if (year < -1 || year > 129) /* algo only works for 1969-2099 */
+		return BAD_STRUCT_TM;
 	if (month < 0 || month > 11) /* array bounds */
-		return -1;
+		return BAD_STRUCT_TM;
 	if (month < 2 || (year + 2) % 4)
 		day--;
 	return (year * 365 + (year + 1) / 4 + mdays[month] + day) * 24*60*60UL +
@@ -337,7 +338,7 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
 				return 1;
 			r->tm_year = now_tm->tm_year;
 		}
-		else if (year >= 1970 && year < 2100)
+		else if (year >= 1969 && year < 2100)
 			r->tm_year = year - 1900;
 		else if (year > 70 && year < 100)
 			r->tm_year = year;
@@ -611,12 +612,11 @@ int parse_date(const char *date, char *result, int maxlen)
 
 	/* mktime uses local timezone */
 	then = tm_to_time_t(&tm);
-	if (offset == -1)
-		offset = (then - mktime(&tm)) / 60;
-
-	if (then == -1)
+	if (then == BAD_STRUCT_TM)
 		return -1;
 
+	if (offset == -1)
+		offset = (then - mktime(&tm)) / 60;
 	if (!tm_gmt)
 		then -= offset * 60;
 	return date_string(then, offset, result, maxlen);
-- 
1.6.3.3.412.gf581d
