From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 0/7] limit the usage of the default remote "origin" to the minimum
Date: Mon, 28 Apr 2008 11:32:11 -0400
Message-ID: <cover.1209391614.git.bonzini@gnu.org>
References: <4812DA50.3000702@gnu.org>
Cc: spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 17:34:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVMj-0004Kp-Vn
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 17:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935730AbYD1Pcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 11:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935695AbYD1Pcp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 11:32:45 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60641 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935598AbYD1Pcf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 11:32:35 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JqVL0-0004f3-7s; Mon, 28 Apr 2008 11:32:18 -0400
X-Mailer: git-send-email 1.5.5.1.89.g36c79d
In-Reply-To: <4812DA50.3000702@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80543>

The aim of this series of patches limits the "magic" default of
"origin", that git sometimes uses in its fetch/push/pull commands,
to what I consider to be the bare acceptable minimum.  (I will discuss
later what this minimum is).

This has two aims.  The first is to make people more aware of what remote
they are interacting with.  The second is to allow faster operation for
those people that do work with more than one remote.  While "git remote
update" already does some of the latter, it is limited to fetching.
These patches use a different approach: they take the zero-argument
commands "git fetch", "git push", "git pull" that all git users know,
and make them scale nicely to use cases with >1 remote.

Patches 1 to 4 deal with "git push".  The problem here is that the
"magic" default operation ("git push sends to origin all refs that
are already present there"), as of new, cannot be explained in the
configuration, and this is fixed by patches 1 and 2.  Patch 1 adds a
special push refspec meaning "consider all refs already on the remote",
and patch 2 makes git-clone add one such line when it creates the
origin remote.

Patch 3 could also be split out of this series.  It adds to "git-remote
add" a new --push option, that sets up a push refspec for the newly
created remote.  If git-clone will ever use "git-remote add", it should
pass this option.  This patch also defines the "--push --mirror" combo
to create a remote *which will backup the current repository*.  I posted
this patch here, and placed it as the third, because some design decisions
in patch 4 are clearer if one considers the --push --mirror use case.

Patch 4 is a reworking of my previous patch.  Instead of having "git
push" push to "all mirrors plus the magic origin branch", it will
push to "all remotes having a push refspec".  In the future, this
will always include the origin branch because of patch 2, while
right now the origin branch is still used if no remote has a
push refspec (for backwards compatibility -- more discussion in the
patch log message).

This patch may cause incompatibilities to be warned about in
the release notes.  Luckily, these incompatibilities only affect
users that already know their way in .git/config, because no porcelain
command creates push refspecs.

Patches 5 and 6 affect "git pull".  Pulling uses the magic origin branch
less often, because branch.*.remote already establishes a saner default.
Therefore, here we can actually warn and deprecate the misfeature for
real (patch 6).  Patch 5 however is still needed, so that "git pull"
itself decides when to use the magic "origin" branch instead of making
the decision in "git fetch".

Finally, patch 7 affects "git fetch".  As hinted earlier, I chose to
duplicate the functionality already present in "git remote update"
(for the case where remotes are not grouped), but the code is much
simpler so there is no incentive (at least for now) in borrowing code
from "git remote update" into "git fetch"---actually, as a cleanup
it is maybe possible to borrow code in the other direction.

The patch series touches relatively many areas.  Some patches could
go in separately as cleanups, new features or just because their effect
is less profound.  In particular:
- patch 5 could go in separately as a code cleanup;
- patch 6 does not affect the user operation, it just adds a warning
  that should not appear for the most common cases; it can go in IMHO
  even if "git fetch" and "git push" keep the magic choice of "origin".
- patches 1 and 2 add a new feature and could go in separately.

As a closing comment (this cover letter is already too long possibly!),
I think this design is sound.  In particular, here is a list of
citations from the earlier thread in light of which, I think, this
design makes a lot of sense.

"I _hate_ the default remote."
	Well, this series does not make origin behave differently.  Still,
	a "remote configured by default to behave in a particular way",
	is obviously much better than "a remote whose default behavior
	is built into git".  Also, even though this series could not
	completely remove git's knowledge of origin, that's only motivated
	by backwards compatibility.

"I am sympathetic when they want to say "git push" and have it default
 to that single other repository."
	So that's what git will keep doing.  However...

"Should we [...] make people more aware that what _they_ do is the
 special case to have only one remote to interact with?"
	... after this series, it will scale to >1 remote consistently
	with this aim.  "git fetch" and "git push" will examine every
	possible remote (and there is just one in the simple "CVS" case).

"BTW, I find myself decreasingly using "git fetch" in favor of "git
 remote update" which handles fetching from multiple remotes."
	The series remove the need to switch from "git fetch" to
	"git remote update" as one learns the power of DVCS.

"[Removing a default altogether] harms the `git pull` case that relies
upon the magic branch.$name.remote and branch.$name.merge keys."
	Indeed, IMHO the way to go (in general, and especially for
	"git pull") is to deprecate the magic usage of "origin"---not
	to deprecate the zero-argument versions.

"I know git pretty well, and I find that particular distinction (that is,
needing to specify the remote if using refspecs, but not otherwise)
annoying.  It is purely a syntactic issue that relying on order of
arguments means you can't default earlier ones but specify later ones."
	The patches admittedly does not tackle that.  It actually makes
	it "harder to solve", because it is not anymore a matter of
	default arguments.  Zero-argument push and fetch work on
	all remotes (suggested also by Stephen R. van der Berg in the
	thread), not on just one.  On the other hand, it makes it
	easier to explain: all remotes? no need to specify anything;
	one remote? always specify it.


