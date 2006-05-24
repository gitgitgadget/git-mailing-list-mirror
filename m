From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [RFC][PATCH] Allow transfer of any valid sha1
Date: Wed, 24 May 2006 01:51:36 -0600
Message-ID: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 24 09:52:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FioAO-00051R-L5
	for gcvg-git@gmane.org; Wed, 24 May 2006 09:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWEXHw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 03:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWEXHwZ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 03:52:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38283 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932652AbWEXHwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 03:52:25 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4O7pbib006292;
	Wed, 24 May 2006 01:51:37 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4O7paJ9006291;
	Wed, 24 May 2006 01:51:36 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20670>


While working on git-quiltimport I decided to see if
I could transform Andrews patches where he imports git tress into
git-pull commands, which should result in better history and better
attribution.

To be accurate of his source Andrew records the sha1 of the commit
and the git tree he pulled from.  Which looks like:

GIT b307e8548921c686d2eb948ca418ab2941876daa \
 git+ssh://master.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

So I figured I would transform the above line into the obvious
git-pull command:

 git-pull \
  git+ssh://master.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
  b307e8548921c686d2eb948ca418ab2941876daa

To my surprise that didn't work.  There were a couple of little places
in the scripts where git-fetch and git-fetch-pack never expected to be
given a sha1 but that was easy to fix up, and had no real repercussions.  

More problematic was the little bit in git-upload pack that only
allows you to a sha1 if it was on the list of sha1 generated from
looking at the heads.  I'm not at all certain of the sense of
that check as you can get everything by just cloning the repository.

Can we fix the check in upload-pack.c something like my
patch below does?  Are there any security implications for
doing that?

Could we just make the final check before dying if (!o) ?





		/* We have sent all our refs already, and the other end
		 * should have chosen out of them; otherwise they are
		 * asking for nonsense.
		 *
		 * Hmph.  We may later want to allow "want" line that
		 * asks for something like "master~10" (symbolic)...
		 * would it make sense?  I don't know.
		 */

diff --git a/upload-pack.c b/upload-pack.c
index 47560c9..0f2e544 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -207,7 +207,9 @@ static int receive_needs(void)
 		 * would it make sense?  I don't know.
 		 */
 		o = lookup_object(sha1_buf);
-		if (!o || !(o->flags & OUR_REF))
+		if (!o)
+			o = parse_object(sha1_buf);
+		if (!o || ((o->type != commit_type) && (o->type != tag_type)))
 			die("git-upload-pack: not our ref %s", line+5);
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
