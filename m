From: =?ISO-8859-1?Q?Ingo_Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] Utilize config variable pager.stash in stash list command
Date: Tue, 16 Aug 2011 12:10:45 +0200
Message-ID: <4e4a4743.4e230d8a.bm000@wupperonline.de>
References: <20110815234714.GB4699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 12:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGwx-0002c3-2K
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 12:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab1HPKcm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 06:32:42 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:41723 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab1HPKcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 06:32:41 -0400
Received: from point.localnet (mue-88-130-93-036.dsl.tropolys.de [88.130.93.36])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id 2D4E811E2ABF
	for <git@vger.kernel.org>; Tue, 16 Aug 2011 12:32:39 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1QtGwo-3ZI-00 for <git@vger.kernel.org>; Tue, 16 Aug 2011 12:32:38 +0200
In-Reply-To: <20110815234714.GB4699@sigill.intra.peff.net>
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179430>

Jeff King wrote on Mon, 15 Aug 2011 16:47:14 -0700:

> On Sun, Aug 14, 2011 at 04:31:49PM +0200, Ingo Br=FCckl wrote:

>> Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>
>> ---
>>  By now stash list ignores it.
>>
>>  git-stash.sh |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-stash.sh b/git-stash.sh
>> index f4e6f05..7bb0856 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -264,7 +264,8 @@ have_stash () {
>>
>>  list_stash () {
>>       have_stash || return 0
>> -     git log --format=3D"%gd: %gs" -g "$@" $ref_stash --
>> +     test "$(git config --get pager.stash)" =3D "false" && no_pager=
=3D--no-pager
>> +     git $no_pager log --format=3D"%gd: %gs" -g "$@" $ref_stash --
>>  }

> It's not quite as simple as this these days. The pager.* variables ca=
n
> also point to a program to run as a pager for this specific command.

> This stuff is supposed to be handled by the "git" wrapper itself, whi=
ch
> will either run the pager (if the config is boolean true, or a specif=
ic
> command), or will set an environment variable to avoid running one fo=
r
> any subcommand (if it's boolean false).

> However, we don't respect pager.* config for external commands there =
at
> all. I think this was due to some initialization-order bugs that made=
 it
> hard for us to look at config before exec'ing external commands. But
> perhaps they are gone, as the patch below[1] seems to work OK for me.

>  git.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

> diff --git a/git.c b/git.c
> index 8828c18..47a6d3d 100644
> +++ b/git.c
> @@ -459,6 +459,8 @@ static void execv_dashed_external(const char **ar=
gv)
>         const char *tmp;
>         int status;
>
> +       if (use_pager =3D=3D -1)
> +               use_pager =3D check_pager_config(argv[0]);
>         commit_pager_choice();
>
>         strbuf_addf(&cmd, "git-%s", argv[0]);

> -Peff

> [1] I posted this in a similar discussion several months ago:


> http://thread.gmane.org/gmane.comp.version-control.git/161756/focus=3D=
161771

Actually, I only wanted to change the stash list behavior (but better s=
hould
have used $(git config --get pager.stash.list) for that). Unfortunately=
, it
is impossible then to force the pager with --paginate again.

> I think what it really needs is more testing to see if looking at the
> config then has any unintended side effects.

Yours surely is a far better approach, although it only can handle the =
main
command (stash), not the sub-command (list), but this is totally in
accordance with everything else in git.

With "pager.stash false" (which would then require --paginate for a lot=
 of
stash commands), I found that a paginated output of 'git -p stash show =
-p'
loses the diff colors, but that seems unrelated to your patch. It still=
 is
strange though.

Ingo
