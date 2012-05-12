From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Update "gc" behavior in commit, merge, am, rebase and index-pack
Date: Sat, 12 May 2012 15:18:24 +0700
Message-ID: <CACsJy8BXXrze-0n++YenDERfi=z26L1P_06XjZLFeeMuuLgg8w@mail.gmail.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Fernando Vezzosi <buccia@repnz.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 10:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ST7Xw-0001Pn-43
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 10:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349Ab2ELITL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 04:19:11 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:46562 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321Ab2ELIS4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 04:18:56 -0400
Received: by wibhn6 with SMTP id hn6so934877wib.1
        for <git@vger.kernel.org>; Sat, 12 May 2012 01:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Hv4F3CfElU0aqfnyy5Pb346+qTs01j425TqtPD6BsVE=;
        b=U1dtV1kIsFIDNN7fpuU550JAUBKBvhdtZoDlBqCSypJ4Z036ZfGusuOS5XthLKm77K
         Hg3mWwqLeZFP38tD/vjL7/skMMLPrBUR2FoCHzKv0fg2x5gdgMgGpbzUNaXpR8y6wC74
         uCh7ikerv0jKkNU9vimPVUHMRwSmyEQqVh3XB0Sdea3jQGrOA21SKs2kF7izSJGz/dyJ
         OkRKRja2EVfz7SKyryZ5w92Jcuu5ed9VJVEnoU0nvfmi3gnpySzj7ACyZpgLRlu9PHG5
         PmpZvrT6IXtF/rcU3HfGMVYRYYpj/f0B4wTL0ghX3JTW+H4HAY+qpPLzA/zguACNTmr3
         KOwQ==
Received: by 10.216.142.200 with SMTP id i50mr694035wej.47.1336810734523; Sat,
 12 May 2012 01:18:54 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sat, 12 May 2012 01:18:24 -0700 (PDT)
In-Reply-To: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197717>

(CCing Fernnando and complaining about send-email)

I accidentally put buccia@@repnz.net instead of one @. There were
warnings in the jungle that send-email spit out:

Use of uninitialized value $cc in string eq at
/home/pclouds/opt/git/libexec/git-core/git-send-email line 983.
Use of uninitialized value $cc in quotemeta at
/home/pclouds/opt/git/libexec/git-core/git-send-email line 983.
W: unable to extract a valid address from: Fernando Vezzosi <buccia@@re=
pnz.net>
W: unable to extract a valid address from: Fernando Vezzosi <buccia@@re=
pnz.net>

but it's really hard to see that. Maybe send-email should not allow me
to send in this case (unless I give --force), or make the warnings
more outstanding?

