From: Jakub Narebski <jnareb@gmail.com>
Subject: git-blame and finding previous version of a line
Date: Sat, 21 Feb 2009 15:39:42 +0100
Message-ID: <200902211539.43312.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>, Luben Tuikov <ltuikov@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 15:48:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lat99-0000gg-6s
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 15:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbZBUOiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Feb 2009 09:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbZBUOiS
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 09:38:18 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:52914 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbZBUOiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 09:38:16 -0500
Received: by bwz5 with SMTP id 5so3499807bwz.13
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-disposition:cc:content-type
         :content-transfer-encoding:message-id;
        bh=SgcfrvssIwLxO18xnXjxYoha0bxofXlJ5BG7X+54h00=;
        b=MjV6igMeOOP4LkJm7sLFqkK2BNtg6H/SjRvBxFzwvWV5G6pWZhd7JZO+5YA5nCb7gY
         XHmjIXELbyS/iLhgmcmCyk2kzcsoSLYXCLJTRx7j4YwrA8Nel8DXhqgrJvuUWTG186GH
         y1e+L+D8xpM0hkOysVFUrs2UVDph02J91bVy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition:cc
         :content-type:content-transfer-encoding:message-id;
        b=dedsgpR6LxHEJhQeb8tXnrjKULzxJdtUss/m+e5nV6W5PI+QH/eY8yVl59YMGRYEzM
         F9R2SgtZfQlzp1JMEhDf31No3CrJKVKuDcIWOzKJwPfvEiaxMw2RZt0XI1cVNl8KFbGR
         rXkqbOoeOmvdIrA2F1eCABkG+C/8wkmZCbTGI=
Received: by 10.223.111.134 with SMTP id s6mr2513422fap.37.1235227094673;
        Sat, 21 Feb 2009 06:38:14 -0800 (PST)
Received: from ?192.168.1.13? (abwx73.neoplus.adsl.tpnet.pl [83.8.247.73])
        by mx.google.com with ESMTPS id e17sm6488519fke.28.2009.02.21.06.38.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Feb 2009 06:38:13 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110956>

Junio C Hamano <gitster@pobox.com> wrote
in "What's cooking in git.git (Feb 2009, #06; Wed, 18)"

> * jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
> =A0+ blame: show "previous" information in --porcelain/--incremental
> =A0 =A0format
> =A0+ git-blame: refactor code to emit "porcelain format" output
>
> This gives Porcelains (like gitweb) the information on the commit
> _before_ the one that the final blame is laid on, which should save
> them one rev-parse to dig further. =A0The line number in the "previou=
s"
> information may need refining, and sanity checking code for reference
> counting may need to be resurrected before this can move forward.
>
> I thought recent tig discussion may blow new life into it, but is
> this unneeded? =A0If so I'd rather revert it (or discard after 1.6.2)=
=2E

The commit message for second patch in this series has the following:

   blame: show "previous" information in --porcelain/--incremental form=
at
   =20
   When the final blame is laid for a line to a <commit, path> pair, it=
 also
   gives a "previous" information to --porcelain and --incremental outp=
ut
   format.  It gives the parent commit of the blamed commit, _and_ a pa=
th in
   that parent commit that corresponds to the blamed path --- in short,=
 it is
   the origin that would have been blamed (or passed blame through) for=
 the
   line _if_ the blamed commit did not change that line.

(The patch itself doesn't include update to the documentation.)  This
I guess mean that --porcelain and --incremental output have additional
header:

   "previous" <sha-1 of parent> <whitespace-quoted-filename>

I also guess that it is a merge commit that got blamed (because it was
evil merge, otherwise one of parents or its descendants would get the
blame) we would get two or more "previous" info lines, in the order of
ordering of parents.


I assume that filename in "previous" info can differ from filename in
blamed commit only wrt. wholesame filename detection, and does not do
detection of code fragment movements by itself... or does it?

This info would be even more helpful for gitweb that I thought because
of 'filename' part; we can simply relax refname restrictions and use
<blamed commit>^ or <blamed commit>^<n> for 'hb' parameter, but filenam=
e
gives some troubles (although it should happen rarely). Well, in one of
solutions I thought of there was intermediate step where gitweb resolve=
d
<ref>^ to <sha1>, and did HTTP redirection; in this solution there is
a place where gitweb can find previous filename (filename in <rev>^,
given filename in <rev>), but it would be a mess.


Luben Tuikov in 244a70e6 (Blame "linenr" link jumps to previous state
at "orig_lineno") made gitweb link to previous version of a file (using
always first parent), for better data mining, or in other words to be
able to follow history of a given line.  Current code makes a few
assumptions:
 * we are always interested in first parent; this matters only for
   'evil merges', it the merge commit itself was blamed, which should
   be fairly rare case
 * the name of a file is the same in parent as in blamed commit; we
   would have to run git-diff-tree to check it without proposed
   "previous" header in blame output, all for rare case of file rename,
   or complicate a bit resolving filename after clicking link
 * previous version of given line is at the same position in a file
   in a parent; or at least it is close

It is the last assumption that is, I think, hardest to correct.

What algorithm do you propose to find previous version of a line? It is
not a question with definitive answer, I think, so some heuristic would
be required. Previous version of a line might not even exists! (in that
case we would probably want to be in the place it is inserted).=20
=46ortunately this is a situation where approximation is good enough.


(I don't know if git-blame has access to textual diff, or at least
information in chunk headers when calculating blame information, so
I don't know if the following algorithm is feasible.)

I propose the following algorithm:
 * find a hunk in textual diff which postimage contains current
   version of a line: searching hunk headers for line number should
   be enough here
 * get line numbers for corresponding preimage (I'm not sure if this
   algorithm wouldn't fail here if code movement detection is enabled)
 * either find most similar line in preimage, or calculate (perhaps
   with linear interpolation) where given line number in postimage
   line range corresponds to in preimage line range

What do you think about this algorithm? Is it good enough?


P.S. I think that going to the blamed commit version might be also
     interesting: you can check how the neighbourhood if given line
     changed, isn't it?
--=20
Jakub Narebski
Poland
