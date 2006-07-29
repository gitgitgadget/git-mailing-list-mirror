From: Shawn Pearce <spearce@spearce.org>
Subject: Re: print errors from git-update-ref
Date: Fri, 28 Jul 2006 23:44:51 -0400
Message-ID: <20060729034451.GB28128@spearce.org>
References: <81b0412b0607180613t603551b8t865b407c40ab8aef@mail.gmail.com> <7vk663h6zi.fsf@assigned-by-dhcp.cox.net> <20060727012856.GB32492@spearce.org> <Pine.LNX.4.63.0607271302150.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060728062720.GC30783@spearce.org> <7vejw6mbqj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 29 05:45:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6flG-0000oZ-Nr
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 05:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbWG2DpB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 23:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161400AbWG2DpB
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 23:45:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:15321 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1752069AbWG2DpA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 23:45:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G6fkq-0002oW-6E; Fri, 28 Jul 2006 23:44:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C4EAE20E433; Fri, 28 Jul 2006 23:44:51 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejw6mbqj.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24410>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> Hi,
> >> 
> >> On Wed, 26 Jul 2006, Shawn Pearce wrote:
> >> 
> >> > This change adds a test for trying to create a ref within a directory
> >> > that is actually currently a file, and adds error printing within
> >> > the ref locking routine should the resolve operation fail.
> >> 
> >> Why not just print an error message when the resolve operation fails, 
> >> instead of special casing this obscure corner case? It is way shorter, 
> >> too. The test should stay, though.
> >
> > Did you read the patch?  If resolve_ref returns NULL then this
> > change prints an error (from errno) no matter what.  If errno is
> > ENOTDIR then it tries to figure out what part of the ref path wasn't
> > a directory (but was attempted to be used as such) and prints an
> > ENOTDIR error about that path instead of the one actually given
> > to the ref lock function
> >
> > So I think I'm doing what you are suggesting...
>
[snip]
> But the last step does not take into account what resolve_ref()
> does, doesn't it?  What if orig_path is "HEAD", which is a
> symref, which contained "ref: refs/heads/myhack/one" and
> "refs/heads/myhack" is a file?  Ideally you may want to say
> something like:
> 
>      '''while resolving %s, which points at %s,
>         we found out %s is not a directory''' %
>         ("HEAD", "refs/heads/myhack/one", "refs/heads/myhack")
> 
> So I tend to agree with Johannes's "why bother?" reaction.

OK, that's a bug.  It would be horribly misleading.  So I'm taking
the shortcut here and just telling the user ENOTDIR and orig_path
rather than resolving it and finding that bad directory component.

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
 refs.c                |    5 +++++
 t/t1400-update-ref.sh |   12 ++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 56db394..02850b6 100644
--- a/refs.c
+++ b/refs.c
@@ -294,6 +294,7 @@ static struct ref_lock *lock_ref_sha1_ba
 	int plen,
 	const unsigned char *old_sha1, int mustexist)
 {
+	const char *orig_path = path;
 	struct ref_lock *lock;
 	struct stat st;
 
@@ -303,7 +304,11 @@ static struct ref_lock *lock_ref_sha1_ba
 	plen = strlen(path) - plen;
 	path = resolve_ref(path, lock->old_sha1, mustexist);
 	if (!path) {
+		int last_errno = errno;
+		error("unable to resolve reference %s: %s",
+			orig_path, strerror(errno));
 		unlock_ref(lock);
+		errno = last_errno;
 		return NULL;
 	}
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 04fab26..ddc80bb 100755
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
+	 grep $n err'
+rm -f .git/$n_dir out err
+
+test_expect_success \
 	"create $m (by HEAD)" \
 	'git-update-ref HEAD $A &&
 	 test $A = $(cat .git/$m)'
-- 
1.4.2.rc1.g802da
