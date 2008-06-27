From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: is rebase the same as merging every commit?
Date: Fri, 27 Jun 2008 08:30:56 +0200
Message-ID: <vpqfxqz5qzj.fsf@bauges.imag.fr>
References: <willow-jeske-01l78ZaEFEDjCZEG>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "David Jeske" <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 08:32:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC7VB-0000RD-P1
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 08:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbYF0GbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 02:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbYF0GbN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 02:31:13 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:65330 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbYF0GbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 02:31:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m5R6UuhB021603;
	Fri, 27 Jun 2008 08:30:57 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KC7U0-0007tG-FG; Fri, 27 Jun 2008 08:30:56 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KC7U0-0004bY-BG; Fri, 27 Jun 2008 08:30:56 +0200
In-Reply-To: <willow-jeske-01l78ZaEFEDjCZEG> (David Jeske's message of "Thu\, 26 Jun 2008 23\:04\:58 -0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 27 Jun 2008 08:30:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86523>

"David Jeske" <jeske@willowmail.com> writes:

> Rebasing is described in the docs I've read as turning this: (sorry f=
or the
> dots)
>
> ..........A---B---C topic
> ........./
> ....D---E---F---G master
>
> Into this:
>
> ...................A'--B'--C' topic
> ................../
> .....D---E---F---G master
>
> If I understand it right (and that's a BIG if), it's the same as doin=
g a merge
> of C into G where every individual commit in the C-line is individual=
ly
> committed into the new C' line.
>
> ...........-------------A---B---C
> ........../            /   /   /
> ........./        /---A'--B'--C'  topic
> ......../        /
> ....D---E---F---G - master

I'd draw that the other way:

  ...........---------A---B---C
  ........../          \   \   \
  ........./        /---A'--B'--C'  topic
  ......../        /
  ....D---E---F---G - master

> (1) Is the above model a valid explanation?

Sounds correct to me.

> (2) From the documentation diagrams, it looks like the rebased A' has=
 only (G)
> as a parent, not (A,G). If this is the case, why?

Well, one could imagine a "rebase keeping ancestry" command, which
would keep A and G (indeed, you can do that by hand with multiple
calls to "merge"). The advantage being that further merges involving
both A and A' have better chance to succeed.

But philosophy of "rebase" is different: the idea is that you usually
rebase your private branches before submission, and the guys you
submit to are interested in your changes (i.e. the patch serie
diff(G,A'), diff(A',B'), ...), not the way you got this patch serie.

So, discarding this ancestry information is a bit like discarding your
*~ files (or whatever backup files your editor might create) after
some time: it has been valuable information, but at some point, it
becomes noise you don't want to hear.

> (i.e. not connecting those nodes throws away useful information)

=46or the use-cases where this information is useful, "rebase" is not
for you. Indeed, in these cases, a plain "merge" is usually what you
want.

> (3) If it only has (G) as a parent, does the rebase explicitly remove=
 the
> source A,B,C nodes from the repository?

Most commands, and this includes rebase, are "add-only". The objects
will remain unreferenced and will be pruned by the next git gc
--prune. Unreferenced objects do not harm, they just eat your disk
space.

Well, that was a first approximation. Indeed, the reflog still
references C, see "git reflog". For example, after the rebase, if you
realize that you actually didn't want this rebase, you can still
"git=A0reset --hard HEAD@{1}" or something like that.

--=20
Matthieu
