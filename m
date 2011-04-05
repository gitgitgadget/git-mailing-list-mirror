From: Kevin Ballard <kevin@sb.org>
Subject: Re: rebase autosquash doesn't recognise a chain of fixups
Date: Tue, 05 Apr 2011 11:02:06 -0700
Message-ID: <B584DA91-1811-4976-A915-458672455DAD@sb.org>
References: <20110405154100.GC16031@bee.lab.cmartin.tk>
 <7v4o6cob4t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Notz <patnotz@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?utf-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 21:06:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Ba7-0006tn-2J
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 21:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab1DETGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 15:06:22 -0400
Received: from honeycrisp.apple.com ([17.151.62.51]:65414 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab1DETGV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 15:06:21 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Apr 2011 15:06:21 EDT
Received: from relay16.apple.com ([17.128.113.55])
 by localhost.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTP id <0LJ6009CRY65TC71@localhost.apple.com> for git@vger.kernel.org;
 Tue, 05 Apr 2011 11:06:20 -0700 (PDT)
X-AuditID: 11807137-b7c3cae0000010f5-4e-4d9b5a1b68df
Received: from et.apple.com (et.apple.com [17.151.62.12])
	by relay16.apple.com (Apple SCV relay) with SMTP id 3D.3B.04341.B1A5B9D4; Tue,
 05 Apr 2011 11:06:20 -0700 (PDT)
Received: from [17.244.5.20] by et.apple.com
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPSA id <0LJ600929YAJD410@et.apple.com> for git@vger.kernel.org; Tue,
 05 Apr 2011 11:06:19 -0700 (PDT)
In-reply-to: <7v4o6cob4t.fsf@alter.siamese.dyndns.org>
X-Mailer: iPad Mail (8G4)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170904>

This seems unnecessary. `git commit --fixup HEAD` doesn't really make a=
ny sense at all to run when you can say `git commit --amend` instead,

-Kevin

On Apr 5, 2011, at 10:34 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
>> Say I have the following commits:
>>=20
>>    5154127 fixup! fixup! one
>>    0d130d8 fixup! one
>>    0869d30 one
>>=20
>> because I keep executing `git commit -a --fixup HEAD`. When I want t=
o
>> squash them all into 0869d30, I do `git rebase -i --autosquash
>> 0869d30^` and I get
>>=20
>>    pick 0869d30 one
>>    fixup 0d130d8 fixup! one
>>    pick 5154127 fixup! fixup! one
>=20
> The way Kevin's d3d7a42 (rebase: better rearranging of fixup!/squash!
> lines with --autosquash, 2010-11-04) series works is to match "fixup!=
"
> only with "pick"; a later "fixup!" never matches an earlier "fixup!" =
but a
> "pick" can be matched against more than one "fixup!".
>=20
> I think one way to make this work is to fix what Pat did in d71b8ba
> (commit: --fixup option for use with rebase --autosquash, 2010-11-02)=
=2E
>=20
> Perhaps like this, but I'll leave additions of test scripts to t3415 =
to
> others.
>=20
> -- >8 --
> Subject: commit --fixup: do not duplicate "fixup! " at the beginning
>=20
> The "rebase -i" command can match more than one "fixup!" against a si=
ngle
> "pick" in the right order thanks to the earlier d3d7a42 (rebase: bett=
er
> rearranging of fixup!/squash! lines with --autosquash, 2010-11-04), b=
ut a
> "fixup!" entry is never matched with another "fixup!" entry.
>=20
> When creating a commit marked to fix up an earlier commit with --fixu=
p, we
> can mark it to look for the original and fix that one up.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> builtin/commit.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 67757e9..b3c4d63 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -668,6 +668,8 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
>        ctx.output_encoding =3D get_commit_output_encoding();
>        format_commit_message(commit, "fixup! %s\n\n",
>                      &sb, &ctx);
> +        while (!prefixcmp(sb.buf, "fixup! fixup!"))
> +            strbuf_splice(&sb, 0, 7, "", 0);
>        hook_arg1 =3D "message";
>    } else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
>        if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