Paolo Bonzini (7):
  add special "matching refs" refspec
  add push line in git-clone
  Add a --push option to "git-remote add"
  make "git push" update all push repositories.
  don't rely on zero-argument "git fetch" from within git pull
  warn on "git pull" without a given branch.<name>.remote value
  make "git fetch" update all fetch repositories

 Documentation/git-fetch.txt               |    7 ++
 Documentation/git-pull.txt                |    9 ++-
 Documentation/git-push.txt                |   35 +++++++---
 Documentation/git-remote.txt              |   31 ++++++---
 builtin-fetch.c                           |  109 ++++++++++++++++-------------
 builtin-push.c                            |   67 +++++++++++++++---
 builtin-remote.c                          |   32 ++++++--
 builtin-send-pack.c                       |   10 +++-
 git-clone.sh                              |    2 +
 git-parse-remote.sh                       |    8 ++
 git-pull.sh                               |    9 ++-
 remote.c                                  |   80 ++++++++++++++-------
 remote.h                                  |    1 +
 t/t5400-send-pack.sh                      |    2 +-
 t/t5505-remote.sh                         |   26 +++++++-
 t/t5510-fetch.sh                          |   19 +++++-
 t/t5511-refspec.sh                        |    5 +-
 t/t5515-fetch-merge-logic.sh              |    8 +--
 t/t5515/fetch.br-branches-default         |    8 --
 t/t5515/fetch.br-branches-default-merge   |    9 ---
 t/t5515/fetch.br-branches-default-octopus |   10 ---
 t/t5515/fetch.br-branches-one             |    8 --
 t/t5515/fetch.br-branches-one-merge       |    9 ---
 t/t5515/fetch.br-branches-one-octopus     |    9 ---
 t/t5515/fetch.br-config-explicit          |   11 ---
 t/t5515/fetch.br-config-explicit-merge    |   11 ---
 t/t5515/fetch.br-config-explicit-octopus  |   11 ---
 t/t5515/fetch.br-config-glob              |   11 ---
 t/t5515/fetch.br-config-glob-merge        |   11 ---
 t/t5515/fetch.br-config-glob-octopus      |   11 ---
 t/t5515/fetch.br-remote-explicit          |   11 ---
 t/t5515/fetch.br-remote-explicit-merge    |   11 ---
 t/t5515/fetch.br-remote-explicit-octopus  |   11 ---
 t/t5515/fetch.br-remote-glob              |   11 ---
 t/t5515/fetch.br-remote-glob-merge        |   11 ---
 t/t5515/fetch.br-remote-glob-octopus      |   11 ---
 t/t5515/fetch.br-unconfig                 |   11 ---
 t/t5515/fetch.master                      |   11 ---
 t/t5515/refs.br-branches-default          |   12 ---
 t/t5515/refs.br-branches-default-merge    |   12 ---
 t/t5515/refs.br-branches-default-octopus  |   12 ---
 t/t5515/refs.br-branches-one              |   12 ---
 t/t5515/refs.br-branches-one-merge        |   12 ---
 t/t5515/refs.br-branches-one-octopus      |   12 ---
 t/t5515/refs.br-config-explicit           |   15 ----
 t/t5515/refs.br-config-explicit-merge     |   15 ----
 t/t5515/refs.br-config-explicit-octopus   |   15 ----
 t/t5515/refs.br-config-glob               |   15 ----
 t/t5515/refs.br-config-glob-merge         |   15 ----
 t/t5515/refs.br-config-glob-octopus       |   15 ----
 t/t5515/refs.br-remote-explicit           |   15 ----
 t/t5515/refs.br-remote-explicit-merge     |   15 ----
 t/t5515/refs.br-remote-explicit-octopus   |   15 ----
 t/t5515/refs.br-remote-glob               |   15 ----
 t/t5515/refs.br-remote-glob-merge         |   15 ----
 t/t5515/refs.br-remote-glob-octopus       |   15 ----
 t/t5515/refs.br-unconfig                  |   11 ---
 t/t5515/refs.master                       |   11 ---
 t/t5516-fetch-push.sh                     |   41 +++++++++++
 t/t5517-push-mirror.sh                    |   84 ++++++++++++++++++++++-
 60 files changed, 452 insertions(+), 614 deletions(-)
 delete mode 100644 t/t5515/fetch.br-branches-default
 delete mode 100644 t/t5515/fetch.br-branches-default-merge
 delete mode 100644 t/t5515/fetch.br-branches-default-octopus
 delete mode 100644 t/t5515/fetch.br-branches-one
 delete mode 100644 t/t5515/fetch.br-branches-one-merge
 delete mode 100644 t/t5515/fetch.br-branches-one-octopus
 delete mode 100644 t/t5515/fetch.br-config-explicit
 delete mode 100644 t/t5515/fetch.br-config-explicit-merge
 delete mode 100644 t/t5515/fetch.br-config-explicit-octopus
 delete mode 100644 t/t5515/fetch.br-config-glob
 delete mode 100644 t/t5515/fetch.br-config-glob-merge
 delete mode 100644 t/t5515/fetch.br-config-glob-octopus
 delete mode 100644 t/t5515/fetch.br-remote-explicit
 delete mode 100644 t/t5515/fetch.br-remote-explicit-merge
 delete mode 100644 t/t5515/fetch.br-remote-explicit-octopus
 delete mode 100644 t/t5515/fetch.br-remote-glob
 delete mode 100644 t/t5515/fetch.br-remote-glob-merge
 delete mode 100644 t/t5515/fetch.br-remote-glob-octopus
 delete mode 100644 t/t5515/fetch.br-unconfig
 delete mode 100644 t/t5515/fetch.master
 delete mode 100644 t/t5515/refs.br-branches-default
 delete mode 100644 t/t5515/refs.br-branches-default-merge
 delete mode 100644 t/t5515/refs.br-branches-default-octopus
 delete mode 100644 t/t5515/refs.br-branches-one
 delete mode 100644 t/t5515/refs.br-branches-one-merge
 delete mode 100644 t/t5515/refs.br-branches-one-octopus
 delete mode 100644 t/t5515/refs.br-config-explicit
 delete mode 100644 t/t5515/refs.br-config-explicit-merge
 delete mode 100644 t/t5515/refs.br-config-explicit-octopus
 delete mode 100644 t/t5515/refs.br-config-glob
 delete mode 100644 t/t5515/refs.br-config-glob-merge
 delete mode 100644 t/t5515/refs.br-config-glob-octopus
 delete mode 100644 t/t5515/refs.br-remote-explicit
 delete mode 100644 t/t5515/refs.br-remote-explicit-merge
 delete mode 100644 t/t5515/refs.br-remote-explicit-octopus
 delete mode 100644 t/t5515/refs.br-remote-glob
 delete mode 100644 t/t5515/refs.br-remote-glob-merge
 delete mode 100644 t/t5515/refs.br-remote-glob-octopus
 delete mode 100644 t/t5515/refs.br-unconfig
 delete mode 100644 t/t5515/refs.master
