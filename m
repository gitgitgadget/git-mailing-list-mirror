From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Tue, 14 Feb 2012 19:23:40 +0100
Message-ID: <20120214192340.2d473866@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<201202131944.50886.jnareb@gmail.com>
	<20120213220917.4cf14eb1@gmail.com>
	<201202141831.59699.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 19:23:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxN2g-0002SV-Rh
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 19:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759339Ab2BNSXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 13:23:49 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51868 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756826Ab2BNSXs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 13:23:48 -0500
Received: by eekc14 with SMTP id c14so96034eek.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=V+X5LgZLGnqLwatso/3wf1knq4o3KN9TDhzNkRlZZIo=;
        b=w5MVCbFpLWRgOegONZGWzkHRdVYuEOR49RGZVysIicyyVZlveDdWrBk2HyQuAKKJdf
         QtgOgbfkdrt5ErWH0sRB+bYcumTy07ok5Jzonmgb+NXRFBQ1oyVHUhtwB1e0SQbqLQUp
         a0D9105oMIIY7nBDl4mekWSnz1s+8ZAKra4uA=
Received: by 10.213.29.83 with SMTP id p19mr3697177ebc.107.1329243826764;
        Tue, 14 Feb 2012 10:23:46 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n56sm1095829eeh.6.2012.02.14.10.23.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 10:23:46 -0800 (PST)
In-Reply-To: <201202141831.59699.jnareb@gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190729>

Jakub Narebski <jnareb@gmail.com> wrote:

> A few issues I have just noticed about this series.
>=20
>=20
> First, about naming.  "Highlighting interesting parts of diff" is
> acceptable name, but "syntax highlighting for diff" is not: gitweb
> already use syntax highlighting in diff views.  Call it "diff refinem=
ent
> highlighting", "highlighting changes / changed sections", "intraline
> highlighting".

OK, I'll make sure the naming is correct and consistent.
>=20
>=20
> Second, I think (but I am not sure) that there is a bug in code that
> finds common suffix and prefix.
>=20
> If I understand correctly the idea is to highlight changed part if
> there is at least one of common non-whitespace suffix or prefix.
> So syntax highlighting should look like this:
>=20
> 1. Both prefix and suffix are non empty and non whitespace only
>=20
>   -foo -{bar} baz
>   +foo +{quux} baz
>=20
> 2. Non empty and non whitespace only prefix
>=20
>   -foo -{bar}
>   +foo +{quux}
>=20
> 2. Non empty and non whitespace only suffix
>=20
>   --{bar} baz
>   ++{quux} baz
>=20
> But in your code $prefix is not the length of common prefix, but
> the position of end of prefix in the original line of diff.  So
> you start with $prefix =3D 1... even though the prefix is empty.
>=20
> How is that supposed to work?

But see the check:

