From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Tue, 17 Jun 2008 14:31:38 +0200
Message-ID: <20080617123138.GA6932@diana.vm.bytemark.co.uk>
References: <20080612052913.23549.69687.stgit@yoghurt> <20080612053424.23549.64457.stgit@yoghurt> <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 14:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8aN9-0004LF-Mq
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 14:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbYFQMcT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2008 08:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756041AbYFQMcT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 08:32:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2306 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbYFQMcS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 08:32:18 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K8aLa-0002YU-00; Tue, 17 Jun 2008 13:31:38 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85295>

On 2008-06-17 11:24:53 +0100, Catalin Marinas wrote:

> There are some comments below but I think I haven't fully understood
> this.

I've done my best to answer. Though no doubt you'll have follow-up
questions.

> 2008/6/12 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Create a log branch (called <branchname>.stgit) for each StGit
> > branch, and write to it whenever the stack is modified.
> >
> > Commands using the new infrastructure write to the log when they
> > commit a transaction. Commands using the old infrastructure get a
> > log entry write written for them when they exit, unless they
> > explicitly ask for this not to happen.
>
> I was more thinking for this to be the default for backwards API
> compatibility.
>
> >  class _Directory(object):
> > -    def __init__(self, needs_current_series =3D True):
> > +    def __init__(self, needs_current_series =3D True, log =3D True=
):
>
> i.e. we make log =3D False here by default.

I might not have understood precisely what you meant; but I don't
think API backwards compatibilty should be an issue here? I simply fix
all callers. If log should default to true or false is immaterial --
it just means some extra text in one or the other of two equally
common cases.

> > --- /dev/null
> > +++ b/stgit/lib/log.py
> > @@ -0,0 +1,254 @@
> > +r"""This module contains functions and classes for manipulating
>
> Why does this start with an 'r'? I thought this is for regular
> expressions.

"r" in front of a string literal means "raw" (or some such). Escape
sequences aren't recognized inside a raw string -- e.g., r'\n' =3D=3D
'\\n'. They are useful when you have to write strings with embedded
backslashes, such as regexes -- or this string, which has \n in it.

> > +A stack log is a git branch. Each commit contains the complete sta=
te
> > +of the stack at the moment it was written; the most recent commit =
has
> > +the most recent state.
> > +
> > +For a branch C{I{foo}}, the stack log is stored in C{I{foo}.stgit}=
=2E
>
> The main question. Is this history preserved after a git-gc?

Yes. It's stored in a regular git branch. (The design is such that it
should even be possible to pull a stack log from another repository
and _still_ get everything you need.)

This should probably be in the description text.

> > +  - C{patches}: a tree containing one subtree for each patch, name=
d
> > +    after that patch. Each such subtree contains:
> > +
> > +      - C{a}, C{b}: the patch's I{bottom} and I{top} trees.
> > +
> > +      - C{info}: a blob containing::
> > +
> > +          Author: <author name and e-mail>
> > +          Date: <patch timestamp>
> > +
> > +          <commit message>
>
> I might not fully understand this but can we not store just the
> commit object if the patch, which would have the bottom/top
> information.

You can't store a commit object in a tree. (Well, with submodules you
can, but said commit object isn't protected from gc and won't be
included when pulling.) The idea with this format is that with the two
trees and the info file, you can recreate the patch's commit -- not
exactly, but close enough as makes no difference.

> > +Simplified log
> > +--------------
> > +
> > +The simplified log looks exactly like the normal, or I{full}, log,
> > +except for the following:
> > +
> > +  - Instead of having a tree per patch in the C{patches} subtree, =
it
> > +    has a blob per patch. This blob contains::
> > +
> > +      Bottom: <sha1 of patch's bottom tree>
> > +      Top:    <sha1 of patch's top tree>
> > +      Author: <author name and e-mail>
> > +      Date:   <patch timestamp>
>
> Can we not point to the original commit corresponding to the patch?
> It already has this information.
>
> > +
> > +      <commit message>
> > +
> > +      ---
> > +
> > +      <patch's diff>
>
> What is the patch's diff here? Cannot it be determined from the
> trees?
>
> > +The simplified log contains no information not in the full log; it=
s
> > +purpose is ease of visualization."""
>
> Ah, OK. But I think it would be more useful to see the diff between
> subsequent revisions of a stack rather than the full patch diff.

Have you tried looking at a patch stack log (in gitk, say)? That is,
"stg log -g" in this patch series. It shows you diffs between
subsequent revisions of the simplified log. I'm sure it's far from
perfect, but I think it's actually quite useful.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
