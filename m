From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [jgit] index v2 pull request
Date: Mon, 10 Mar 2008 20:35:26 -0400
Message-ID: <20080311003526.GM8410@spearce.org>
References: <20080308025027.GZ8410@spearce.org> <200803100051.55367.robin.rosenberg@dewire.com> <7bfdc29a0803100032q6b30f16el97c021f3b051b944@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	Dave Watson <dwatson@mimvista.com>
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 01:36:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYsTV-0001rS-7w
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 01:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbYCKAff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 20:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbYCKAff
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 20:35:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55552 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbYCKAfe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 20:35:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JYsSd-0004dF-TV; Mon, 10 Mar 2008 20:35:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D2FF020FBAE; Mon, 10 Mar 2008 20:35:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7bfdc29a0803100032q6b30f16el97c021f3b051b944@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76778>

Imran M Yousuf <imyousuf@gmail.com> wrote:
> I would like to volunteer to work in JGit;
> can someone let me know where I can pick some tasks to implement?

One of the areas that I think is really weak in JGit and that we
need to do a _good_ fetch/push implementation is the branch model.

For example, if you look at Repository.getBranches() it returns
to the caller a Collection<String>.

But in Git a branch is a heck of a lot more data, and that data is
relevant to the end user when we are talking about fetch and merge.
There are many configuration options stored in .git/config for a
branch, and these are (today) created by git-branch and git-checkout
automatically as the user creates and deletes branches.

JGit has none of this model.  It thinks all that a branch is is a
String.  Sad.

Another thing that bothers me is the packed refs cache.  We toss
away the peeled information (the "^" lines), but that data is very
useful when you are talking about fetch as well as a few other
types of operations, like plotting tag labels onto a history graph
(such as how gitk does it).

The Ref class was started as a means of wrapping up the various
important bits of data about a ref (of which branches are a subclass
and annotated tags with peeled data is another) but I suspect it
didn't quite do everything so these string APIs got created.

The above is a farily small task, one that any good OO programmer
should be able to tackle, but it can be challenging if you are
new to Git plumbing as you'll have to learn what are the important
parts of a branch/ref/annotated tag.

As a starting point look at the config file format in C Git and
see what is possible in a "branch" and "remote" section; that
data needs to be pretty readily available for any Ref, if such
data exists.  The backward mapping of Ref->Remote (which does
not exist yet, unless Robin created it) is quite relevant for
tracking branches.

-- 
Shawn.
