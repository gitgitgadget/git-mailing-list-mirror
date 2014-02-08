From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [RFH] hackday and GSoC topic suggestions
Date: Sat, 08 Feb 2014 20:03:02 +0100
Message-ID: <87mwi1l95l.fsf@thomasrast.ch>
References: <20140205225702.GA12589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 08 20:03:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCDBJ-0000gz-JF
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 20:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbaBHTDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 14:03:08 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:34192 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbaBHTDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 14:03:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 0BE124D656A;
	Sat,  8 Feb 2014 20:03:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4ijQPFG05ysm; Sat,  8 Feb 2014 20:03:03 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 87E9F4D64BD;
	Sat,  8 Feb 2014 20:03:03 +0100 (CET)
In-Reply-To: <20140205225702.GA12589@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Feb 2014 17:57:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241845>

Jeff King <peff@peff.net> writes:

> Below is a list of features / bugs that I am taking to the hackday.

I have the list below at

  https://github.com/trast/git/wiki/Todo-items

(started at git-merge last year).  I did a quick triage, but don't take
my word for it.  Perhaps it's not too late for your hackathon yet ;-)

Some items may have been fixed by other people when I wasn't looking, so
first check if the problem still exists.  The ones I knew are done I
moved to the bottom.


Easy:

* Add -p 'e' when it fails to apply should offer an obvious way of
  starting from the original hunk (not the broken one) or both

* filter-branch should apply {tree,index}-filter to HEAD and complain if
  it's not invariant (cf. BFG)

* git-config should follow symlinks when rewriting the file, so as to
  avoid replacing a symlink at ~/.gitconfig with the actual contents

* git-send-email should complain when given an option --cc= (i.e., --cc
  with empty argument) instead of silently not using any address
  there. It's easy to accidentally cause this in combination with
  $()-expanding a script that searches for the address by name when
  there are no matches. Note that the cccmd feature should not error if
  it doesn't come up with anything!


Medium difficulty:  
  
* LC_CTYPE=C to work around an old issue in glibc that has since been
  fixed (ask jrn). We should autodetect if we still need the fix, and
  otherwise avoid it; it causes trouble with localized messages

* rebase -i --exec should be able to work elsewhere so you can continue
  doing useful work

* git-send-email could build smarter reference lists if it had
  strategies to fetch the in-reply-to email. One obvious, and very
  useful for git and linux, strategy to do so would be to append the
  References header of the mail obtained from
  http://mid.gmane.org/$in_reply_to (follow the 403 and then append /raw
  to get the headers).

* git-svn should have a diff subcommand, to match svn's output for
  feeding into tools that need the precise format with 'Index:' lines

* Resurrect the move of config var descriptions onto the separate pages
  for commands

  
Hard or unknown difficulty:
 
* Add -p 's' followed by 'e' fails to apply even a no-op edit if the
  context is small

* git-bisect appears to test a linear number of merge bases, thus
  ruining its usually log(n) complexity, in cases involving 'git bisect
  good origin/next', 'git bisect bad origin/pu', in git.git

* I have a script git-pie which runs 'perl -i -pe' as follows:

        #!/bin/sh
        
        cmd=$1
        shift
        
        git ls-files -z "$@" |
        xargs -0 perl -i -pe "$cmd"

  The prompt display (__git_ps1) in the prompt immediately after using
  'git pie ...' always shows that there are no uncommitted changes, even
  if that is not correct. Hitting RET again yields a correct status.


Already underway or done (only here so people don't say "but you dropped
this from the wiki list"):

* In-core merge: a clean merge should be able to work fully in memory,
  esp. without any worktree

* For the issue of "what did the evil merge do", should try to flatten
  out the conflicted merge (i.e. mechanically re-merge, and scrap the
  conflicted state in favor of conflict hunks in stage 0) and diff that
  against the merge result. if that works out, store the tree as a note
  somewhere for caching; git-notes should be able to handle that

  * For the last point: need a way of storing trees as
    notes. Technically the notes infrastructure does not require things
    to be blobs, but in practice all the frontends we have error out, or
    do worse things, when handed a tree as a note.

* ./t0000-foo.sh --valgrind should be able to: a) run only a single
  specific test under valgrind, using the normal git for the rest; and
  b) parallelize over (a) so as to speed up a complete ./t0000-foo.sh
  --valgrind run

-- 
Thomas Rast
tr@thomasrast.ch
