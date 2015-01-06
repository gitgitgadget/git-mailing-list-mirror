From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 1/2] log.c: fix translation markings
Date: Tue,  6 Jan 2015 02:34:18 -0800
Message-ID: <ecb18f9d6ac56da0a61c3b98f8f2236@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 11:35:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8RT9-0006Pm-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 11:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbbAFKeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 05:34:31 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:65438 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbbAFKea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 05:34:30 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so30780681pad.13
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 02:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4Z0PpP/bLLgRPZs/K7XH+AmgKbrwd5/P2pWwCdqORdY=;
        b=KzMmE7BjpQMwAE7QRLPzQhk9M36tx1ZM4ljbclLfpssoOM+YXPJEt1TiWNYSYK5GvI
         aaFOWgRevmolyfc7Z6iskmC2uWAHp8QePWHxa7hpBsGPtBpWB136erBZMsncfLmuV4GA
         k3GRO36lgo7u1sJ4ALa6c0iGmLantpEDUf/jq2jVG7PA7ziqzR+W37SxMSFjRXx8/L2G
         zTfZ+4Bmj6+vxaVj2RLhnDXpDZAygDVrba7QQgN+1Qn/YQ/WxN6KTR88CezaVR9cvml0
         p2X9VNVNwQL86Ami7Fc3d3J3X7uuvXPfBFDAqvMeCP3nu80wpE3crwrtHIgzS1rHg7sl
         eCvw==
X-Received: by 10.68.69.37 with SMTP id b5mr152729838pbu.102.1420540470137;
        Tue, 06 Jan 2015 02:34:30 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id x10sm56985818pas.18.2015.01.06.02.34.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 02:34:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262052>

The parse_options API expects an array of alternative usage lines
to which it automatically ads the language-appropriate "or" when
displaying.  Each of these options is marked for translation with N_
and then later translated when gettext is called on each element
of the array.

Since the N_ macro just expands to its argument, if two N_-marked
strings appear next to each other without being separated by anything
else such as a comma, the preprocessor will join them into one string.

In that case two separate strings get marked for translation, but at
runtime they have been joined into a single string passed to gettext
which then fails to get translated because the combined string was
never marked for translation.

Fix this by properly separating the two N_ marked strings with
a comma and removing the embedded "\n" and "   or:" that are
properly supplied by the parse_options API.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f2a9f015..923ffe72 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -38,8 +38,8 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
-	N_("git log [<options>] [<revision range>] [[--] <path>...]\n")
-	N_("   or: git show [options] <object>..."),
+	N_("git log [<options>] [<revision range>] [[--] <path>...]"),
+	N_("git show [options] <object>..."),
 	NULL
 };
 
-- 
2.1.4
