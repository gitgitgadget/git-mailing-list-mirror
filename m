From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 3/3] receive-pack: detect aliased updates which can 
	occur with symrefs
Date: Thu, 10 Jun 2010 18:06:35 +0000
Message-ID: <AANLkTindct9FNsDGeGwFcMxFqgyxa4FlvtE0Lbw95GQM@mail.gmail.com>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
	<1271715558-56781-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junio@kernel.org>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:06:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMm9L-0007Do-Ns
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759528Ab0FJSGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 14:06:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43652 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757215Ab0FJSGg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 14:06:36 -0400
Received: by iwn37 with SMTP id 37so195672iwn.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HDtlGoM2GIbcy5eRzno0wlCoYFPHFgptEfNa06yYePA=;
        b=achndXDcnkZXIj6Y6j6uq5titH3nFmzfnoVfoixYa3CpDoormGcB0mJ9pTQIfZPyD3
         nSsgpKS5NXtwrGdzS67JOk6oo8UTPMRFBN1LAmSc070A7BNLsp6i6nyABN+qmjrrpjZn
         BttBu3G2Qsd9PQfkqLEWDaZMj7WIh8a1eiqbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WDNhtY1FQ25GTarMHYpn+2XOoKefg6wS01TtshFOEM52KbjoPWB2BPdXyg68Kb/Tmq
         oFOxks9guS6DI+nWeZyVAA2PW+YYlC1OGTRJwtCxCq9s5m8kl+P7ykn0iLydXtTNm2vn
         ltNQsAHuubcHpq65BXJDzflAiqe8UX/MnDXRg=
Received: by 10.231.196.221 with SMTP id eh29mr461899ibb.180.1276193195719; 
	Thu, 10 Jun 2010 11:06:35 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Thu, 10 Jun 2010 11:06:35 -0700 (PDT)
In-Reply-To: <1271715558-56781-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148900>

On Mon, Apr 19, 2010 at 22:19, Jay Soffian <jaysoffian@gmail.com> wrote=
:
> When pushing to a remote repo the sending side filters out aliased
> updates (e.g., foo:baz bar:baz). However, it is not possible for the
> sender to know if two refs are aliased on the receiving side via
> symrefs. Here is one such scenario:
>
> =C2=A0$ git init origin
> =C2=A0$ (cd origin && touch file && git add file && git commit -a -m =
intial)
> =C2=A0$ git clone --bare origin origin.git
> =C2=A0$ rm -rf origin
>
> =C2=A0$ git clone origin.git client
>
> =C2=A0$ git clone --mirror client backup.git &&
> =C2=A0$ (cd backup.git && git remote set-head origin --auto)
>
> =C2=A0$ (cd client &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git remote add --mirror backup ../backup.g=
it &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo change1 > file && git commit -a -m ch=
ange1 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git push origin &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git push backup
> =C2=A0 =C2=A0 =C2=A0 =C2=A0)
>
> The push to backup fails with:
>
> =C2=A0Counting objects: 5, done.
> =C2=A0Writing objects: 100% (3/3), 244 bytes, done.
> =C2=A0Total 3 (delta 0), reused 0 (delta 0)
> =C2=A0Unpacking objects: 100% (3/3), done.
> =C2=A0error: Ref refs/remotes/origin/master is at ef3... but expected=
 262...
