From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix broken sha1 locking
Date: Tue, 19 Sep 2006 22:58:23 +0200
Message-ID: <20060919205823.18579.59604.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 19 22:58:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPmfk-0003xI-5k
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 22:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbWISU6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbWISU6Z
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 16:58:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42195 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1752070AbWISU6Y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 16:58:24 -0400
Received: (qmail 18589 invoked from network); 19 Sep 2006 22:58:23 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 19 Sep 2006 22:58:23 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27283>

Current git#next is totally broken wrt. cloning over HTTP, generating refs
at random directories. Of course it's caused by the static get_pathname()
buffer. lock_ref_sha1() stores return value of mkpath()'s get_pathname()
call, then calls lock_ref_sha1_basic() which calls git_path(ref) which
calls get_pathname() at that point returning pointer to the same buffer.
So now you are sprintf()ing a format string into itself, wow! The resulting
pathnames are really cute. (If you've been paying attention, yes, the
mere fact that a format string _could_ write over itself is very wrong
and probably exploitable here. See the other mail I've just sent.)

I've never liked how we use return values of those functions so liberally,
the "allow some random number of get_pathname() return values to work
concurrently" is absolutely horrible pit and we've already fallen in this
before IIRC. I consider it an awful coding practice, you add a call
somewhere and at some other point some distant caller of that breaks since
it reuses the same return values. Not to mention this takes quite some time
to debug.

My gut feeling tells me that there might be more of this.  I don't have
time to review the rest of the users of the refs.c functions though.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 refs.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 134c0fc..7bd36e4 100644
--- a/refs.c
+++ b/refs.c
@@ -462,10 +462,12 @@ static struct ref_lock *lock_ref_sha1_ba
 struct ref_lock *lock_ref_sha1(const char *ref,
 	const unsigned char *old_sha1, int mustexist)
 {
+	char refpath[PATH_MAX];
 	if (check_ref_format(ref))
 		return NULL;
-	return lock_ref_sha1_basic(mkpath("refs/%s", ref),
-		5 + strlen(ref), old_sha1, mustexist);
+	strcpy(refpath, mkpath("refs/%s", ref));
+	return lock_ref_sha1_basic(refpath, strlen(refpath),
+		old_sha1, mustexist);
 }
 
 struct ref_lock *lock_any_ref_for_update(const char *ref,
