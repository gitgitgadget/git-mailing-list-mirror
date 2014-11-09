From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 2/2] use env_array member of struct child_process
Date: Sun, 09 Nov 2014 14:49:54 +0100
Message-ID: <545F7102.50403@web.de>
References: <54390DC0.8060302@web.de> <20141012015321.GA15272@peff.net> <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com> <54439D0C.1070308@web.de> <20141020091949.GB12913@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 14:50:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnSsw-00060m-Ci
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 14:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbaKINu0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 08:50:26 -0500
Received: from mout.web.de ([212.227.17.11]:62238 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbaKINuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 08:50:25 -0500
Received: from [192.168.178.27] ([79.253.168.90]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M1oGM-1Y2OV63joI-00tk4o; Sun, 09 Nov 2014 14:50:11
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141020091949.GB12913@peff.net>
X-Provags-ID: V03:K0:Du0gHxIyJMs73NnVEOzD2jgJTwFgDF49i3cmQ4Ik310GH7n05NA
 4pUIOgbmkmtgXyUD10si4FCqR49K7V5DeuS9iKKnk3iAMZtQRhlpm1l6qhj2gcPCilS7uX/
 3h+AYZyk3YVpOzvnJGWiltoayXta0/7rLF4BKIeykN+Rbs4yv2nMdyaYns2n2d2QiB3LdHc
 AiLiHdY8gMdUzCq73ZlJQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.10.2014 um 11:19 schrieb Jeff King:
> On Sun, Oct 19, 2014 at 01:14:20PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -726,14 +726,14 @@ static void wt_status_print_changed(struct wt_=
status *s)
>>   static void wt_status_print_submodule_summary(struct wt_status *s,=
 int uncommitted)
>>   {
>>   	struct child_process sm_summary =3D CHILD_PROCESS_INIT;
>> -	struct argv_array env =3D ARGV_ARRAY_INIT;
>>   	struct argv_array argv =3D ARGV_ARRAY_INIT;
>=20
> I don't think it belongs in this patch, but a follow-on 3/2 might be =
to
> give argv the same treatment.

Yes, good idea.

-- >8 --
Subject: [PATCH] use args member of struct child_process

Convert users of struct child_process to using the managed argv_array
args instead of providing their own.  This shortens the code a bit and
ensures that the allocated memory is released automatically after use.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/repack.c | 47 ++++++++++++++++++++++-------------------------
 wt-status.c      | 17 +++++++----------
 2 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 2845620..83e91c7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -135,7 +135,6 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	};
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct string_list_item *item;
-	struct argv_array cmd_args =3D ARGV_ARRAY_INIT;
 	struct string_list names =3D STRING_LIST_INIT_DUP;
 	struct string_list rollback =3D STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs =3D STRING_LIST_INIT_DUP;
@@ -202,56 +201,55 @@ int cmd_repack(int argc, const char **argv, const=
 char *prefix)
=20
 	sigchain_push_common(remove_pack_on_signal);
=20
-	argv_array_push(&cmd_args, "pack-objects");
-	argv_array_push(&cmd_args, "--keep-true-parents");
+	argv_array_push(&cmd.args, "pack-objects");
+	argv_array_push(&cmd.args, "--keep-true-parents");
 	if (!pack_kept_objects)
-		argv_array_push(&cmd_args, "--honor-pack-keep");
-	argv_array_push(&cmd_args, "--non-empty");
-	argv_array_push(&cmd_args, "--all");
-	argv_array_push(&cmd_args, "--reflog");
-	argv_array_push(&cmd_args, "--indexed-objects");
+		argv_array_push(&cmd.args, "--honor-pack-keep");
+	argv_array_push(&cmd.args, "--non-empty");
+	argv_array_push(&cmd.args, "--all");
+	argv_array_push(&cmd.args, "--reflog");
+	argv_array_push(&cmd.args, "--indexed-objects");
 	if (window)
-		argv_array_pushf(&cmd_args, "--window=3D%s", window);
+		argv_array_pushf(&cmd.args, "--window=3D%s", window);
 	if (window_memory)
-		argv_array_pushf(&cmd_args, "--window-memory=3D%s", window_memory);
+		argv_array_pushf(&cmd.args, "--window-memory=3D%s", window_memory);
 	if (depth)
-		argv_array_pushf(&cmd_args, "--depth=3D%s", depth);
+		argv_array_pushf(&cmd.args, "--depth=3D%s", depth);
 	if (max_pack_size)
-		argv_array_pushf(&cmd_args, "--max-pack-size=3D%s", max_pack_size);
+		argv_array_pushf(&cmd.args, "--max-pack-size=3D%s", max_pack_size);
 	if (no_reuse_delta)
-		argv_array_pushf(&cmd_args, "--no-reuse-delta");
+		argv_array_pushf(&cmd.args, "--no-reuse-delta");
 	if (no_reuse_object)
-		argv_array_pushf(&cmd_args, "--no-reuse-object");
+		argv_array_pushf(&cmd.args, "--no-reuse-object");
 	if (write_bitmaps)
-		argv_array_push(&cmd_args, "--write-bitmap-index");
+		argv_array_push(&cmd.args, "--write-bitmap-index");
=20
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs);
=20
 		if (existing_packs.nr && delete_redundant) {
 			if (unpack_unreachable)
-				argv_array_pushf(&cmd_args,
+				argv_array_pushf(&cmd.args,
 						"--unpack-unreachable=3D%s",
 						unpack_unreachable);
 			else if (pack_everything & LOOSEN_UNREACHABLE)
-				argv_array_push(&cmd_args,
+				argv_array_push(&cmd.args,
 						"--unpack-unreachable");
 		}
 	} else {
-		argv_array_push(&cmd_args, "--unpacked");
-		argv_array_push(&cmd_args, "--incremental");
+		argv_array_push(&cmd.args, "--unpacked");
+		argv_array_push(&cmd.args, "--incremental");
 	}
=20
 	if (local)
-		argv_array_push(&cmd_args,  "--local");
+		argv_array_push(&cmd.args,  "--local");
 	if (quiet)
-		argv_array_push(&cmd_args,  "--quiet");
+		argv_array_push(&cmd.args,  "--quiet");
 	if (delta_base_offset)
-		argv_array_push(&cmd_args,  "--delta-base-offset");
+		argv_array_push(&cmd.args,  "--delta-base-offset");
=20
-	argv_array_push(&cmd_args, packtmp);
+	argv_array_push(&cmd.args, packtmp);
=20
-	cmd.argv =3D cmd_args.argv;
 	cmd.git_cmd =3D 1;
 	cmd.out =3D -1;
 	cmd.no_stdin =3D 1;
@@ -270,7 +268,6 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	ret =3D finish_command(&cmd);
 	if (ret)
 		return ret;
-	argv_array_clear(&cmd_args);
=20
 	if (!names.nr && !quiet)
 		printf("Nothing new to pack.\n");
diff --git a/wt-status.c b/wt-status.c
index cdbc8d7..b54eac5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -726,7 +726,6 @@ static void wt_status_print_changed(struct wt_statu=
s *s)
 static void wt_status_print_submodule_summary(struct wt_status *s, int=
 uncommitted)
 {
 	struct child_process sm_summary =3D CHILD_PROCESS_INIT;
-	struct argv_array argv =3D ARGV_ARRAY_INIT;
 	struct strbuf cmd_stdout =3D STRBUF_INIT;
 	struct strbuf summary =3D STRBUF_INIT;
 	char *summary_content;
@@ -735,23 +734,21 @@ static void wt_status_print_submodule_summary(str=
uct wt_status *s, int uncommitt
 	argv_array_pushf(&sm_summary.env_array, "GIT_INDEX_FILE=3D%s",
 			 s->index_file);
=20
-	argv_array_push(&argv, "submodule");
-	argv_array_push(&argv, "summary");
-	argv_array_push(&argv, uncommitted ? "--files" : "--cached");
-	argv_array_push(&argv, "--for-status");
-	argv_array_push(&argv, "--summary-limit");
-	argv_array_pushf(&argv, "%d", s->submodule_summary);
+	argv_array_push(&sm_summary.args, "submodule");
+	argv_array_push(&sm_summary.args, "summary");
+	argv_array_push(&sm_summary.args, uncommitted ? "--files" : "--cached=
");
+	argv_array_push(&sm_summary.args, "--for-status");
+	argv_array_push(&sm_summary.args, "--summary-limit");
+	argv_array_pushf(&sm_summary.args, "%d", s->submodule_summary);
 	if (!uncommitted)
-		argv_array_push(&argv, s->amend ? "HEAD^" : "HEAD");
+		argv_array_push(&sm_summary.args, s->amend ? "HEAD^" : "HEAD");
=20
-	sm_summary.argv =3D argv.argv;
 	sm_summary.git_cmd =3D 1;
 	sm_summary.no_stdin =3D 1;
 	fflush(s->fp);
 	sm_summary.out =3D -1;
=20
 	run_command(&sm_summary);
-	argv_array_clear(&argv);
=20
 	len =3D strbuf_read(&cmd_stdout, sm_summary.out, 1024);
=20
--=20
2.1.3
