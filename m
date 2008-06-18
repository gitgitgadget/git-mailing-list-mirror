From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Wed, 18 Jun 2008 16:36:33 +0200
Message-ID: <20080618143633.GB30540@diana.vm.bytemark.co.uk>
References: <20080612052913.23549.69687.stgit@yoghurt> <20080612053424.23549.64457.stgit@yoghurt> <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com> <20080617123138.GA6932@diana.vm.bytemark.co.uk> <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com> <20080617153247.GA12520@diana.vm.bytemark.co.uk> <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 16:37:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8yn6-00013g-Kz
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 16:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYFROgo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 10:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYFROgo
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 10:36:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3325 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbYFROgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 10:36:42 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K8ym1-00089s-00; Wed, 18 Jun 2008 15:36:33 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85380>

On 2008-06-18 14:03:51 +0100, Catalin Marinas wrote:

> 2008/6/17 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > The log actually _contains_ those trees, so there is no problem.
>
> OK, I begin to understand. It is a generic solution for storing
> metadata

I don't know about "generic" -- it's made specifically for storing an
StGit stack. You could certainly store just about anything in a git
tree, but that's also true for a git commit message ...

> but IMHO it is too overweight when we only need a list of applied
> and unapplied files (we can remove hidden) that could be easily
> stored in a commit log.

Do you mean remove hidden patches from StGit altogether, or just not
store them in the log?

> It would be useful to run a quick benchmark with many (hundreds) of
> patches and compare it with no logging variant (or the current patch
> logging, which isn't as advanced).

Will do, as soon as I've done some basic optimization. (A simple
"dirty" flag on each patch will enable us to only write out the log
for the patches that have actually changed, and reuse the rest from
the previous log entry.)

> Could we not make this (much) simpler? I.e. <branch>.stgit is a
> commit object whose tree is <branch>^{tree} and the message contains
> the command followed by list of patches in the form "<commit>
> <patch>"? This commit can have two parents - the previous
> <branch>.stgit and current <branch> head. All the patches are
> referred via the <branch> head or the previous <branch> heads if
> unapplied (assuming that when a patch is created it is first applied
> and then popped, maybe this needs a bit of thinking).

I considered a scheme much like this, but besides the problem with
(the very few) patches that are created unapplied, it fails badly in a
very important corner case: when you start logging in a pre-existing
stack. A similar failure will occur if we ever build some sort of log
pruning (without which the log will grow without limit).

I suppose it would be possible to special-case the very first log
entry: let it have all patches as ancestors. But I don't really see
this format as being simpler than the one I use now: all you've done,
basically, is cram all the data into the commit message instead of
storing it in the tree. (Benchmarking could certainly prove your
design superior to mine, however.)

> This way, a diff between subsequent <branch>.stgit commits would
> show the tree changes. The 'stg log' command could be made to show
> differences in the commit messages.

Tree changes are only really useful for refresh. (More on this below.)

> > If you have ideas for a better way to visualize this, I'm all
> > ears.
>
> The diff of diffs is generally useful but for 'refresh' logs, you
> can show the diff between the old top tree and the new one (the
> current patch log implementation does something like this but it
> doesn't show anything for commands like 'push' where a diff of diffs
> would be more appropriate).

The diff-of-diffs view is actually very useful for refresh as well.
The diff of old and new top tree is useful only for refresh (but it
_is_ useful -- I'm not arguing against it).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
