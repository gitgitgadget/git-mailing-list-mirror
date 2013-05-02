From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Thu, 2 May 2013 02:49:26 +0000
Message-ID: <20130502024926.GA12172@dcvr.yhbt.net>
References: <1438528085.20130501090926@gmail.com>
 <1409591910.20130501123153@gmail.com>
 <7vhaim8w48.fsf@alter.siamese.dyndns.org>
 <455264907.20130501235104@gmail.com>
 <20130501213031.GA13056@dcvr.yhbt.net>
 <7v1u9q5pu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Basin <basinilya@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 04:49:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXjaO-0004MV-Gn
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 04:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994Ab3EBCt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 22:49:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54322 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758853Ab3EBCt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 22:49:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A331F1F42E;
	Thu,  2 May 2013 02:49:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v1u9q5pu5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223176>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > Ilya Basin <basinilya@gmail.com> wrote:
> >> JCH> comment line "# added by git-svn only to keep the directory" and
> >> JCH> consider a directory that has nothing but .gitignore that consists
> >> JCH> of only that exact comment line an "added placeholder" directory to
> >> JCH> work it around.
> >> Sounds good, but it's not I who decided to use the config file.
> >
> > Ugh, I didn't review Ray's original commit closely enough to notice
> > this :x
> >
> > Perhaps we should migrate users to use YAML storage for this, instead
> > (we already use YAML for Git::SVN::Memoize::YAML).
> 
> But does it solve the impedance mismatch between "per tree"
> information and "per project" information?  Unless you key the
> information not just with path but also with revision or tree object
> name, use of YAML vs config would not make a difference in the
> semantics, I am afraid.

No it doesn't solve the impedance mismatch, but the YAML project would
be more flexible than the git config file.

> I am reading the placeholder-added flag as: "This .gitignore file
> does not exist in the Subversion original; it is there only so that
> we can keep the otherwise empty diretory in the checkout, and it
> should not be pushed back to the Subversion side".  Am I mistaken?

You're right, I had forgotten this feature completely :x

> That however is not a property of the directory containing it (or
> the path to that .gitignore file) that is valid throughout the
> history of the project.  It is a property of a specific tree object
> (or you could say it is a property of the revision).  When at some
> point in the history the upstream project adds .gitignore there
> because many people use git-svn to contribute to their project, it
> stops to be "should not be pushed back".
> 
> So it seems to me that the information this "placeholder added"
> thing wants to express belongs to the tree object (and .gitignore
> file itself is a natural place to have that information).

Perhaps that was the better way to go...

How would (the presumably few) existing users of this feature be
affected?

Currently with the config file, there are problems with interop between
git-svn users that do git <-> git repo sharing, an updated version with
the "placeholder added" .gitignore would allow git <-> git repo sharing,
but only between users of newer git versions.  Perhaps that's fine and
better than the current situation.
