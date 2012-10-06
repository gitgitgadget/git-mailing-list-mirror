From: Jeff King <peff@peff.net>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Sat, 6 Oct 2012 15:07:53 -0400
Message-ID: <20121006190753.GA5648@sigill.intra.peff.net>
References: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
 <op.wlp1lws70aolir@keputer>
 <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
 <20121005225758.GA1202@sigill.intra.peff.net>
 <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
 <20121006131200.GB11712@sigill.intra.peff.net>
 <7vvcenqx39.fsf@alter.siamese.dyndns.org>
 <20121006183026.GA3644@sigill.intra.peff.net>
 <CAOTq_pu=xWF7q3QobxSerkkbV56n5o+CPQSyHg8onwv73v25+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: =?utf-8?Q?Conrad=C2=A0Irwin?= <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 21:08:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZjS-0008SU-0X
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 21:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab2JFTH6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 15:07:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43152 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753804Ab2JFTH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 15:07:57 -0400
Received: (qmail 10002 invoked by uid 107); 6 Oct 2012 19:08:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 15:08:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 15:07:53 -0400
Content-Disposition: inline
In-Reply-To: <CAOTq_pu=xWF7q3QobxSerkkbV56n5o+CPQSyHg8onwv73v25+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207167>

On Sat, Oct 06, 2012 at 11:32:51AM -0700, Conrad=C2=A0Irwin wrote:

> I think I messed up sending somehow:

Thanks for resending.

> > What state should the "add -p" interaction start from for path F?
> > Should you be picking from a patch between the state you previously
> > "git add"ed to the index and the working tree, or should the entire
> > difference between HEAD and the working tree eligible to be picked
> > or deferred during the "add -p" session?  Starting from a temporary
> > index that matches HEAD essentially means that you lose the earlier
> > "git add F" [*1*].
>=20
> Two questions are easier answered:
>=20
> What should git commit --only --patch F do?
> =3D> It should start you from the state of HEAD.

Are you sure?  Does "--only" mean "only the changes I am about to mark"
or "only the paths I am about to tell you about"? Without partial hunk
selection (i.e., "commit -p"), they were the same; a path you mention i=
s
a path which will be either be staged in its entirety or not. Specifyin=
g
(or omitting) the path was sufficient to say what you wanted. But with
"-p", I can see three useful possibilities:

  1. Do not include F in the commit, even if changes are staged in the
     index (i.e., take HEAD exactly).

  2. Include F in the commit, and stage partial changes on top of what =
is
     already staged.

  3. Include F in the commit, and stage partial changes on top of HEAD.

In cases 2 and 3, we are still taking "only the path" F. But we are
not taking "only what is about to be staged" in 2. And I can see both
being useful (2 because it is more convenient not to re-approve staged
changes, and 3 because there is no way to unstage changes via "-p").

> What should git commit --include --patch F do?
> =3D> It should start you from the state of the index.

This one is much easier. The distinction between cases 2 and 3 above
does not exist here, because we always start from the current index
state.

So there are two questions:

  1. How does --only interact with partial staging (whether paths are
     specified or not)?

  2. What should the default for "-p" be, between "--only" and
     "--include"?

I think the answer to the second is "--only"; but a prerequisite to tha=
t
is making "--only" work at all (it currently just barfs). And a
prerequisite to that is figuring out what the right semantics are.

> The question that's harder to ponder, is "what should the default be"=
=2E

Interestingly, I came to the exact opposite conclusion of which questio=
n
is harder. :)

> The big UI problem with --only is not figuring out what should go in =
the commit,
> but rather ensuring that the index is in the expected state after the=
 commit
> (it's the problems solved by 2888605c649ccd423232161186d72c0e6c458a48=
 but for
> hunks instead of files). If file F has hunks (H, J, K) then I stage h=
unk J with
> git add --interactive; then I commit hunks H & K with git commit --in=
teractive,
> the resulting index should contain H, J, K. Unfortunately, git add --=
interactive
> allows me to edit hunks, and so if I instead commit H & J2 (where J2 =
is an
> edited version of J) then the index would contain (H, J) and the comm=
it (H, J2);
> the working tree would contain H, J, K still.

