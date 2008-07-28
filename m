From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-mv: Keep moved index entries inact
Date: Mon, 28 Jul 2008 12:19:19 -0700
Message-ID: <7vwsj5rf48.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <20080728142023.GC6701@neumann>
 <alpine.DEB.1.00.0807281605330.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:20:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNYGp-0004Tt-43
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 21:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbYG1TTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 15:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYG1TTb
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 15:19:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYG1TTa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2008 15:19:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52FC040CF7;
	Mon, 28 Jul 2008 15:19:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3D13D40CF3; Mon, 28 Jul 2008 15:19:24 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807281605330.8986@racer> (Johannes
 Schindelin's message of "Mon, 28 Jul 2008 16:06:05 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 199C29A6-5CDA-11DD-A86F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90490>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 28 Jul 2008, SZEDER G=C3=A1bor wrote:
>
>> there is a race somewhere in these 'git-mv: Keep moved index entries
>> inact' changes.
>>=20
>> The test cases 'git mv should overwrite symlink to a file' or 'git m=
v
>> should overwrite file with a symlink' fail occasionaly.  It's quite
>> non-deterministic:  I have run t7001-mv.sh in a loop (see below) and
>> one or the other usually fails around 50 runs (but sometimes only
>> after 150).  Adding some tracing echos to the tests shows that both
>> tests fail when running 'git diff-files' at the end.
>
> To make it more convenient to test: with this patch it fails all the =
time:

It's because we rename(2) but do not read back ctime, and reuse the cac=
hed
data from the old path that was renamed.  After the failed test that mo=
ves
a regular file "move" to "symlink":

$ stat symlink
  File: `symlink'
  Size: 2               Blocks: 8          IO Block: 4096   regular fil=
e
Device: 30ah/778d       Inode: 18104337    Links: 1
Access: (0664/-rw-rw-r--)  Uid: ( 1012/   junio)   Gid: (   40/     src=
)
Access: 2008-07-28 11:49:55.000000000 -0700
Modify: 2008-07-28 11:48:41.000000000 -0700
Change: 2008-07-28 11:48:42.000000000 -0700

But the cached stat information looks like this:

$ ../../git-ls-files --stat
ctime=3D1217270921, mtime=3D1217270921, ino=3D18104337, mode=3D100644, =
uid=3D1012, gid=3D40symlink

We need to refresh the entry to pick up potential ctime changes.


 read-cache.c       |    7 ++++++-
 builtin-ls-files.c |   21 +++++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1cae361..834096f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -40,7 +40,7 @@ static void replace_index_entry(struct index_state *i=
state, int nr, struct cache
=20
 void rename_index_entry_at(struct index_state *istate, int nr, const c=
har *new_name)
 {
-	struct cache_entry *old =3D istate->cache[nr], *new;
+	struct cache_entry *old =3D istate->cache[nr], *new, *refreshed;
 	int namelen =3D strlen(new_name);
=20
 	new =3D xmalloc(cache_entry_size(namelen));
@@ -51,6 +51,11 @@ void rename_index_entry_at(struct index_state *istat=
e, int nr, const char *new_n
=20
 	cache_tree_invalidate_path(istate->cache_tree, old->name);
 	remove_index_entry_at(istate, nr);
+
+	/* the renaming could have smudged the ctime */
+	refreshed =3D refresh_cache_entry(new, 0);
+	if (refreshed && refreshed !=3D new)
+		new =3D refreshed;
 	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPL=
ACE);
 }
=20
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index e8d568e..a6b30c8 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -16,6 +16,7 @@ static int show_deleted;
 static int show_cached;
 static int show_others;
 static int show_stage;
+static int show_stat;
 static int show_unmerged;
 static int show_modified;
 static int show_killed;
@@ -205,16 +206,20 @@ static void show_ce_entry(const char *tag, struct=
 cache_entry *ce)
 		tag =3D alttag;
 	}
=20
-	if (!show_stage) {
-		fputs(tag, stdout);
-	} else {
+	if (show_stage)
 		printf("%s%06o %s %d\t",
 		       tag,
 		       ce->ce_mode,
 		       abbrev ? find_unique_abbrev(ce->sha1,abbrev)
 				: sha1_to_hex(ce->sha1),
 		       ce_stage(ce));
-	}
+	else if (show_stat)
+		printf("ctime=3D%u, mtime=3D%u, ino=3D%u, mode=3D%o, uid=3D%u, gid=3D=
%u\t",
+		       ce->ce_ctime, ce->ce_mtime, ce->ce_ino,
+		       ce->ce_mode, ce->ce_uid, ce->ce_gid);
+
+	else
+		fputs(tag, stdout);
 	write_name_quoted(ce->name + offset, stdout, line_terminator);
 }
=20
@@ -235,7 +240,7 @@ static void show_files(struct dir_struct *dir, cons=
t char *prefix)
 		if (show_killed)
 			show_killed_files(dir);
 	}
-	if (show_cached | show_stage) {
+	if (show_cached | show_stage | show_stat) {
 		for (i =3D 0; i < active_nr; i++) {
 			struct cache_entry *ce =3D active_cache[i];
 			int dtype =3D ce_to_dtype(ce);
@@ -488,6 +493,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *prefix)
 			show_stage =3D 1;
 			continue;
 		}
+		if (!strcmp(arg, "-S") || !strcmp(arg, "--stat")) {
+			show_stat =3D 1;
+			continue;
+		}
 		if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
 			show_killed =3D 1;
 			require_work_tree =3D 1;
@@ -593,7 +602,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *prefix)
=20
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage | show_deleted | show_others | show_unmerged |
-	      show_killed | show_modified))
+	      show_killed | show_modified | show_stat))
 		show_cached =3D 1;
=20
 	read_cache();
