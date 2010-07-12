From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: skipping commits via commit-msg contents
Date: Mon, 12 Jul 2010 14:02:03 -0500
Message-ID: <20100712190203.GA9365@dert.cs.uchicago.edu>
References: <AANLkTikYcODU96J-cVYCIad1yrd5zGklVj2OV4UT2PxC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 21:02:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYOGa-0002U2-TU
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 21:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab0GLTCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 15:02:07 -0400
Received: from camembert.cs.uchicago.edu ([128.135.11.243]:59107 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab0GLTCG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 15:02:06 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 588CFA132;
	Mon, 12 Jul 2010 14:02:04 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 2189C4E5A; Mon, 12 Jul 2010 14:02:04 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikYcODU96J-cVYCIad1yrd5zGklVj2OV4UT2PxC@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150843>

Hi Jim,

Jim Cromie wrote:

> if git bisect were to recognize  --skip-bisect  in the subject line
> (or in commit-message somewhere, say top or bottom),
> then bisection could proceed silently past such commits.

In addition to Ram=E2=80=99s suggestion, you might want to look into
=E2=80=98git replace=E2=80=99[1].  It can be useful when the broken com=
mits
have already been published.  It works like this:

 git replace <bad commit> <bad commit>^

and then =E2=80=98git bisect=E2=80=99 and lower-level commands like git=
 show and
checkout will silently substitute the parent of the broken commit
when ever you refer to it.

You can publish the resulting =E2=80=9Creplace refs=E2=80=9D in the ref=
s/replace/*
namespace and anyone who explicitly chooses to fetch them will be
able to see the same effect.

Two problems:

 - bisect skip is a bit more sophisticated (read: better) than just
   substituting a parent, especially when the commit to be skipped
   is a merge.  So it might still make sense to teach bisect to
   respect a refs/notes/skip-bisect note that requests for it
   to skip a specific ref.

   One can try this out by making an appropriate wrapper script
   for =E2=80=98git bisect next=E2=80=99 (using =E2=80=98git notes=E2=80=
=99).

 - replace refs are a little too powerful.  It would be nicer to
   by able to use =E2=80=98git replace --refs=3Drefs/replace/bisect/=E2=
=80=99
   and =E2=80=98GIT_REPLACE_REFS=3Drefs/replace/bisect/ git bisect=E2=80=
=99 to
   make them take effect only when needed.  In other words,
   it would be nicer if =E2=80=9Cgit replace=E2=80=9D were configurable=
 in the
   same way as =E2=80=9Cgit notes=E2=80=9D is.

   One can get something like that effect by using git for-each-ref
   and git update-ref to rename replace refs into place only when
   needed.

[1] http://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.h=
tml#_git_replace
