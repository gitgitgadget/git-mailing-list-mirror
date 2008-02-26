From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Build in clone
Date: Tue, 26 Feb 2008 03:21:13 +0100
Message-ID: <200802260321.14038.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Kristian =?utf-8?q?H=C3=B8gsberg?= <krh@redhat.com>,
	Santi =?utf-8?q?B=C3=A9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 03:22:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTpSO-0003EJ-Gi
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 03:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757748AbYBZCVg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 21:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757854AbYBZCVf
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 21:21:35 -0500
Received: from smtp.getmail.no ([84.208.20.33]:55330 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086AbYBZCVe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 21:21:34 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JWT00J05QJU2H00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 26 Feb 2008 03:21:30 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JWT004SOQJEI480@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 26 Feb 2008 03:21:14 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JWT008YRQJET2SQ@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 26 Feb 2008 03:21:14 +0100 (CET)
In-reply-to: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75101>

On Monday 25 February 2008, Daniel Barkalow wrote:
> This version is still a mess, but it passes all of the tests.

Not for me:
*** t5700-clone-reference.sh ***
*   ok 1: preparing first repository
*   ok 2: preparing second repository
* FAIL 3: cloning with reference (-l -s)
        git clone -l -s --reference B A C
*   ok 4: existence of info/alternates
*   ok 5: pulling from reference
*   ok 6: that reference gets used
* FAIL 7: cloning with reference (no -l -s)
        git clone --reference B file://`pwd`/A D
*   ok 8: existence of info/alternates
*   ok 9: pulling from reference
*   ok 10: that reference gets used
*   ok 11: updating origin
*   ok 12: pulling changes from origin
*   ok 13: that alternate to origin gets used
*   ok 14: pulling changes from origin
*   ok 15: check objects expected to exist locally
* failed 2 among 15 test(s)
make[1]: *** [t5700-clone-reference.sh] Error 1

> I'm somewhat unconvinced by the test ccoverage for clone, however; th=
e
> last failure I found was actually for which heads get created in a
> bare repository, and it was only failing when there was an extra one
> in a non-bare clone in a test for something entirely different.
>=20
> This is largely based on Kristian H=C3=B8gsberg's version from Decemb=
er, but=20
> the introduced warnings and two whitespace errors I haven't located a=
re=20
> mine.
>=20
> I'm still working on getting it cleaned up, but I thought it would be=
 good=20
> to get it some exposure and testing, since people have been talking a=
bout=20
> builtin-clone today.

Other than the failing tests, it seems to work fairly well. I've been
playing around with it for a few minutes, and on a test repo I have wit=
h
1001 branches and 10000 tags, it cuts down the runtime of a local git-c=
lone
from 25 seconds to ~1.5 seconds. (simply by eliminating the overhead of
invoking git-update-ref for every single ref) :)

I've tried to test this by diffing a cloned repo against an equivalent
clone done by the old script. Below I pasted in a few immediate fixes I
found. With these fixes, the only remaining diff between the clones is
that refs/remotes/origin/HEAD used to be a symbolic ref (with no reflog=
),
but is now a "regular" ref (with reflog).
The fixes are, in order of importance:
- Call git_config(git_default_config) in order to properly set up
  user.name and user.email for reflogs (This BREAKS test #9 in
  t1020-subdirectory.sh. Have yet to figure out why)
- Fix "clone from $repo" reflog messages (using strbufs; something tell=
s
  me more of this code would benefit from using strbufs)
- H=C3=B8gsberg's name should be in UTF-8 (not sure if this will surviv=
e this
  mail)
- The two whitespace errors you mentioned

I'm sorry that my patch below sucks from a style POV. Feel free to igno=
re.
Will redo when it's not in the middle of the night.


Have fun! :)

=2E..Johan

-8<----------------8<---------------------8<-
[PATCH] WIP: Minor fixes on top of builtin-clone

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-clone.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 5aa75e1..7eed340 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -1,7 +1,7 @@
 /*
  * Builtin "git clone"
  *
- * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
+ * Copyright (c) 2007 Kristian H=C3=83=C2=B8gsberg <krh@redhat.com>
  * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
  *
  * Clone a repository into a different directory that does not yet exi=
st.
@@ -79,7 +79,7 @@ static char *get_repo_path(const char *repo)
=20
 	if (!stat(repo, &buf) && S_ISDIR(buf.st_mode))
 		return xstrdup(make_absolute_path(repo));
-=09
+
 	return NULL;
 }
=20
@@ -347,6 +347,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	char *path, *dir, *head, *ref_temp;
 	struct ref *refs, *r, *remote_head, *head_points_at, *remote_master;
 	char branch_top[256], key[256], refname[256], value[256];
+	struct strbuf reflog_msg;
+
+	git_config(git_default_config);
=20
 	clone_pid =3D getpid();
=20
@@ -459,6 +462,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		snprintf(branch_top, sizeof branch_top,
 			 "refs/remotes/%s", option_origin);
=20
+	strbuf_init(&reflog_msg, strlen(repo) + 12);
+	strbuf_addf(&reflog_msg, "clone: from %s", repo);
+
 	printf("%p\n", refs);
 	remote_head =3D NULL;
 	remote_master =3D NULL;
@@ -487,7 +493,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 				continue;
 		}
=20
-		update_ref("clone from $repo",
+		update_ref(reflog_msg.buf,
 			   refname, r->old_sha1, NULL, 0, DIE_ON_ERR);
 	}
=20
@@ -495,7 +501,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	if (!remote_head) {
 		/* If there isn't one, oh well. */
 	} else if (remote_master && !hashcmp(remote_master->old_sha1,
-				      remote_head->old_sha1)) {
+					     remote_head->old_sha1)) {
 		/* If refs/heads/master could be right, it is. */
 		head_points_at =3D remote_master;
 	} else
@@ -552,7 +558,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		git_config_set(key, head_points_at->name);
 	} else if (remote_head) {
 		/* Source had detached HEAD pointing somewhere. */
-		update_ref("clone from $repo", "HEAD", remote_head->old_sha1,
+		update_ref(reflog_msg.buf, "HEAD", remote_head->old_sha1,
 			   NULL, REF_NODEREF, DIE_ON_ERR);
 	} else {
 		/* Nothing to checkout out */
@@ -591,7 +597,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		    commit_locked_index(&lock_file))
 			die("unable to write new index file");
 	}
-=09
+
+	strbuf_release(&reflog_msg);
 	junk_work_tree =3D NULL;
 	junk_git_dir =3D NULL;
 	return 0;
--=20
1.5.4.3.328.gcaed