+	# Mark lines that are different from each other, but have some common
+	# part that isn't whitespace.  If lines are completely different, don=
't
+	# mark them because that would make output unreadable, especially if
+	# diff consists of multiple lines.
+	if (($prefix =3D=3D 1 && $suffix_rem =3D=3D $#r && $suffix_add =3D=3D=
 $#a)
                        ^
                        |
                        This part.

+		|| ($prefix_is_space && $suffix_is_space)) {
+		$esc_rem =3D esc_html($rem);
+		$esc_add =3D esc_html($add);
+	} else {
+		$esc_rem =3D esc_html_mark_range(\@r, $prefix, $suffix_rem);
+		$esc_add =3D esc_html_mark_range(\@a, $prefix, $suffix_add);
+	}

I guess it's still not correct because it should be equal to number of
parents or $prefix_length should start from 0 like you wrote later.

>=20
>=20
> On Mon, 13 Feb 2012, Micha=C5=82 Kiedrowicz wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> > > On Mon, 13 Feb 2012, Michal Kiedrowicz wrote:
>=20
> > > > I haven't found *examples* on GitHub and Trac sites, but what a=
bout
> > > > these ones:
> > > >=20
> > > > https://github.com/gitster/git/commit/8cad4744ee37ebec1d9491a13=
81ec1771a1ba795
> > > > http://trac.edgewall.org/changeset/10973
> [...]
> > > BTW GitHub is closed source, but we can check what algorithm does=
 Trac
> > > use for diff refinement highlighting (highlighting changed portio=
ns of
> > > diff).
> > >=20
> >=20
> > I think it's
> > http://trac.edgewall.org/browser/trunk/trac/versioncontrol/diff.py
> > (see markup intraline_changes()).
> =20
> It is get_change_extent() that finds extent of changes, as a pair
> containing the offset at which the changes start, and the negative of=
fset
> at which the changes end.  So it is the same solution you use, only
> without ignoring whitespace-only prefixes and suffixes...  This code =
can
> be easily ported to Perl, BTW.
>=20
> The markup_intraline_changes() function compares lines from preimage =
and
> from postimage pairwise, requiring that number of lines matches, the =
same
> like in your algorithm.
>=20

So using Jeff's diff-highlight we remain quite consistent with Trac
output. There's nothing we can "steal" from it.=20

> > > > I would also consider ignoring prefixes/suffixes with punctuati=
on, like:
> > > >=20
> > > > 	- * I like you.
> > > > 	+ * Alice had a little lamb.
> > >=20
> > > But this patch doesn't implement this feature yet, isn't it?
> >=20
> > No, but is a matter of adding
> >=20
> > 	-$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s/);
> > 	+$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s|[[:punct:]]/);
> >=20
> > (and the same for suffix)
>=20
> All right.  But it is better added as separate patch.

Sure=20

> Perhaps even
> requiring that not only there is at least one of common prefix or com=
mon
> suffix, but at least one of them is not whitespace only could be put
> in a separate commit...
>=20
> > > > > > +sub format_rem_add_line {
> > > > > > +	my ($rem, $add) =3D @_;
> > > > > > +	my @r =3D split(//, $rem);
> > > > > > +	my @a =3D split(//, $add);
> > >=20
> > > BTW the name of variable can be just @add and @rem.
> > >
> >=20
> > I know they are different scopes but I don't like it. It makes the =
code
> > more confusing IMO. But I won't insist.
>=20
> In my opinion if the variable refers to the same entity in different
> forms, using @foo and %foo (used in gitweb), or $foo and @foo (could =
be
> used here) is all right, and even better than trying to come up with
> different name for the same thing because of sigil.

OK. I'll follow that convention then.

> =20
> > > > > Shouldn't
> > > > > $prefix / $prefix_len start from 0, not from 1?
> > > >=20
> > > > It starts from 1 because it skips first +/-. It should become o=
bvious
> > > > after reading the comment from last patch :).
>=20
> This means that $prefix is true even if prefix is empty ($prefix =3D=3D=
 1).
> Wouldn't it be better for $prefix_len to count length of true prefix,
> without diff adornment?  Or make @r / @rem skip initial characters...
>=20
> > > > +	# In combined diff we must ignore two +/- characters.
> > > > +	$prefix =3D 2 if ($is_combined);
> > >=20
> > > Anyway comment about that fact would be nice.
> >=20
> > Will do.
>=20
> BTW. it is not "2" but "scalar @{$co{'parents'}}".
>=20

OK.

>=20
> > > > The splitting and comparing by characters is taken from diff-hi=
ghlight.
> > > > I don't think it's worth changing here.
> > >=20
> > > You are right.
> > >=20
> > > I'll try to come with hacky algorithm using string bitwise xor an=
d regexp,
> > > and benchmark it comparing to your C-like solution, but it can be=
 left for
> > > later (simple is better than clever, usually).
> >=20
> > If you have time :).
>=20
> Anyway it would be separate commit.  Better to just copy tested code
> from contrib/diff-highlight
>=20
> BTW. would "git blame -C -C -C -w" detect this correctly as code
> movement^W copying?
> =20

Cannot say. Have you considered what I wrote in a separate e-mail,
about using diff-highlight output directly / as a library?=20
