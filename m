From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: backups with git and inotify
Date: Mon, 10 Dec 2007 21:18:18 +0000
Message-ID: <e1dab3980712101318v264fcce5pebbb829d8cefb1ac@mail.gmail.com>
References: <20071210202911.GA14738@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Luciano Rocha" <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 22:18:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1q1U-0005Wl-Fb
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 22:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbXLJVSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 16:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbXLJVSU
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 16:18:20 -0500
Received: from el-out-1112.google.com ([209.85.162.181]:27464 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbXLJVST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 16:18:19 -0500
Received: by el-out-1112.google.com with SMTP id v27so327635ele
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 13:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tcFjp1WI2+jqkttKceu5DAntXVlZzrzHROHwgh1alnk=;
        b=XhqLuamt9YOB8N1s11FcZjqpgChHXVDd94GpXiIRTATA6r4A+XX8gHBhgYPoGl3s0o5EYgyFELkvh/9mxKRUFKpA+CWDDQ5m/lNiR7CPI3cSZAHhcLGM1KUsb7J/3x9NOA9XoAtuUKjICPtVhRLytZ3gxgYxC6zfQ5GhmHgOL0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MujUBQtWzAnwnaLr82+zCgIlvKQiEwqEDZvmXYl6UBsXIqfy1X+G8j+UkcF7QHX13LUAbWUUIAc8pEMGi6aeUKjdHOUYHNBr4u4HmyrutoMVx7OLGpGJqO9/yD3goxQ4GCqfsC5xJEEz01Fn0qf/1nn3rSn82GscyHnTiicoTKI=
Received: by 10.150.200.8 with SMTP id x8mr2466544ybf.1197321498127;
        Mon, 10 Dec 2007 13:18:18 -0800 (PST)
Received: by 10.150.53.15 with HTTP; Mon, 10 Dec 2007 13:18:18 -0800 (PST)
In-Reply-To: <20071210202911.GA14738@bit.office.eurotux.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67756>

Hi, looks interesting project.

I've been doing something similar-ish (but periodically rather than
upon changes). Here are some rough off-the-cuff observations (probably
telling you things you already know).

Firstly, are you doing backups (be able to restore to n previous
states upon catastrophe) or archives (being able to lookup arbitrary
points in history to compare with current stuff, eg, for regressions)?
(Archiving is useful if you aren't in a disciplined enough project to
do rewritten proper commits but still want to be able to look around
and try to figure out what's caused regressions, etc.)

The scripts I use are at

http://www.personal.rdg.ac.uk/~sis05dst/chronoversion.tgz

but they're designed around archiving rather than backups.

On Dec 10, 2007 8:29 PM, Luciano Rocha <luciano@eurotux.com> wrote:
> The following is a work in progress. There are some problems in how I'm
> using git and recording the history:
>
> 1. I use an opened fd for each monitored directory (and subdirectories),
>    (inotify_add_watch_at would be nice).
>    I fchdir(fd) when a change happens to register and commit it.

I thought about trying to have a daemon using inotify to record the
git-add's/git-rm's but keeping the cron driven actual commits, and
looked at python support module. I didn't because firstly I wasn't
sure how far inotify scaled (the fact the Linux VFS maintainer insists
on calling it "idiotify" doesn't inspire confidence). If it was me,
I'd pull the git-commit outside your loop that does the git-add/git-rm
(see later comment about emacs, etc). Obviously if your buffer isn't
completely emptied you'll get a misleading granularity of commits, but
then I guess that'll happen anyway. I think inotify drops events if an
internal queue fills: personally I'd try to check for that and
initiate manually scanning if I detected that happening.

> 2. git-rm dir/file also removes <dir> if file was the only entry of
>    <dir>. So, when committing the removal, git complains that it can't
>    find cwd. So I record the parent directory, do the git command, check
>    if getcwd() works, and if not do the commit in the parent directory.
>
> 3. git-rm (empty) directory fails
>
> 4. Changes aren't atomic, but I can live with that and I doubt I would
>    be able to make it atomic without implementing a filesystem (FUSE or
>    not).

With things like emacs that do update writes by writing a new file
with a temporary name and then copying it over the top of the old
file, you'll get presumably 3 commits. Is that acceptable?

> I can work around most of the problems, and rewrite to use recorded path
> names instead of directories fd, but before I do that, and while I'm
> at the beginning, I'd like to probe for opinions and suggestions.

The only other thing that occurs to me is whether you need any greater
support for stopping the automatic monitoring than just stopping the
daemon. Eg, what happens if you decide you need to recover a previous
version of a file. Git checks it out, presumably updates the index
itself and then inotify fires off a git-add that will want to write to
the index. Basically, I'm trying to think if there's any situation
where you can have a delete event that git causes, followed by a
creating some new content where delay in your program processing the
delete will cause the new content to be `lost'? (I know, I sould read
the code.) In chronoversion, the first thing it does is check for a
"suppress" file which stops it doing anything automatically and I put
one in there whenever I'm doing anything more than looking at the data
(eg, switch branch, checkout old version, etc). But I might be being
hyper-cautious.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
