From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] update-index: allow overwriting existing submodule index
	entries
Date: Sat, 9 Jun 2012 16:27:00 +0200
Message-ID: <20120609142658.GB16268@book.hvoigt.net>
References: <CAOkDyE9q1n=oLoEXXxurDjNM0B2+cZ9eoeGE57F9hEQUjK0hZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Adam Spiers <git@adamspiers.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 16:27:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdMdH-0007lg-FJ
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 16:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176Ab2FIO1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 10:27:07 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:44736 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2FIO1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 10:27:06 -0400
X-Greylist: delayed 2370 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2012 10:27:06 EDT
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1SdMd3-000780-40; Sat, 09 Jun 2012 16:27:01 +0200
Content-Disposition: inline
In-Reply-To: <CAOkDyE9q1n=oLoEXXxurDjNM0B2+cZ9eoeGE57F9hEQUjK0hZg@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199550>

In commit e01105 Linus introduced gitlinks to update-index. He explains
that he thinks it is not the right thing to replace a gitlink with
something else.

That commit is from the very first beginnings of submodule support.
Since then we have gotten a lot closer to being able to remove a
submodule without losing its history. This check prevents such a use
case, so I think this assumption has changed.

Additionally in the git add codepath we do not have such a check, so for
consistency reasons I think removing this check is the correct thing to
do.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
Hi,

On Fri, Jun 01, 2012 at 11:31:26AM +0100, Adam Spiers wrote:
> Now if I press Control-T to try to stage 'two' into the index, I get a new
> dialog which says:
> 
>     Updating the Git index failed. A rescan will be automatically
>     started to resynchronize git-gui.
> 
>     error: two is already a gitlink, not replacing
>     fatal: Unable to process path two
> 
> 
>                               [Unlock Index] [Continue]
> 
> I can work around via 'git add two', but it would be nice if citool
> handled this correctly.

This is because git gui uses plumbing (update-index) for updating the
index.

This patch fixes that popup. Testsuite passes here.

Is it ok this way?

Cheers Heiko

 builtin/update-index.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5f038d6..5a4e9ea 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -211,12 +211,6 @@ static int process_path(const char *path)
 	if (S_ISDIR(st.st_mode))
 		return process_directory(path, len, &st);
 
-	/*
-	 * Process a regular file
-	 */
-	if (ce && S_ISGITLINK(ce->ce_mode))
-		return error("%s is already a gitlink, not replacing", path);
-
 	return add_one_path(ce, path, len, &st);
 }
 
-- 
1.7.10.2.522.g93b45fe
