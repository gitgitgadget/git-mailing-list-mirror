From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 13:30:30 -0400
Message-ID: <9e4733910709041030ye912369nd574a5f78d3f521b@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <Pine.LNX.4.64.0709041816340.29009@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:30:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IScEV-0001Dt-NZ
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942AbXIDRab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 13:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbXIDRab
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:30:31 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:43239 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbXIDRaa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 13:30:30 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1228434rvb
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 10:30:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ILT8JnxjfC4UO7xam9LVguXrFpFO+Gm2wdMOCU3U9suBwP/ynRhOGlUmBV/cqESx9sHUKvCcbx2P7qNbEzg8noZBXgFGyqzZKMyHQ1Ps3ka6mCXNzR2aIQ23oxeXSOUcIBpZ8wdkIGflyd+xItD6XZdaMYV4+jgb/PrWBnNNTmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H/VYyHm8fQm8KI0OT4fH+Qz3s7vstLqDBFBZ9mqWocCJ+SuAkFrWP36V9c58zCfxb6Da73sSb1/C/0FicepBgh9k8wCTdQjNa80dy60ICMxD3XhHxZVAMpPOXAnGLVK/r5t7EJEpShKQGFXKI4rP8ASbKfakVOMl3KtkqyHgRSg=
Received: by 10.141.20.7 with SMTP id x7mr2403115rvi.1188927030190;
        Tue, 04 Sep 2007 10:30:30 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Tue, 4 Sep 2007 10:30:29 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709041816340.29009@reaper.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57624>

On 9/4/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Tue, 4 Sep 2007, Jon Smirl wrote:
>
> > Let's back up a little bit from "Caclulating tree node".  What are the
> > elements of git's data structures?
> >
> > Right now we have an index structure (tree nodes) integrated in to a
> > base table. Integrating indexing into the data is not normally done in
> > a database. Doing a normalization analysis like this may expose flaws
> > in the way the data is structured. Of course we may also decide to
> > leave everything the way it is.
> >
> > What about the special status of a rename? In the current model we
> > effectively have three tables.
> >
> > commit - a set of all SHAs in the commit, previous commit, comment, author, etc
> > blob - a file, permissions, etc.
> > file names - name, SHA
> >
> > The file name table is encoded as an index and it has been
> > intermingled with the commit table.
> >
> > Looking at this from a set theory angle brings up the question, do we
> > really have three tables and file names are an independent variable
> > from the blobs, or should file names be an attribute of the blob?
>
> There isn't a one-to-one mapping of file names to blobs.  The blob only
> describes the contents of the file.  In the extreme case you could have
> one blob for every single file in your tree.  For example:
>
> # git ls-tree -r HEAD
> 100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    bar/foo
> 100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo
> 100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo2
> 100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo3
> 100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo4
> 100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo5
> 100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo6

Both schemes support aliasing. In the flat scheme you would create a
second blob which contains the file and the aliased path name. When
the blob gets delta'd the second copy of the file will disappear.

I'm not proposing a change to data being stored in git, it is a
proposal to consider the impacts of how this data has been normalized
in the data store.

> > How this gets structured in the db is an independent question about
> > how renames get detected on a commit. The current scheme for detecting
> > renames by comparing diffs is working fine. The question is, once we
> > detect a rename how should it be stored?
> >
> > Ignoring the performance impacts and looking at the problem from the
> > set theory view point, should:
> > the pathnames be in their own table with a row for each alias
> > the pathnames be stored as an attribute of the blob
> >
> > Both of these are the same information, we're just looking at how
> > things are normalized.
> >
> >
>
> --
> Julian
>
>   ---
> "You shouldn't make my toaster angry."
> -- Household security explained in "Johnny Quest"
>


-- 
Jon Smirl
jonsmirl@gmail.com
