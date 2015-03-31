From: Mike Hommey <mh@glandium.org>
Subject: Re: Allowing weak references to blobs and strong references to
 commits
Date: Wed, 1 Apr 2015 07:39:19 +0900
Message-ID: <20150331223919.GA24362@glandium.org>
References: <20150331100756.GA13377@glandium.org>
 <xmqq8uecrk5g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:39:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4om-00020G-DP
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbbCaWj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 18:39:28 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:43277 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbbCaWj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 18:39:26 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1Yd4oZ-00080R-HN; Wed, 01 Apr 2015 07:39:19 +0900
Content-Disposition: inline
In-Reply-To: <xmqq8uecrk5g.fsf@gitster.dls.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266574>

On Tue, Mar 31, 2015 at 01:23:23PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > So I thought, since commits are already allowed in tree objects, for
> > submodules, why not add a bit to the mode that would tell git that
> > those commit object references are meant to always be there aka strong
> > reference, as opposed to the current weak references for submodules.
> 
> Unless you are recording the paths to these "commits" to be
> potentially checked out on the filesystem, do not put them in a
> "tree".  The entries in a tree object represent "This thing go to
> this path in the working tree".
> 
> It is not clear to me (and because you said "I won't bother you with
> all the whys and hows", I am guessing that it is OK for readers to
> be unclear), but I think you only want to make sure "git fetch" and
> "git push" transfers these objects, the graph formed by which is
> *not* any part of the main history of the project.

Transfer is not the main reason I have those refs, although it's a nice
plus. I'm using the git database as a storage for metadata I need to
keep track of the remote mercurial content that isn't part of the
content history represented in the corresponding git history. Obviously,
this isn't meant to be checked out, like a notes tree. The refs are only
there so that a) git-cinnabar can find its data and b) git gc doesn't
remove it.

> It is perfectly OK to represent these objects as a special purpose
> history and have a ref point at its tip.  The "notes" database is
> represented that way, for example.

Indeed, the notes database is in a similar situation. But the fact that
in my use-case (cloning Mozilla mercurial repositories) _thousands_ of
refs are involved is not really making it user-friendly. I'd rather hide
those away from users.

> And I do not see anything wrong to use octopus merges in the history
> if you want to represent "here are the commit objects that I care
> about at this point in the 'special purpose' history (not the main
> history)".

Octopus merges are limited to 16 parents. That means to merge thousands
of refs, I need to do that on at least 3 levels, involving hundreds of
commit objects, many of which would become loose quickly, or become
extra noise in the "metadata" "branches"... and while researching this
further, I realize it doesn't seem there is such a limit to the number
of parents for octopus merges. Where did I get that from? Was there such
a limit in the past or was I high?

That being said, having names associated with those tips _is_ useful to
me (it allows to know the corresponding mercurial sha1 and branch
without having to do a note lookup for each), and a tree of commits
would help, here, although I could put a tree of weak refs to commits
as the content of an octopus merge...

So I guess I could live without the strong commit refs. Weak blob refs
would still be useful, though.

Mike
