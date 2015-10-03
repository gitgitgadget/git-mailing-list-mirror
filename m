From: Ray Donnelly <mingw.android@gmail.com>
Subject: [PATCH 1/2] test-path-utils.c: remove incorrect assumption
Date: Sat, 3 Oct 2015 13:44:43 +0100
Message-ID: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Ray Donnelly <mingw.android@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 14:44:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiMBF-0000Yl-8T
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 14:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbbJCMop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 08:44:45 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36571 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbbJCMoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 08:44:44 -0400
Received: by oibi136 with SMTP id i136so70956127oib.3
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 05:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=uIyWRy6nCWn3DudZqWUD0iTbvjf32c3jRw7Z8FCeaZc=;
        b=C2mC6G1TMxnUgx6M5lTFBJguRrBA4DRx00q6keKPPQksATDQEpRb2Z6F2bzCIE517x
         hGEyfG+qszQ0ACNUfXBpt2FPiw+bHbb/59hn682x6E23u40v+BoDTiSD2hp067piU3VW
         /RjCgsSNfJNbMM1R1L671DR43dX9iuKF9nGEhqGKfGY4xXIj/JpJOjAAFptOnMM3X0KZ
         a0jJfKU8016jsO5p0/asgPJl9hQqjfmXOqZwJNLe7yXcq9oAiGYe/sjV7S8lhUY0b07O
         8PbUm04CH4t7KFdlYID8AjDtok/0b1pB2BUrKO2ugW6aYeBZhY5r01BeBunZDojg4PMp
         uROw==
X-Received: by 10.202.69.5 with SMTP id s5mr11546735oia.123.1443876283716;
 Sat, 03 Oct 2015 05:44:43 -0700 (PDT)
Received: by 10.202.15.21 with HTTP; Sat, 3 Oct 2015 05:44:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278971>

In normalize_ceiling_entry(), we test that normalized paths end with
slash, *unless* the path to be normalized was already the root
directory.

However, normalize_path_copy() does not even enforce this condition.

Even worse: on Windows, the root directory gets translated into a
Windows directory by the Bash before being passed to `git.exe` (or
`test-path-utils.exe`), which means that we cannot even know whether
the path that was passed to us was the root directory to begin with.

This issue has already caused endless hours of trying to "fix" the
MSYS2 runtime, only to break other things due to MSYS2 ensuring that
the converted path maintains the same state as the input path with
respect to any final '/'.

So let's just forget about this test. It is non-essential to Git's
operation, anyway.

Ack-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ray Donnelly <mingw.android@gmail.com>
---
 test-path-utils.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/test-path-utils.c b/test-path-utils.c
index 3dd3744..c67bf65 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -21,8 +21,6 @@ static int normalize_ceiling_entry(struct
string_list_item *item, void *unused)
  if (normalize_path_copy(buf, ceil) < 0)
  die("Path \"%s\" could not be normalized", ceil);
  len = strlen(buf);
- if (len > 1 && buf[len-1] == '/')
- die("Normalized path \"%s\" ended with slash", buf);
  free(item->string);
  item->string = xstrdup(buf);
  return 1;
-- 
2.5.2
