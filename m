From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git gui error with relocated repository
Date: Tue, 29 Apr 2014 16:23:18 +1200
Message-ID: <CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>, patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Tue Apr 29 06:23:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WezZk-0003NG-5P
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 06:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbaD2EXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 00:23:19 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:43993 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbaD2EXS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 00:23:18 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so6639191pbc.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 21:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=/4o6rZXQbyWsxt6/aRsbMRsR3PCKuETgzDRFdts1oSA=;
        b=TiKHoEzKSpBELtvU1yb833v2ssnj97ClHsm4YG05lk5TcaNkzL6Doftk+GlYr1s9vn
         WdZG5S93n9k3pRgvpzVeWuvuaqXRGnWOel7nBkYpcHMqOs5h9UWrPYjm2U/t1iCOddHP
         Zugv1EL8zr9ifuNmFY/fIlz59tttWX9fVwoqclSelWY+VM33pz7vj1u5XBc/wFIZ4mZd
         XbBeL/vVwdRgHuvH6N5GsS7Q3MGD62ibSL6f41wd+cemzif6DiyYdmqof/yg2cA2vX0D
         ZvVdc4DpsT3KZxSe1yRH4gYBvVBjxMhesFnoRTtU/5sckii4qegkM+8BC7F2olFMQ763
         /O1A==
X-Received: by 10.68.202.194 with SMTP id kk2mr8030288pbc.156.1398745398220;
 Mon, 28 Apr 2014 21:23:18 -0700 (PDT)
Received: by 10.70.46.38 with HTTP; Mon, 28 Apr 2014 21:23:18 -0700 (PDT)
In-Reply-To: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247520>

On Tue, Apr 29, 2014 at 2:56 PM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi Pat,
>
> I'm running git 2.0.0-rc0 (haven't got round to pulling down rc1 yet)
> which includes gitgui-0.19.0 and I'm getting a new error when I run
> 'git gui' in a repository with a .git file (created by git submodule).
>
> I can send you a screencap of the error message off list if you want
> but the text is
>
> "No working directory ../../../<repo>
>
> couldn't change working directory to ../../../<repo>: no such file or directory"

My tcl is a little rusty but I think the problem might be this snippet.

# v1.7.0 introduced --show-toplevel to return the canonical work-tree
if {[package vsatisfies $_git_version 1.7.0]} {
    if { [is_Cygwin] } {
        catch {set _gitworktree [exec cygpath --windows [git rev-parse
--show-toplevel]]}
    } else {
        set _gitworktree [git rev-parse --show-toplevel]
    }
} else {
    # try to set work tree from environment, core.worktree or use
    # cdup to obtain a relative path to the top of the worktree. If
    # run from the top, the ./ prefix ensures normalize expands pwd.
    if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
        set _gitworktree [get_config core.worktree]
        if {$_gitworktree eq ""} {
            set _gitworktree [file normalize ./[git rev-parse --show-cdup]]
        }
    }
}

The  vsatisfies call probably doesn't handle '2.0.0.rc0' and the
fallback behaviour probably needs to normalise core.worktree

>
> Here's some other info that might help
>
>   $ git --version
>   git version 2.0.0.rc0
>
>   $ cat .git
>   gitdir: ../.git/modules/<repo>
>
>   $ git rev-parse --git-dir
>   /home/chris/src/<super>/.git/modules/<repo>
>
>   $ git config core.worktree
>   ../../../<repo>
>
> Thanks,
> Chris
