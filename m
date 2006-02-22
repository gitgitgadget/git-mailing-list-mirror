From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Prevent git-upload-pack segfault if object cannot be found
Date: Wed, 22 Feb 2006 11:11:14 -0800
Message-ID: <7vr75vmcod.fsf@assigned-by-dhcp.cox.net>
References: <20060222181758.GH3355@andrew-vasquezs-powerbook-g4-15.local>
	<87bqwzs07h.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 20:11:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBzOT-0004ia-Pw
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 20:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWBVTLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 14:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWBVTLS
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 14:11:18 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:27027 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751403AbWBVTLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 14:11:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222190742.IYA20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 14:07:42 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87bqwzs07h.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	22 Feb 2006 10:44:02 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16609>

Carl Worth <cworth@cworth.org> writes:

> In the case in which I hit the original bug, this message is necessary
> to provide information about where the actual problem is. Here is what
> that scenario looks like with the message:
>
> $ mkdir original;
> $ (cd original; git-init-db; touch foo; git add foo; git commit -m "original")
> defaulting to local storage area
> Committing initial tree 4d5fcadc293a348e88f777dc0920f11e7d71441c
> $ git clone -l -s original clone
> $ mv original moved
> $ git clone clone again
> unable to open object pack directory: /tmp/original/.git/objects/pack: No such file or directory
> fatal: git-upload-pack: cannot find object 0153d496df669cbe5cecb665dbe6f95b20461917:
> fatal: unexpected EOF
> clone-pack from '/tmp/clone/.git' failed.
>
> Here the "cannot find object" message doesn't point to the core
> problem, but the "unable to open object pack directory" does contain
> the "/tmp/original" path of interest.

Updated patch.  The root cause of the problem you had was that
alternates was dangling, so we catch that.

-- >8 --
diff --git a/sha1_file.c b/sha1_file.c
index f08b1d6..c08da35 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -247,6 +247,7 @@ static void link_alt_odb_entries(const c
 		for ( ; cp < ep && *cp != sep; cp++)
 			;
 		if (last != cp) {
+			struct stat st;
 			struct alternate_object_database *alt;
 			/* 43 = 40-byte + 2 '/' + terminating NUL */
 			int pfxlen = cp - last;
@@ -269,9 +270,19 @@ static void link_alt_odb_entries(const c
 			}
 			else
 				memcpy(ent->base, last, pfxlen);
+
 			ent->name = ent->base + pfxlen + 1;
-			ent->base[pfxlen] = ent->base[pfxlen + 3] = '/';
-			ent->base[entlen-1] = 0;
+			ent->base[pfxlen + 3] = '/';
+			ent->base[pfxlen] = ent->base[entlen-1] = 0;
+
+			/* Detect cases where alternate disappeared */
+			if (stat(ent->base, &st) || !S_ISDIR(st.st_mode)) {
+				error("object directory %s does not exist; "
+				      "check .git/objects/info/alternates.",
+				      ent->base);
+				goto bad;
+			}
+			ent->base[pfxlen] = '/';
 
 			/* Prevent the common mistake of listing the same
 			 * thing twice, or object directory itself.
@@ -552,7 +563,9 @@ static void prepare_packed_git_one(char 
 	len = strlen(path);
 	dir = opendir(path);
 	if (!dir) {
-		fprintf(stderr, "unable to open object pack directory: %s: %s\n", path, strerror(errno));
+		if (errno != ENOENT)
+			error("unable to open object pack directory: %s: %s\n",
+			      path, strerror(errno));
 		return;
 	}
 	path[len++] = '/';
