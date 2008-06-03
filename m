From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 22:24:07 +0200
Message-ID: <200806032224.08714.jnareb@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <200806031445.23002.jnareb@gmail.com> <48455433.8080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Lea Wiemann <lewiemann@gmail.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:25:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3d48-0008Lw-Ov
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbYFCUYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 16:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbYFCUYP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:24:15 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:30438 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbYFCUYN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:24:13 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1671558mue.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=FSIabx003p5sA8cbuq5N+5U3SCh5rwYgxNnEaIRWJj8=;
        b=MnPnqmwwWEcMr6v28MlTyu2JnV9dDPu7JXvJCxlbbUM0Ynzfvl7BBHesj9iRKJS5M2Up6JNbCOj33ZAOCIHlHThTKusNAwBiAq2nq/aMKd8GUqK+xWLBI9Prv1eYjbm3Ay6TU6l2Y47f3ZQy0lGTUcRCsIMDnAgfR7E57q4GpMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=dNe4s12minvjwFjhBp7k31SwQvBhPvVJtdGCfwmB9jmXpCLZW+wX4++WkFb8Asp+bcwWn4lRo0g4Gdb9svKn6RwI5nzmS/CqBE5k4MaoGDA12DCQxRKFYzeMVYM0hNE3heSNFykR1bU8PMaX95xTWlP8nTwyDWMTtF5tufF4+8s=
Received: by 10.103.119.19 with SMTP id w19mr3681555mum.129.1212524652020;
        Tue, 03 Jun 2008 13:24:12 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id y37sm801408mug.9.2008.06.03.13.24.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 13:24:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48455433.8080500@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83700>

I have joined there two separate threads... probably attaching them
in a wrong place.

On Tue, 3 June 2008, Lea Wiemann wrote:
> Rafael Garcia-Suarez wrote:
> >
> > Finally, to avoid forking git-rev-parse too many times, cache its
> > results in a new hash %parent_commits.
>
> I'm not too happy with this:
>
> 1) Minor point: I'm working on caching for the backend right now
> (IOW, basically what you're doing, just centralized in a separate
> module), so you're essentially duplicating work, and you're making it
> (a little) harder for me to refactor gitweb since I have to rip out
> your cache code.

I don't think %parent_commits hash is suitable for caching; it is only
intermediate step, reducing number of git command calls (and forks)
from number of blocks of changes in a blame, to number of distinct=20
commits blamed.  From this you would put info into appropriate Perl=20
structure.


ATTENTION! This example shows where caching [parsed] data have problems=
=20
compared to front-end caching (caching output).  Caching data is=20
(usually) the best solution for pages which are generated from some=20
parsed data _as a whole_, or can be generated from parsed data as a=20
whole, i.e. heads, tags, summary, projects list, shortlog, history,=20
view etc.

Problems occur when we try to cache page with _streaming_ output, such=20
as blob view, blame view, diff part of commitdiff etc.  Here better=20
solution might be either front-end cache (caching HTML output), or=20
back-end caching (caching output of git commands).

> Those few lines won't hurt, but in general I suggest that nobody
> make any larger efforts to cache stuff in gitweb for the next few
> weeks.=20

Understandable, we want to avoid conflicts.

By the way, if we agree that version %parent_commits is too intrusive=20
dusring GSoC 2008, I think it would be good to accept into maint the=20
patch with --revs-only, which fixes real bug, even if it is annoyance=20
level only...

> 2) Major point: You're still forking a lot. =C2=A0The Right Thing is =
to
> condense everything into a single call -- I believe "git-rev-list
> --parents --no-walk hash hash hash..." is correct and easily
> parsable. Its output seems to be lines of
> =C2=A0 =C2=A0 =C2=A0hash parent_1 parent_2 ... parent_n
> with n >=3D 0. =C2=A0Can you implement that? =C2=A0It would be very u=
seful and
> also reusable for me!

This is not a good solution for 'blame' view, which is generated "on th=
e=20
fly", by streaming git-blame output via filter.  Above solution goes=20
counter to code flow flow: gitweb would have to somehow get list of all=
=20
blamed commits.  (See also note above about caching "stream-generated"=20
pages).

Modifying git-blame --porcelain (and --incremental) output has the=20
advantage of simple code on gitweb side, retaining "streamed" page=20
generation.  It would be one fork less, but I guess that is negligible.=
  =20
It would be useful for other blame viewers such as "git gui blame" to=20
do similar data mining fast.  Other consumers of git-blame output=20
should be (if written correctly) not affected by additional header=20
which they don't understand.=20

The disadvantage would be for gitweb to require version of git binary=20
which has this feature...


Of course implementing get_parents($hash[, $hash...]) in either gitweb,=
=20
or Git.pm, using "git-rev-list --parents --no-walk <args>" could still=20
be useful.


----------------------------------------------------------------------
On Tue, 3 June 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
> > I was thinking about extending git-blame porcelain format (and also
> > incremental format, of course) by 'parents' (and perhaps
> > 'original-parents') header...
>=20
> Regarding prettiness, I don't find parents in the porcelain output=20
> particularly useful, but if other people think they need this, I won'=
t=20
> object. :)

The change in gitweb was introduced by commit 244a70e (Blame "linenr"=20
link jumps to previous state at "orig_lineno"), by Luben Tuikov; please=
=20
read commit message for explanation how it could be used for data=20
mining / browsing annotated history of a file.

As I wrote above, this solution allows to have very simple, streaming=20
code in gitweb dealing with "line before change" links.

The porcelain (and incremental) format of git-blame was created in such=
=20
way to allow easy extending it; true and rewritten parents would help=20
in navigating annotated file view in history.

It should not, I think, affect your efforts; it is not you that propose=
d=20
to write such extension.

> Regarding performance, it would be good to show that the solution I'm=
=20
> suggesting in my separate is slower than extending git-blame before=20
> implementing anything.  (I doubt it matters performance-wise.)

It is one fork more.  And as I wrote above, you need list of all blamed=
=20
commits upfront, which goes counter to currently used "streaming=20
output" code flow; it would complicate code, and thus reduce=20
performance.

--=20
Jakub Narebski
Poland
