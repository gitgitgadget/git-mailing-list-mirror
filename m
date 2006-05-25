From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch possible regressions
Date: Thu, 25 May 2006 12:56:34 -0700
Message-ID: <7vhd3dubd9.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 25 21:56:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjLwv-0001P3-3h
	for gcvg-git@gmane.org; Thu, 25 May 2006 21:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWEYT4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 15:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWEYT4h
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 15:56:37 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:57256 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030376AbWEYT4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 15:56:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525195636.RDBP15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 15:56:36 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20757>

"Marco Costalba" <mcostalba@gmail.com> writes:

> A couple of possible regressions:
>
> 1) Unreconized --signoff option
>
> $ git --version
> git version 1.3.3.ged90
> $ git-format-patch -s HEAD^..HEAD
> 0001-cat-file-document-p-option.txt
> $ git-format-patch --signoff HEAD^..HEAD
> fatal: unrecognized argument: --signoff
>...
> Both regressions brake qgit. The first one is easy to fix (--signoff  --> -s)

I do not think -s does what you want.  It means "do not generate
diff" to the diff family, but format-patch overrides it and
forces generating patch+stat output, so you do not see what it
is doing.

Also I do not think we would want to have --sign to format-patch
anyway; it encourages a wrong workflow.  Please see this and
other messages in the thread:

	http://article.gmane.org/gmane.comp.version-control.git/20389

On a slightly related topic, I sent a message to Pasky about
this -s stuff.  It means something slightly different in
diff-files (instead of asking for no output, it behaves as a
no-op there), and we can remove that compatibility wart once
Cogito stops using "diff-files -s" when it wants to do
"diff-files" in cg-merge (and I suspect that diff-files is
unnecessary).

> 2) Unhandled ranges list
>
> The second one is not so easy.

This is a real regression; I was hoping Porcelain writers were
paying attention of what are coming, but obviously the
description in "What's in git.git" messages and discussion on
the list were not detailed enough.  My apologies.

Having said that, I think what Linus says about equilvalence
between "a..b" and "^a b" makes whole lot of sense.  However, I
could argue both ways.  Linus's interpretation of "a..b c..d" is
"^a ^c b d", but format-patch's interpretation has always been
"do '^a b' and then '^c d'".

The former is more generic; you could say "not in A nor B but in
C pretty easily -- list of ranges cannot express something like
that.  On the other hand, at least in the context of usual
format-patch, the convenience of being able to work on more than
one ranges in sequence may far outweigh the restriction of not
being able to say something like that.

As an easy alternative, we could give --start-number=<n> to
format-patch so that you can do the iteration yourself instead
of having format-patch to iterate over the list.
