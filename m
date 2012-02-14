From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Tue, 14 Feb 2012 18:31:58 +0100
Message-ID: <201202141831.59699.jnareb@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com> <201202131944.50886.jnareb@gmail.com> <20120213220917.4cf14eb1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 18:32:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxMEd-0001TU-Hw
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 18:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419Ab2BNRcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 12:32:07 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50239 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab2BNRcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 12:32:03 -0500
Received: by eekc14 with SMTP id c14so79162eek.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 09:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=XH7TUDJ8ioa9C3IAu2y8Cdpob4PXMJz/uap/G7xdyf0=;
        b=R2FDFG1ZIngm82UCxHPqg7QtGnIZfg+QyItInWmLJXjdMlRFpVx/RyhbUrKnyk9D0r
         9Qor/TVUWvIsHdQDAPxdSMRV43bCvzIrJnGvG2Z/leNGMQ37y7DzyVkoTBTeMgQ1OZIF
         GUbzPhFPdBrigA9w0oklDI3Cc6EmQe+wybNw4=
Received: by 10.213.104.140 with SMTP id p12mr1071939ebo.111.1329240722391;
        Tue, 14 Feb 2012 09:32:02 -0800 (PST)
Received: from [192.168.1.13] (abwo148.neoplus.adsl.tpnet.pl. [83.8.238.148])
        by mx.google.com with ESMTPS id o49sm509976eei.0.2012.02.14.09.32.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 09:32:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120213220917.4cf14eb1@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190727>

A few issues I have just noticed about this series.


=46irst, about naming.  "Highlighting interesting parts of diff" is
acceptable name, but "syntax highlighting for diff" is not: gitweb
already use syntax highlighting in diff views.  Call it "diff refinemen=
t
highlighting", "highlighting changes / changed sections", "intraline
highlighting".


Second, I think (but I am not sure) that there is a bug in code that
finds common suffix and prefix.

If I understand correctly the idea is to highlight changed part if
there is at least one of common non-whitespace suffix or prefix.
So syntax highlighting should look like this:

1. Both prefix and suffix are non empty and non whitespace only

  -foo -{bar} baz
  +foo +{quux} baz

2. Non empty and non whitespace only prefix

  -foo -{bar}
  +foo +{quux}

2. Non empty and non whitespace only suffix

  --{bar} baz
  ++{quux} baz

But in your code $prefix is not the length of common prefix, but
the position of end of prefix in the original line of diff.  So
you start with $prefix =3D 1... even though the prefix is empty.

How is that supposed to work?


On Mon, 13 Feb 2012, Micha=C5=82 Kiedrowicz wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > On Mon, 13 Feb 2012, Michal Kiedrowicz wrote:

> > > I haven't found *examples* on GitHub and Trac sites, but what abo=
ut
> > > these ones:
> > >=20
> > > https://github.com/gitster/git/commit/8cad4744ee37ebec1d9491a1381=
ec1771a1ba795
> > > http://trac.edgewall.org/changeset/10973
[...]
> > BTW GitHub is closed source, but we can check what algorithm does T=
rac
> > use for diff refinement highlighting (highlighting changed portions=
 of
> > diff).
> >=20
>=20
> I think it's
> http://trac.edgewall.org/browser/trunk/trac/versioncontrol/diff.py
> (see markup intraline_changes()).
=20
It is get_change_extent() that finds extent of changes, as a pair
containing the offset at which the changes start, and the negative offs=
et
at which the changes end.  So it is the same solution you use, only
without ignoring whitespace-only prefixes and suffixes...  This code ca=
n
be easily ported to Perl, BTW.

The markup_intraline_changes() function compares lines from preimage an=
d
from postimage pairwise, requiring that number of lines matches, the sa=
me
like in your algorithm.

[...]
> > I wonder if we can use --diff-words for diff refinement highlightin=
g,
> > i.e. LCS on words.
>=20
> I think we can try it, but I worry about performance of running `git
> diff` on every diff chunk.

I was thinking about one single additional run of git-diff-tree with
`--diff-words`, not one per chunk.

Or perhaps even put it together in one git-diff-tree invocation, just l=
ike
'commitdiff' action / git_commitdiff() subroutine uses single git-diff-=
tree
invocation, with the option "--patch-with-raw", to generate both raw di=
ff
for difftree and patchset.
=20
> > Anyway Jeff's approach is a bit limited, in that it would work only=
 for
> > change that does not involve adding newlines, for example splitting
> > overly long line when changing something.
> >=20
> > See for example line 1786 (in pre-image) in http://trac.edgewall.or=
g/changeset/10973
>=20
> Yes, I'm aware of that. I was thinking about improving it later ("Let=
's
> start with a simple refinment highlightning and maybe later add more
> sophisticated algorithms").

Right.
=20
[...]
> > BTW. is it "at least one of prefix or suffix are non-empty" or "bot=
h prefix
> > and suffix are non-empty"?
> >=20
>=20
> At least one. See:
>=20
> 	-a =3D 42;
> 	+b =3D 42;
>=20
> Here prefix is empty but suffix is not.

Nb. prefix is empty but $prefix =3D=3D 1, and is boolean true.

> > > I would also consider ignoring prefixes/suffixes with punctuation=
, like:
> > >=20
> > > 	- * I like you.
> > > 	+ * Alice had a little lamb.
> >=20
> > But this patch doesn't implement this feature yet, isn't it?
>=20
> No, but is a matter of adding
>=20
> 	-$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s/);
> 	+$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s|[[:punct:]]/);
>=20
> (and the same for suffix)

All right.  But it is better added as separate patch.  Perhaps even
requiring that not only there is at least one of common prefix or commo=
n
suffix, but at least one of them is not whitespace only could be put
in a separate commit...

> > > > > +sub format_rem_add_line {
> > > > > +	my ($rem, $add) =3D @_;
> > > > > +	my @r =3D split(//, $rem);
> > > > > +	my @a =3D split(//, $add);
> >=20
> > BTW the name of variable can be just @add and @rem.
> >
>=20
> I know they are different scopes but I don't like it. It makes the co=
de
> more confusing IMO. But I won't insist.

In my opinion if the variable refers to the same entity in different
forms, using @foo and %foo (used in gitweb), or $foo and @foo (could be
used here) is all right, and even better than trying to come up with
different name for the same thing because of sigil.
=20
> > > > Shouldn't
> > > > $prefix / $prefix_len start from 0, not from 1?
> > >=20
> > > It starts from 1 because it skips first +/-. It should become obv=
ious
> > > after reading the comment from last patch :).

This means that $prefix is true even if prefix is empty ($prefix =3D=3D=
 1).
Wouldn't it be better for $prefix_len to count length of true prefix,
without diff adornment?  Or make @r / @rem skip initial characters...

> > > +	# In combined diff we must ignore two +/- characters.
> > > +	$prefix =3D 2 if ($is_combined);
> >=20
> > Anyway comment about that fact would be nice.
>=20
> Will do.

BTW. it is not "2" but "scalar @{$co{'parents'}}".


> > > The splitting and comparing by characters is taken from diff-high=
light.
> > > I don't think it's worth changing here.
> >=20
> > You are right.
> >=20
> > I'll try to come with hacky algorithm using string bitwise xor and =
regexp,
> > and benchmark it comparing to your C-like solution, but it can be l=
eft for
> > later (simple is better than clever, usually).
>=20
> If you have time :).

Anyway it would be separate commit.  Better to just copy tested code
from contrib/diff-highlight

BTW. would "git blame -C -C -C -w" detect this correctly as code
movement^W copying?
=20
--=20
Jakub Narebski
Poland
