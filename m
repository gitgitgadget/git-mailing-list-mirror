From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 17:54:45 +0530
Message-ID: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 30 14:23:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX9ab-0002vr-FF
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 14:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760512Ab3D3MXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 08:23:17 -0400
Received: from mail-da0-f54.google.com ([209.85.210.54]:61535 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760437Ab3D3MXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 08:23:16 -0400
Received: by mail-da0-f54.google.com with SMTP id s35so225582dak.13
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=OLOkHioYmbLWen0t/6jK71MDofMFTAIopr3IrBx/fjQ=;
        b=Srkj9j6SONAXlOTGx98KGE8z2R3apV+EqeiSkBE6JoFceU+MuulYsfXux2P9SSQ/fc
         U9Nl0j64GHaajjFiRL6MPibk17ZJGSCQ7yttueSbZGYkyvASprxyVI4y9z3sGq+VXFSf
         xou7VYXrLLf7oKCPXEthBx1UjU8Na0PdpNtx5N8FDic7m1TosRGLpBNZU+6T5WoSO9JQ
         b5dNVBnmvBQqLU3uQCMh6Eqhzh7+TsdlRq6xi97tsx03zfUfxAu8KBHDRahnp094WLBs
         WPaCQQx4A/UTp8YGics9r0GFpwkNZOkbls0TPrjvW2wvhwGdSDUrcrR0cH3qDjCC0sou
         +18A==
X-Received: by 10.66.154.72 with SMTP id vm8mr7041205pab.2.1367324595773;
        Tue, 30 Apr 2013 05:23:15 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id l4sm28360801pbo.6.2013.04.30.05.23.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:23:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.628.gcd33b41.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222931>

The rev spec forms @{}, .., ... fill in HEAD as the missing argument
automatically.  Unfortunately, HEAD~<n> is a very common idiom and
there is no way to make HEAD implicit here (due the shell expansion of
~<n>).

However, there is an alternative solution to the issue: overload the
character @ to mean HEAD.  Do this at the lowest possible layer of
abstraction: in dwim_ref(), substitute @ with HEAD just before calling
resolve_ref_unsafe().  The program will only reach this point after
the other specs like ~, ^ and @{} have been resolved; therefore, it is
safe to do it here.

This patch has the exact same effect as:

    $ git symbolic-ref @ HEAD

It means that you can now do @~1, @^2, and even topic..@.  However,
since the @-parsing happens before we ever reach the symref
resolution, @@{u} is invalid.  But this is okay, since @{u} already
has an implicit HEAD in it.

Inspired-by: Felipe Contreras <felipe.contreras@gmail.com>
Inspired-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I haven't included documentation/ tests because I want feedback on
 this two-liner first.

 refs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.c b/refs.c
index de2d8eb..cb67b73 100644
--- a/refs.c
+++ b/refs.c
@@ -1604,6 +1604,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 
 		this_result = refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
+		if (!strcmp(fullref, "@"))
+			mksnpath(fullref, sizeof(fullref), *p, 4, "HEAD");
 		r = resolve_ref_unsafe(fullref, this_result, 1, &flag);
 		if (r) {
 			if (!refs_found++)
-- 
1.8.2.1.628.gcd33b41.dirty
