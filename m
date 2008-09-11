From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 09:55:39 +0200
Message-ID: <20080911075539.GA27089@cuci.nl>
References: <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl> <20080910151015.GA8869@coredump.intra.peff.net> <20080910215045.GA22739@cuci.nl> <20080910215410.GA24432@coredump.intra.peff.net> <20080910223427.GB22739@cuci.nl> <20080910225518.GA24534@coredump.intra.peff.net> <20080910231900.GF22739@cuci.nl> <48C8A9A4.7030906@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Theodore Tso <tytso@MIT.EDU>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 09:58:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdh2n-0002ng-SM
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 09:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbYIKHzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 03:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbYIKHzl
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 03:55:41 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:48763 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbYIKHzk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 03:55:40 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 4F9365465; Thu, 11 Sep 2008 09:55:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C8A9A4.7030906@gnu.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95589>

Paolo Bonzini wrote:
>> Being able to subvert the authenticity of git blame by providing fake
>> origin information is not very appealing.

>You could use a dummy submodule to ensure that each commit pointed to
>the right set of notes.  It would force to create a separate commit
>whenever you modified the notes, which is actually not bad.

Possibly, yes.  But we'd have to be careful not to incur too much
overhead because every indirection will cost, especially since the
origin link sometimes is checked for on every commit during a treewalk.
The fact that it rarely exists means that it should be fast to find out
that there are no origin links (which obviously is the common case).

>Alternatively, the header of the commit can be modified to add a pointer
>to a tree object for the notes; I suppose this is more palatable than
>the origin link.

This won't work for the original notes concept, because it makes the
notes immutable after commit.  For the origin links this would be fine,
since they don't change once committed.
The problem with fitting the origin links in the notes is twofold:
- They become mutable, which is undesirable, I'd like to preserve
  history as is (just like parent links).
- There is a performance hit, since origin links need to be found not to
  exist on every commit (sometimes, depending on the operation of course).

>  The tree could be organized in directories+blobs like
>..git/objects to speed up the lookup.

Yes, that was already in the latest proposal for notes, I believe.

>I actually like the commit notes idea, but then I wonder: why are the
>author and committer part of the commit object?  How does the plumbing
>use them?  Isn't that metadata that could live in the "notes"?  And so,

It would fit with a non-mutable version of the notes.  Then again, we
already *have* the non-mutable version of the notes, it's called the
header of the commit message.

>why should the origin link have less privileges?

They both belong in the non-mutable notes, and those happen to live in
the header of the commit (which *is* the most efficient spot, of course).
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
