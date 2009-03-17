From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Define a version of lstat(2) specially for copy operation
Date: Tue, 17 Mar 2009 22:38:21 +0100
Message-ID: <20090317213820.GC13458@blimp.localdomain>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com> <7vprggqeh2.fsf@gitster.siamese.dyndns.org> <49BFD6DD.1010800@viscovery.net> <20090317202818.GA13458@blimp.localdomain> <7v63i7ridk.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	layer <layer@known.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 22:40:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljh11-0002SL-DD
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 22:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126AbZCQVig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 17:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757024AbZCQVig
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 17:38:36 -0400
Received: from mout2.freenet.de ([195.4.92.92]:34854 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756103AbZCQVif (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 17:38:35 -0400
Received: from [195.4.92.11] (helo=1.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #76)
	id 1LjgzS-00042h-I0; Tue, 17 Mar 2009 22:38:26 +0100
Received: from x6d6d.x.pppool.de ([89.59.109.109]:38273 helo=tigra.home)
	by 1.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #79)
	id 1LjgzS-000544-9E; Tue, 17 Mar 2009 22:38:26 +0100
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 701B7277D8;
	Tue, 17 Mar 2009 22:38:21 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 2E15D36D27; Tue, 17 Mar 2009 22:38:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v63i7ridk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113530>

So that Cygwin port can continue work around its supporting
library and get access to its faked file attributes.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Junio C Hamano, Tue, Mar 17, 2009 21:42:31 +0100:
> But isn't this something shops that do deploy Cygwin version of git want
> to see fixed, so that they can have a site-wide policy implemented in the

Frankly, I doubt they know or care.

> hooks copied from templates?  I think we could pass mode 0 to copy_files()
> and have the function special case it (and allow a platform specific
> copy_files() implementated by Cygwin).  lstat() in the copy_templates_1()
> codepath is primarily done to see if we need to descend into a directory
> or symlink() and our use of st.st_mode to pass to copy_files() is a no
> cost side effect on platforms with x-bit support.

And I don't think that the platform broken in so many ways deserves
that kind of treatement. Maybe this patch is enough. Will test it
tomorrow, when I get to mine so much hated Windows system.

> >> access(..., X_OK), not lstat(). We don't play games with access(), do we?
> > access(..., X_OK) will return -1.
> 
> That codepath would also need to be fixed if Cygwin wants to use hooks, I
> would guess.

I hope not. In the reply to Johannes' example I was referring to the
copied file, the one which was created with open(..., O_CREAT..., 0666),
0666 being there because of our lstat stub.

 builtin-init-db.c |    2 +-
 git-compat-util.h |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index ee3911f..f3f781b 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -66,7 +66,7 @@ static void copy_templates_1(char *path, int baselen,
 		else
 			exists = 1;
 
-		if (lstat(template, &st_template))
+		if (lstat_for_copy(template, &st_template))
 			die("cannot stat template %s", template);
 
 		if (S_ISDIR(st_template.st_mode)) {
diff --git a/git-compat-util.h b/git-compat-util.h
index 878d83d..4c23478 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,11 +85,16 @@
 #undef _XOPEN_SOURCE
 #include <grp.h>
 #define _XOPEN_SOURCE 600
+static inline int lstat_for_copy(const char *file_name, struct stat *buf)
+{
+	return lstat(file_name, buf);
+}
 #include "compat/cygwin.h"
 #else
 #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
 #include <grp.h>
 #define _ALL_SOURCE 1
+#define lstat_for_copy lstat
 #endif
 #else 	/* __MINGW32__ */
 /* pull in Windows compatibility stuff */
-- 
1.6.2.1.171.g3422
