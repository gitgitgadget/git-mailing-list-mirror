From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2 00/11] post-rewrite / automatic notes copying
Date: Wed, 17 Feb 2010 00:25:56 +0100
Message-ID: <cover.1266361759.git.trast@student.ethz.ch>
References: <cover.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:26:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhWoO-0005pQ-R0
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933537Ab0BPX03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:26:29 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:45469 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757044Ab0BPX02 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:26:28 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 00:26:25 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 00:26:07 +0100
X-Mailer: git-send-email 1.7.0.67.g67ac3
In-Reply-To: <cover.1266164150.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140161>

I originally had two series, but to retain my sanity while shuffling
fixups, I based the entire batch on a rebase of jh/notes onto current
master.  The first four do not depend on jh/notes though, and are
almost unchanged from the first round.

The docs are probably sprinkled a bit strangely over the patches, not
sure if it's worth a cleanup though (or I could just gather all the
docs in a final patch).  At least tests should be in the right place.


Based on Hannes's comment:

On Monday 15 February 2010 21:36:05 Johannes Sixt wrote:
> Thomas Rast schrieb:
> > +if test -x "$GIT_DIR"/hooks/post-rewrite &&
> > +	test -s "$workdir"/../rewritten; then
> > +	"$GIT_DIR"/hooks/post-rewrite filter-branch < "$workdir"/../rewritten
> > +fi
> 
> This sounds extra-strange. As if filter-branch is used 20 times a day. If 
> the intent is to carry notes over to new commits, then filter-branch 
> should grow a --notes-filter instruction, no? With an easily accessible 
> copy-everything mode like --tagname-filter=cat.

I made filter-branch extra-tweakable, but tried to stay consistent
with the configuration of the rest of the series.  Maybe it's a bit
overengineered now, dunno.

On Monday 15 February 2010 02:25:52 Johan Herland wrote:
> On Sunday 14 February 2010, Thomas Rast wrote:
> > 
> > I spent some time trying to refactor cmd_notes() into something
> > that can nicely handle commands that do not fit the normal scheme,
> > but eventually was too tired to continue and just crafted it in
> > the existing code in the right place.
[...]
> As you say, cmd_notes() should be refactored, so that you don't have to 
> duplicate all of this (and some of the below stuff).

Actually I meant something different: it took me quite some time to
figure out what goes where in the flow of the current main() function,
since it is sprinkled with if(subcommand) -- for most of them, several
such clauses.

I guess it made sense at the time, because all commands more or less
worked with the same arguments and mostly the same background logic,
just in a slightly different way.  But I think it's quite unnatural
for an entirely-different command like 'copy --stdin'.

But maybe that's just me.

> We (this goes for the existing commit_notes() call in cmd_notes() as well) 
> should either check the return value for commit_notes(), or (since it 
> currently only returns 0) we should change commit_notes() to void instead of 
> int. Actually, the correct solution is probably to "return error()" instead 
> of "die()" inside commit_notes(), and then check the return value.

I'll leave that up to your judgement; I haven't looked into the API
workings much, so I'm not sure when it should fail how.

[Thanks for the other comments on my embarrassing mistakes; I was
apparently rather too tired to continue programming.]


Thomas Rast (11):
  Documentation: document post-rewrite hook
  commit --amend: invoke post-rewrite hook
  rebase: invoke post-rewrite hook
  rebase -i: invoke post-rewrite hook
  notes: clean up t3301
  notes: implement 'git notes copy --stdin'
  notes: implement helpers needed for note copying during rewrite
  rebase: support automatic notes copying
  commit --amend: copy notes to the new commit
  filter-branch: invoke post-rewrite hook
  filter-branch: learn how to filter notes

 Documentation/config.txt            |   17 +++
 Documentation/git-filter-branch.txt |   20 +++-
 Documentation/git-notes.txt         |   16 ++-
 Documentation/githooks.txt          |   40 +++++
 builtin-commit.c                    |   49 +++++++
 builtin-notes.c                     |  134 +++++++++++++++++-
 builtin.h                           |   15 ++
 git-am.sh                           |   13 ++
 git-filter-branch.sh                |   37 +++++
 git-rebase--interactive.sh          |   45 ++++++-
 git-rebase.sh                       |    6 +
 notes.c                             |   21 +++
 notes.h                             |    9 ++
 t/t3301-notes.sh                    |  273 +++++++++++++++++++++++------------
 t/t3400-rebase.sh                   |   16 ++
 t/t3404-rebase-interactive.sh       |   10 ++
 t/t5407-post-rewrite-hook.sh        |  188 ++++++++++++++++++++++++
 t/t7003-filter-branch.sh            |   22 +++
 t/t7501-commit.sh                   |   11 ++
 19 files changed, 843 insertions(+), 99 deletions(-)
 create mode 100755 t/t5407-post-rewrite-hook.sh
