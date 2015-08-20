From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] log: when --cc is given, default to -p unless told otherwise
Date: Thu, 20 Aug 2015 15:43:10 -0700
Message-ID: <1440110591-12941-3-git-send-email-gitster@pobox.com>
References: <1440110591-12941-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 00:43:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSYYL-0002fX-KW
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 00:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbbHTWnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 18:43:18 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34261 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbbHTWnP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 18:43:15 -0400
Received: by pdbfa8 with SMTP id fa8so19009440pdb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=yxjpZ9anvPzgZ0RllPpsZOmkhyKN/GPCfJlT7+cLbZE=;
        b=WIDDOyP1imKomTRrUkXzIBl12Xqndair2ShtRmYOgWW9FXJ9zl238U3X4w/v7dyQN+
         /12jiw8j4i7AKIPI+zLKfMqznkjoRkKeynwy4hBDZ6ALQ02YFcOgqv+FwxEuNdQK4Fkf
         YMd53ZIuRJ0sAU4ZQdAnZHiF2W5oaJLGm5604ZgHHYf+q4WeVtvoWedWa7+I3VtHczio
         w79rV0tiiZO6G/RIj2Ue9YDf/3S96mFVx/klCKhkeFFqhLGUc/fKTPuVE30Brbptq15f
         8u+CL9r/8KjBdF201FmB1iV00CLoITHXiMu7T7L/ldEpkAs210/G5dcegLJAchf7G7sY
         j8Zw==
X-Received: by 10.70.14.36 with SMTP id m4mr2942435pdc.117.1440110594526;
        Thu, 20 Aug 2015 15:43:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:247b:3165:9cce:44a3])
        by smtp.gmail.com with ESMTPSA id fp5sm5434068pbb.94.2015.08.20.15.43.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Aug 2015 15:43:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-546-gb1bbc0d
In-Reply-To: <1440110591-12941-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276270>

The "--cc" option to "git log" is clearly a request to show some
sort of combined diff (be it --patch or --raw), but traditionally
we required the command line to explicitly ask for "git log -p --cc".

Teach the command line parser to treat a lone "--cc" as if the user
specified "-p --cc".  Formats that do ask for other forms of diff
output, e.g. "log --raw --cc", are not overriden.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 8651105..e37c27a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -633,6 +633,10 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	if (DIFF_OPT_TST(&rev->diffopt, DEFAULT_FOLLOW_RENAMES) &&
 	    rev->prune_data.nr == 1)
 		DIFF_OPT_SET(&rev->diffopt, FOLLOW_RENAMES);
+
+	/* Turn --cc/-c into -p --cc/-c when -p was not given */
+	if (!rev->diffopt.output_format && rev->combine_merges)
+		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
-- 
2.5.0-546-gb1bbc0d
