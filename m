From: Jon Loeliger <jdl@jdl.com>
Subject: [RFC] Silent File Mods Being Committed
Date: Wed, 22 Mar 2006 22:04:32 -0600
Message-ID: <E1FMH3o-0001B5-Dw@jdl.com>
X-From: git-owner@vger.kernel.org Thu Mar 23 05:05:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMH4N-00082k-3K
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 05:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbWCWEE5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 23:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbWCWEE5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 23:04:57 -0500
Received: from www.jdl.com ([66.118.10.122]:7846 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S965182AbWCWEE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 23:04:56 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FMH3o-0001B5-Dw
	for git@vger.kernel.org; Wed, 22 Mar 2006 22:04:33 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17852>

Folks,

I sort of got blindsided by committing (accidental) mode
changes on a file that was also textually changed.  Because
it was textually changed, I happily expected 'git status'
to show it as modified and subsequently 'git commit'-ed it.

Only after I 'git diff'-ed it later did I see that there
was also a mode change on the file!  Argh!

Secondarily, I think that the invisible file changes like
this caused an eariler (yesterday-ish) confusion where an
index looked clean, but was dirty due to stat issues and
poor users (me) couldn't quite see why.

Originally, I was going to propose that git-ls-files be modified
such that the mode and stat changes that ce_modified() correctly
identifies as changing are somehow translated into output that
"git status" shows the user per-file _in_addition_ to the normal
"is modified" header.  So I did this mod:


diff --git a/ls-files.c b/ls-files.c
index df25c8c..3e7e55d 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -450,7 +450,7 @@ static void show_killed_files(void)
 	}
 }
 
-static void show_ce_entry(const char *tag, struct cache_entry *ce)
+static void show_ce_entry(const char *tag, struct cache_entry *ce, int changed)
 {
 	int len = prefix_len;
 	int offset = prefix_offset;
@@ -482,6 +482,14 @@ static void show_ce_entry(const char *ta
 		fputs(tag, stdout);
 		write_name_quoted("", 0, ce->name + offset,
 				  line_terminator, stdout);
+		if (changed & (MTIME_CHANGED | CTIME_CHANGED)) {
+		    putchar(' ');
+		    putchar('T');
+		}
+		if (changed & MODE_CHANGED) {
+		    putchar(' ');
+		    putchar('M');
+		}
 		putchar(line_terminator);
 	}
 	else {
@@ -541,7 +549,7 @@ static void show_files(void)
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
-			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce);
+			show_ce_entry(ce_stage(ce) ? tag_unmerged : tag_cached, ce, 0);
 		}
 	}
 	if (show_deleted | show_modified) {
@@ -553,9 +561,13 @@ static void show_files(void)
 				continue;
 			err = lstat(ce->name, &st);
 			if (show_deleted && err)
-				show_ce_entry(tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st, 0))
-				show_ce_entry(tag_modified, ce);
+				show_ce_entry(tag_removed, ce, 0);
+			if (show_modified) {
+				int changed = ce_modified(ce, &st, 0);
+				if (changed)
+					show_ce_entry(tag_modified,
+						      ce, changed);
+			}
 		}
 	}
 }


And with that, "git ls-file -m" showed a trailing T or M to
indicate a "time" or a "mode" change happened on each file.

However, 'git status' didn't show that output....

And that is because it is driven by the diffcore instead!
So I _think_ diff_resolve_rename_copy() has to be consulted
to get that DIFF_STATUS_MODIFIED indicator.  Except that it is
shared with the SHA1 compare too:

                else if (memcmp(p->one->sha1, p->two->sha1, 20) ||
                         p->one->mode != p->two->mode)
                        p->status = DIFF_STATUS_MODIFIED;

But I haven't tracked it back to see how to propagate that
status back up to show_modified() in diff-files.c yet...

Maybe there is an easier way...?

jdl
