From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb using "--cc"?
Date: Sat, 11 Feb 2006 12:59:36 -0800
Message-ID: <7vslqplih3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	<7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091235210.2458@g5.osdl.org>
	<7v8xsk9s3v.fsf@assigned-by-dhcp.cox.net>
	<7v4q389rwi.fsf@assigned-by-dhcp.cox.net>
	<7voe1g8air.fsf@assigned-by-dhcp.cox.net>
	<7vk6c48a69.fsf@assigned-by-dhcp.cox.net>
	<7v3bis88y9.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550602110117i7b742351m14e908de10aac12c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 22:00:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F81qW-0007XN-7w
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 21:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWBKU7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 15:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWBKU7j
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 15:59:39 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:3541 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932354AbWBKU7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 15:59:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211205809.KXGW6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 15:58:09 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550602110117i7b742351m14e908de10aac12c@mail.gmail.com>
	(Marco Costalba's message of "Sat, 11 Feb 2006 10:17:19 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15963>

Marco Costalba <mcostalba@gmail.com> writes:

> Please _do not_ change this behaviour to make -m a no-op as stated in
> "diff-tree -c raw output" patch message
> (ee63802422af14e43eccce3c6dc4150a27ceb1a3).
>
> qgit has the possibility to switch from "see all merge files"
> to "see interesting only", so we really need that difference
> between 'git-diff-tree -r' and 'git-diff-tree -r -m'

Let me make sure I am not misreading you.  You are proposing to
revert making -m a no-op.  So '-r' and '-r -m' would do
different things, like illustrated in the log message below.

All of the above combinations of flags produces the same result
for non-merge commit, by the way.

Ack, or did I grossly misunderstand what you wanted?

-- >8 --
[PATCH] diff-tree: do not default to -c

Marco says it breaks qgit.  This makes the flags a bit more
orthogonal.

  $ git-diff-tree -r --abbrev ca18

    No output from this command because you asked to skip merge by
    not having -m there.

  $ git-diff-tree -r -m --abbrev ca18
  ca182053c7710a286d72102f4576cf32e0dafcfb
  :100644 100644 538d21d... 59042d1... M	Makefile
  :100644 100644 410b758... 6c47c3a... M	entry.c
  ca182053c7710a286d72102f4576cf32e0dafcfb
  :100644 100644 30479b4... 59042d1... M	Makefile

    The same "independent sets of diff" as before without -c.

  $ git-diff-tree -r -m -c --abbrev ca18
  ca182053c7710a286d72102f4576cf32e0dafcfb
  ::100644 100644 100644 538d21d... 30479b4... 59042d1... MM	Makefile

    Combined.

  $ git-diff-tree -r -c --abbrev ca18
  ca182053c7710a286d72102f4576cf32e0dafcfb
  ::100644 100644 100644 538d21d... 30479b4... 59042d1... MM	Makefile

    Asking for combined without -m does not make sense, so -c
    implies -m.

We need to supply -c as default to whatchanged, which is a
one-liner.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/diff-tree.c b/diff-tree.c
index b170b03..f55a35a 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -6,7 +6,7 @@ static int show_root_diff = 0;
 static int no_commit_id = 0;
 static int verbose_header = 0;
 static int ignore_merges = 1;
-static int combine_merges = 1;
+static int combine_merges = 0;
 static int dense_combined_merges = 0;
 static int read_stdin = 0;
 static int always_show_header = 0;
@@ -248,7 +248,7 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strcmp(arg, "-m")) {
-			combine_merges = ignore_merges = 0;
+			ignore_merges = 0;
 			continue;
 		}
 		if (!strcmp(arg, "-c")) {
diff --git a/git-whatchanged.sh b/git-whatchanged.sh
index 574fc35..1fb9feb 100755
--- a/git-whatchanged.sh
+++ b/git-whatchanged.sh
@@ -10,7 +10,7 @@ case "$0" in
 	count=
 	test -z "$diff_tree_flags" &&
 		diff_tree_flags=$(git-repo-config --get whatchanged.difftree)
-	diff_tree_default_flags='-M --abbrev' ;;
+	diff_tree_default_flags='-c -M --abbrev' ;;
 *show)
 	count=-n1
 	test -z "$diff_tree_flags" &&
