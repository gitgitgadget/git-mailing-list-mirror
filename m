From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] embedded TAB and LF in pathnames
Date: Fri, 07 Oct 2005 12:35:19 -0700
Message-ID: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 21:36:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENy0G-0000rm-5S
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 21:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbVJGTf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 15:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbVJGTf0
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 15:35:26 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:59341 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030510AbVJGTf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 15:35:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007193507.KOZI29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 15:35:07 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9813>

While I was reviewing git-status fix by Kai Ruemmler, it struck
me that our barebone Porcelain-ish layer got a bit sloppier over
time.  The core layer does not care about any metacharacters in
the pathname, and it has provisions, primarily in the form of
'-z' flag, for carefully written Porcelain layers to handle
pathnames with embedded metacharacters correctly.

One exception, however, is the interaction between the git-diff
family output and git-apply.  We needed to be compatible with
other people's diff, which meant that we should not have to
worry too much about pathnames with embedded TABs and LFs
because GNU diff would not produce usable diff for such things
anyway.  But 'git-diff --names' barfing if a pathname contained
these characters when run without '-z' flag was too much.  This
still breaks 'git-status'.

So I am considering the following changes:

 - 'raw' output format without '-z', upon finding a TAB or LF,
   would not die, but just issue a warning.  However, the paths
   are "munged" in a way described later.

 - '--name-only' and '--name-status' format issue the same
   warning when finding these characters and run without '-z'.
   And the paths are "munged" as well.

 - 'patch' output format also issues a warning.  The paths are
   "munged" but in a slightly different manner from the above.

 - 'git-apply' is taught about the path munging in the diff
   input for git diffs (i.e. 'diff --git') and do sensible
   things.

One possible way for path munging goes like this.  We could take
advantage of the fact that we do not ever output '//' ourselves,
and '//' never appears in valid diffs by other people's tools,
unless done deliberately by hand ("diff -u a//foo. b//foo.c"
from the command line).  So we could use '//' as if it is a
backslash.  Examples.

  "foo/bar.c" --> "foo/bar.c"	(no funny letters - as before)
  "foo\nbar"  --> "foo//0Abar" (double slash followed by 2 hex)
  "foo\tbar"  --> "foo//09bar" (double slash followed by 2 hex)

So a diff output to rename "foo/bar.c" to "foo\nbar.c" would
become:

  diff --git a/foo/bar.c b/foo//0Abar.c
  similarity index 100%
  rename from foo
  rename to foo//0Abar.c

The byte-values subject to this munging is LF for patch output
(because git-apply seems to grok TABs in pathnames just fine),
and TAB and LF for 'raw', '--name-only', '--name-status' without
'-z'.

I have not made up my mind on the exact choice of the quoting
convention.  We could say '///' instead of '//', for example, or
even '//{LF}//' instead of '//0A' proposed above.  One thing I
am trying to avoid is "foo\nbar", which I suspect would be
unfriendly to the Cygwin folks.
