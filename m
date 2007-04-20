From: Peter Baumann <waste.manager@gmx.de>
Subject: [PATCH] pack-refs: dereference .git/packed-refs if it is a symlink
Date: Fri, 20 Apr 2007 18:52:56 +0200
Message-ID: <20070420165256.GA14318@xp.machine.xx>
References: <Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk> <7vfy6xird9.fsf@assigned-by-dhcp.cox.net> <20070418174350.GB5913@xp.machine.xx> <7vlkgph7i0.fsf@assigned-by-dhcp.cox.net> <20070418183156.GF5913@xp.machine.xx> <7v647th6cv.fsf@assigned-by-dhcp.cox.net> <20070418210819.GG5913@xp.machine.xx> <7v4pndfjym.fsf@assigned-by-dhcp.cox.net> <20070419053518.GK5913@xp.machine.xx> <7vabx499u2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 18:53:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HewM8-0007NB-7k
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 18:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767153AbXDTQwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 12:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767144AbXDTQwz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 12:52:55 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:54641 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1767153AbXDTQwy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 12:52:54 -0400
Received: (qmail 1381 invoked by uid 0); 20 Apr 2007 16:52:51 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 20 Apr 2007 16:52:51 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Julian Phillips <julian@quantumfyre.co.uk>
Content-Disposition: inline
In-Reply-To: <7vabx499u2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45116>

git-new-workdir creates a new working directory where everything
necessary, including .git/packed-refs, is symlinked to your master repo.
But git-pack-refs breaks the symlink, so you could accidentally loose some
refs.

This fixes git-pack-refs to first dereference .git/packed-refs if it is a
symlink. While we are it, add some tests to prevent this from happening
again.

Signed-off-by: Peter Baumann <waste.manager@gmx.de>
---
On Wed, Apr 18, 2007 at 11:06:45PM -0700, Junio C Hamano wrote:
> Peter Baumann <waste.manager@gmx.de> writes:
> 
> > Signed-off-by: Peter Baumann <waste.manager@gmx.de>
> > ---
> > On Wed, Apr 18, 2007 at 02:31:29PM -0700, Junio C Hamano wrote:
> >> An additional test or two in t/t3210 would be nice to accompany
> >> this change.
> >> 
> >
> > Something like this?
> 
> That's a good start, but I expected to see at least tests for
> two cases: a case in which .git/packed-refs symlink points at an
> actual file (i.e. the original repository has run pack-refs) and
> another case in which .git/packed-refs symlink is dangling
> (i.e. the original repository hasn't run pack-refs).  I
> understand that the borrower "worktree" can have .git/packed-refs
> symlink pointing at the repositories .git/packed-refs yet to be
> born.
> builtin-pack-refs.c  |   18 +++++++++++++++++-

As I couldn't find anything related to this in your repo, I added a test
for a danling symklink and integrated your little fix to check for
doubly symlinked files for easier handling and to not mess up the
history with all does tiny "fixes"

Greetings,
  Peter

 t/t3210-pack-refs.sh |   15 +++++++++++++++
 2 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index d080e30..1ce4f55 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -89,6 +89,8 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	int fd, i;
 	struct pack_refs_cb_data cbdata;
+	struct stat st;
+	char *ref_file_name;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 
@@ -113,7 +115,21 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	if (i != argc)
 		usage(builtin_pack_refs_usage);
 
-	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"), 1);
+	ref_file_name = git_path("packed-refs");
+	if (!lstat(ref_file_name, &st) && S_ISLNK(st.st_mode)) {
+		char *buf = xmalloc(st.st_size + 1);
+		if (readlink(ref_file_name, buf, st.st_size + 1) != st.st_size) {
+			free(buf);
+			die("readlink failed\n");
+		}
+		buf[st.st_size] = '\0';
+		if (!lstat(buf, &st) && S_ISLNK(st.st_mode))
+			die("cannot have doubly symlinked packed-refs file: %s",
+			    ref_file_name);
+		ref_file_name = buf;
+	}
+
+	fd = hold_lock_file_for_update(&packed, ref_file_name, 1);
 	cbdata.refs_file = fdopen(fd, "w");
 	if (!cbdata.refs_file)
 		die("unable to create ref-pack file structure (%s)",
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index f0c7e22..5756304 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -105,4 +105,19 @@ test_expect_success 'pack, prune and repack' '
 	diff all-of-them again
 '
 
+test_expect_success \
+	'derefence symlinks for packed-refs' \
+	'mv -f .git/packed-refs .git/real_packed-refs &&
+	ln -s `pwd`/.git/real_packed-refs .git/packed-refs &&
+	git-tag z &&
+	git-pack-refs --prune &&
+	diff .git/real_packed-refs .git/packed-refs'
+
+test_expect_success \
+	'derefence dangling symlinks for packed-refs' \
+	'git branch dangling_symlink &&
+	rm .git/real_packed-refs
+	git-pack-refs --all --prune &&
+	diff .git/real_packed-refs .git/packed-refs'
+
 test_done
-- 
1.5.1
