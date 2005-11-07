From: Junio C Hamano <junkio@cox.net>
Subject: Re: Expected Behavior?
Date: Sun, 06 Nov 2005 17:38:32 -0800
Message-ID: <7vy841utif.fsf@assigned-by-dhcp.cox.net>
References: <E1EYsny-0004hq-IW@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 02:40:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYvyI-0001n2-3l
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 02:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVKGBie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 20:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVKGBie
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 20:38:34 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:36295 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932285AbVKGBie (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 20:38:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107013746.ZVQT776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 20:37:46 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EYsny-0004hq-IW@jdl.com> (Jon Loeliger's message of "Sun, 06
	Nov 2005 16:16:02 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11245>

Jon Loeliger <jdl@freescale.com> writes:

>     # Untracked files:
>     #   (use "git add" to add to commit)
>     #
>     #       file3
>
> Why is file3 considered untracked and needing to be added?
> It was present in both "dev" and "master" branches before
> the merge.  It doesn't end up with "<<< one === other >>>"
> style diffs either.

It is because Untracked uses different program than git-diff-*
and, it mishandles unmerged paths.  Let me see...

Yup, it uses "git-ls-files --others", which considers that
unmerged paths do not "exist" in the index.  This is wrong.

The attached is a patch to fix ls-files.

I also think that file3 should not appear in "Updated but not
checked in (will commit)" list -- we are _not_ going to commit
unmerged paths until you tell git what you want to do with
them.  The patch in the next message fixes it.

-- >8 -- cut here -- >8 --
Subject: ls-files: --others should not say unmerged paths are unknown.

Jon Loeliger noticed that an unmerged path appears as
"Untracked" in git-status output, even though we show the same
path as updated/changed.  Since --others means "we have not told
git about that path", we should not show unmerged paths --
obviously, git knows about them; it just does not know what we
want to do about them yet.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 ls-files.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

applies-to: f571975209b0bc38ca099684f9731efe4163b396
fcbc3083e37f3c025d85d7b2c8a1c53d07a81fac
diff --git a/ls-files.c b/ls-files.c
index d9c8b21..f7653e7 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -348,6 +348,29 @@ static void show_dir_entry(const char *t
 	putchar(line_terminator);
 }
 
+static void show_other_files(void)
+{
+	int i;
+	for (i = 0; i < nr_dir; i++) {
+		/* We should not have a matching entry, but we
+		 * may have an unmerged entry for this path.
+		 */
+		struct nond_on_fs *ent = dir[i];
+		int pos = cache_name_pos(ent->name, ent->len);
+		struct cache_entry *ce;
+		if (0 <= pos)
+			die("bug in show-other-files");
+		pos = -pos - 1;
+		if (pos < active_nr) { 
+			ce = active_cache[pos];
+			if (ce_namelen(ce) == ent->len &&
+			    !memcmp(ce->name, ent->name, ent->len))
+				continue; /* Yup, this one exists unmerged */
+		}
+		show_dir_entry(tag_other, ent);
+	}
+}
+
 static void show_killed_files(void)
 {
 	int i;
@@ -438,8 +461,7 @@ static void show_files(void)
 		read_directory(path, base, baselen);
 		qsort(dir, nr_dir, sizeof(struct nond_on_fs *), cmp_name);
 		if (show_others)
-			for (i = 0; i < nr_dir; i++)
-				show_dir_entry(tag_other, dir[i]);
+			show_other_files();
 		if (show_killed)
 			show_killed_files();
 	}
---
0.99.9.GIT
