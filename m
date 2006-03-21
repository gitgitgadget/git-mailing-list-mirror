From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Tue, 21 Mar 2006 01:45:12 -0800
Message-ID: <7vy7z4f7x3.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<7vbqw1nakz.fsf@assigned-by-dhcp.cox.net>
	<7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
	<200603201730.19373.Josef.Weidendorfer@gmx.de>
	<7voe00iupp.fsf@assigned-by-dhcp.cox.net>
	<20060320232101.GQ18185@pasky.or.cz>
	<7vfylcismx.fsf@assigned-by-dhcp.cox.net> <441FB715.1000500@op5.se>
	<7v4q1sgpet.fsf@assigned-by-dhcp.cox.net>
	<20060321091916.GA17125@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 10:45:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLdQg-0000Rq-Fq
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 10:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWCUJpZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 04:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWCUJpY
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 04:45:24 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41937 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932376AbWCUJpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 04:45:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060321094344.LVFS15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Mar 2006 04:43:44 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20060321091916.GA17125@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 21 Mar 2006 04:19:16 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17780>

Jeff King <peff@peff.net> writes:

> Then why not create .git/refs/remotes/$origin/HEAD at the time of clone
> (or later)? Then the core looks for:
>   (current order, .git/refs, etc)
>   .git/refs/remotes/foo
>   .git/refs/remotes/foo/HEAD
> The porcelain can take care of managing the contents of HEAD. If there
> is no HEAD in the directory, then it cannot be looked up by 'foo'
> ('foo/remote-branch' must be used instead).

Yup, earlier I mentioned that possibility, and it does not seem
too painful.  On top of the "next", here is what is needed.

-- >8 --
[PATCH] get_sha1_basic(): try refs/... and finally refs/remotes/$foo/HEAD

This implements the suggestion by Jeff King to use
refs/remotes/$foo/HEAD to interpret a shorthand "$foo" to mean
the primary branch head of a tracked remote.  clone needs to be
told about this convention as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 sha1_name.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

c51d13692d4e451c755dd7da3521c5db395df192
diff --git a/sha1_name.c b/sha1_name.c
index 74c479c..3adaec3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -235,18 +235,21 @@ static int ambiguous_path(const char *pa
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
-	static const char *prefix[] = {
-		"",
-		"refs",
-		"refs/tags",
-		"refs/heads",
-		"refs/remotes",
+	static const char *fmt[] = {
+		"/%.*s",
+		"refs/%.*s",
+		"refs/tags/%.*s",
+		"refs/heads/%.*s",
+		"refs/remotes/%.*s",
+		"refs/remotes/%.*s/HEAD",
 		NULL
 	};
 	const char **p;
 	const char *warning = "warning: refname '%.*s' is ambiguous.\n";
 	char *pathname;
 	int already_found = 0;
+	unsigned char *this_result;
+	unsigned char sha1_from_ref[20];
 
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
@@ -255,11 +258,9 @@ static int get_sha1_basic(const char *st
 	if (ambiguous_path(str, len))
 		return -1;
 
-	for (p = prefix; *p; p++) {
-		unsigned char sha1_from_ref[20];
-		unsigned char *this_result =
-			already_found ? sha1_from_ref : sha1;
-		pathname = git_path("%s/%.*s", *p, len, str);
+	for (p = fmt; *p; p++) {
+		this_result = already_found ? sha1_from_ref : sha1;
+		pathname = git_path(*p, len, str);
 		if (!read_ref(pathname, this_result)) {
 			if (warn_ambiguous_refs) {
 				if (already_found &&
-- 
1.2.4.gf1250
