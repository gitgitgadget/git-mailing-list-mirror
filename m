From: Sundararajan R <dyoucme@gmail.com>
Subject: [PATCH] [GSoC Microproject]Adding "-" shorthand for "@{-1}" in RESET command
Date: Sat,  7 Mar 2015 07:27:36 +0530
Message-ID: <1425693456-21163-1-git-send-email-dyoucme@gmail.com>
Cc: Sundararajan R <dyoucme@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 02:57:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU3zz-0003pb-NT
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 02:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbbCGB5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 20:57:46 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39132 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbbCGB5q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 20:57:46 -0500
Received: by pabrd3 with SMTP id rd3so22443711pab.6
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 17:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0AqyqetmoqwlDbw5rnMicQh5pxxYUZ/W+b6GsgpfAzg=;
        b=PX5n/BF5SBts5oI8BE690Pu8LXehwncAup56lzPfkv2sLhHwrbOK+hxRv8YfURLjgy
         b9NMB6YvSFxW/XngjgMJfMpKkcf9npvAWwzHwYBBrdRKYMvN157lTNScdH1kLVCoobHS
         GVH72A8mU/62m5rgO/TTP0ihjeOjuvYVpAfoDx8ggREb8C4e9KS8c0YZW149lGs6+amU
         DcgC33Cqj18rytxFIghD2uTQpgitrieY4aDfo/5ophF26WezdU+p4iYoo0AoUzONYBGO
         A3oJlBm34inXang48gDtgu5zt26MO63AUL9Js/bXlsZh+X3GsdjLC+A9WM2MCiOutsia
         bwMA==
X-Received: by 10.70.18.97 with SMTP id v1mr2771723pdd.152.1425693465880;
        Fri, 06 Mar 2015 17:57:45 -0800 (PST)
Received: from work.localdomain ([117.222.2.79])
        by mx.google.com with ESMTPSA id kv9sm10638610pbc.72.2015.03.06.17.57.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2015 17:57:45 -0800 (PST)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264986>

Hi all, I am a GSoC '15 aspirant for git.
In this commit I have directly associated "-" to "@{-1}" except when it refers to a filename. 
All the given tests pass(except those which shouldn't).
I have to add a failsafe for the case in when there is no branch as "@{-1}". For this I have a 
rough idea that I would have to call get-sha1() on @{-1} to check if there is an object matching 
with it. But I am not able to think of the details.
Please guide me with that and give feedback for this patch.
Signed-off-by: Sundararajan R <dyoucme@gmail.com>
---
 builtin/reset.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..62764d4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -203,8 +203,16 @@ static void parse_args(struct pathspec *pathspec,
 	 *
 	 * At this point, argv points immediately after [-opts].
 	 */
-
+	int flag=0; /* 
+		     *  "-" may refer to filename in which case we should be giving more precedence 
+		     *  to filename than equating argv[0] to "@{-1}" 
+		     */
 	if (argv[0]) {
+		if (!strcmp(argv[0], "-") && !argv[1])  /* "-" is the only argument */
+		{
+			argv[0]="@{-1}";
+			flag=1;
+		}
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
@@ -226,6 +234,8 @@ static void parse_args(struct pathspec *pathspec,
 			rev = *argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
+			if(flag)
+				argv[0]="-";
 			verify_filename(prefix, argv[0], 1);
 		}
 	}
-- 
2.1.0
