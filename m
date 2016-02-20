From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PULL] svn pathnameencoding for git svn dcommit
Date: Sat, 20 Feb 2016 23:37:43 +0000
Message-ID: <20160220233743.GA28606@dcvr.yhbt.net>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
 <20160208225806.GA3487@dcvr.yhbt.net>
 <20160215005210.GA31141@dcvr.yhbt.net>
 <56C297A9.2080705@f2.dion.ne.jp>
 <20160216063357.GA17455@dcvr.yhbt.net>
 <56C34BFF.3030301@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	alex.crezoff@gmail.com
To: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
X-From: git-owner@vger.kernel.org Sun Feb 21 00:37:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXH5w-0007G9-RA
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 00:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbcBTXhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 18:37:45 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44644 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbcBTXho (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 18:37:44 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D76D20453;
	Sat, 20 Feb 2016 23:37:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56C34BFF.3030301@f2.dion.ne.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286792>

Kazutoshi Satoda <k_satoda@f2.dion.ne.jp> wrote:
> (Shouldn't the branch be based on maint, as these are bugfixes?)

I'm not sure if it being previously left-out/untested feature
would qualify for maint.  Maybe it does, but I suppose I'll let
Junio decide.

> Thank you. I tried it but got similar problem:

<snip>

> I found how "\357\202\201\357\202\202" (U+F081 U+F082 in UTF-8) could
> come.
> https://cygwin.com/cygwin-ug-net/using-specialnames.html#pathnames-specialchars
> > Some characters are disallowed in filenames on Windows filesystems. ...
> ...
> > ... All of the above characters, except for the backslash, are converted
> > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
> > "Private use area") when creating or accessing files.
> "U+F081 U+F082" seems the result of conversion from "0x8182" (neq in
> cp932) as treating each of 2 bytes as disallowed characters.
> 
> And I also noticed that LANG and LC_ALL is set to "C" in test-lib.sh.
> 
> Setting LC_ALL=C.UTF-8 in the test 11-12 made them pass on Cygwin.
> Same change made the previous version also pass. Please find the patch
> in the attached output of git format-patch.

Thanks.  However, I also wonder what happens on machines without
"C.UTF-8" support (are there still any?).

> Could you please test with this on non-Cygwin environment?

Works for me, at least.  I've squashed your changes into the two
patches already queued up.  I needed to split the
"export LC_ALL=C.UTF-8" statement into
"LC_ALL=C.UTF-8 && export LC_ALL" for portability.

> If it made no harm, please tell me what should I do to proceed this patch.
> Will you (Eric) please make further integration? Shall I make another
> series (v2) of patches?

I've pushed out a new branch with your LC_ALL changes squashed
in.  However I'm unsure if there's any new portability problems
with LC_ALL=C.UTF-8...

Junio or anyone else: thoughts?

The following changes since commit 0233b800c838ddda41db318ee396320b3c21a560:

  Merge branch 'maint' (2016-02-17 10:14:39 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn.git ks/svn-pathnameencoding-3

for you to fetch changes up to 980c083276ba06a9400c5b1b2558c3626bcff969:

  git-svn: apply "svn.pathnameencoding" before URL encoding (2016-02-20 23:30:16 +0000)

----------------------------------------------------------------
Kazutoshi Satoda (2):
      git-svn: enable "svn.pathnameencoding" on dcommit
      git-svn: apply "svn.pathnameencoding" before URL encoding

 perl/Git/SVN/Editor.pm                   |  4 +++-
 t/t9115-git-svn-dcommit-funky-renames.sh | 39 ++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)
