From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 03:23:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901250305450.14855@racer>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <7vpricmoda.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901242156320.14855@racer> <7vzlhgl35z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>,
	spearce@spearce.org, Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 03:24:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQug1-00066A-EZ
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 03:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbZAYCXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 21:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbZAYCXV
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 21:23:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:58554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754788AbZAYCXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 21:23:20 -0500
Received: (qmail invoked by alias); 25 Jan 2009 02:23:18 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp014) with SMTP; 25 Jan 2009 03:23:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/muXNzbVDmqQ9DvFXqHMDHLf8Fj/vdh6LYATUlO1
	NWofJR3suPBRW8
X-X-Sender: gene099@racer
In-Reply-To: <7vzlhgl35z.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107036>

Hi,

On Sat, 24 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> - What's with the apostrophe?  I seem to remember that you argued it 
> >>   would be enough to make "A" stand for the original when it is used 
> >>   for the first time and the second and later use can stand for the 
> >>   result of the last use (e.g. the "goto A'" above can be simply 
> >>   spelled as "goto A"), when I suggested to use "mark" in a way 
> >>   similar to how fast-import language uses it during the sequencer 
> >>   discussion?
> >> 
> >>   I am not complaining; I am just being curious why the sudden change 
> >>   of heart.
> >
> > Very easy explanation.  I got convinced by your arguments.  Even if I 
> > could imagine that I never use the thing without apostrophe, it is 
> > good to have an obvious indicator that this is not necessarily the 
> > original commit.
> 
> Now that does not make much sense to me.
> 
> The reason I suggested that 'mark' would give a cleaner semantics was 
> because in your earlier design "A" could either stand for the original 
> or it could stand for the result of an operation that used "A", and 
> there could be more than one operation that uses "A".  Explicitly naming 
> each result with a mark would give us an unambiguous way to distinguish 
> them.

But that is not what rebase -i is about!  Either you rewrite a commit, or 
you don't.  You don't rewrite it multiple times _and_ reference all of the 
intermediate steps!

Should you suggest that this is a sane worflow, you would really ask for 
trouble.

As it is, "mark" is useless.  It would give one and the same thing two 
names, one short SHA-1, and one numeric value, and the relationship 
between the two -- even if they mean the same! -- would be completely 
arbitrary.

> I however do not think you would ever use A twice in the context of 
> "rebase -i/-p".

Exactly!

> Cherry-picking the same commit twice to create two copies of them will 
> not happen in that context.

Not exactly true, as you could split a patch by

	edit abcdefg Patch to be split
	edit abcdefg Patch to be split

And removing half of the patch in the first edit (e.g. by "git reset 
HEAD^ && git add -e" or something similar).

> While trying to recreate something like this on top of a commit "o", you
> would have to talk about "A" multiple times,...
> 
>           B---M
>          /   / \
>  ---o---A---C   \
>      \   \       \
>       D---N-------O
> 
> ... but even in such a picture, after one "pick A", you would always want
> to refer to the result of the pick, and never the original A.
> 
>     pick A
>     goto A'^

... or goto $ONTO...

>     pick D
>     merge A' was N
>     goto A'
>     pick B
>     goto A'
>     pick C
>     merge B' was M
>     merge N' was O
> 
> So I am inclined to think that "first use refers to the original, second
> and thereafter will refer to the result of the first use" would be a good
> enough semantics for "rebase -i/-p", and you do not need "A" vs "A'" for
> this.
> 
> By the way, I think this example shows that your "goto" might need a way
> to refer to the "onto" commit in some way (I just used "A'^" there).

It will use $ONTO.

> On the other hand, if you are aiming to allow users to create (by editing
> the insn file) an arbitrarily different structure like this, starting from
> the same topology:
> 
>   ---o---B---C---A
>       \           \
>        A---D-------O
> 
> that is, rebasing the upper line of development into one linear sequence
> with different patch order, while rebasing the lower line into another
> linear sequence by rebasing D on top of A, you would need to be able to
> refer to the two different results of "using A", and your "A'" notation
> would not help.
> 
>     pick B
>     pick C
>     pick A
>     goto B'^
>     pick A
>     pick D
>     merge A' was O
> 
> The last "merge A' was O" is done while on the result of applying D on top
> of the result of applying A on the lower line, and wants to call the tip
> of the upper line by referring it as "the result of applying A". 
> 
> But there are two results from applying A, and I do not think you can
> avoid 'mark', even though you for some reason seem to hate it.

You can, by doing the sane thing and first apply one strand of the two 
branches, then going back and applying the other strand.  You would not 
even once need "goto A'".

> If this kind of transformation is outside the scope of your redesign 
> (which I think is a sensible design decision), I do not see why you 
> would need "A vs A'".
> 
> You either need the full power of 'mark', or "A is original until it is 
> used, and then the one and only one result once it is used,"; nothing in 
> between like "A vs A'" would make much sense.

Your example seems a little bit constructed to the purpose of showing the 
shortcomings of the A' notation.

But it has a shortcoming in and of its own: if you want to apply A for 
both branches, it would make a metric ton more sense to apply A before 
branching:

   ---o---A---B---C
           \       \
            D-------O

Besides, if you would concoct a real obscure situation where you really 
needed to apply one and the same patch twice, _and_ refer to both "A'" 
(something like

   ---o---B---A---C----H
       \       \ /    /
        \       E    /
         \          /
           D---A---F
                \ /
                 G

Then you could still do the part B...C first (with the first version of 
A'), then D...F (with the second version of A') and be done with it.  
Unless you would want anything like


 C---A---B
        /
    ---A

which is ugly beyond belief IMO, but in which case you could _still_ do it 
with an "edit C; merge A' was B" where you just git cherry-pick A.

So it is possible, even if it needs trickery, which is okay IMHO as this 
is not the common case.  And I want to optimize for the common case.

Ciao,
Dscho