> =C2=A0remote: error: failed to lock refs/remotes/origin/master
> =C2=A0To ../backup.git
> =C2=A0 =C2=A0 262cd57..ef307ff =C2=A0master -> master
> =C2=A0 =C2=A0 262cd57..ef307ff =C2=A0origin/HEAD -> origin/HEAD
> =C2=A0 ! [remote rejected] origin/master -> origin/master (failed to =
lock)
> =C2=A0error: failed to push some refs to '../backup.git'
>
> The reason is that refs/remotes/origin/HEAD is a symref to
> refs/remotes/origin/master, but it is not possible for the sending si=
de
> to unambiguously know this.
>
> This commit fixes the issue by having receive-pack ignore any update =
to
> a symref whose target is being identically updated. If a symref and i=
ts
> target are being updated inconsistently, then the update for both fai=
ls
> with an error message ("refusing inconsistent update...") to help
> diagnose the situation.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> =C2=A0builtin-receive-pack.c | =C2=A0 68 ++++++++++++++++++++++++++++=
+++++++++++++++++---
> =C2=A0t/t5516-fetch-push.sh =C2=A0| =C2=A0 49 +++++++++++++++++++++++=
+++++++++++
> =C2=A02 files changed, 113 insertions(+), 4 deletions(-)
>
> diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
> index fffb6ea..bb34757 100644
> --- a/builtin-receive-pack.c
> +++ b/builtin-receive-pack.c
> @@ -9,6 +9,7 @@
> =C2=A0#include "object.h"
> =C2=A0#include "remote.h"
> =C2=A0#include "transport.h"
> +#include "string-list.h"
>
> =C2=A0static const char receive_pack_usage[] =3D "git receive-pack <g=
it-dir>";
>
> @@ -129,6 +130,7 @@ static void write_head_info(void)
> =C2=A0struct command {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct command *next;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *error_string;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int skip_update;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char old_sha1[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char new_sha1[20];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char ref_name[FLEX_ARRAY]; /* more */
> @@ -486,6 +488,63 @@ static void run_update_post_hook(struct command =
*commands)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
>
> +static void check_aliased_update(struct command *cmd, struct string_=
list *list)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct string_list_item *item;
> + =C2=A0 =C2=A0 =C2=A0 struct command *dst_cmd;
> + =C2=A0 =C2=A0 =C2=A0 unsigned char sha1[20];
> + =C2=A0 =C2=A0 =C2=A0 char cmd_oldh[41], cmd_newh[41], dst_oldh[41],=
 dst_newh[41];
> + =C2=A0 =C2=A0 =C2=A0 int flag;
> +
> + =C2=A0 =C2=A0 =C2=A0 const char *dst_name =3D resolve_ref(cmd->ref_=
name, sha1, 0, &flag);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!(flag & REF_ISSYMREF))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 if ((item =3D string_list_lookup(dst_name, lis=
t)) =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 cmd->skip_update =3D 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 dst_cmd =3D (struct command *) item->util;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!hashcmp(cmd->old_sha1, dst_cmd->old_sha1)=
 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !hashcmp(cmd->new_sha1, dst_cmd-=
>new_sha1))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 dst_cmd->skip_update =3D 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 strcpy(cmd_oldh, find_unique_abbrev(cmd->old_s=
ha1, DEFAULT_ABBREV));
> + =C2=A0 =C2=A0 =C2=A0 strcat(cmd_newh, find_unique_abbrev(cmd->new_s=
ha1, DEFAULT_ABBREV));
> + =C2=A0 =C2=A0 =C2=A0 strcpy(dst_oldh, find_unique_abbrev(dst_cmd->o=
ld_sha1, DEFAULT_ABBREV));
> + =C2=A0 =C2=A0 =C2=A0 strcat(dst_newh, find_unique_abbrev(dst_cmd->n=
ew_sha1, DEFAULT_ABBREV));
> + =C2=A0 =C2=A0 =C2=A0 rp_error("refusing inconsistent update between=
 symref '%s' (%s..%s) and"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" its target=
 '%s' (%s..%s)",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd->ref_nam=
e, cmd_oldh, cmd_newh,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_cmd->ref=
_name, dst_oldh, dst_newh);
> +
> + =C2=A0 =C2=A0 =C2=A0 cmd->error_string =3D dst_cmd->error_string =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "inconsistent alia=
sed update";
> +}
> +
> +static void check_aliased_updates(struct command *commands)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct command *cmd;
> + =C2=A0 =C2=A0 =C2=A0 struct string_list ref_list =3D { NULL, 0, 0, =
0 };
> +
> + =C2=A0 =C2=A0 =C2=A0 for (cmd =3D commands; cmd; cmd =3D cmd->next)=
 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct string_list=
