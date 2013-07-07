From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] range_set: fix coalescing bug when range is a subset of another
Date: Sun,  7 Jul 2013 09:02:32 -0400
Message-ID: <1373202152-3231-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 15:03:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvocX-00040u-SG
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 15:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759Ab3GGNC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 09:02:57 -0400
Received: from mail-ye0-f174.google.com ([209.85.213.174]:42843 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab3GGNC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 09:02:56 -0400
Received: by mail-ye0-f174.google.com with SMTP id m9so1319686yen.33
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=TFbUX305Zp7qQc/hu+KfbdUMek3/1o6CA6I64BCdzJc=;
        b=cu9Hbl9Xqj7HIZM/fPBTwmk74m+xpKNl3V8KcRInbwK2nu1wiXoZBVmQKdQib5BxJ7
         MTvcUE/XBN+qHH0dqbjqf5V0In9EP8tzJB6riMe/BsvfEfQbxE/2S20LlPOCxLTmOCcT
         EJIA9v4BGclamK1o8QvScgMhq64hiOUgPjWio0ShjEdfIcLpqh/N49neVrKvanVOHrxu
         VqSq+kgVR0bS6Hh5gQm6sOxWqgQg/+owhBl7UkdP2aZ4FYuuGTyjnxKDKMM+xPcVeu5j
         B8H1CttihwKushgGzpaN1lmcx6KujIXbDcbJ2Gu+Y/hBpWNwOeknkcHsv7suIYnOpE6R
         ikRg==
X-Received: by 10.236.110.97 with SMTP id t61mr1719345yhg.128.1373202174180;
        Sun, 07 Jul 2013 06:02:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id g66sm28627135yhd.11.2013.07.07.06.02.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 06:02:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229774>

When coalescing ranges, sort_and_merge_range_set() unconditionally
assumes that the end of a range being folded into a preceding range
should become the end of the coalesced range. This assumption, however,
is invalid when one range is a subset of another.  For example, given
ranges 1-5 and 2-3 added via range_set_append_unsafe(),
sort_and_merge_range_set() incorrectly coalesces them to range 1-3
rather than the correct union range 1-5. Fix this bug.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Presumably, this problem does not happen in practice, so it's not clear
if the patch should be applied.  I discovered it when teaching git-blame
to accept multiple -L options, one iteration of which (after making the
range_set API public) employed sort_and_merge_range_set() to sort and
coalesce input -L ranges added via range_set_append_unsafe().

It might make sense to apply this patch in order to future-proof
sort_and_merge_range_set() in case the range_set API ever becomes
public.


 line-log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index 4bbb09b..8cc29a0 100644
--- a/line-log.c
+++ b/line-log.c
@@ -116,7 +116,8 @@ static void sort_and_merge_range_set(struct range_set *rs)
 
 	for (i = 1; i < rs->nr; i++) {
 		if (rs->ranges[i].start <= rs->ranges[o-1].end) {
-			rs->ranges[o-1].end = rs->ranges[i].end;
+			if (rs->ranges[o-1].end < rs->ranges[i].end)
+				rs->ranges[o-1].end = rs->ranges[i].end;
 		} else {
 			rs->ranges[o].start = rs->ranges[i].start;
 			rs->ranges[o].end = rs->ranges[i].end;
-- 
1.8.3.2
