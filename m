From: Junio C Hamano <junkio@cox.net>
Subject: gitweb sometimes shows branch heads sometimes doesn't
Date: Mon, 09 Jan 2006 01:35:09 -0800
Message-ID: <7v1wzhrbg2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 09 10:35:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvtQp-0008Dz-PM
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 10:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWAIJfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 04:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWAIJfN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 04:35:13 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:23721 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751202AbWAIJfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 04:35:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109093410.ZOAV20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 04:34:10 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14366>

Has anybody wondered why some repositories at kernel.org have
yellowish (#ffffaa) <master> at the latest commit in the
shortlog on the summary page, and some do not have it at all
or have it at a wrong place, i.e. not at the top?

http://www.kernel.org/git/?p=git/git.git;a=summary
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=summary

This is because gitweb looks at info/refs as a shortcut to find
out which commits branch heads and tags are pointing at, in
order to place these markers.  The repositories that do not have
the marker at the right place in gitweb have this file out-of-date.

In fact, most of the repositories at kernel.org seem to either
not have info/refs at all, or have them out-of-date.

This file is updated when git-update-server-info is run on the
repository, along with another file objects/info/packs.  It also
is used by dumb http transfer, so the corollary is that you may
have trouble fetching via http from any repository that does not
show the branch head marker at the latest commit in gitweb.

Attached is a patch to gitweb that I do _not_ really want Kay to
apply, because I think helping people to acquire a good habit to
help others is a good thing, and I would like to encourage
repository owners to do this, so update-server-info is run every
time the repository is pushed into:

	mkdir -p hooks
        cat >hooks/post-update <<\EOF
        #!/bin/sh
        exec git-update-server-info
	EOF
	chmod +x hooks/post-update

The first 5 lines are unneeded for people who initialized the
repository with recent git (later than v0.99.3-g8d5a on Aug 2nd,
2005), because they are likely to have the necessary file from
the templates.

HOWEVER.

If enough repository owners forget to do so, and I suspect some
of them deliberately forget to do so in order to discourage use
of dumb http transfers -- you know whom I mean ;-), at least
gitweb can be helped with this patch.

-- >8 --
[PATCH] Do not rely on info/refs

I personally consider this change is backwards, but many
repositories at kernel.org have obsolete info/refs (i.e. the
owners do not run git-update-server-info in them), so the
information kept there is unfortunately unreliable.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 gitweb.cgi |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

f22fb181cb315bfa14261d81fcaba25154224384
diff --git a/gitweb.cgi b/gitweb.cgi
index 1814f7f..a97859e 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -914,7 +914,9 @@ sub read_info_ref {
 	my %refs;
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
-	open my $fd, "$projectroot/$project/info/refs" or return;
+
+	open my $fd, "-|", "$gitbin/git", "ls-remote", "$projectroot/$project"
+		or return;
 	while (my $line = <$fd>) {
 		chomp($line);
 		if ($line =~ m/^([0-9a-fA-F]{40})\t.*$type\/([^\^]+)/) {
-- 
1.1.0
