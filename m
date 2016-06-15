From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation/technical/racy-git.txt
Date: Tue, 15 Aug 2006 13:12:33 -0700
Message-ID: <7vhd0d7o7i.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
	<20060815090129.5223.17174.stgit@leonov.stosberg.net>
	<7vzme670dm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 15 22:12:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD5HO-0005s2-OX
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 22:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWHOUMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 16:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWHOUMi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 16:12:38 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:21652 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750786AbWHOUMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 16:12:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815201235.ICFR23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Aug 2006 16:12:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org>
In-Reply-To: <7vzme670dm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 15 Aug 2006 03:35:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25477>


Signed-off-by: Junio C Hamano <junkio@cox.net>
---

   Junio C Hamano <junkio@cox.net> writes:

   > We might want to yank out the whole "racy-git avoidance is
   > costly later so let's delay writing the index out" codepath
   > later, but that is a separate issue and needs some testing on
   > large trees to figure it out.  After playing with the kernel
   > tree, I have a feeling that the whole thing may not be worth
   > it.

   Addressed to Linus because he originally brought up this issue
   in <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org>, Johannes
   CC'ed because he had some comments earlier on the same topic
   and he is generally a good person to talk to when I have
   doubts on issues ;-).

 Documentation/technical/racy-git.txt |  193 ++++++++++++++++++++++++++++++++++
 1 files changed, 193 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
