From: David Roundy <droundy@abridgegame.org>
Subject: Re: Darcs and git: plan of action
Date: Wed, 20 Apr 2005 07:14:52 -0400
Message-ID: <20050420111446.GE29945@abridgegame.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
	<20050418122011.GA13769@abridgegame.org>
	<Pine.LNX.4.58.0504180832330.7211@ppc970.osdl.org>
	<20050419104252.GA28269@abridgegame.org>
	<Pine.LNX.4.58.0504190749030.19286@ppc970.osdl.org>
	<426532D5.3040306@tupshin.com>
	<Pine.LNX.4.58.0504190943060.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Wed Apr 20 13:16:40 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DODCC-0000fT-69
	for gcvdd-darcs-devel@m.gmane.org; Wed, 20 Apr 2005 13:16:40 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DODFn-0006Lq-4g; Wed, 20 Apr 2005 07:20:23 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]
	helo=localhost) by abridgegame.org with esmtp (Exim 4.50)
	id 1DODFi-00052G-7H
	for darcs-devel@darcs.net; Wed, 20 Apr 2005 07:20:18 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DODAS-0000Zi-9G; Wed, 20 Apr 2005 07:14:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Tupshin Harper <tupshin@tupshin.com>, darcs-devel@darcs.net,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504190943060.19286@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

On Tue, Apr 19, 2005 at 09:49:12AM -0700, Linus Torvalds wrote:
> On Tue, 19 Apr 2005, Tupshin Harper wrote:
> > I suspect that any use of wildcards in a new format would be impossible
> > for darcs since it wouldn't allow darcs to construct dependencies,
> > though I'll leave it to david to respond to that.
> 
> Note that git _does_ very efficiently (and I mean _very_) expose the 
> changed files.
> 
> So if this kind of darcs patch is always the same pattern just repeated
> over <n> files, then you really don't need to even list the files at all.
> Git gives you a very efficient file listing by just doing a "diff-tree"
> (which does not diff the _contents_ - it really just gives you a pretty
> much zero-cost "which files changed" listing).

The catch is that it's possible to have a darcs patch that doesn't change
any files, or that affects files without changing them.  If I rename
function foo to bar, I might want to do

darcs replace foo bar *.c

which would issue a replace on all files, which means that when this patch
is merged with any patches that add occurrences of foo in a file, that will
get modified to a bar, regardless of whether there was previously an
occurrence of foo in that file.

I think we might (when working with git--it would be problematic within
darcs straight) be able to work out some sort of a wildcard replace
scheme, so it could be something like

replace foo bar in: mm/*.c

The regexp bit could be left out, if we restrict the definition of "tokens"
in token replaces--which probably isn't a troublesome limitation.  By
default darcs uses two tokenizing schemes, one which allows "." in tokens
(usually relevant in Makefiles), and one which doesn't, and basically
matches C identifiers.  We could allow for both of these if we had a second
option:

replace filename foo.h bar.h in: mm/*.c

We'd just need to expand the wildcards when translating from the git
repository into darcs patches.

> So that combination would be 100% reliable _if_ you always split up darcs 
> patches to "common elements". 
> 
> And note that there does not have to be a 1:1 relationship between a git
> commit and a darcs patch. For example, say that you have a darcs patch
> that does a combination of "change token x to token y in 100 files" and
> "rename file a into b". I don't know if you do those kind of "combination 
> patches" at all, but if you do, why not just split them up into two? That 
> way the list of files changed _does_ 100% determine the list of files for 
> the token exchange.

We do allow multiple sorts of changes (in darcs terminology, multiple
"primitive patches") in a single patch.

One *could* have multiple git commits for a single darcs patch, but that
seems ugly and I'd rather avoid it.  In my view, revision control system is
more about communication than history (which is why by default, darcs
doesn't "do" history), and grouping changes together is how we express
which changes "go together".  Of course, we could still have a grouping at
a higher level, so that a single "changeset" could consist of multiple git
commits (for example by recognizing that identical commit logs mean that
it's a single change), but that adds a layer of complexity that I'd like to
avoid if possible.
-- 
David Roundy
http://www.darcs.net
