From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] receive-pack: crash when checking with non-exist HEAD
Date: Wed, 22 Jul 2015 09:49:40 +0800
Message-ID: <CANYiYbE3Vy_gtFMKTMw1wHLDhU758nXaJnKaNy6WMNRz0fjUnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 03:49:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHjAO-0000S7-GY
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 03:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbbGVBtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 21:49:42 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37942 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbGVBtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 21:49:41 -0400
Received: by wibxm9 with SMTP id xm9so79836462wib.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 18:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=l57bZXw+65jh1LfsgP/hHb+Yyj16IzwepYc0OuMDM9g=;
        b=j1BSjSvzlCYugFcjSxqd8fGC3eYcvu0cTnTo14r8n+OboGSEAkAN57wy+TpnEfqUzR
         E7qVDhKrGxCYxv+kki47HjjKIagxAqLUfunHVGWFP8lVi8ZE+M6XfaLCatEhxNO5Oiy1
         jGAgWu8DEdf2M9UbsPXz54gqJ8e+gRDyBwyGJehjuyDR2cTYFJBtF7wZHHLKIi2pCZ2N
         eDyFI7+trHEpqZwNunyvqUdPi1UW3+rKsB2iUA4anYFw8g/92N5VqQjSI1U7jaO4c+J1
         fEk9YqZYlwo1aMHDSCvwfoExvlwLhAwaIovofH18uhtrUl1kpLgHppkqkodrNmV0xUvq
         nTFw==
X-Received: by 10.180.75.243 with SMTP id f19mr24684266wiw.52.1437529780249;
 Tue, 21 Jul 2015 18:49:40 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Tue, 21 Jul 2015 18:49:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274436>

If HEAD of a repository points to a conflict reference, such as:

* There exist a reference named 'refs/heads/jx/feature1', but HEAD
  points to 'refs/heads/jx', or

* There exist a reference named 'refs/heads/feature', but HEAD points
  to 'refs/heads/feature/bad'.

When we push to delete a reference for this repo, such as:

        git push /path/to/bad-head-repo.git :some/good/reference

The git-receive-pack process will crash.

This is because if HEAD points to a conflict reference, the function
`resolve_refdup("HEAD", ...)` does not return a valid reference name,
but a null buffer.  Later matching the delete reference against the null
buffer will cause git-receive-pack crash.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
I'm not sure this email is well-formed for git-am. Because gmail changed
it's auth policy, I can not use git send-email command line to send mail.
You may know, in our China, we can not visit google/gmail directly, I
must access the outside world use VPN!

 builtin/receive-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94d0571..04cb5a1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -911,7 +911,7 @@ static const char *update(struct command *cmd,
struct shallow_info *si)
      return "deletion prohibited";
    }

-   if (!strcmp(namespaced_name, head_name)) {
+   if (head_name && !strcmp(namespaced_name, head_name)) {
      switch (deny_delete_current) {
      case DENY_IGNORE:
        break;
-- 
2.5.0.rc2.34.gfbdeabf.dirty