new file mode 100644
index 0000000..7597d04
--- /dev/null
+++ b/Documentation/technical/racy-git.txt
@@ -0,0 +1,193 @@
+Use of index and Racy git problem
+=================================
+
+Background
+----------
+
+The index is one of the most important data structure in git.
+It represents a virtual working tree state by recording list of
+paths and their object names and serves as a staging area to
+write out the next tree object to be committed.  The state is
+"virtual" in the sense that it does not necessarily have to, and
+often does not, match the files in the working tree.
+
+There are cases git needs to examine the differences between the
+virtual working tree state in the index and the files in the
+working tree.  The most obvious case is when the user asks `git
+diff` (or its low level implementation, `git diff-files`) or
+`git-ls-files --modified`.  In addition, git internally checks
+if the files in the working tree is different from what are
+recorded in the index to avoid stomping on local changes in them
+during patch application, switching branches, and merging.
+
+In order to speed up this comparison between the files in the
+working tree and the index entries, the index entries record the
+information obtained from the filesystem via `lstat(2)` system
+call when they were last updated.  When checking if they differ,
+git first runs `lstat(2)` on the files and compare the result
+with this information (this is what was originally done by the
+`ce_match_stat()` function, which the current code does in
+`ce_match_stat_basic()` function).  If some of these "cached
+stat information" fields do not match, git can tell that the
+files are modified without even looking at their contents.
+
+Note: not all members in `struct stat` obtained via `lstat(2)`
+are used for this comparison.  For example, `st_atime` obviously
+is not useful.  Currently, git compares the file type (regular
+files vs symbolic links) and executable bits (only for regular
+files) from `st_mode` member, `st_mtime` and `st_ctime`
+timestamps, `st_uid`, `st_gid`, `st_ino`, and `st_size` members.
+With a `USE_STDEV` compile-time option, `st_dev` is also
+compared, but this is not enabled by default because this member
+is not stable on network filesystems.  With `USE_NSEC`
+compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
+members are also compared, but this is not enabled by default
+because the value of this member becomes meaningless once the
+inode is evicted from the inode cache on filesystems that do not
+store it on disk.
+
+
+Racy git
+--------
+
+There is one slight problem with the optimization based on the
+cached stat information.  Consider this sequence:
+
+  $ git update-index 'foo'
+  : modify 'foo' in-place without changing its size
+
+The first `update-index` computes the object name of the
+contents of file `foo` and updates the index entry for `foo`
+along with the `struct stat` information.  If the modification
+that follows it happens very fast so that the file's `st_mtime`
+timestamp does not change, after this sequence, the cached stat
+information the index entry records still exactly match what you
+can obtain from the filesystem, but the file `foo` is modified.
+This way, git can incorrectly think files in the working tree
+are unmodified even though they actually are.  This is called
+the "racy git" problem (discovered by Pasky), and the entries
+that appear clean when they may not be because of this problem
+are called "racily clean".
+
+To avoid this problem, git does two things:
+
+. When the cached stat information says the file has not been
+  modified, and the `st_mtime` is the same as (or newer than)
+  the timestamp of the index file itself (which is the time `git
+  update-index foo` finished running in the above example), it
+  also compares the contents with the object registered in the
+  index entry to make sure they match.
+
+. When the index file is updated that contains racily clean
+  entries, cached `st_size` information is truncated to zero
+  before writing a new version of the index file.
+
+Because the index file itself is written after collecting all
+the stat information from updated paths, `st_mtime` timestamp of
+it is usually the same as or newer than any of the paths the
+index contains.  And no matter how quick the modification that
+follows `git update-index foo` finishes, the resulting
+`st_mtime` timestamp on `foo` cannot get the timestamp earlier
+than the index file.  Therefore, index entries that can be
+racily clean are limited to the ones that have the same
+timestamp as the index file itself.
+
+The callers that want to check if an index entry matches the
+corresponding file in the working tree continue to call
+`ce_match_stat()`, but with this change, `ce_match_stat()` uses
+`ce_modified_check_fs()` to see if racily clean ones are
+actually clean after comparing the cached stat information using
+`ce_match_stat_basic()`.
+
+The problem the latter solves is this sequence:
+
+  $ git update-index 'foo'
+  : modify 'foo' in-place without changing its size
+  : wait for enough time
+  $ git update-index 'bar'
+
+Without the latter, the timestamp of the index file gets a newer
+value, and falsely clean entry `foo` would not be caught by the
+timestamp comparison check done with the former logic anymore.
+The latter makes sure that the cached stat information for `foo`
+would never match with the file in the working tree, so later
+checks by `ce_match_stat_basic()` would report the index entry
+does not match the file and git does not have to fall back on more
+expensive `ce_modified_check_fs()`.
+
+
+Runtime penalty
+---------------
+
+The runtime penalty of falling back to `ce_modified_check_fs()`
+from `ce_match_stat()` can be very expensive when there are many
+racily clean entries.  An obvious way to artificially create
+this situation is to give the same timestamp to all the files in
+the working tree in a large project, run `git update-index` on
+them, and give the same timestamp to the index file:
+
+  $ date >.datestamp
+  $ git ls-files | xargs touch -r .datestamp
+  $ git ls-files | git update-index --stdin
+  $ touch -r .datestamp .git/index
+
+This will make all index entries racily clean.  The linux-2.6
+project, for example, there are over 20,000 files in the working
+tree.  On my Athron 64X2 3800+, after the above:
+
+  $ /usr/bin/time git diff-files
+  1.68user 0.54system 0:02.22elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
+  0inputs+0outputs (0major+67111minor)pagefaults 0swaps
+  $ git update-index MAINTAINERS
+  $ /usr/bin/time git diff-files
+  0.02user 0.12system 0:00.14elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
+  0inputs+0outputs (0major+935minor)pagefaults 0swaps
+
+Running `git update-index` in the middle checked the racily
+clean entries, and left the cached `st_mtime` for all the paths
+intact because they were actually clean (so this step took about
+the same amount of time as the first `git diff-files`).  After
+that, they are not racily clean anymore but are truly clean, so
+the second invocation of `git diff-files` fully took advantage
+of the cached stat information.
+
+
+Avoiding runtime penalty
+------------------------
+
+In order to avoid the above runtime penalty, the recent "master"
+branch (post 1.4.2) has a code that makes sure the index file
+gets timestamp newer than the youngest files in the index when
+there are many young files with the same timestamp as the
+resulting index file would otherwise would have by waiting
+before finishing writing the index file out.
+
+I suspect that in practice the situation where many paths in the
+index are all racily clean is quite rare.  The only code paths
+that can record recent timestamp for large number of paths I
+know of are:
+
+. Initial `git add .` of a large project.
+
+. `git checkout` of a large project from an empty index into an
+  unpopulated working tree.
+
+Note: switching branches with `git checkout` keeps the cached
+stat information of existing working tree files that are the
+same between the current branch and the new branch, which are
+all older than the resulting index file, and they will not
+become racily clean.  Only the files that are actually checked
+out can become racily clean.
+
+In a large project where raciness avoidance cost really matters,
+however, the initial computation of all object names in the
+index takes more than one second, and the index file is written
+out after all that happens.  Therefore the timestamp of the
+index file will be more than one seconds later than the the
+youngest file in the working tree.  This means that in these
+cases there actually will not be any racily clean entry in
+the resulting index.
+
+So in summary I think we should not worry about avoiding the
+runtime penalty and get rid of the "wait before finishing
+writing" code out.
-- 
1.4.2.g59bb
