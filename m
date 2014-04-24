From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH] setup: Fix windows path buffer over-stepping
Date: Thu, 24 Apr 2014 15:06:09 +0200
Message-ID: <1398344769-32564-1-git-send-email-martinerikwerner@gmail.com>
Cc: Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 15:06:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdJMS-0006vY-77
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 15:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbaDXNGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 09:06:39 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46199 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbaDXNGi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 09:06:38 -0400
Received: by mail-wi0-f177.google.com with SMTP id cc10so1014370wib.10
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=b8WYfHUNHXMCfAcdpEcWHCH36o1ALX7W7TWlPJUoP1U=;
        b=00Cmnn5PALz+hDappQ65MTFBxcdkuO2sQBgSVQg8bYpJ8FrYw+GsIN2MvPrJfr1fYk
         mIDIbXLedWrInbOtYnbodcvvfI7o5Pi7BRPioDfn0ZGPZzlZ0MaP4v9LuEgBMn5HuiFX
         lBJyUKA49PtResyzUXn0XSFzsmKo7o6i2uuIWm70nDELoHbHEfvKq324L1ZCUow6npAY
         pAJj7CrLMPCZYzaybthEkj80S3OyqnXAZysGI4rbwTkH+w+NToI1k/TAsvpeTp7SKj1p
         XiBVLAD/9eR1RspuUZKb+9icMIeFtgb5wb25j4w2doZap8OQm96VzWquxiKxdanc35Et
         4leQ==
X-Received: by 10.180.39.175 with SMTP id q15mr6489915wik.4.1398344797133;
        Thu, 24 Apr 2014 06:06:37 -0700 (PDT)
Received: from localhost.localdomain (mail.aacmicrotec.com. [194.150.18.17])
        by mx.google.com with ESMTPSA id ez5sm6153966wjd.9.2014.04.24.06.06.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Apr 2014 06:06:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246967>

Fix a buffer over-stepping issue triggered by providing an absolute path
that is similar to the work tree path.

abspath_part_inside_repo() may currently increment the path pointer by
offset_1st_component() + wtlen, which is too much, since
offset_1st_component() is a subset of wtlen.

For the *nix-style prefix '/', this does (by luck) not cause any issues,
since offset_1st_component() is 1 and there will always be a '/' or '\0'
that can "absorb" this.

In the case of DOS-style prefixes though, the offset_1st_component() is
3 and this can potentially over-step the string buffer. For example if

    work_tree = "c:/r"
    path      = "c:/rl"

Then wtlen is 4, and incrementing the path pointer by (3 + 4) would
end up 2 bytes outside a string buffer of length 6.

Similarly if

    work_tree = "c:/r"
    path      = "c:/rl/d/a"

Then (since the loop starts by also incrementing the pointer one step),
this would mean that the function would miss checking if "c:/rl/d" could
be the work_tree, arguably this is unlikely though, since it would only
be possible with symlinks on windows.

Fix this by simply avoiding to increment by offset_1st_component() and
wtlen at the same time.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---

This is a follow-up on 655ee9e mw/symlinks which is currently merged into
master, prospective for git v2.0.0, the issue only affects v2.0.0-rc0.

 setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 613e3b3..0a22f8b 100644
--- a/setup.c
+++ b/setup.c
@@ -29,7 +29,7 @@ static int abspath_part_inside_repo(char *path)
 		return -1;
 	wtlen = strlen(work_tree);
 	len = strlen(path);
-	off = 0;
+	off = offset_1st_component(path);
 
 	/* check if work tree is already the prefix */
 	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
@@ -45,7 +45,7 @@ static int abspath_part_inside_repo(char *path)
 		off = wtlen;
 	}
 	path0 = path;
-	path += offset_1st_component(path) + off;
+	path += off;
 
 	/* check each '/'-terminated level */
 	while (*path) {
-- 
1.9.2
