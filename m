From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Fri, 04 May 2007 20:38:41 -0700
Message-ID: <7vwszolz26.fsf@assigned-by-dhcp.cox.net>
References: <463BD40C.6080909@gmail.com>
	<Pine.LNX.4.64.0705050324580.4015@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 05 05:38:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkB6d-0003qg-Ah
	for gcvg-git@gmane.org; Sat, 05 May 2007 05:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423977AbXEEDio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 23:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423976AbXEEDio
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 23:38:44 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:61021 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423977AbXEEDin (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 23:38:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070505033844.FNKS6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 4 May 2007 23:38:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vFei1W00V1kojtg0000000; Fri, 04 May 2007 23:38:43 -0400
In-Reply-To: <Pine.LNX.4.64.0705050324580.4015@racer.site> (Johannes
	Schindelin's message of "Sat, 5 May 2007 03:29:44 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46239>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Think of the "todo" branch, for example. And this is not even far fetched. 
> In many repositories I have to have separate related, but non-branch 
> HEADs. For example, I track some projects with custom scripts. These 
> scripts do _not_ belong into that branch. However, they are related, so I 
> store them in the same repository.

I said I won't talk about it until 1.5.2 final, but you forced
me into it.

> Plus, my example of the bare-repository still has not been answered by 
> _anyone_ in favour of changing the current behaviour.

I am not sure if there is anything to answer on this one.

When you are talking to a bare-repository, your place relative
to the root of the working tree is clearly undefined, and it is
natural that "<tree-ish>:./<path>", "<tree-ish>:/<path>" and
"<tree-ish>:<path>" cannot mean anything but relative to the
root of the tree-ish.  "<tree-ish>:../<path>" is obviously
nonsense.  So it does not matter if unadorned <path> is relative
to cwd or root in this case.

Your other example, however, gives a much better illustration.
An unrelated 'todo' branch where your cwd does not have any
relevance to the contents of that tree-ish, or worse yet, a
commit from git-gui project in git.git repository, where taking
your cwd into account has an actively wrong effect, demonstrates
why we would need a way to say "By this path, I mean from the
top, I do not want you to take it as relative to where I am".

One way to ensure that is to keep the current "it is a path from
the top" behaviour, and extended it with "... unless it begins
with ./".  Doing this forever however penalizes the case where
you want to use relative paths by requiring ./ at the beginning.

Another is to do the usual POSIXy path interpretation and
"unless it begins with /, it is taken as relative to where you
are".  This penalizes the 'todo' and git-gui commit use case
because the user explicitly needs to say "where I am does not
matter" by prefixing the path with '/', and also necessitates a
change to the syntax for looking backwards for a commit with
that message, because the existing syntax to look for a string
clashes with it [*1*].

Both have merits and demerits.  If we did not have any existing
code and users, the latter is clearly what we would have done,
as it is more consistent.  The path handling feels more natural
(in line with the way we expect paths to be handled on POSIX
systems), the "look backwards" search feels more natural ( you
use '/' for forward search, '?' for backwards).

I also suspect the latter is more often convenient.  When
working on a flat project, it does not matter if the default is
relative to cwd or to the root.  But if your project is deep,
and if you somehow do "git show" more often than "git diff" (I
don't, but different people may do so for different reasons), it
would start to hurt if you always have to say "./".

It is however clearly a bigger change to existing users.
Correcting earlier mistakes is painful, so it certainly is
tempting to take the approach that the path is always absolute
and require "./" for relative.  I agree it is an easier change,
but I am not convinced yet that it is the right design in the
longer term.

[Footnote]

*1* This is only true for looking for a path in the index case,
as <commit>:/<string> does not seem to work.  I think this is a
bug in the current code -- shouldn't it limit the search to
commits that are reachable from that named one?
