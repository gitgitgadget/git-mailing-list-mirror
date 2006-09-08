From: linux@horizon.com
Subject: Re: Change set based shallow clone
Date: 7 Sep 2006 21:01:12 -0400
Message-ID: <20060908010112.6962.qmail@science.horizon.com>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 08 03:02:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLUkf-0001a8-Ke
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 03:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbWIHBBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 21:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWIHBB3
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 21:01:29 -0400
Received: from science.horizon.com ([192.35.100.1]:8766 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1752003AbWIHBBP
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 21:01:15 -0400
Received: (qmail 6963 invoked by uid 1000); 7 Sep 2006 21:01:12 -0400
To: git@vger.kernel.org, jonsmirl@gmail.com, linux@horizon.com
In-Reply-To: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26670>

> Here's a change set based shallow clone scheme I've been thinking
> about, does it have potential?

Well, let's look at the problems...

You might want to look at the explanation of the current git network
protocol at
http://www.spinics.net/lists/git/msg08899.html

I'm just understanding it myself, but as best I understant it,
it has four phases:

- First, the server lists all of the heads it has, by SHA1 and name.
- Second, the client tells it which ones it wants, by name.
- Third, an interactive protocol is entered in which the client
  tells the server which commits it has in terms the server can
  understand.  This proceeds as follows:

  - For each head the client has, it lists commit objects going
    backwards in history.
  - As soon as the server sees one that it has heard of, it sends
    back "ACK <hash> continue".  The client stops tracing that
    branch and starts in on the next one.
  - (Periodically, the client sends a ping to the server, which
    responds "NAK" if it's still alive.)
  - This continues until the client says "done".

At this point, the server knows a set of commits which the client has,
and a set of commits which the client wants.  Then it invokes

	git-rev-list --objects-edge <want1> <want2> ^<have1> ^<have2>

(In practice, there will be a lot more than two of each, but forgive
me if I simplify.)

This builds a list of commits that are ancestors of <want1> and <want2>
but not <have1> or <have2>.  (A commit is considered an ancestor of
itself, so <want1> and <want2> are in the set, while <have1> and <have2>
are not.)

Then it enumerates the complete trees of each of those commits.  Then it
subtracts from that object set all of the trees and blobs in the <have1>
and <have2> commits.

This is a good approximation to the set of objects that the client needs
to be sent.  It does not search the ancestors of <have1> and <have2>,
so it is possible that a copy of some object exists in an older commit,
and the state in <want1> is a reversion to a pre-<have1> state, but it's
unlikely and not worth looking for.  Sending it redundantly is harmless.


Then, this set of objects is piped to git-pack-objects, which finds them
and builds a pack file.  If the objects are stored locally as deltas
relative to other objects which are either to be sent, or are in the
<have1> or <have2> commits (which information is included in the data
output by git-rev-list), the delta is copied to the pack file verbatim.
Otherwise, more CPU is spent to pack it.

Again, the server is allowed to check for deltas against ancestors
of <have1> or <have2>, but doesn't bother for efficiency.


Fourth, the pack file is sent to the client, which unpacks it (and
discards any duplicates).

> When the client wants a shallow clone it starts by telling the server
> all of the HEADs and how many change sets down each of those HEADs it
> has locally. That's a small amout of data to transmit and it can be
> easily tracked. Let's ignore merged branches for the moment.

When you say "change set", I'm going to assume you mean "commit object".

Okay.  Now, the server hasn't heard of one or more of those commit
objects, because they're local changes.  What then?


Another issue is that a client with a nearly-full copy has to do a full
walk of its history to determine the depth count that it has.  That can
be more than 2500 commits down in the git repository, and worse in the
mozilla one.  It's actually pretty quick (git-show-branch --more=99999
will do it), but git normally tries to avoid full traversals like the
plague 

Oh, and was "for the moment" supposed to last past the end of your e-mail?
I don't see what to do if there's a merge in the history and the depth
on different sides is not equal.  E.g. the history looks like:

...a---b---c---d---e---f
                  /     \
      ...w---x---y       HEAD
                        /
        ...p---q---r---s

Where "..." means that there are ancestors, but they're missing.

> If you haven't updated for six months when the server walks backwards
> for 10 change sets it's not going to find anything you have locally.
> When this situation is encountered the server needs to generate a
> delta just for you between one of the change sets it knows you have
> and one of the 10 change sets you want. By generating this one-off
> delta it lets you avoid the need to fetch all of the objects back to a
> common branch ancestor. The delta functions as a jump over the
> intervening space.

Your choice of words keeps giving me the impression that you believe
that a "change set" is a monolithic object that includes all the changes
made to all the files.  It's neither monolithic nor composed of changes.
A commit objects consists soley of metadata, and contains a pointer to
a tree object, which points recursively to the entire project state at
the time of the commit.

There is massive sharing of component objects between successive
commits, but they are NOT stored as deltas relative to one another.

The pack-forming heuristics tend to achieve that effect, but it is not
guaranteed or required by design.

Please understand that, deep in your bones: git is based on snapshots,
not deltas.


But okay, so we've sent the client the latest 10 commits, with a dangling
tail at the bottom.  (The files may have been sent as deltas against the
old state, or just fresh compressed copies, but that doesn't matter.)
Then the heads like "origin" have been advanced.

So the old commit history is now unreferenced garbage; nothing points
to it, and it will be deleted next time git-prune is run.  Is that
the intended behavior?  Or should updates to an existing clone always
complete the connections?
