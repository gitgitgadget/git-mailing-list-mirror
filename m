From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/POC 3/7] setup.c: add split-repo support to .git files
Date: Fri, 13 Dec 2013 12:43:48 -0800
Message-ID: <20131213204348.GX2311@google.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1386771333-32574-4-git-send-email-pclouds@gmail.com>
 <xmqqiousr4bg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 21:43:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrZaX-0003Sr-4o
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 21:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab3LMUnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 15:43:53 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:52979 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab3LMUnw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 15:43:52 -0500
Received: by mail-yh0-f41.google.com with SMTP id f11so1978104yha.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2013 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FRPAH8Pqx76Q+c0qBv+eKcFIQCIS7WXHtkAqtC4iEYo=;
        b=ZtD5yjXWD2lZRdSkHYZgODNKiLd052eWtHq+IINIw5zaNUTuAzKbjrkP42dbuqi2zd
         Vg+BGiwT7jGEfCWEeG5ky6LNZ4PudpbKi95925K9tvb33Oi3GqFzsaR7mXgVKC7IhI3N
         ByxqK4SntfyGwKAESkH7ggoxTyFsp4eRGxqMhQxQVfUouf1ozWEyNk/fmPA8afxv5U5x
         fs9AAupYqekov5kAqzsw5I0kYubWksyjJHAxSs7fyq7xBpIzpGeHJLIC5nGLB2zU5aXF
         sCR/1m6i9U4Xxh1lt02/LwKJ5odHGjcT1j/aDiTXEfxcNSw0DcfRGoMX/aBU7BDov9ZZ
         29Wg==
X-Received: by 10.236.228.137 with SMTP id f9mr4188370yhq.44.1386967432025;
        Fri, 13 Dec 2013 12:43:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w45sm5029107yhk.4.2013.12.13.12.43.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Dec 2013 12:43:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqiousr4bg.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239265>

Junio C Hamano wrote:

>  - Do we want to record where the working tree directory is in
>    $GIT_SUPER_DIR/repos/<id> somewhere?  Would it help to have such
>    a record?

That could be nice for the purpose of garbage collecting them.  I fear
that for users it is too tempting to remove a worktree with "rm -rf"
without considering the relationship from the parent repo that might
be making walking through all reflogs slower or holding on to objects
no one cares about any more.

I imagine it would work like this:

 1. At worktree creation time, full path to the working tree directory
    is stored in $GIT_SUPER_DIR/repos/<id>.

 2. "git gc" notices that the worktree is missing and writes a file
    under $GIT_SUPER_DIR/repos/<id> with a timestamp, saying so.

 3. If the worktree still hasn't existed for a month, "git gc" deletes
    the corresponding $GIT_SUPER_DIR/repos/<id> directory.

Problems:

 * What if I move my worktree with "mv"?  Then I still need the
   corresponding $GIT_SUPER_DIR/repos/<id> directory, and nobody told
   the GIT_SUPER_DIR about it.

 * What if my worktree is on removable media (think "network
   filesystem") and has just been temporarily unmounted instead of
   deleted?

So maybe it would be nicer to:

  i. When the worktree is on the same filesystem, keep a *hard link* to
     some file in the worktree (e.g., the .git file).  If the link count
     goes down, it is safe to remove the $GIT_SUPER_DIR/repos/<id>
     directory.

 ii. When the worktree is on another filesystem, always keep
     $GIT_SUPER_DIR/repos/<id> unless the user decides to manually
     remove it.  Provide documentation or a command to list basic
     information about $GIT_SUPER_DIR/repos directories (path to
     worktree, what branch they're on, etc).

(i) doesn't require any futureproofing.  As soon as someone wants it,
they can implement the check and fall back to (ii) for worktrees
without the magic hard link.

(ii) would benefit from recording the working tree directory as a
possibly unreliable, human-friendly reminder.

>  - How would this interact with core.worktree in .git/config of that
>    "super" repository?

Eek.

Thanks,
Jonathan
