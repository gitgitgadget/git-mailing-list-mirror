From: Ulrich Spoerlein <uspoerlein@gmail.com>
Subject: Re: git-notes, how do they work?
Date: Sat, 12 May 2012 13:27:07 +0200
Message-ID: <20120512112707.GP71676@acme.spoerlein.net>
References: <20120512104332.GN71676@acme.spoerlein.net>
 <CACsJy8DRujbCc5Etod8eCoUW5+SxK-1qbJaAYw7gdvkO2SdSRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 13:27:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STAUF-0000yd-Ad
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 13:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab2ELL1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 07:27:34 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56932 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909Ab2ELL1K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 07:27:10 -0400
Received: by wgbdr13 with SMTP id dr13so3231407wgb.1
        for <git@vger.kernel.org>; Sat, 12 May 2012 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=75nXjFvRZs/PygoNzThywVVzXDWKWmLmm1fhLECg4Vw=;
        b=dCPa0LUByGnqL4FRRAUB2Qz7UOHmX1PHrc7aQe39mxof5E5/421zJ1F9Wt4ipUTNG2
         uzS/zqjJaFw0Gsih5Wr/+DNFVkNONQQSw6uRmBkn/6BNGp00z/jWDvAEyQkvvo/bupPD
         3w8aF0pt7TiBq0JKGt9FKzbpQocoxR9t1ubSkudqheuHZCMlpAaXvI1DFScWGmp74jgb
         LqZJeaIvkD5qRjNuASOeDs7qH7FLYyfI/68XtxZXjp1637tefHl3y2+HCxYnYGdpnBDK
         1NDgTpqRDiKUR0cQU006WBwJw52YCazT59R/o7Y9g61RRHAboAU0pL4VNqcUI2Kq8uJu
         ZTcQ==
Received: by 10.180.24.39 with SMTP id r7mr3681309wif.9.1336822028953;
        Sat, 12 May 2012 04:27:08 -0700 (PDT)
Received: from localhost (acme.spoerlein.net. [88.198.49.12])
        by mx.google.com with ESMTPS id k6sm18074541wiy.7.2012.05.12.04.27.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 May 2012 04:27:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8DRujbCc5Etod8eCoUW5+SxK-1qbJaAYw7gdvkO2SdSRw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197724>

On Sat, 2012-05-12 at 18:01:40 +0700, Nguyen Thai Ngoc Duy wrote:
> On Sat, May 12, 2012 at 5:43 PM, Ulrich Spoerlein <uspoerlein@gmail.com> wrote:
> > IIUC refs/notes/commits points to the latest note, which points to HEAD.
> > However, there's no reference that points to the note pointing to
> > HEAD^1, so how will it not be garbage collected?
> 
> No. refs/notes/commits points to a commit, whose tree contains all
> notes at the last time a note is changed. This commit has a parent
> commit that stores note snapshot of the previous change and so on..
> 
> refs/notes/commits is an ordinary ref, which is searched for
> reachability at gc time, so all notes (even replaced notes) cannot be
> deleted.

Cool, I believe this is then a bug with how svn2git works when it's
being restarted to do incremental conversions and have contacted the
author of that code.

> > How can it be pushed to a remote repository?
> 
> What I wrote about were my findings while I studied the notes code.
> I'm new to it too. And I believe there's no mechanism to transfer
> notes. Of course you can transfer resfs/notes/commits like any other
> refs, but the objects those notes are attached to might or might not
> exist at destination repo.

Pushing them to github works fine like this:

[remote "github"]
        url = github.com:freebsd/freebsd.git
        push = +refs/heads/master:refs/heads/master
        push = +refs/heads/release/*:refs/heads/release/*
        push = +refs/heads/releng/*:refs/heads/releng/*
        push = +refs/heads/stable/*:refs/heads/stable/*
        push = +refs/notes/*:refs/notes/*

And you will see them displayed in their web UI (at the bottom):

https://github.com/freebsd/freebsd/commit/4bef84bb40695b68a4ccdcec5f847b5a7a302864

But older commits are missing this, most likely because the notes were
clobbered before I pushed them, e.g.

https://github.com/freebsd/freebsd/commit/1e7688b79181301805cd4616daa42ae827d74e99#README


> > I understand that notes cannot point to older notes, as that would make
> > removing/adding notes from/to older commits quite a hassle.
> >
> > So, what am I doing wrong here? How can I avoid notes from disappearing
> > so that each and every one of it remains in the repo?
> -- 
> Duy
