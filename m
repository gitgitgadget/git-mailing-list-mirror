From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH 0/3] Towards a Git-to-SVN bridge
Date: Sat, 15 Jan 2011 13:13:29 +0530
Message-ID: <20110115074327.GA9277@kytes>
References: <1295074272-19559-1-git-send-email-artagnon@gmail.com>
 <20110115072211.GB25253@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 15 08:42:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pe0md-0003Sy-4x
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 08:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab1AOHmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 02:42:42 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40331 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1AOHml (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 02:42:41 -0500
Received: by iwn9 with SMTP id 9so3225104iwn.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 23:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7wKLcT87SPYQDJG0uNhbE00RuUuHDcZPKOM/3wxqzPI=;
        b=dcYT0pL94AbeDyTOGmP7mNr3SnkTdAGFBsTORt+f/pLWxQJ129RNwLe6PISjuDX1+7
         E+o7iRodtSK0RpB7pP6GKWdR1b8E5JbDrsMOsqS902eM2uHkheG4SOmZwE9xTdKjqkXw
         mroYX5qeGd4l5gQ4vARTdDtfZ0GpcOcUsjhek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=f/liSuIfv86VKZfvsXmM1AG6VwgSzyIgmvb5LcvIE7cgYNkUxkd1NCZGQYyb5y+TFJ
         x4RbyZCQuxakNkLiuTMnCxl+6rvGGyzu35ogATgJH2rTxazIrrVKdhr5Ty8yAaShUvIE
         I1q5pmrJhX7fJ0aWNxv66B6ZCdZwNJj8VwSnk=
Received: by 10.231.208.8 with SMTP id ga8mr1712193ibb.1.1295077360829;
        Fri, 14 Jan 2011 23:42:40 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 34sm1694722ibi.8.2011.01.14.23.42.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 23:42:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110115072211.GB25253@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165143>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > Over the last couple of days, I've been working on a parser that
> > converts a fast-import stream into a SVN dumpfile. So far, it's very
> > rough and works minimally for some common fast-import
> > commands.
> 
> Some early questions:

Thanks for raising these questions. People interested in the project
should find this useful.

>  - what are the design goals?  Is this meant to be super fast?
>    Robust?  Simple?  Why should I be excited about it?[1]

I want it to be a lot like current svn-fe: as you can see, I've
re-used many parsing ideas from it. It has to be atleast as fast as
svnrdump, because I don't want it to bottleneck in the remote helper
pipeline. It has to be simple because it'll give rise to other simple
remote helpers- all the complexity has to be offloaded onto the lower
layers like fast-import/ fast-export, and not onto the developer of
the remote helper.

>  - what subset of fast-import commands is supported?  Is it well
>    enough defined to make a manpage?

Currently, it supports just "commit", "blob", "author", "committer"
and "mark" that appear after a blob. It should support more commands
soon enough- this implementation is just a proof of concept. Also,
Instead of giving it the ability to parse /any/ valid fast-import
stream, I want to simply focus on parsing the stream produced by git
fast-export. That should explain why I'm trying to patch git
fast-export primarily.

>  - does this produce v2 or v3 dumpfiles?

This is one issue I haven't thought about fully yet. I'm currently
thinking of generating a non-deltified dumpfile v3 -- something that
svnrdump will accept. Generating deltas might be an unnecessary
overhead- but as you pointed out yesterday, that clearly needs more
thought.

>  - why would I use this instead of git2svn?  Does git2svn do anything
>    this will not eventually be able to do?  (Not a trick question ---
>    I don't have enough experience with git2svn to tell its strengths
>    and weaknesses.)

git2svn persists blobs in-memory. It's written in Perl and it's
slow. I thought we needed something nicer to be used with a remote
helper, and started writing svn-fi.

> > I've decided to try re-implementing fast-export
> > to eliminate blob marks
> 
> Hopefully "re-implement" means "patch" here. :)

Yep. Just a big one :)

> I can comment on the code but it's probably better if I have a sense
> of the design first (in any event, thanks for sending it).

I haven't had time to clean up the code. Note that it "just works" at
the moment- yes, it's already very very fast :) However, I'm going to
stall the branch and work on fast-export-inline for now.

-- Ram