On Sat, May 12, 2012 at 3:08 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> A few attempts have been made in the past to change 'gc --auto' [1]
> [2]. This is another such attempt.
>
> Commit d4bb43e (Invoke "git gc --auto" from commit, merge, am and
> rebase. - 2007-09-05) used the rule to put "gc --auto" is "where
> update-ref occurs". I would argue that this is not a good condition t=
o
> run gc, because (at least current) gc is slow. We encourage commit
> often and rebase to make all patches in good shape and this workflow
> should not be interrupted/slowed down by random "gc --auto".
>
> Instead, we could just inform users that "gc" should be run soon in
> commonly used commands (this patch also reinstates "gc" check in
> commit, which was lost at the sh->C conversion). [1] and [2] can anno=
y
> users constantly with warnings. This patch shows the warning at most
> once a day.
>
> There are commands that are not expected to return immediately. These
> are more suitable for "gc --auto". One of them is receive-pack, which
> already calls "gc --auto". The other one is index-pack, which "gc
> --auto" is added in by this patch.
>
> In short, after this patch:
>
> =C2=A0- receive-pack and index-pack (or push, pull/fetch at high leve=
l) can
> =C2=A0 do "gc --auto".
> =C2=A0- commmit, merge, am, rebase warns once a day, no actual gc.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/184848
> =C2=A0 adds an config option to turn --auto to warning only
>
> [2] http://thread.gmane.org/gmane.comp.version-control.git/187711
> =C2=A0 make it warn early before actual do the house keeping
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0builtin/commit.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A02 ++
> =C2=A0builtin/gc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 21 ++++++++++++++++++++-
> =C2=A0builtin/index-pack.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 16 +++++++++=
+++++--
> =C2=A0builtin/merge.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A02 +-
> =C2=A0git-am.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0git-rebase--interactive.sh | =C2=A0 =C2=A02 +-
> =C2=A06 files changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index a2ec73d..4ba5677 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1418,6 +1418,7 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_END()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> + =C2=A0 =C2=A0 =C2=A0 const char *argv_gc_auto[] =3D { "gc", "--chec=
k", NULL };
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf sb =3D STRBUF_INIT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf author_ident =3D STRBUF_INIT=
;
> @@ -1589,6 +1590,7 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 "new_index file. Check that disk is not full or quota is\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 "not exceeded, and then \"git reset HEAD\" to recover."));
>
> + =C2=A0 =C2=A0 =C2=A0 run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rerere(0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0run_hook(get_index_file(), "post-commit", =
NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (amend && !no_post_rewrite) {
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 9b4232c..a85f71c 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -171,6 +171,7 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int aggressive =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int auto_gc =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int check_gc =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int quiet =3D 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct option builtin_gc_options[] =3D {
> @@ -180,12 +181,16 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_BOOLEAN(0,=
 "aggressive", &aggressive, "be more thorough (increased runtime)"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_BOOLEAN(0,=
 "auto", &auto_gc, "enable auto-gc mode"),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN(0, "ch=
eck", &check_gc, "enable auto-gc mode"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_END()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0};
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argc =3D=3D 2 && !strcmp(argv[1], "-h"=
))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage_with_opt=
ions(builtin_gc_usage, builtin_gc_options);
>
> + =C2=A0 =C2=A0 =C2=A0 if (auto_gc && check_gc)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die(_("--auto and =
--check are incompatible"));
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_array_pushl(&pack_refs_cmd, "pack-ref=
s", "--all", "--prune", NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_array_pushl(&reflog, "reflog", "expir=
e", "--all", NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_array_pushl(&repack, "repack", "-d", =
"-l", NULL);
> @@ -211,12 +216,26 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (quiet)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0argv_array_pus=
h(&repack, "-q");
>
> - =C2=A0 =C2=A0 =C2=A0 if (auto_gc) {
> + =C2=A0 =C2=A0 =C2=A0 if (auto_gc || check_gc) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Auto-gc sho=
uld be least intrusive as possible.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!need_to_g=
c())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (check_gc) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 struct stat st;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (stat(git_path("gc_needed"), &st))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open(git_path("gc_needed"), O_CREAT=
 | O_RDWR);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* do not bother users more than on=
ce a day */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (time(NULL) - st.st_mtime < 8640=
0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return =
0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 utime(git_path("gc_needed"), NULL);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 warning(_("This repository needs maintenance. "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Please run \"git gc\" as so=
on as possible."));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (quiet)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0fprintf(stderr, _("Auto packing the repository for optimu=
m performance.\n"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 83555e5..438245c 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -9,6 +9,7 @@
> =C2=A0#include "progress.h"
> =C2=A0#include "fsck.h"
> =C2=A0#include "exec_cmd.h"
> +#include "run-command.h"
>
> =C2=A0static const char index_pack_usage[] =3D
> =C2=A0"git index-pack [-v] [-o <index-file>] [--keep | --keep=3D<msg>=
] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file=
>])";
> @@ -63,6 +64,7 @@ static int nr_resolved_deltas;
> =C2=A0static int from_stdin;
> =C2=A0static int strict;
> =C2=A0static int verbose;
> +static int auto_gc;
>
> =C2=A0static struct progress *progress;
>
> @@ -968,6 +970,10 @@ static int git_index_pack_config(const char *k, =
const char *v, void *cb)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0die("bad pack.indexversion=3D%"PRIu32, opts->version);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 if (strcmp(k, "receive.autogc") =3D=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auto_gc =3D git_co=
nfig_bool(k, v);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return git_default_config(k, v, cb);
> =C2=A0}
>
> @@ -1254,12 +1260,18 @@ int cmd_index_pack(int argc, const char **arg=
v, const char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0curr_index =3D write_idx_file(index_name, =
idx_objects, nr_objects, &opts, pack_sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free(idx_objects);
>
> - =C2=A0 =C2=A0 =C2=A0 if (!verify)
> + =C2=A0 =C2=A0 =C2=A0 if (!verify) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0final(pack_nam=
e, curr_pack,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0index_name, curr_index,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0keep_name, keep_msg,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pack_sha1);
> - =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (auto_gc) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *argv_gc_auto[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "gc", "--auto", "--quiet", NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 };
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 } else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(input_fd=
);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free(objects);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free(index_name_buf);
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 470fc57..8b8716e 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -385,7 +385,7 @@ static void finish(struct commit *head_commit,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (verbosity =
>=3D 0 && !merge_msg.len)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0printf(_("No merge message -- not updating HEAD\n"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *argv_gc_auto[] =3D { "gc", "--auto", NULL };
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *argv_gc_auto[] =3D { "gc", "--check", NULL };
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0update_ref(reflog_message.buf, "HEAD",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_head, head, 0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DIE_ON_ERR);
> diff --git a/git-am.sh b/git-am.sh
> index f8b7a0c..0f2dbc4 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -902,4 +902,4 @@ if test -s "$dotest"/rewritten; then
> =C2=A0fi
>
> =C2=A0rm -fr "$dotest"
> -git gc --auto
> +git gc --check
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0c19b7c..89996a3 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -573,7 +573,7 @@ do_next () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true # we don'=
t care if this hook failed
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -rf "$state_dir" &&
> - =C2=A0 =C2=A0 =C2=A0 git gc --auto &&
> + =C2=A0 =C2=A0 =C2=A0 git gc --check &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0warn "Successfully rebased and updated $he=
ad_name."
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit
> --
> 1.7.8.36.g69ee2
>



--=20
Duy
