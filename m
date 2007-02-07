From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git log filtering
Date: Wed, 7 Feb 2007 18:25:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 18:32:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEqXf-0000bf-FL
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 18:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161387AbXBGRZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 12:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161397AbXBGRZH
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 12:25:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:59903 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161396AbXBGRZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 12:25:06 -0500
Received: (qmail invoked by alias); 07 Feb 2007 17:25:04 -0000
X-Provags-ID: V01U2FsdGVkX1/08D1yD3709ONkH/5UphCpi0EBdoKLirdw5B1MSG
	olzA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38945>

Hi,

On Wed, 7 Feb 2007, Linus Torvalds wrote:

> You can do
> 
> 	git log --grep="Signed-off-by:.*akpm"
> 
>    on the kernel archive to see which ones were signed off by Andrew.
> 
> So the above works, and catches *most* uses. But it has problems if you 
> want to do something fancier (and I think that includes something as 
> simple as doing a case-insensitive grep).

[TIC PATCH] revision.c: accept "-i" to make --grep case insensitive

When calling

	git log --grep=blabla -i --grep=blublu

the expression "blabla" is greppend case _sensitively_, but "blublu"
case _insensitively_.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 revision.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 42ba310..843aa8e 100644
--- a/revision.c
+++ b/revision.c
@@ -9,6 +9,8 @@
 #include "grep.h"
 #include "reflog-walk.h"
 
+static int case_insensitive_grep = 0;
+
 static char *path_name(struct name_path *path, const char *name)
 {
 	struct name_path *p;
@@ -742,6 +744,8 @@ static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token
 		opt->status_only = 1;
 		opt->pattern_tail = &(opt->pattern_list);
 		opt->regflags = REG_NEWLINE;
+		if (case_insensitive_grep)
+			opt->regflags |= REG_ICASE;
 		revs->grep_filter = opt;
 	}
 	append_grep_pattern(revs->grep_filter, ptn,
@@ -1042,6 +1046,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				add_header_grep(revs, "committer", arg+12);
 				continue;
 			}
+			if (!strcmp(arg, "-i") ||
+					!strcmp(arg, "--case-insensitive")) {
+				case_insensitive_grep = 1;
+				continue;
+			}
 			if (!strncmp(arg, "--grep=", 7)) {
 				add_message_grep(revs, arg+7);
 				continue;
