From: "Chris Lee" <clee@kde.org>
Subject: Re: Simple UI question...
Date: Sun, 7 Jan 2007 03:21:56 -0800
Message-ID: <204011cb0701070321w18942a3w7fb4f7ecd26fc457@mail.gmail.com>
References: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
	 <20070107111305.GD10351@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 12:22:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3W6B-0002R9-Ua
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbXAGLV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbXAGLV5
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:21:57 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:8123 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbXAGLV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:21:56 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7675352wxd
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 03:21:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=no53lqyKuYixRNVDG8AP14OccPJALnkNNuPd/jSPxFLk2744xSnhnJNTCI4jRyH1KqIXuvtJpT30q0WZtGLbeRg/VwgiK1Tdx7jQ3WF98e4m2XBxrlQFI1hsq2iCbIrN6sjoBjLH2LO6w4dcNP2PICbDcqHi4q1hHgscNwYxQug=
Received: by 10.90.63.16 with SMTP id l16mr1611397aga.1168168916169;
        Sun, 07 Jan 2007 03:21:56 -0800 (PST)
Received: by 10.90.81.19 with HTTP; Sun, 7 Jan 2007 03:21:56 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070107111305.GD10351@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 338870acdac0ab87
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36159>

On 1/7/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Chris Lee <clee@kde.org> wrote:
> > So I'm trying to figure out the best way to pull out a checkout of the
> > entire tree as of a given revision ID. I have a whole bunch of
> > revision IDs, and I'd like to know what the git equivalent of (say)
> > the following is:
> >
> > svn co -r280600 file:///path/to/svn/repo
> >
> > For the sake of argument, let's say that r280600 imported as
> > 07058310db903317faa300b93004a5a2e0fc2dcc into my git tree.
> >
> > How do I get a pristine checkout in my working copy of the entire tree
> > as the repository saw it at 07058310db903317faa300b93004a5a2e0fc2dcc?
>
> One way is:
>
>   git archive \
>     --format=tar \
>     07058310db903317faa300b93004a5a2e0fc2dcc \
>     | (mkdir ../export; cd ../export; tar xf -)
>
> Would give you a new directory tree which is not related to any
> Git repository, but which contains the exact set of files in 070583.
> But that's probably not what you meant.
>
> > Eric Anholt suggested 'git checkout -b temporary-branch-name
> > $sha1sum';
>
> Yes, that is usually the way you do this.  Unlike the archive trick
> above the result will be in your current working directory and
> will be associated with the current Git repository.  Further you
> can modify this and commit changes if you need to.
>
> > davej suggested 'git-read-tree $sha1sum &&
> > git-checkout-index -a -f'
>
> That's just cruel.  Its only part of the underlying operations that
> git checkout is performing, and its trashing your current branch
> by making HEAD no longer match the index.  And its very low-level.
> And it doesn't really do a 2-way merge to fully update the working
> directory.  Not the best way for a user to perform this action.
> Forget davej ever suggested this.

Heh. He's going to kill me for continuing to drag his name throught he
mud. Anyway... :)

> > but for some reason, neither of these
> > commands seems to do exactly as I expect. davej's method seems to work
> > for some revision IDs, but not for others, and the other method seems
> > to work just about as well. (The problem I have seen is that, for some
> > revisions, the only files I get in the working copy are the files that
> > were changed in that commit; the rest of the files in the tree do not
> > get checked out.)
>
> The problem is davej's method doesn't take into account what the
> current working directory actually has stored in it.  It does not
> delete any files which should not appear in $sha1sum.  It also
> overwrites more files than it needs to, as it overwrites everything
> instead of just those files which actually differ between the
> current working directory and $sha1sum.

What I've been doing is 'rm -rf *' from the working directory and
trying the commands out; I don't want any empty folders or anything.

> Eric Anholt's version is the correct way to do it.  It is also very
> fast as it only has to modify the files which actually differed.

Eric's shows the same problem - for some revision IDs, when I do a
checkout, I only get the files that were changed in that revision.

> If Eric's version isn't always working then I'd have to suggest
> that you exmaine the output of `git status` for switching to
> some temporary branch based on $sha1sum.  Perhaps you have local
> modifications which are carrying over in your working directory?

I assume 'removing everything in the working tree' counts as "local
modifications"? :)
