From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Fix off by one error in prep_exclude.
Date: Sun, 27 Jan 2008 18:37:30 -0600
Message-ID: <1201480650-19716-1-git-send-email-shawn.bohrer@gmail.com>
References: <20080128003404.GA18276@lintop>
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	j.sixt@viscovery.net, Shawn Bohrer <shawn.bohrer@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 28 01:39:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJI21-0000FL-Dx
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 01:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbYA1Aiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 19:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbYA1Aiz
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 19:38:55 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:58532 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYA1Aiy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 19:38:54 -0500
Received: by an-out-0708.google.com with SMTP id d31so322443and.103
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 16:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FIjabjmAum2mGx1ukYq+N8RI9XZovmZh9VI37rg4EDA=;
        b=a63WXIVTf/gMDH0you4+GsdiGL5LnoDN69ncUr7OlZiNyc+geVO2j1RYUJlDP2gBp1KcMcu/P/gR2iyt3UcqvAU7YrLA1+DSRZf5YytY6Hv+22TdMeUB33QKisIUvfej21x1nbG1zfYlBGR23zPJ/tNsy4RoxWThpTX4QC03J28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wl9/bdA8azGHhgEJNdFiqaOdHoN/EoYLJXSfGEN+L0eRUGkkSPO7wNjcq70FPQjpzppkI58xH38+iTSk721dKrfnwGXVubjsmlgG7fHj2LLtM0OzdDF25yiuJoC/U2GmAiXWuiuj/Zmfh7SdtnHVNxs9VKfOrpW3d7wnrAZLn3I=
Received: by 10.100.247.14 with SMTP id u14mr10517990anh.79.1201480733553;
        Sun, 27 Jan 2008 16:38:53 -0800 (PST)
Received: from lintop ( [70.112.149.232])
        by mx.google.com with ESMTPS id i8sm8444733rng.19.2008.01.27.16.38.50
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Jan 2008 16:38:52 -0800 (PST)
Received: by lintop (sSMTP sendmail emulation); Sun, 27 Jan 2008 18:37:30 -0600
X-Mailer: git-send-email 1.5.4.rc5.1.g813e
In-Reply-To: <20080128003404.GA18276@lintop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71841>

In "struct exclude_stack", prep_exclude() and excluded(), the
convention for a path is to express the length of directory part
including the trailing slash (e.g. "foo" and "bar/baz" will get
baselen=0 and baselen=4 respectively).

The variable current and parameter baselen follow that
convention in the codepath the following patch touches.

                else {
                        cp = strchr(base + current + 1, '/');
                        if (!cp)
                                die("oops in prep_exclude");
                        cp++;
                }
                stk->prev = dir->exclude_stack;
                stk->baselen = cp - base;

is about coming up with the next value for current (which is
taken from stk->baselen) to dig one more level.

If base="foo/bar/boo" and current=4 (i.e. we are looking at
"foo/"), the current code (base + current + 1) will begin scanning
for the next slash at ar/boo skipping one letter ('b').  This
patch starts the scanning at bar/boo/

This only causes a problem when a path component has a length of
zero which can happen when the user provides an absolute path to
a file or directory in the root directory (i.e. "/", or "/foo"),
or if the input is malformed and contains a double-slash such
as "foo//boo".

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 3e345c2..9e5879a 100644
--- a/dir.c
+++ b/dir.c
@@ -237,7 +237,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			current = 0;
 		}
 		else {
-			cp = strchr(base + current + 1, '/');
+			cp = strchr(base + current, '/');
 			if (!cp)
 				die("oops in prep_exclude");
 			cp++;
-- 
1.5.4.rc5.1.g813e
