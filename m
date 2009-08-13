From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 0/6] {checkout,reset,stash} --patch
Date: Thu, 13 Aug 2009 14:29:38 +0200
Message-ID: <cover.1250164190.git.trast@student.ethz.ch>
References: <200908101136.34660.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 14:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbZRn-0002is-IF
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 14:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbZHMMaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 08:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbZHMMaK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 08:30:10 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:54458 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbZHMMaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 08:30:10 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:09 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 14:30:00 +0200
X-Mailer: git-send-email 1.6.4.262.gbda8
In-Reply-To: <200908101136.34660.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125809>

Junio C Hamano wrote:
> * tr/reset-checkout-patch (Tue Jul 28 23:20:12 2009 +0200) 8 commits
[...]
> Progress?

Slow, as always.  There are three groups of changes:

1. This iteration goes the "complicated" way to mitigate Jeff's concern:

Jeff King wrote:
> Shouldn't the diff [in checkout -p] be reversed? That is, I think
> what users would like to see is "bring this hunk over from the index
> to the working tree". But we have the opposite (a hunk that is in
> the working tree that we would like to undo).

That is, the rules are now as follows:

add -p			forward application
reset -p [HEAD]		exact opposite of add -p: reverse application
reset -p other		forward application to index (**)
checkout -p		"opposite of editing": reverse application
checkout -p HEAD	"opposite of editing and staging": reverse application
checkout -p other	forward application to WT and index (**)
stash -p		"stash these edits": reverse application to WT, "forward to stash"

Those marked (**) are the only ones that changed semantics compared to
v4.  However, I adjusted the messages to look different:

add -p			Stage this hunk?
reset -p [HEAD]		Reset this hunk? (**)
reset -p other		Apply this hunk to index? (**)
checkout -p		Discard this hunk from worktree? (**)
checkout -p HEAD	Discard this hunk from index and worktree? (**)
checkout -p other	Apply this hunk to index and worktree? (**)
stash -p		Stash this hunk?

Again, (**) are the changed ones from v4.  The help message also shows
the "to/from ..." extra in the help for y/n.

I think this should now make 'reset -p' and 'checkout -p' fairly
intuitive, while at the same time making the '... other' forms easier
to wrap one's head around.  Of course, as stated earlier in the
thread, the downside with this approach is that the direction suddenly
changes when you give it an 'other'.

These changes affect all 'Implement foo --patch' patches, and the
git-apply--interactive refactoring.


2. git checkout -p HEAD fixed

Nicolas Sebrecht wrote:
> 
>   % git checkout -p HEAD
> 
> and
> 
>   % git checkout -p HEAD -- file
> 
> behave differently here in my test above.

This sadly was a rather trivial thinko on my part in the C glue for
'checkout -p', which I fixed.  I also changed the tests to cover
various ways of limiting paths.


3. Tests rewritten

I added a new 2/6 refactors the many occurences of

	test "$(cat file)" = expected_worktree &&
	test "$(git show :file)" = expected_index

to a few library functions, and rewritten all three tests to use them.
Due to the bug discussed in (2.) above, the tests also cover pathspecs
for all new commands.  Due to my own concern because this was broken
at some point during development, all commands also check if relative
paths inside a directory work.


3/6 (which was 2/5) and 7/6 (was 6/5) are unchanged, and apart from
the fix for (2.) which was a one-liner, so is all the C code.  7/6 is,
as before, based on a merge with js/stash-dwim.


Thomas Rast (7):
  git-apply--interactive: Refactor patch mode code
  Add a small patch-mode testing library
  builtin-add: refactor the meat of interactive_add()
  Implement 'git reset --patch'
  Implement 'git checkout --patch'
  Implement 'git stash save --patch'
  DWIM 'git stash save -p' for 'git stash -p'
