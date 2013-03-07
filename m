From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: inotify to minimize stat() calls
Date: Thu, 07 Mar 2013 23:16:19 +0100
Message-ID: <513911B3.7010903@web.de>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org> <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com> <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com> <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com> <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com> <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh> <20130210112205.GA28434@lanh> <7vhaljudos.fsf@alter.siamese.dyndns.org> <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 23:17:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDj7X-0006QA-U5
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 23:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933514Ab3CGWQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 17:16:39 -0500
Received: from mout.web.de ([212.227.15.4]:56711 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933503Ab3CGWQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 17:16:37 -0500
Received: from [192.168.2.107] ([79.244.188.215]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MGRdk-1U0XoZ2buS-00DXyv; Thu, 07 Mar 2013 23:16:21
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130216 Thunderbird/17.0.3
In-Reply-To: <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com>
X-Provags-ID: V02:K0:9UgPRN8chgR0R/Ei/J0mE6cGhO6/tuOsOPCaIwjUvKT
 l0MipOMutCPXWLJ8VlgFIOlR4xlHkFRZKpHHcQdMvkkA0pKL+t
 r4moR1FFsPRTWvjY9D0kwd8qxiEyGtBS0H/snFYhTQE25iqNZS
 1lwPTcvlk+odHmDV0pSy6ln/ccXn1x/4hgJJWAd85GhX08ulCO
 //8F/i2I8Jk9JOY4kHFUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217622>

On 11.02.13 03:56, Duy Nguyen wrote:
> On Mon, Feb 11, 2013 at 3:16 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> The other "lstat()" experiment was a very interesting one, but this
>> is not yet an interesting experiment to see where in the "ignore"
>> codepath we are spending times.
>>
>> We know that we can tell wt_status_collect_untracked() not to bother
>> with the untracked or ignored files with !s->show_untracked_files
>> already, but I think the more interesting question is if we can show
>> the untracked files with less overhead.
>>
>> If we want to show untrackedd files, it is a given that we need to
>> read directories to see what paths there are on the filesystem. Is
>> the opendir/readdir cost dominating in the process? Are we spending
>> a lot of time sifting the result of opendir/readdir via the ignore
>> mechanism? Is reading the "ignore" files costing us much to prime
>> the ignore mechanism?
>>
>> If readdir cost is dominant, then that makes "cache gitignore" a
>> nonsense proposition, I think.  If you really want to "cache"
>> something, you need to have somebody (i.e. a daemon) who constantly
>> keeps an eye on the filesystem changes and can respond with the up
>> to date result directly to fill_directory().  I somehow doubt that
>> it is a direction we would want to go in, though.
>=20
> Yeah, it did not cut out syscall cost, I also cut a lot of user-space
> processing (plus .gitignore content access). From the timings I poste=
d
> earlier,
>=20
>>         unmodified  dir.c
>> real    0m0.550s    0m0.287s
>> user    0m0.305s    0m0.201s
>> sys     0m0.240s    0m0.084s
>=20
> sys time is reduced from 0.24s to 0.08s, so readdir+opendir definitel=
y
> has something to do with it (and perhaps reading .gitignore). But it
> also reduces user time from 0.305 to 0.201s. I don't think avoiding
> readdir+openddir will bring us this gain. It's probably the cost of
> matching .gitignore. I'll try to replace opendir+readdir with a
> no-syscall version. At this point "untracked caching" sounds more
> feasible (and less complex) than ".gitignore cachine".
>=20
Thanks for Duy for the measurements, and patches.
I took the freedom to convert the patched dir.c into a=20
"runtime configurable" git status option.
I'm not sure if the following copy-and-paste work applies,
(it is based on Git 1.8.1.3), but the time spend for=20
"git status --changed-only" is basically half the time of
"git status", similar to what Duy has measured.
I did a test both on a Linux box and Mac OS.

And the speedup is so impressive, that I am tempted to submit a patch s=
imlar
to the following, what do we think about it?
/Torsten




-- >8 --

[PATCH] git status: add option changed-only
git status may be run faster if
- we only check if files are changed which are already known to git.
- we don't check if there are untracked files.

"git status --changed-only" (or the short form "git status -c")

will only check for changed files which are already known to git,
and which are in the index.

The call to read_directory_recursive() is skipped and untracked files
in the working tree are not reported.

Inspired-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 builtin/commit.c | 2 ++
 dir.c            | 5 +++--
 dir.h            | 3 ++-
 wt-status.c      | 3 +++
 wt-status.h      | 1 +
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d6dd3df..6a5ba11 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1158,6 +1158,8 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	unsigned char sha1[20];
 	static struct option builtin_status_options[] =3D {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT_BOOLEAN('c', "changed-only", &s.check_changed_only,
+			    N_("Ignore untracked files. Check if files known to git are mod=
ified")),
 		OPT_SET_INT('s', "short", &status_format,
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
 		OPT_BOOLEAN('b', "branch", &s.show_branch,
diff --git a/dir.c b/dir.c
index a473ca2..555b652 100644
--- a/dir.c
+++ b/dir.c
@@ -1274,8 +1274,9 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const char
 		return dir->nr;
=20
 	simplify =3D create_simplify(pathspec);
-	if (!len || treat_leading_path(dir, path, len, simplify))
-		read_directory_recursive(dir, path, len, 0, simplify);
+	if ((!(dir->flags & DIR_CHECK_CHANGED_ONLY)) &&
+			(!len || treat_leading_path(dir, path, len, simplify))) o
+			read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
diff --git a/dir.h b/dir.h
index f5c89e3..1a915a7 100644
--- a/dir.h
+++ b/dir.h
@@ -41,7 +41,8 @@ struct dir_struct {
 		DIR_SHOW_OTHER_DIRECTORIES =3D 1<<1,
 		DIR_HIDE_EMPTY_DIRECTORIES =3D 1<<2,
 		DIR_NO_GITLINKS =3D 1<<3,
-		DIR_COLLECT_IGNORED =3D 1<<4
+		DIR_COLLECT_IGNORED =3D 1<<4,
+		DIR_CHECK_CHANGED_ONLY =3D 1<<5
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
diff --git a/wt-status.c b/wt-status.c
index d7cfe8f..b315785 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -503,6 +503,9 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 	if (s->show_untracked_files !=3D SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=3D
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
+	if (s->check_changed_only)
+		dir.flags |=3D DIR_CHECK_CHANGED_ONLY;
+
 	setup_standard_excludes(&dir);
=20
 	fill_directory(&dir, s->pathspec);
diff --git a/wt-status.h b/wt-status.h
index 236b41f..7eb0115 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -47,6 +47,7 @@ struct wt_status {
 	const char **pathspec;
 	int verbose;
 	int amend;
+	int check_changed_only;
 	enum commit_whence whence;
 	int nowarn;
 	int use_color;
--=20
1.8.2.rc2
