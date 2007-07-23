From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Sun, 22 Jul 2007 21:45:23 -0700
Message-ID: <7v1wezohi4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
	<Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
	<Pine.LNX.4.64.0707222223460.14781@racer.site>
	<Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
	<Pine.LNX.4.64.0707222255010.14781@racer.site>
	<Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
	<Pine.LNX.4.64.0707230000020.14781@racer.site>
	<20070723035644.GC32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 06:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICpnV-00076S-ER
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 06:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbXGWEpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 00:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbXGWEpZ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 00:45:25 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64936 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbXGWEpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 00:45:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070723044524.NYBN1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Jul 2007 00:45:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SslN1X00g1kojtg0000000; Mon, 23 Jul 2007 00:45:23 -0400
In-Reply-To: <20070723035644.GC32566@spearce.org> (Shawn O. Pearce's message
	of "Sun, 22 Jul 2007 23:56:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53389>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I live by new-workdir.  I do everything with it.  And today I just
> spent over an hour sorting out cases where my many, many workdirs
> have different refs than their base repositories, because their
> packed-refs files are different.  Grrrrrrrrrrrrrrrrrr.
>
> So we really need to make anyone that edits packed-refs (and
> maybe also config) resolve the symlink and do the edit in the
> target directory.  Then we can consider adding this workdir thing
> to core git.

This is actually not limited to packed-refs file, but applies to
other things as well.

I have been wondering if something like this patch would be
sufficient.  The idea essentially is to take the lock on the
link target when we try to take a lock on something that is a
symlink pointing elsewhere.

---

 lockfile.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index fb8f13b..7fc71d9 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -28,6 +28,17 @@ static void remove_lock_file_on_signal(int signo)
 static int lock_file(struct lock_file *lk, const char *path)
 {
 	int fd;
+	struct stat st;
+
+	if ((!lstat(path, &st)) && S_ISLNK(st.st_mode)) {
+		ssize_t sz;
+		static char target[PATH_MAX];
+		sz = readlink(path, target, sizeof(target));
+		if (sz < 0)
+			warning("Cannot readlink %s", path);
+		else
+			path = target;
+	}
 	sprintf(lk->filename, "%s.lock", path);
 	fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= fd) {
