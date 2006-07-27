From: Shawn Pearce <spearce@spearce.org>
Subject: Re: print errors from git-update-ref
Date: Wed, 26 Jul 2006 21:28:56 -0400
Message-ID: <20060727012856.GB32492@spearce.org>
References: <81b0412b0607180613t603551b8t865b407c40ab8aef@mail.gmail.com> <7vk663h6zi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 03:29:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5uge-0007Hp-0n
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 03:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWG0B3D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 21:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWG0B3D
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 21:29:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:14287 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751846AbWG0B3B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 21:29:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G5ugC-0006ZJ-9M; Wed, 26 Jul 2006 21:28:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 360F620FB77; Wed, 26 Jul 2006 21:28:57 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk663h6zi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24265>

Junio C Hamano <junkio@cox.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> 
> > ...otherwise it not clear what happened when update-ref fails.
> >
> > E.g., git checkout -b a/b/c HEAD would print nothing if refs/heads/a
> > exists and is a directory (it does return 1, so scripts checking for
> > return code should be ok).
> 
> My gut feeling is that complaining from update-ref is fine, but
> I am still tired after a long week and not thinking straight, so
> I will not be applying this tonight.

So I looked into this issue tonight.  For starters I can't seem to
reproduce the situtation reported by Alex, and since he didn't
supply new test cases its difficult to actually fix it.

I did however find problems with git-update-ref a/b/c when a is
actually an existing ref.  This didn't report any error, so here's
a fix.  It may resolve Alex's problem - or maybe not.

-->8--
Display an error from update-ref if target ref name is invalid.

Alex Riesen (raa.lkml@gmail.com) recently observed that git branch
would fail with no error message due to unexpected situations with
regards to refs.  For example, if .git/refs/heads/gu is a file but
`git branch -b refs/heads/gu/fixa HEAD` was invoked by the user
it would fail silently due to refs/heads/gu being a file and not
a directory.

This change adds a test for trying to create a ref within a directory
that is actually currently a file, and adds error printing within
the ref locking routine should the resolve operation fail.

The error printing code probably belongs at this level of the library
as other failures within the ref locking, writing and logging code
are also currently at this level of the code.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 refs.c                |   33 +++++++++++++++++++++++++++++++++
 t/t1400-update-ref.sh |   12 ++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 56db394..e99e9e4 100644
--- a/refs.c
+++ b/refs.c
@@ -290,10 +290,33 @@ static struct ref_lock *verify_lock(stru
 	return lock;
 }
 
+static char* not_a_directory (const char *orig_path)
+{
+	char *p = strdup(orig_path);
+	struct stat st;
+
+	do {
+		char * s = strrchr(p, '/');
+		if (s) {
+			*s = 0;
+			if (lstat(p, &st) == 0 && S_ISDIR(st.st_mode)) {
+				*s = '/';
+				break;
+			}
+		} else {
+			strcpy(p, orig_path);
+			break;
+		}
+	} while (errno == ENOTDIR);
+
+	return p;
+}
+
 static struct ref_lock *lock_ref_sha1_basic(const char *path,
 	int plen,
 	const unsigned char *old_sha1, int mustexist)
 {
+	const char *orig_path = path;
 	struct ref_lock *lock;
 	struct stat st;
 
@@ -303,7 +326,17 @@ static struct ref_lock *lock_ref_sha1_ba
 	plen = strlen(path) - plen;
 	path = resolve_ref(path, lock->old_sha1, mustexist);
 	if (!path) {
+		int last_errno = errno;
+		if (errno == ENOTDIR) {
+			char* p = not_a_directory(orig_path);
+			error("unable to resolve reference %s: %s",
+				p, strerror(errno));
+			free(p);
+		} else
+			error("unable to resolve reference %s: %s",
+				orig_path, strerror(errno));
 		unlock_ref(lock);
+		errno = last_errno;
 		return NULL;
 	}
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 04fab26..e73827c 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -14,6 +14,8 @@ D=44444444444444444444444444444444444444
 E=5555555555555555555555555555555555555555
 F=6666666666666666666666666666666666666666
 m=refs/heads/master
+n_dir=refs/heads/gu
+n=$n_dir/fixes
 
 test_expect_success \
 	"create $m" \
@@ -26,6 +28,16 @@ test_expect_success \
 rm -f .git/$m
 
 test_expect_success \
+	"fail to create $n" \
+	'touch .git/$n_dir
+	 git-update-ref $n $A >out 2>err
+	 test $? = 1 &&
+	 test "" = "$(cat out)" &&
+	 grep "error: unable to resolve reference" err &&
+	 grep $n_dir err'
+rm -f .git/$n_dir out err
+
+test_expect_success \
 	"create $m (by HEAD)" \
 	'git-update-ref HEAD $A &&
 	 test $A = $(cat .git/$m)'
-- 
1.4.2.rc1.g802da
