From: Junio C Hamano <gitster@pobox.com>
Subject: Re* Slow "git rev-list origin/master --not --all" or "git fetch"
 slow when downloading nothing
Date: Wed, 05 Nov 2008 09:32:51 -0800
Message-ID: <7vprlakri4.fsf@gitster.siamese.dyndns.org>
References: <adf1fd3d0811050138j7b8bbed1nd94a999f55e38d61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 18:35:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxmGz-00022B-HY
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 18:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbYKERdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Nov 2008 12:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbYKERdG
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 12:33:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbYKERdF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2008 12:33:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D62E1936CF;
	Wed,  5 Nov 2008 12:33:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 76807936CA; Wed, 
 5 Nov 2008 12:32:55 -0500 (EST)
In-Reply-To: <adf1fd3d0811050138j7b8bbed1nd94a999f55e38d61@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Wed, 5 Nov 2008 10:38:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CCE25610-AB5F-11DD-8950-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100162>

"Santi B=C3=A9jar" <santi@agolina.net> writes:

>   In cold cache "git rev-list origin/master --not --all" is slow
> reading many files:
>
> cold cache:
> $ /usr/bin/time git rev-list origin/master --not --all
> 0.03user 0.02system 0:04.57elapsed 1%CPU (0avgtext+0avgdata 0maxresid=
ent)k
> 77848inputs+0outputs (410major+1798minor)pagefaults 0swaps
>
> hot cache:
> $ /usr/bin/time git rev-list origin/master --not --all
> 0.01user 0.00system 0:00.06elapsed 31%CPU (0avgtext+0avgdata 0maxresi=
dent)k
> 0inputs+0outputs (0major+2207minor)pagefaults 0swaps
>
> I think that, in this particular case (when the arguments are the tip=
s
> of some of the branches), this should not read that many files.

What kind of "many files" are you making git read?  Do you have too man=
y
unpacked refs?  Too many loose objects? =20

> ... When nothing has changed in the remote repository (so
> refs/<remote>/* has all the remote refs) the "git fetch" could be alm=
ost
> instantaneous (even in coldcache),...

You at least need to read:

 - what "--all" refs point at; to find this out, you need to read all
   unpacked refs files, and one packed-refs file;

 - commit objects that these refs point at; to cull refs that do not po=
int
   at committish and dereference tag objects that point at commit, you
   need to read these objects (either loose objects or in packs);

 - commit objects on the ancestry graph starting from the commit pointe=
d
   at by origin/master and the commits from "--all" refs, until your
   traversal from origin/master hit one of the ancestors of "--all" ref=
s.

I noticed that when you "git pack-refs" (or "git gc"), we do not remove
the leading directories of loose refs that become empty because of
pruning.  This can cause many opendir() when you used to have too many
hierachy of refs even after packing them.

 dir.c       |   13 +++++++++----
 pack-refs.c |    5 +++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git c/dir.c w/dir.c
index 0131983..7241631 100644
--- c/dir.c
+++ w/dir.c
@@ -779,7 +779,12 @@ int is_inside_dir(const char *dir)
 	return get_relative_cwd(buffer, sizeof(buffer), dir) !=3D NULL;
 }
=20
-int remove_dir_recursively(struct strbuf *path, int only_empty)
+/*
+ * option:
+ * 1: remove empty directory;
+ * 2: remove empty subdirectories, but not the directory itself
+ */
+int remove_dir_recursively(struct strbuf *path, int option)
 {
 	DIR *dir =3D opendir(path->buf);
 	struct dirent *e;
@@ -803,9 +808,9 @@ int remove_dir_recursively(struct strbuf *path, int=
 only_empty)
 		if (lstat(path->buf, &st))
 			; /* fall thru */
 		else if (S_ISDIR(st.st_mode)) {
-			if (!remove_dir_recursively(path, only_empty))
+			if (!remove_dir_recursively(path, !!option))
 				continue; /* happy */
-		} else if (!only_empty && !unlink(path->buf))
+		} else if (!option && !unlink(path->buf))
 			continue; /* happy, too */
=20
 		/* path too long, stat fails, or non-directory still exists */
@@ -815,7 +820,7 @@ int remove_dir_recursively(struct strbuf *path, int=
 only_empty)
 	closedir(dir);
=20
 	strbuf_setlen(path, original_len);
-	if (!ret)
+	if (!ret && option !=3D 2)
 		ret =3D rmdir(path->buf);
 	return ret;
 }
diff --git c/pack-refs.c w/pack-refs.c
index 2c76fb1..30fbae8 100644
--- c/pack-refs.c
+++ w/pack-refs.c
@@ -2,6 +2,7 @@
 #include "refs.h"
 #include "tag.h"
 #include "pack-refs.h"
+#include "dir.h"
=20
 struct ref_to_prune {
 	struct ref_to_prune *next;
@@ -73,10 +74,14 @@ static void prune_ref(struct ref_to_prune *r)
=20
 static void prune_refs(struct ref_to_prune *r)
 {
+	struct strbuf refs =3D STRBUF_INIT;
+
+	strbuf_addstr(&refs, git_path("refs"));
 	while (r) {
 		prune_ref(r);
 		r =3D r->next;
 	}
+	remove_dir_recursively(&refs, 2);
 }
=20
 static struct lock_file packed;
