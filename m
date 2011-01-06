From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: clone breaks replace
Date: Thu, 6 Jan 2011 15:33:38 -0600
Message-ID: <20110106213338.GA15325@burratino>
References: <4D262D68.2050804@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 22:33:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaxT4-0005Ig-Mo
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 22:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771Ab1AFVdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 16:33:53 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53555 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab1AFVdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 16:33:53 -0500
Received: by qwa26 with SMTP id 26so17194506qwa.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 13:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=o0xlXr7l3ZWlULyYuRfVEY1+n/v2dTCfTzwQBk/IIvA=;
        b=nG3F552Wc1E8UEUd8bYZa1yLGwTSPd6JLG1JnnFMGnVdiLdVt3W/yfkWzWlwxg9WYc
         xCiDGLjPqnKJ4sSUduGETtWpl5aXyrIZ6jGOSvGmbw+UuVgYRvfVpkGzYRh4DV70OX/0
         JQkeWxGghyQZfp3SbndWudQ3EJuW+uktCC7Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YgEKstQpBMtHKOQDFkfbT3yNi223UxuTgCifiFgOIcYWq2ICqtQ65VyJgJEdz0za6p
         F9qum0tBXE6mjEzDVQwb1Vfvj+1NWR9OQL95bVVZGQqh3mspg7hEYELJBFoP+XFTaehw
         udLEouUPnPmkh10S4cNerz/0BKWFY4RFo0B/4=
Received: by 10.224.11.145 with SMTP id t17mr24043863qat.54.1294349632137;
        Thu, 06 Jan 2011 13:33:52 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id t7sm13489701qcs.4.2011.01.06.13.33.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 13:33:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D262D68.2050804@cfl.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164675>

Phillip Susi wrote:

> I managed to
> correctly add a replace commit that truncates the history and contains
> instructions where you can find it, and running git log only goes back
> to the replacement commit, unless you add --no-replace-objects, which
> causes it to show the original full history.

Before I get to your real question: this seems a bit backwards.  Let
me say a few words about why.

In the days before replacement refs (and today, too), each commit
name described not only the state of a tree at a moment but the
history that led up to it.  In fact you can see this somewhat directly:
given two distinct commits A and B if you try

	$ git cat-file commit A >a.commit
	$ git cat-file commit B >b.commit
	$ diff -u a.commit b.commit

then you will see precisely what can make them different:

 - the author's name and email and the date of authorship
 - the committer's name and email and the date committed
 - the names of the parent commits, describing the history
 - the name of a tree, describing the content
 - the log message, including its encoding

The commit name is a hash of that information (see git-hash-object(1))
and an invariant maintained is "if a repository has access to commit A,
it has access to its parents, their parents, and so on".  This invariant
is maintained during object transfer and garbage collection and relied
on by object transfer and revision traversal.

The beauty of replacement refs is that they can be easily added or
removed without breaking this invariant.  And a replacement ref is an
actual reference into history, so garbage collection does not remove
those commits and the repository keeps enough information to traverse
both the modified and unmodified history.

Therefore if you want clients to be able to choose between a minimal
history and a larger one to save bandwidth, it has to work like this

 - to get the minimal history, fetch _without_ any replacement refs
 - to get the full history, fetch the replacement refs on top of that.

because an additional reference can only increase the number of
objects to be downloaded.

> The problem is that when I clone the repository, I expect the clone to
> contain only history up to the replacement record, and not the old
> history before that.  Instead, the clone contains only the full original
> history, and the replacement ref is not imported at all.  A git replace
> in the new clone shows nothing.
>
> Shouldn't clone copy .git/refs/replace?

With that in mind, I suspect the best way to achieve what you are
looking for is the following:

 1. Make a big, ugly history (branch "big").  Presumably this part's
    already done.

 2. Find the part you want to get rid of and make appropriate
    replacement refs so "gitk big" shows what you want it to.

 3. Use "git filter-branch" to make that history a reality (branch
    "simpler").  Remove the replacement refs.

 4. Use "git replace" to graft back on the pieces you cauterized.
    Publish the result.

 5. Perhaps also run and publish "git replace big simpler", so
    contributors of branches based against the old 'big' can merge
    your latest changes from 'simpler'.  Encourage contributors to
    use 'git rebase' or 'git filter-branch' to rebase their
    contributions against the new, simpler history.

Does that make sense?

Jonathan
