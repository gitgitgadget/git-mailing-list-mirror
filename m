From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Introduce %<branch> as shortcut to the tracked branch
Date: Wed, 18 Mar 2009 22:12:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:11:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk33N-0006Vo-Iy
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbZCRVK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbZCRVK2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:10:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:49022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752030AbZCRVK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:10:27 -0400
Received: (qmail invoked by alias); 18 Mar 2009 21:10:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 18 Mar 2009 22:10:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ii0FxH1TiR0d2iXGOOh8RBj0whyOlXUefqggucZ
	xV/CzEimhasuyR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090318182603.GM8940@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113666>


Suggested by Pasky.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Wed, 18 Mar 2009, Petr Baudis wrote:

	> On Wed, Mar 18, 2009 at 02:48:50PM +0100, Andreas Gruenbacher wrote:
	> > I often want to see what the differences are between a local 
	> > branch and the branch it tracks (if it tracks a branch). I
	> > currently do something like "git log master..origin/master". 
	> > This is a lot of unnecessary typing though compared to something
	> > like "git log -t master", or even "git log -t" when on the 
	> > master branch.
	> 
	> sorry, I think Git can't do anything like this either. :-(
	> 
	> However, I think something like this would be useful and 
	> probably easy to do? Maybe someone on the list will get inspired to 
	> implement a special refspec character to represent the "tracked
	> branch" relationship, so e.g. %master would expand to 
	> %origin/master. Then you should be able to do something like:
	> 
	> 	git log %..

	Great idea!

 sha1_name.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index a96ca8b..1a77b20 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -6,6 +6,7 @@
 #include "tree-walk.h"
 #include "refs.h"
 #include "cache-tree.h"
+#include "remote.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -241,9 +242,10 @@ static int ambiguous_path(const char *path, int len)
 
 /*
  * *string and *len will only be substituted, and *string returned (for
- * later free()ing) if the string passed in is of the form @{-<n>}.
+ * later free()ing) if the string passed in is of the form @{-<n>} or
+ * of the form %<branch>.
  */
-static char *substitute_nth_last_branch(const char **string, int *len)
+static char *substitute_branch(const char **string, int *len)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret = interpret_nth_last_branch(*string, &buf);
@@ -255,12 +257,24 @@ static char *substitute_nth_last_branch(const char **string, int *len)
 		return (char *)*string;
 	}
 
+	if (**string == '%') {
+		int ours, theirs;
+		struct branch *tracking = branch_get((*string)[1] ?
+			(*string) + 1 : NULL);
+
+		if (tracking->merge && tracking->merge[0]->dst) {
+			*string = xstrdup(tracking->merge[0]->dst);
+			*len = strlen(*string);
+			return (char *)*string;
+		}
+	}
+
 	return NULL;
 }
 
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
-	char *last_branch = substitute_nth_last_branch(&str, &len);
+	char *last_branch = substitute_branch(&str, &len);
 	const char **p, *r;
 	int refs_found = 0;
 
@@ -289,7 +303,7 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 
 int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 {
-	char *last_branch = substitute_nth_last_branch(&str, &len);
+	char *last_branch = substitute_branch(&str, &len);
 	const char **p;
 	int logs_found = 0;
 
-- 
1.6.2.1.422.g885ce.dirty
