From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix machine-parseability of 'git log --source'
Date: Sat, 15 Nov 2008 10:02:01 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811150947430.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 19:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1PUZ-0003pC-IG
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 19:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbYKOSCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 13:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbYKOSCK
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 13:02:10 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35353 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751756AbYKOSCJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2008 13:02:09 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAFI22Wi011132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Nov 2008 10:02:04 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAFI21lX020105;
	Sat, 15 Nov 2008 10:02:01 -0800
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.43 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101082>


The space between the commit and the source attribute is not easily 
machine-parseable: if we combine --source with --parents and give a SHA1 
as a starting point, it's unnecessarily hard to see where the list of 
parents ends and the source decoration begins.

Example:
	git show --parents --source $(git rev-list HEAD)

which is admittedly contrived, but can easily happen in scripting.

So use a <tab> instead of a space as the source separator.

The other decorations didn't have this issue, because they were surrounded 
by parenthesis, so it's obvious that they aren't parent SHA1's.

It so happens that _visually_ this makes no difference for "git log 
--source", since "commit <40-char SHA1>" is 47 characters, so both a space 
and a <tab> will end up showing as a single commit. Of course, with 
'--pretty=oneline' or '--parents' or '--abbrev-commit' you'll see the 
difference.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is all partly because I also wish that 'gitk' would use --decorate to 
give decorations rather than look them up by hand. I'm not entirely source 
--source is useful for gitk (since it wants _all_ branches), but I do know 
that I hate knowing that

	gitk --source

just results in parse errors.

 log-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5444f08..194ddb1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -58,7 +58,7 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 	struct name_decoration *decoration;
 
 	if (opt->show_source && commit->util)
-		printf(" %s", (char *) commit->util);
+		printf("\t%s", (char *) commit->util);
 	if (!opt->show_decorations)
 		return;
 	decoration = lookup_decoration(&name_decoration, &commit->object);
