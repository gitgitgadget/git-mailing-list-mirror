From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Make merge-recursive honor diff.renamelimit
Date: Tue, 25 Sep 2007 08:36:38 +0200
Message-ID: <1190702198133-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 08:38:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia44D-0000fb-IY
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 08:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXIYGih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 02:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbXIYGih
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 02:38:37 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:52100 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbXIYGig (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 02:38:36 -0400
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id l8P6cMF0007128;
	Tue, 25 Sep 2007 08:38:22 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.1.1.g1e61
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59096>

It might be a sign of source code management gone bad, but when two branches
has diverged almost beyond recognition and time has come for the branches to
merge, the user is going to need all the help his tool can give him. Honoring
diff.renamelimit has great potential as a painkiller in such situations.

The painkiller effect could have been achieved by e.g. 'merge.renamelimit',
but the flexibility gained by a separate option is questionable: our user
would probably expect git to detect renames equally good when merging as
when diffing (I known I did).

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---


On 9/14/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> The choice of default value is of course very debatable. Limiting the
> rename matrix to a 100x100 size will mean that even if you have just one
> obvious rename, but you also create (or delete) 10,000 files, the rename
> matrix will be so big that we disable the heuristics. Sounds reasonable to
> me, but let's see if people hit this (and, perhaps more importantly,
> actually *care*) in real life.

Yeah, I got hit, and I care ;-)


 merge-recursive.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 19d5f3b..97dcf9b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -96,6 +96,7 @@ static struct path_list current_directory_set = {NULL, 0, 0, 1};
 
 static int call_depth = 0;
 static int verbosity = 2;
+static int rename_limit = -1;
 static int buffer_output = 1;
 static struct output_buffer *output_list, *output_end;
 
@@ -372,6 +373,7 @@ static struct path_list *get_renames(struct tree *tree,
 	diff_setup(&opts);
 	opts.recursive = 1;
 	opts.detect_rename = DIFF_DETECT_RENAME;
+	opts.rename_limit = rename_limit;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
 		die("diff setup failed");
@@ -1693,6 +1695,10 @@ static int merge_config(const char *var, const char *value)
 		verbosity = git_config_int(var, value);
 		return 0;
 	}
+	if (!strcasecmp(var, "diff.renamelimit")) {
+		rename_limit = git_config_int(var, value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
-- 
1.5.3.2.1054.g35b0b