_item *item =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 string_list_append(cmd->ref_name, &ref_list);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 item->util =3D (vo=
id *)cmd;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 sort_string_list(&ref_list);
> +
> + =C2=A0 =C2=A0 =C2=A0 for (cmd =3D commands; cmd; cmd =3D cmd->next)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 check_aliased_upda=
te(cmd, &ref_list);
> +
> + =C2=A0 =C2=A0 =C2=A0 string_list_clear(&ref_list, 0);
> +}
> +
> =C2=A0static void execute_commands(struct command *commands, const ch=
ar *unpacker_error)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct command *cmd;
> @@ -503,10 +562,13 @@ static void execute_commands(struct command *co=
mmands, const char *unpacker_erro
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 check_aliased_updates(commands);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0head_name =3D resolve_ref("HEAD", sha1, 0,=
 NULL);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (cmd =3D commands; cmd; cmd =3D cmd->n=
ext)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->error_string =
=3D update(cmd);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cmd->skip_upd=
ate)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 cmd->error_string =3D update(cmd);
> =C2=A0}
>
> =C2=A0static struct command *read_head_info(void)
> @@ -541,12 +603,10 @@ static struct command *read_head_info(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (strstr(refname + reflen + 1, "side-band-64k"))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use_sideband =3D LARGE_PACKET=
_MAX;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D xmalloc(si=
zeof(struct command) + len - 80);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D xcalloc(1,=
 sizeof(struct command) + len - 80);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hashcpy(cmd->o=
ld_sha1, old_sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hashcpy(cmd->n=
ew_sha1, new_sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(cmd->re=
f_name, line + 82, len - 81);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->error_string =
=3D NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd->next =3D NULL=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*p =3D cmd;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D &cmd->ne=
xt;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 3148789..f0813e0 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -683,4 +683,53 @@ test_expect_success 'push with branches containi=
ng #' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout master
> =C2=A0'
>
> +test_expect_success 'push into aliased refs (consistent)' '
> + =C2=A0 =C2=A0 =C2=A0 mk_test heads/master &&
> + =C2=A0 =C2=A0 =C2=A0 mk_child child1 &&
> + =C2=A0 =C2=A0 =C2=A0 mk_child child2 &&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd child1 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git branch foo &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git symbolic-ref r=
efs/heads/bar refs/heads/foo
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config receive=
=2EdenyCurrentBranch false
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd child2 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >path2 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git add path2 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git commit -a -m c=
hild2 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git branch foo &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git branch bar &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git push ../child1=
 foo bar
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> +test_expect_success 'push into aliased refs (inconsistent)' '
> + =C2=A0 =C2=A0 =C2=A0 mk_test heads/master &&
> + =C2=A0 =C2=A0 =C2=A0 mk_child child1 &&
> + =C2=A0 =C2=A0 =C2=A0 mk_child child2 &&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd child1 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git branch foo &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git symbolic-ref r=
efs/heads/bar refs/heads/foo
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config receive=
=2EdenyCurrentBranch false
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd child2 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >path2 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git add path2 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git commit -a -m c=
hild2 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git branch foo &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 >path3 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git add path3 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git commit -a -m c=
hild2 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git branch bar &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 push ../child1 foo bar 2>stderr &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grep "refusing inc=
onsistent update" stderr
> + =C2=A0 =C2=A0 =C2=A0 )
> +'
> +
> =C2=A0test_done
> --
> 1.7.0.3.436.g2b878

I've been having troubles running t5516-fetch-push.sh which I traced
down to this patch, here's the gist of it:

    $ make
    rm -f -r test-results
    make aggregate-results-and-cleanup
    make[1]: Entering directory `/home/avar/g/git/t'
    echo "*** t5516-fetch-push.sh ***"; GIT_CONFIG=3D.git/config
'/bin/sh' t5516-fetch-push.sh
    *** t5516-fetch-push.sh ***
    *   ok 1: setup
    *   ok 2: fetch without wildcard
    *   ok 3: fetch with wildcard
    *   ok 4: fetch with insteadOf
    *   ok 5: fetch with pushInsteadOf (should not rewrite)
    *   ok 6: push without wildcard
    *   ok 7: push with wildcard
    *   ok 8: push with insteadOf
    *   ok 9: push with pushInsteadOf
    *   ok 10: push with pushInsteadOf and explicit pushurl
(pushInsteadOf should not rewrite)
    *   ok 11: push with matching heads
    *   ok 12: push with matching heads on the command line
    *   ok 13: failed (non-fast-forward) push with matching heads
    *   ok 14: push --force with matching heads
    *   ok 15: push with matching heads and forced update
    *   ok 16: push with no ambiguity (1)
    *   ok 17: push with no ambiguity (2)
    *   ok 18: push with colon-less refspec, no ambiguity
    *   ok 19: push with weak ambiguity (1)
    *   ok 20: push with weak ambiguity (2)
    *   ok 21: push with ambiguity
    *   ok 22: push with colon-less refspec (1)
    *   ok 23: push with colon-less refspec (2)
    *   ok 24: push with colon-less refspec (3)
    *   ok 25: push with colon-less refspec (4)
    *   ok 26: push head with non-existant, incomplete dest
    *   ok 27: push tag with non-existant, incomplete dest
    *   ok 28: push sha1 with non-existant, incomplete dest
    *   ok 29: push ref expression with non-existant, incomplete dest
    *   ok 30: push with HEAD
    *   ok 31: push with HEAD nonexisting at remote
    *   ok 32: push with +HEAD
    *   ok 33: push HEAD with non-existant, incomplete dest
    *   ok 34: push with config remote.*.push =3D HEAD
    *   ok 35: push with config remote.*.pushurl
    *   ok 36: push with dry-run
    *   ok 37: push updates local refs
    *   ok 38: push updates up-to-date local refs
    *   ok 39: push preserves up-to-date packed refs
    *   ok 40: push does not update local refs on failure
    *   ok 41: allow deleting an invalid remote ref
    *   ok 42: allow deleting a ref using --delete
    *   ok 43: allow deleting a tag using --delete
    *   ok 44: push --delete without args aborts
    *   ok 45: push --delete refuses src:dest refspecs
    *   ok 46: warn on push to HEAD of non-bare repository
    *   ok 47: deny push to HEAD of non-bare repository
    *   ok 48: allow push to HEAD of bare repository (bare)
    *   ok 49: allow push to HEAD of non-bare repository (config)
    *   ok 50: fetch with branches
    *   ok 51: fetch with branches containing #
    *   ok 52: push with branches
    *   ok 53: push with branches containing #
    *   ok 54: push into aliased refs (consistent)
    *** buffer overflow detected ***: receive-pack terminated
    =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
    /lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x50)[0x402a0350]
    /lib/tls/i686/cmov/libc.so.6(+0xe128a)[0x4029f28a]
    /lib/tls/i686/cmov/libc.so.6(+0xe05ba)[0x4029e5ba]
    receive-pack[0x8094de8]
    receive-pack[0x804b8ab]
    receive-pack[0x804be73]
    /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe6)[0x401d4bd6]
    receive-pack[0x804b211]
    =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
    08048000-0813e000 r-xp 00000000 08:02 6792494
/home/avar/g/git/git-receive-pack
    0813e000-0813f000 r--p 000f6000 08:02 6792494
/home/avar/g/git/git-receive-pack
    0813f000-08143000 rw-p 000f7000 08:02 6792494
/home/avar/g/git/git-receive-pack
    08143000-08189000 rw-p 00000000 00:00 0
    0996b000-0998c000 rw-p 00000000 00:00 0          [heap]
    40000000-4001b000 r-xp 00000000 08:02 5496926    /lib/ld-2.11.1.so
    4001b000-4001c000 r--p 0001a000 08:02 5496926    /lib/ld-2.11.1.so
    4001c000-4001d000 rw-p 0001b000 08:02 5496926    /lib/ld-2.11.1.so
    4001d000-4001e000 r-xp 00000000 00:00 0          [vdso]
    4001e000-40020000 rw-p 00000000 00:00 0
    4003d000-40050000 r-xp 00000000 08:02 5497495    /lib/libz.so.1.2.3=
=2E3
    40050000-40051000 r--p 00012000 08:02 5497495    /lib/libz.so.1.2.3=
=2E3
    40051000-40052000 rw-p 00013000 08:02 5497495    /lib/libz.so.1.2.3=
=2E3
    40052000-4018a000 r-xp 00000000 08:02 4431990
/lib/i686/cmov/libcrypto.so.0.9.8
    4018a000-40192000 r--p 00137000 08:02 4431990
/lib/i686/cmov/libcrypto.so.0.9.8
    40192000-401a0000 rw-p 0013f000 08:02 4431990
/lib/i686/cmov/libcrypto.so.0.9.8
    401a0000-401a5000 rw-p 00000000 00:00 0
    401a5000-401ba000 r-xp 00000000 08:02 7234200
/lib/tls/i686/cmov/libpthread-2.11.1.so
    401ba000-401bb000 r--p 00014000 08:02 7234200
/lib/tls/i686/cmov/libpthread-2.11.1.so
    401bb000-401bc000 rw-p 00015000 08:02 7234200
/lib/tls/i686/cmov/libpthread-2.11.1.so
    401bc000-401be000 rw-p 00000000 00:00 0
    401be000-40311000 r-xp 00000000 08:02 7233919
/lib/tls/i686/cmov/libc-2.11.1.so
    40311000-40312000 ---p 00153000 08:02 7233919
/lib/tls/i686/cmov/libc-2.11.1.so
    40312000-40314000 r--p 00153000 08:02 7233919
/lib/tls/i686/cmov/libc-2.11.1.so
    40314000-40315000 rw-p 00155000 08:02 7233919
/lib/tls/i686/cmov/libc-2.11.1.so
    40315000-40318000 rw-p 00000000 00:00 0
    40318000-4031a000 r-xp 00000000 08:02 7233925
/lib/tls/i686/cmov/libdl-2.11.1.so
    4031a000-4031b000 r--p 00001000 08:02 7233925
/lib/tls/i686/cmov/libdl-2.11.1.so
    4031b000-4031c000 rw-p 00002000 08:02 7233925
/lib/tls/i686/cmov/libdl-2.11.1.so
    4031c000-4031d000 rw-p 00000000 00:00 0
    4031d000-4033a000 r-xp 00000000 08:02 7217157    /lib/libgcc_s.so.1
    4033a000-4033b000 r--p 0001c000 08:02 7217157    /lib/libgcc_s.so.1
    4033b000-4033c000 rw-p 0001d000 08:02 7217157    /lib/libgcc_s.so.1
    bf9b1000-bf9c6000 rw-p 00000000 00:00 0          [stack]
    * FAIL 55: push into aliased refs (inconsistent)
    =09
    		mk_test heads/master &&
    		mk_child child1 &&
    		mk_child child2 &&
    		(
    			cd child1 &&
    			git branch foo &&
    			git symbolic-ref refs/heads/bar refs/heads/foo
    			git config receive.denyCurrentBranch false
    		) &&
    		(
    			cd child2 &&
    			>path2 &&
    			git add path2 &&
    			test_tick &&
    			git commit -a -m child2 &&
    			git branch foo &&
    			>path3 &&
    			git add path3 &&
    			test_tick &&
    			git commit -a -m child2 &&
    			git branch bar &&
    			test_must_fail git push ../child1 foo bar 2>stderr &&
    			grep "refusing inconsistent update" stderr
    		)
    =09
    *   ok 56: push --porcelain
    *   ok 57: push --porcelain bad url
    *   ok 58: push --porcelain rejected
    *   ok 59: push --porcelain --dry-run rejected
    * failed 1 among 59 test(s)
    make[1]: *** [t5516-fetch-push.sh] Error 1
    make[1]: Leaving directory `/home/avar/g/git/t'
    make: *** [all] Error 2


And the bisect script/log from 1.7.0 to master:

    #!/bin/sh
    cd ~/g/git
    git reset --hard >/dev/null
    git clean -dxf >/dev/null

    make >/dev/null 2>&1
    cp -v /tmp/Makefile t/Makefile
    make test
    ret=3D$?

    git reset --hard >/dev/null
    git clean -dxf  >/dev/null

    exit $ret

log:

    $ git bisect log
    git bisect start
    # bad: [92a75a391e66cfc278cf59741e484efd80c02176] Merge branch 'mai=
nt'
    git bisect bad 92a75a391e66cfc278cf59741e484efd80c02176
    # good: [e923eaeb901ff056421b9007adcbbce271caa7b6] Git 1.7.0
    git bisect good e923eaeb901ff056421b9007adcbbce271caa7b6
    # good: [419fe5bc861517c789c8f028519e085fd8d1992f] fmt-merge-msg:
be quiet if nothing to merge
    git bisect good 419fe5bc861517c789c8f028519e085fd8d1992f
    # good: [b6b0afdc30e066788592ca07c9a6c6936c68cc11] test-lib: some
shells do not let $? propagate into an eval
    git bisect good b6b0afdc30e066788592ca07c9a6c6936c68cc11
    # good: [cd4ce1e8a81ef5c24af7b914fb72212273e7d489] Merge branch
'jc/status-show-ignored'
    git bisect good cd4ce1e8a81ef5c24af7b914fb72212273e7d489
    # bad: [71f1d729b39ce5c92df6d623151f88bbb5d4c774] Merge branch
'jn/gitweb-our-squelch'
    git bisect bad 71f1d729b39ce5c92df6d623151f88bbb5d4c774
    # good: [465ef577b59986d70c51ea72dd3f87759b2bcd4f] Merge branch
'jn/submodule-basic-test'
    git bisect good 465ef577b59986d70c51ea72dd3f87759b2bcd4f
    # bad: [9215f76fb6d938ae93889f46f27cff22723fe0e4] Merge branch
'js/maint-receive-pack-symref-alias'
    git bisect bad 9215f76fb6d938ae93889f46f27cff22723fe0e4
    # good: [9b0aa728705439ca4b4e7ec845f79f8487059320] Extract
verify_pack_index for reuse from verify_pack
    git bisect good 9b0aa728705439ca4b4e7ec845f79f8487059320
    # good: [90d05713575ea6ed21d05228bcda8461f7b28ccf]
http.c::new_http_pack_request: do away with the temp variable filename
    git bisect good 90d05713575ea6ed21d05228bcda8461f7b28ccf
    # bad: [da3efdb17bef25dedc753131462ee784d822132e] receive-pack:
detect aliased updates which can occur with symrefs
    git bisect bad da3efdb17bef25dedc753131462ee784d822132e
    # good: [5e1c71fd1488a33680c313f287b88d9f7a7d3e45] receive-pack:
switch global variable 'commands' to a parameter
    git bisect good 5e1c71fd1488a33680c313f287b88d9f7a7d3e45

What the t/Makefile patch does is this:

    diff --git a/t/Makefile b/t/Makefile
    index 25c559b..da0d5bc 100644
    --- a/t/Makefile
    +++ b/t/Makefile
    @@ -13,7 +13,7 @@ RM ?=3D rm -f
     # Shell quote;
     SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))

    -T =3D $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
    +T =3D $(wildcard t[5][5][1][6]-*.sh)
     TSVN =3D $(wildcard t91[0-9][0-9]-*.sh)

The reason is that I can't reproduce this when running just the
script, it has to be through make test, which suggests some sort of
evil heisenbug. Even running the exact same commands the Makefile
would run to execute the script doesn't work.

I also ran the tests under valgrind, here's the full output:
http://gist.github.com/433379
