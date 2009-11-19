From: Tommy Wang <subscription@august8.net>
Subject: Default history simplification
Date: Thu, 19 Nov 2009 17:30:43 -0600
Message-ID: <ae09c2a40911191530y626dd035q90de0212e0b4b6d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 20 00:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBGSg-0005wi-5e
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 00:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbZKSXaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 18:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757028AbZKSXai
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 18:30:38 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:61423 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbZKSXai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 18:30:38 -0500
Received: by fxm21 with SMTP id 21so3039990fxm.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 15:30:43 -0800 (PST)
Received: by 10.239.183.37 with SMTP id s37mr75284hbg.90.1258673443263; Thu, 
	19 Nov 2009 15:30:43 -0800 (PST)
X-Google-Sender-Auth: db8d21e1883beef0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133268>

Hi all,

I'm working on a small perl script that needs to reproduce the results
of the default git history simplification used by log & rev-list when
a list of paths is given.  It is important that I reproduce its
results exactly.  I would love to simply use the rev-list built-in to
do my work for me; but I fear that I may have much too many path
limiters than the linux command-line can handle (which if I'm correct,
can only take so many arguments).

I can understand whether a commit is included or not rather easily: we
basically only include a commit iff the commit introduces a change to
the given path (ie, it is !TREESAME to any of its parents).

For merges, I get a little confused.  In the simple case of a 2-parent
merge, if we find that we are TREESAME with one parent -- it follows
that the interesting change must have come from that parent.  So we
follow it, and can safely assume that the other parent is
uninteresting.

If we find that we are TREESAME with both parents, it follows that
neither parent nor the merge commit is interesting.  Therefore, we
randomly pick the first parent and move up the graph looking for an
interesting commit.  Looking at this more closely, the parents we
ignored will fall under three scenarios:

1. It finds it way all the way up to a root commit without finding an
interesting commit -- which can happen if your repository has multiple
root commits.
2. It will move up the graph and eventually find a common ancestor
with the first parent.
3. It will find an interesting commit that has an identical/equivalent
commit somewhere in the first parent's ancestry.

In all 3 cases, it is safe to follow just the first TREESAME parent.
It is interesting to note that if are working with a repository with
multiple root commits (say, you imported a project without history,
and later merged in its upstream history), you could potentially lose
that history with this algorithm if you happened to merge it as the
second parent.  This is not necessarily a flaw (in fact, it may be a
feature!), since you have still fully explained the state of your HEAD
with respect to the first parent (which is probably your mainline).

In the case that neither parent was TREESAME, we can have 2 scenarios:

1. The merge commit itself made the interesting change.
2. The interesting changes came from both parents, in which we would
rightfully follow both parents.

My first question is this:

If the merge commit itself (D) made the interesting change, we could
potentially follow an uninteresting parent -- most likely all the way
up until we find a common ancestor (A).  This would produce a graph
that looks like:

A---B---D
 \-------/ (C pruned)

Or, if both parents were uninteresting:

A---D (both B & C pruned)
 \---/

I assume that the simplification takes care of this by removing
duplicate parents as well as searching for common ancestors?  (It is
not mentioned in the documentation).

My second question is then:

Given that we perform an extra simplification pass to remove common
ancestors and duplicate parents, what is the purpose of selectively
following parents?  Is it just for speed?  If we always followed all
parents and applied our duplicate simplification and common ancestor
simplification, we would not always arrive at the same result?  In
which case, if my application is not concerned with speed (ie, I don't
mind following all parents), would I always arrive at the same graph?

Thanks,

Tommy
