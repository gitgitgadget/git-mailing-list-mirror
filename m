From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Mon, 2 Apr 2012 15:57:00 -0500
Message-ID: <20120402205659.GA13725@burratino>
References: <11292500.AVmZFUUvNi@flobuntu>
 <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com>
 <2148933.pnpYo0xMAP@flomedio>
 <2487557.B8qfnaixh3@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner@student.tugraz.at>
X-From: git-owner@vger.kernel.org Mon Apr 02 22:57:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEoJT-0000eK-Pr
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 22:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab2DBU5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 16:57:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58279 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab2DBU5O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 16:57:14 -0400
Received: by iagz16 with SMTP id z16so4598493iag.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5h87pZlSKPK4lu0FZraf1sw4I9gGth8J8pe92IBmn5E=;
        b=Zt8dWJS9tyiHd65CeDC2pQaAtqOt7DHUEdqvtY7rPgI7gyZxIUOrdHXZ50mywA2XJU
         zmz3LmppD3idbEJsSxISIJ3lCeB2R/FahqcdHuE6Yfm5XUhua76T7VhEXckp5duyCFik
         WBS3BI7SIyGybzzt8EeJNePSH5U37XHmcbXlA56Lnzbqu8CS7Oj1JrxrW2Jc2zrnNfJT
         jCO36jxTMEywQ8j9qLBQ2lQW0tZkjN0oKFIvSXvRgm2xth6INRAuQDlGpGKEPMyVPXMV
         McT4NnhILDNRdBswx6L6QEBLgLU7VsqH1pjSQmw3GfhUQbtjDcqOxghOAmZvdD3yrmkt
         PMIQ==
Received: by 10.50.183.137 with SMTP id em9mr8072000igc.58.1333400233678;
        Mon, 02 Apr 2012 13:57:13 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id kn3sm9430020igc.15.2012.04.02.13.57.12
        (version=SSLv3 cipher=OTHER);
        Mon, 02 Apr 2012 13:57:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2487557.B8qfnaixh3@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194561>

Hi Florian,

Florian Achleitner wrote:

> Here is my draft of the proposal for the GSoC project. RFC!
> Please comment and tell me what you think and if I understood it all right!

I like the rough idea.  I also agree with Ram that the scope seems too
wide for one summer and think it would be useful to narrow the scope a
little.

Some tasks I can think of:

 - getting Dmitry's importer into contrib/ and making sure it works
   reliably.  This might require some fixes to svnrdump, svn-fe,
   and the transport-helper.  Some known problems that I suspect may
   be still unresolved:

   - files marked with both svn:special (symlink) and svn:executable

   - dealing with after-the-fact edits to the svn repository.  For
     example, revprops including svn:log can be and often are changed
     after the fact.

   - what happens when the connection to the Subversion server is
     interrupted?  The Subversion dump format does not have an
     "end of commit" marker so currently we can get confused and
     seem to succeed.

   - svn-fe does not correctly handle revs that change a text file to
     a symlink or vice versa without changing its text.

 - UI for importing only some revisions (e.g., "all revisions after
   r1000").  Dmitry has a patch for the svn-fe plumbing to handle
   this but I don't think the corresponding change for the remote
   helper has been written.

   - this would probably also require changes to svnrdump.  What
     happens when r2000 involves copying a file from a version before
     r1000?  If imports do not start at r0, normal dumps of r1000:
     are not self-contained.

 - UI for storing the mapping between Subversion revision numbers and
   git commit names in the git object db somewhere.  Currently we
   store it in a marks file.  There is a script floating around to
   convert that marks file into a set of commit notes and Dmitry also
   has a patch for svn-fe to make it write commit notes directly.
   What happens when the notes and marks file go out of sync --- which
   is authoritative?

   This also implies that repeated fetches would not have to start
   importing again at r1.

 - Storing empty directories and path-specific properties like
   svn:ignore that we don't currently handle.

 - Splitting history into branches.

   Somehow svn-fe has to communicate "svn cp" source and target
   information to the branch mapper so we can trace history to before
   the birth of the paths we are following.  That is, the full history
   of branches/1.7.x/ includes the early history of trunk/ if the
   1.7.x branch was originally created as a copy of the trunk.

   This might be able to use mechanism similar to storage of
   empty directories and path properties.

 - UI for importing only a subset of paths (e.g., "just the trunk").

   - this would probably also require changes to svnrdump.  What
     happens when r2000 involves copying a file from a branch we
     have chosen not to import?

 - Mapping authorship information from Subversion (which usually
   amounts to a remote username) to something more idiomatic in git
   (usually a human's name and email address) in a way that makes
   round trips possible.

 - Sharing an imported repository with other users of the remote
   helper.

   - this might involve changes to the remote helper machinery to
     allow new clones to use some fetch/push ref specification
     different from refs/heads/*:refs/remotes/origin/*, or it might
     involve some change to core git to automatically push notes
     corresponding to some refs in some situations.

 - Importing <rev, path> pairs that have multiple parents.  In the
   subversion model, path nodes have only one (copyfrom) parent,
   but repositories can use the svn:mergeinfo property to indicate
   that changes made in certain revs to another patch have been
   incorporated.  Under what circumstances is that enough
   justification to add a second parent on the git side?

   - Because svn:mergeinfo is a normal path property, the branch
     mapper could have enough information to take care of this with
     the help of the previously mentioned facility for storing path
     properties.

All of the above is just for reasonable fetch support.

For push support, one early problem to solve would be that pushing
a commit so that the git commit id from re-importing it is the same
requires permission to set the svn:date property.  Is our target
audience one that already has that permission?  Is that permission
something reasonable for a committer to ask for from the repository
admin in order to use the remote helper?

Because of the above:

> 1. Write a new bi-directional remote helper in C. 

The word "new" makes me worried that you'd be throwing away whatever
work already exists. :)

[...]
> { Hmm.. so it looks like thats a lot? what do you think? }

I agree --- what you've described is more than one summer's worth
of work.  Are there any aspects you're particularly interested in
focusing on?  For example,

 (1) If we focus on repositories without any branching structure at
     all and where the user has full ability to write whatever she
     pleases to the repository, I think developing a bidirectional
     remote helper is feasible during the summer.  Round-trip
     support (i.e., commit ids staying the same with a push followed
     by a fetch) is feasible with such a quick plan if we're willing
     to store some git-specific junk in the repo.

 (2) Regarding a tool that sits between svn-fe and the remote helper
     and implements the "follow parent" rule for tracing the full
     history of a single (linear) branch: I think developing that
     _and_ getting it merged could fit in the summer.

 (3) Regarding storing and sharing Subversion's path-specific
     and revision-specific properties: I think implementing a
     mechanism for that and getting it merged could fit in one
     summer.

 (4) Regarding getting git weirdness like distinct author and
     committer names, lack of rename information cooked at commit
     time, and timezones in author and committer dates handled during
     pushes to Subversion in a non-invasive way that is user-friendly
     for the pusher likely to be acceptable on the receiving side for
     normal projects: that could certainly fill a summer.

 (5) Subversion weirdness like revs that change the entire repository
     at once in a many-branch repo, non-standard file modes, and
     noticing and acting appropriately for svn:log messages that were
     changed after the fact could fill another summer.

So ideally I would like 5 students working on the remote helper
project. ;-)

Hope that helps,
Jonathan
