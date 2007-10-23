From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 13:44:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710231131320.32497@iabervon.org>
References: <20071023012140.GC22997@thunk.org> <7vtzoi8voo.fsf@gitster.siamese.dyndns.org>
 <20071023020044.GA27132@thunk.org> <20071023040522.GX14735@spearce.org>
 <20071023043321.GC27132@thunk.org> <20071023044657.GC14735@spearce.org>
 <20071023045632.GD27132@thunk.org> <20071023050726.GD14735@spearce.org>
 <20071023053003.GE27132@thunk.org> <20071023054238.GE14735@spearce.org>
 <20071023120338.GG27132@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 23 19:45:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkNoF-0000uT-4L
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 19:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbXJWRoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 13:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbXJWRoi
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 13:44:38 -0400
Received: from iabervon.org ([66.92.72.58]:58730 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbXJWRoh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 13:44:37 -0400
Received: (qmail 24014 invoked by uid 1000); 23 Oct 2007 17:44:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Oct 2007 17:44:36 -0000
In-Reply-To: <20071023120338.GG27132@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62140>

I keep thinking that there should be a better mechanism to use for "pu" 
than a branch. Normally what you see in "pu" is a sequential merge of 
"next" and a number of topic branches, where the series of merges is 
either entirely uninteresting or only interesting in a schematic sense 
(that is, it is interesting what topics appear, and in what order, but the 
snapshot of each topic's head when it got merged isn't interesting).

That is, the work which "pu" consists of, and therefore the history is a 
sequence of steps, each of which is one or more of: "add this topic", 
"update this topic", "remove this topic", "update to a new next". And we 
don't keep a record of this history, but it's not what's discarded by 
rewinding anyway.

I think that, if we actually care about this sort of thing, we'd want to 
make "pu" a series of commits, each with the previous "pu" as the sole 
parent, with a series object given in a new header. The series object 
would start with a "next" commit, and then list the topics merged by name 
and head-as-merged. Of course, the "pu" commits would contain the 
resulting tree as normal, so that people without a git that understands 
this would see "pu" as consisting of a straight line of commits, each of 
which simply shows the net effect of the changes. Or something like that. 
I suppose "pu" could also be represented as a superproject where each 
subproject is "next" or a topic branch, if we really want to avoid 
introducing new objects, but that seems unweildy somehow.

Is this worth doing? It might be; I bet it would make debugging -mm a 
whole lot nicer. (First bisect through -mm to find the action Andrew took 
that accepted the breakage, then bisect the history within that action.) I 
bet the status quo is a real pain when the feature that broke is only in 
-mm and later in Andrew's list than the tree whose change triggered the 
failure (i.e., -mm4 works; -mm5 doesn't work, and everything in -mm5 is 
either broken or untestable).

And, of course, "origin/pu[db/builtin-fetch]" would be an easy thing to 
build into git, and it could even generate extra magic, where it knows 
what the topic was last rebased on, so git could lead people through 
"rebase everything in a pu collection on the new base for the collection"
and "make my local topic branch agree with my topic branch as present in 
origin/pu".

	-Daniel
*This .sig left intentionally blank*
