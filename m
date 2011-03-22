From: =?ISO-8859-2?Q?Micha=B3_=A3owicki?= <mlowicki@gmail.com>
Subject: Re: gsoc - Better git log --follow support
Date: Wed, 23 Mar 2011 00:23:45 +0100
Message-ID: <AANLkTi=woLeveur6gKnSXTRzmS8nB0o4M9HegJ+GNUCa@mail.gmail.com>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
	<20110321122407.GH16334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 00:23:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2AvY-0008Az-Fv
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 00:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab1CVXXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 19:23:48 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64497 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783Ab1CVXXq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 19:23:46 -0400
Received: by iyb26 with SMTP id 26so7959441iyb.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pytTobNNC9Ic/lF5tfN/l50bokKCaxNra7WtwD8+vzI=;
        b=Fgl5aVdSNqiQcxA4RMM+jy8NpIQIL3D1jozvuwd06Xai+bBCjCVoxldJdGw3udhjQS
         x1GOE93G6gIgC2uzZyNTcYeorN9ZbsW2icS8KVQlhmd2jLa0kqS50jqJjnyfKHdP8Wda
         YfvIYRrIgnm4xgjuZSl5sWzh54yQqYUHGvhTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gPMLEphE0eo1PST7kVQw1tcaHD/ufRtQ6lE/aiuwEyvtrdnSFUxtnRQYfAshL+W+XV
         sWRCg85GElHHEYl5w9vP0y8m3CfwtJ4CDMNW2jB5e1QySmNwoyFsIb4jeDuVq46LhaAD
         GJxDedCibUMPESRhvopuDuqOsOV1dZSPlNX/c=
Received: by 10.42.115.73 with SMTP id j9mr9690730icq.117.1300836225998; Tue,
 22 Mar 2011 16:23:45 -0700 (PDT)
Received: by 10.42.227.136 with HTTP; Tue, 22 Mar 2011 16:23:45 -0700 (PDT)
In-Reply-To: <20110321122407.GH16334@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169786>

W dniu 21 marca 2011 13:24 u=BFytkownik Jeff King <peff@peff.net> napis=
a=B3:
> On Sat, Mar 19, 2011 at 08:24:20PM +0100, Micha=B3 =A3owicki wrote:
>
>> I'm looking at idea about better git log --follow support from
>> https://git.wiki.kernel.org/index.php/SoC2011Ideas .There is somethi=
ng
>> like this - "[.. ] it does not interact well with git's usual histor=
y
>> simplification [...]". Can someone elaborate this? I've found Histor=
y
>> Simplification in git rev-list man but don't know yet about issues
>> with --follow.
>
> In short, history simplification is a way of looking at a subset of t=
he
> commit history graph, but in a way that makes it look like a complete
> graph. Imagine I have a linear history like this:
>
> =A0A--B--C
>
> where "A" modifies "file1", "B" modifies "file2", and "C" modifies
> "file1" again. If I ask for the history of "file1" with "git log file=
1",
> then git will pretend as if the graph looks like:
>
> =A0A--C
>
> including rewriting the parent of "C" to point to "A" (because the
> parent pointer is basically an edge in the graph).
>
> If you are just doing a straight "git log", the actual parentage is n=
ot
> that interesting. We either show commits or we don't, and we don't sh=
ow
> links between them. But try "git log --graph" or "gitk", which do car=
e
> about the edges. They want to show you a whole connected graph.
>
> Now consider --follow. It doesn't happen during the commit limiting
> phase, but instead it happens while we're showing commits. And if it
> decides a commit isn't interesting, we don't show it. That works OK f=
or
> "git log", but it makes the graph for other things disjointed.
>
> You can see it in this example:
>
> =A0# make the A-B-C repo we mentioned above
> =A0git init repo && cd repo
> =A0echo content >file1 && git add file1 && git commit -m one
> =A0echo content >file2 && git add file2 && git commit -m two
> =A0echo content >>file1 && git add file1 && git commit -m three
>
> =A0# Now look at it in gitk; we see a nice linear graph.
> =A0gitk
>
> =A0# Now let's try it with path limiting. We see a nice subgraph that
> =A0# pretends to be linear, because we "squished" out the uninteresti=
ng
> =A0# nodes.
> =A0gitk file1
>
> =A0# Now let's make some more commits with a rename.
> =A0echo content >>file2 && git commit -a -m four
> =A0git mv file1 newfile && git commit -m five
> =A0echo content >>newfile && git commit -a -m six
>
> =A0# If we use path limiting, we'll only see the two most recent comm=
its.
> =A0# We get stopped at the rename because path limiting is just about=
 the
> =A0# pathname.
> =A0gitk newfile
>
> =A0# So we can use --follow to follow the rename. First let's try sim=
ple
> =A0# output. You should see commits 1, 3, 5, and 6, which touched eit=
her
> =A0# newfile or its rename source, file1.
> =A0git log --oneline --follow newfile
>
> =A0# But now look at it in gitk. Commit 4 is included as a boundary
> =A0# commit, but we fail to notice that it connects to three. And we
> =A0# don't see commit 3 connecting to anything, and commit 1 is missi=
ng
> =A0# entirely.
> =A0gitk --follow newfile

Why commit 4 is displayed here (changes only file2) ?

# git log with graph works here OK. It displays six -- five .. --
three .. - one .In this case results shouldn't be similar to gitk ?
git log --graph --follow newfile

>
> Obviously this a pretty simplistic example. But you can imagine in a
> history with a lot of branching how useful this simplification is to
> understanding what happened to a subset of the tree.
>
> Jakub mentioned another example with gitweb's subtree merge not being
> found by --follow. I haven't looked into that case, but it may be
> related (or it may simply be a defect in follow finding the right
> source).
>
> -Peff
>



--=20
Pozdrawiam,
Micha=B3 =A3owicki