Yeah, that's a gross-ness I hadn't even considered.

> All in all, I think supporting --only --interactive is well beyond wh=
at I'm
> capable of doing, and probably pushing the limits of what's sane. (it=
 would be
> nice for warm fuzzy completeness reasons though).

Yes. The more we talk about it, the more turned off I am by the idea.
Above I posed my questions as "what _should_ we do when...". And I stil=
l
think we _should_ default to --only with interactive, if we can find
sane semantics. But until we can find them, it obviously does not make
sense to enable it, and the whole discussion is stalled. And we must
come up with an interim solution that is the least bad.

Which is obviously one of:

  1. Keep defaulting to "--include", as that is what we have been doing=
=2E

  2. Forbid the cases where it would matter (i.e., when the index and
     HEAD differ).

The former is more convenient, but the latter is safer against future
breakage. I'm OK either way, but option (1) clearly needs a
documentation update.

> On Fri, Oct 5, 2012 at 3:57 PM, Jeff King <peff@peff.net> wrote:
> > We should probably also support explicit "-i -p" and "-o -p" option=
s, as
> > well (the former would give people who really want the existing beh=
avior
> > a way to get it). And the same for "--interactive". I can't say I'm
> > excited about making all that work, though. Like you, I think it is=
 more
> > sane to use existing tools to inspect and tweak the index to your
> > liking, and then commit.
>=20
> You made the same thinko as me :). --include isn't defined to mean "i=
nclude the
> index as well", but rather "include these files when committing the i=
ndex".
> Flipping that around makes a lot of sense and then --include can be u=
sed
> semantically with --patch, --interactive or even --all. (patch attach=
ed).

But of course we're not specifying paths. So to me it is "include the
changes I am about to stage via -p", as opposed to "--only use the
changes I am about to stage via -p". I think the current behavior is
morally equivalent to how --include works with paths (which includes th=
e
paths along with the current index, rather than only committing the
paths).

Or am I missing something about the distinction you're making? It seems
to me that the end behavior of thinking about it either way would be th=
e
same.

> --------8<------
>=20
> Flip the meaning of 'git commit --include' from 'include these files'=
 to
> 'include the index' to reduce the number of concepts in the manpage.
>=20
> Clarify that --interactive/--patch add to the existing index to avoid
> confusion like [1].
>=20
> [1] http://thread.gmane.org/gmane.comp.version-control.git/207108

The documentation updates look like an improvement to me. Do we also
need a note about "-p" under "-o" where it says "This is the default
mode..."?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index a17a5df..14afa58 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1034,10 +1034,12 @@ static int parse_and_validate_options(int
> argc, const char *argv[],
>         if (patch_interactive)
>                 interactive =3D 1;
>=20
> -       if (!!also + !!only + !!all + !!interactive > 1)
> -               die(_("Only one of
> --include/--only/--all/--interactive/--patch can be used."));
> -       if (argc =3D=3D 0 && (also || (only && !amend)))
> -               die(_("No paths with --include/--only does not make s=
ense."));
> +       if (only && all)
> +               die(_("--only with --all does not make sense."));
> +       if (only && interactive)
> +               die(_("--only with --interactive/--patch is not suppo=
rted."));

We used to complain if (argc =3D=3D 0 && also), but that seems to be lo=
st
here. Wouldn't the new condition be (argc =3D=3D 0 && also && !interact=
ive)?

We also stopped complaining about "also && all", "all && interactive",
and "also && only", all of which are nonsensical.

> +       if (argc =3D=3D 0 && (only && !amend))
> +               die(_("No paths with --only does not make sense."));
>         if (argc =3D=3D 0 && only && amend)
>                 only_include_assumed =3D _("Clever... amending the la=
st

It might be more readable to collapse these two conditionals to:

  if (argc =3D=3D 0 && only) {
  	if (!amend)
		die("...does not make sense");
	only_include_assumed =3D "Clever..."
  }

I wonder if it is even worth loosening this, though. The point, as I
understand it, would be to allow "-i -p". But it doesn't actually do
anything, does it (except, I suppose for allowing one to future-proof
their script against a later change of the default to --only).

-Peff
