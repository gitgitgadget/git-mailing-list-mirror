From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/3] revert: write REVERT_HEAD pseudoref during conflicted revert
Date: Thu, 1 Dec 2011 15:04:43 +0530
Message-ID: <CALkWK0mp4-nxLsf=wjDwHOhvoWFNzNz-Rc+Q+S_Er5rpFW2k=Q@mail.gmail.com>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122111736.GE7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 10:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW32w-0005dV-SI
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 10:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab1LAJfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Dec 2011 04:35:07 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62329 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab1LAJfG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 04:35:06 -0500
Received: by eaak14 with SMTP id k14so1871740eaa.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 01:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=i4SaJAXutQLohiLoBah58fUzsoOiTl4WcAn58dYq8NM=;
        b=EgaXZYPxgDrcqntEMsmmP4i4HHyUJeXcLx+wZ+P3DgaJJ/hAvLfXZBJQIHno8GAYw+
         30r9olLLrcA18t1PaqAFzCGxwCbcxgtaeF2VbJFS/dn+sWG2gyQEgdfCkB1P/bdeeHEh
         R72TNYhJ3Ejd3hfhxSGmvdlT62wq98nCpFQVI=
Received: by 10.180.107.231 with SMTP id hf7mr1124484wib.68.1322732104234;
 Thu, 01 Dec 2011 01:35:04 -0800 (PST)
Received: by 10.216.176.13 with HTTP; Thu, 1 Dec 2011 01:34:43 -0800 (PST)
In-Reply-To: <20111122111736.GE7399@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186167>

Hi,

Jonathan Nieder wrote:
> [...]
> Set a REVERT_HEAD pseudoref when "git revert" does not make a commit,
> for cases like this. =C2=A0This also makes it possible for scripts to
> distinguish between a revert that encountered conflicts and other
> sources of an unmerged index.

Sounds a lot like CHERRY_PICK_HEAD counterpart.  Let's read ahead and
see if there are any unexpected differences.

> diff --git a/branch.c b/branch.c
> index d8098762..025a97be 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -241,6 +241,7 @@ void create_branch(const char *head,
> =C2=A0void remove_branch_state(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("CHERRY_PICK_HEAD"));
> + =C2=A0 =C2=A0 =C2=A0 unlink(git_path("REVERT_HEAD"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_HEAD"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_RR"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_MSG"));
> diff --git a/builtin/commit.c b/builtin/commit.c
> index c46f2d18..8f2bebec 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1514,6 +1514,7 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("CHERRY_PICK_HEAD"));
> + =C2=A0 =C2=A0 =C2=A0 unlink(git_path("REVERT_HEAD"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_HEAD"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_MSG"));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(git_path("MERGE_MODE"));

So far so good.  Behaves exactly like CHERRY_PICK_HEAD.

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 1d112e4c..f5ba67a5 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -289,7 +289,7 @@ static char *get_encoding(const char *message)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
> =C2=A0}
>
> -static void write_cherry_pick_head(struct commit *commit)
> +static void write_cherry_pick_head(struct commit *commit, const char=
 *pseudoref)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *filename;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;
> @@ -297,7 +297,7 @@ static void write_cherry_pick_head(struct commit =
*commit)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addf(&buf, "%s\n", sha1_to_hex(comm=
it->object.sha1));
>
> - =C2=A0 =C2=A0 =C2=A0 filename =3D git_path("CHERRY_PICK_HEAD");
> + =C2=A0 =C2=A0 =C2=A0 filename =3D git_path(pseudoref);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(filename, O_WRONLY | O_CREAT, =
0666);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die_errno(_("C=
ould not open '%s' for writing"), filename);
> @@ -597,7 +597,9 @@ static int do_pick_commit(struct commit *commit, =
struct replay_opts *opts)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * write it at all.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opts->action =3D=3D CHERRY_PICK && !op=
ts->no_commit && (res =3D=3D 0 || res =3D=3D 1))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_cherry_pick_=
head(commit);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_cherry_pick_=
head(commit, "CHERRY_PICK_HEAD");
> + =C2=A0 =C2=A0 =C2=A0 if (opts->action =3D=3D REVERT && ((opts->no_c=
ommit && res =3D=3D 0) || res =3D=3D 1))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_cherry_pick_=
head(commit, "REVERT_HEAD");
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error(opts->ac=
tion =3D=3D REVERT

Interesting.  This additional symmetry will probably make life much
easier for my pending "New Sequencer Workflow! v2" series.

> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-co=
nflict.sh
> index cb45574a..ee1659c1 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> [...]

And some tests.  Nice.

Thanks.

-- Ram
