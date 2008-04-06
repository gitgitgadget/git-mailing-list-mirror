From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: bug in git-apply
Date: Mon, 7 Apr 2008 01:53:34 +0200
Message-ID: <20080406235334.GA8483@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:54:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiehB-0002N9-Ag
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 01:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbYDFXyB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2008 19:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754930AbYDFXyB
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 19:54:01 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2887 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbYDFXyB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 19:54:01 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jieg2-0002RO-00; Mon, 07 Apr 2008 00:53:34 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78941>

StGit's test suite has started failing, and it's due to a change in
git that I'm pretty sure is a bug. I built a small test case using
just git for easier testing:

  mkdir foo
  cd foo

  git init
  touch xx
  git add xx
  git commit -m 'first'

  git checkout -b branch

  echo aaa >> xx
  git add xx
  git commit -m 'second'

  git checkout master

  echo bbb >> xx
  git add xx
  git commit -m 'third'

  git diff branch^ branch > p
  git apply < p && echo "this should not succeed!"

Basically, we have a file containing "aaa\n", and a patch that tries
to take the file from "" to "bbb\n". A recent enough git-apply will
accept this patch without complaining, and put "aaa\nbbb\n" in the
file.

I bisected, and the culprit was this commit:

commit dc41976a3eed1d9c93fdc08c448bab969db4e0ec
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sat Jan 19 01:58:34 2008 -0800

    builtin-apply.c: push match-beginning/end logic down

    This moves the logic to force match at the beginning and/or at
    the end of the buffer to the actual function that finds the
    match from its caller.  This is a necessary preparation for the
    next step to allow matching disregarding certain differences,
    such as whitespace changes.

    We probably could optimize this even more by taking advantage of
    the fact that match_beginning and match_end forces the match to
    be at an exact location (anchored at the beginning and/or the
    end), but that's for another commit.

    Signed-off-by: Junio C Hamano <gitster@pobox.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
