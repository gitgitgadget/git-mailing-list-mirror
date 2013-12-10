From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Setting file timestamps to commit time (git-checkout)
Date: Tue, 10 Dec 2013 17:34:17 +0700
Message-ID: <CACsJy8Bsgfh=0mTHY4kFAXE6+y7ODx5AwVHcLzVgz01Biiy=7A@mail.gmail.com>
References: <20131209112528.GA5309@linux.vnet.ibm.com> <20131209204815.GV29959@google.com>
 <20131210084622.GC4087@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 10 11:34:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqKeS-0003EQ-HT
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 11:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab3LJKet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 05:34:49 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:53193 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab3LJKer (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 05:34:47 -0500
Received: by mail-qc0-f174.google.com with SMTP id n7so3580568qcx.5
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 02:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=gmlmU672No4k+pMdHHBl6BrEAIwQ3JGkE+GtBszJQa0=;
        b=st/pgvvOHjpnGMRzY++3X3qyhMkxduXai898IAe2ywCcpza1Mp5KOQ94ZRjFH4CShh
         jZUEM/IJal4PTb08q4Y9n96bFJ82bYlSPK3zfPNjH+zeuwZaAZDkV79XBwIHcq7fLjBn
         z7FN5IpUgujSwNi7xI4jgeVqV2CCLPZZ7jCNyCfEZoJ4p7BFyGII8lTCk4y48/nd6yau
         Mq/zN8LQjbR8yxzT86h1XnfsXrAZtGbvvVjtdvfR/8Djoq5ZzLtyOa1tvZACUMj2FLZv
         HZEMKG9H90mHWBG1zze7iOVsk8iCLWMxYWZJx/aVh2Zxvh4Njq7tqPiAr6oJ4I2Tcxsd
         sy4g==
X-Received: by 10.229.105.9 with SMTP id r9mr41537690qco.12.1386671687103;
 Tue, 10 Dec 2013 02:34:47 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Tue, 10 Dec 2013 02:34:17 -0800 (PST)
In-Reply-To: <20131210084622.GC4087@linux.vnet.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239132>

On Tue, Dec 10, 2013 at 3:46 PM, Dominik Vogt <vogt@linux.vnet.ibm.com> wrote:
>
> > I suspect the simplest way to accomplish what you're looking for would
> > be to keep separate worktrees for each branch you regularly build.
> > It's possible to do that using entirely independent clones, clones
> > sharing some objects (using "git clone --shared" from some master
> > copy), or even multiple worktrees for the same clone (using the
> > git-new-workdir script from contrib/workdir/).
>
> I've tried the first two ways for separate workdirs in the past
> but did not like them.  How does git-new-workdir cope with
> rebasing (e.g. you have the same branch checked out in two working
> trees and "rebase -i" it in one of them)?  Is it really a working
> option?

I wonder if we could promote multiple worktree from a hack to a
supported feature. What I have in mind is when you "clone
--separate-worktree" it would create a .git file that describes
separate worktree:

gitbasedir: /path/to/the/original/.git
name: foo

HEAD, index and logs/HEAD would be stored in
/path/to/the/original/.git/worktrees/foo/. GIT_DIR would be set to
.../foo/, GIT_OBJECT_DIRECTORY, the new GIT_REF_DIRECTORY (which
covers root for all refs/, logs/ and packed-refs) and maybe
GIT_HOOKS_DIRECTORY are pointed to directories in
.../original/.git/... though.

This allows all worktrees to be aware of the others and locking could
be implemented so that no two worktrees check out the same branch (or
they can, but the other becomes detached if the ref is updated in this
worktree)..
-- 
Duy
