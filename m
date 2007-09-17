From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 15:16:54 +0200
Message-ID: <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com>
References: <11900314321506-git-send-email-hjemli@gmail.com>
	 <46EE7584.8010202@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXGTk-0005xp-Bp
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 15:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbXIQNRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 09:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbXIQNRC
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 09:17:02 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:22039 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbXIQNRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 09:17:00 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2028409wah
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ujJISepGa3qoVhSUEGmTZsLmWg4AeECdkmCgke8YT+A=;
        b=OrDbjFWrrJnuTZCk1iJ30k/hejTK/i7S4qtd/6E0TkzKWBdITJsg+EK3hYChxNS+/Q3dUBRzfWPqVzxoe5CWexSBS5Fm9JW8FS5sym87ZJF4GUM+tWN5gO6UJUbs3KEw0sCy7O4vwdW2HAq41KroQ/LkncVk6WwsZfq4KaDLSs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E5V68h2uUyip+QBjh36YAcuooeJHY50AKyDpiaYe1dyCWXtYN8sMUfr+noH5dhbtSxqmCN/zkcNzga430fkfGKu5z8exN35DybQc1P2NFE9+/m127qwiqyKJDdt9OCAgFh7h143w64F/6ppKDP/8SN4ffqk4e8QzVmqHdCHwxPE=
Received: by 10.114.92.2 with SMTP id p2mr2833371wab.1190035019924;
        Mon, 17 Sep 2007 06:16:59 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Mon, 17 Sep 2007 06:16:54 -0700 (PDT)
In-Reply-To: <46EE7584.8010202@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58438>

On 9/17/07, Andreas Ericsson <ae@op5.se> wrote:
> Lars Hjemli wrote:
> > This new option forces all merges to create a "true" merge commit, i.e. a
> > commit with multiple parents.
> >
> > Although a fast-forward would normally be The Right Thing, it isn't when the
> > branches to be merged originated in subversion and the merge commit will
> > be pushed back by means of 'git svn dcommit'. In these cases, a fast-
> > forward merge simply will not work.
> >
> >       If there is no `-s` option, a built-in list of strategies
> >       is used instead (`git-merge-recursive` when merging a single
> >       head, `git-merge-octopus` otherwise).
> > +
> > +--no-ff::
> > +     Force the creation of a merge commit even when the merge would
> > +     have resolved as a fast-forward operation.
>
> + Although a fast-forward would normally be The Right Thing, it isn't when the
> + branches to be merged originated in subversion and the merge commit will
> + be pushed back by means of 'git svn dcommit'. In these cases, a fast-
> + forward merge simply will not work.
>
> Otherwise someone will sit down and try to figure out why this is necessary.

True.

> I'm having trouble understanding why this is needed, but I'll take your word
> for it ;-)

I'll try to explain:

When 'git-svn dcommit' decides which commits it should push back
subversion, it scans the output from 'git-log --first-parent HEAD'
looking for embedded 'git-svn-id' lines. These lines contain the url
of the upstream subversion repository + the subversion revision
number. So the problem with fast-forward merges of subversion branches
is that the output from 'git-log --first-parent HEAD' will show
commits from the wrong subversion branch (the fast-forwarded commits).

This could maybe be fixed in git-svn if it learned a different way of
discovering the upstream subversion branch, but then it would make
git-svn commit n revisions to subversion (again, the fast-forwarded
commits) instead of a single merge-commit. This would look (in
subversion) like a series of n cherry-picks from the merged branch.

Btw: maybe the --no-ff section in merge-options.txt could just link to
git-svn.txt, which in turn could have some lengthy explanation about
merge --no-ff/dcommit behaviour?

--
larsh
