From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git.c: avoid allocating one-too-many elements for new argv array
Date: Tue, 30 Jun 2009 15:24:13 -0500
Message-ID: <5TvnwnOe5CdWOiVI3-C6R28MSiRiTmlwLVDBsVsXh5WsVbT0-8FT803CQ2tY3PR_02aq3nSSHjc@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 22:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLjtg-00051Y-Dd
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbZF3UZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbZF3UZ1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:25:27 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51318 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbZF3UZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:25:26 -0400
Received: by mail.nrlssc.navy.mil id n5UKOV0u012036; Tue, 30 Jun 2009 15:24:32 -0500
X-OriginalArrivalTime: 30 Jun 2009 20:24:31.0171 (UTC) FILETIME=[C63D4130:01C9F9C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122531>

From: Brandon Casey <drafnel@gmail.com>

When creating a new argv array from a configured alias and the supplied
command line arguments, the new argv was allocated with one element too
many.  Since the first element of the original argv array is skipped when
copying it to the new_argv, the number of elements that are allocated
should be reduced by one.  'count' is the number of elements that new_argv
contains, and *argcp is the number of elements in the original argv array.
So the total allocation (including the terminating NULL entry) for the
new_argv array should be:

  count + (*argcp - 1) + 1

Also, the explicit assignment of the NULL terminating entry can be avoided
by just copying it over from the original argv array.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 7d7f949..f4d53f4 100644
--- a/git.c
+++ b/git.c
@@ -188,10 +188,9 @@ static int handle_alias(int *argcp, const char ***argv)
 				  alias_command);
 
 		new_argv = xrealloc(new_argv, sizeof(char *) *
-				    (count + *argcp + 1));
+				    (count + *argcp));
 		/* insert after command name */
 		memcpy(new_argv + count, *argv + 1, sizeof(char *) * *argcp);
-		new_argv[count+*argcp] = NULL;
 
 		*argv = new_argv;
 		*argcp += count - 1;
-- 
1.6.3.1.24.g152f4
