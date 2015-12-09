From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git-clone fails when current user is not in /etc/passwd
Date: Wed, 9 Dec 2015 19:24:13 +0100
Message-ID: <CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
 <CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Taylor Braun-Jones <taylor@braun-jones.org>
X-From: git-owner@vger.kernel.org Wed Dec 09 19:24:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6jQ1-0002gC-Gb
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 19:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbbLISYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 13:24:45 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34517 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbbLISYo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 13:24:44 -0500
Received: by lbbcs9 with SMTP id cs9so35376202lbb.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 10:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pXqmU2dAH6z67SoX936ZHKMKWYdJUYcQD0gCZFLJ5Ew=;
        b=KxKIjaZyOujmqlr64P86iJCQNmlNOPUN7f2jkP2oizl3pWZ0ToDSMDd1nOneSDFiFN
         W5sQwhbzYrUBqh5SHJuJ+Igld41SJOff4tVdT+1qW/tCc+gGYNSp0BlXAK7MZjaohDGH
         yxCDOOuRLgfGXRWGciHLG0BH3hVlHkxie1EEywVVELR+PihrGKk9MviabDJSY9a6uy6K
         4v7hEfxAbQcDm2pOFXgTAwJUUUEfa2URFRN4HwSMPLiS1LJ4j7PIvXKVrmI8o0UFFiDp
         uQlptnTzETPuUCnA5DMYoD31RRJ4IeClahA6Aejj9OKHESLkMVZBdnjrsdXf9YEaep2s
         KNTg==
X-Received: by 10.112.126.106 with SMTP id mx10mr3183991lbb.3.1449685482856;
 Wed, 09 Dec 2015 10:24:42 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 9 Dec 2015 10:24:13 -0800 (PST)
In-Reply-To: <CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282196>

On Wed, Dec 9, 2015 at 5:08 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Dec 2, 2015 at 9:10 PM, Taylor Braun-Jones
> <taylor@braun-jones.org> wrote:
>> My use case it running git clone inside a docker container with
>> `docker run --user $(id -u):$(id -g) --volume /foo:/foo ...`. I want
>> all /foo/* file creation/access from inside the Docker container to be
>> done as the current uid/gid of the host system.
>>
>> Steps to reproduce:
>>
>> mkdir /tmp/docker-git
>> cat > /tmp/docker-git/Dockerfile <<EOF
>> FROM ubuntu
>> RUN apt-get update && apt-get install -y git-core
>> EOF
>> docker build -t git /tmp/docker-git/
>> docker run --user $(id -u):$(id -g) git git clone
>> https://github.com/git/git.git /tmp/git
>> # fatal: unable to look up current user in the passwd file: no such user
>
> It probably helps if you could get the stack trace to this message
> (printed from function xgetpwuid_self). I haven't checked if my
> personal laptop has docker to reproduce this.. In general we won't ask
> passwd if the user specifies name/email in the config file. But I
> still don't see why git-clone needs that info in the first place.

Well.. reflog needs it. So either you disable reflog at clone time or
define name/email via config file. I don't see anything wrong with
this behavior. Stack trace

(gdb) bt
#0  0x0000000000585aaf in xgetpwuid_self () at wrapper.c:608
#1  0x00000000004ef2c4 in ident_default_name () at ident.c:108
#2  0x00000000004ef851 in fmt_ident (name=0x0, email=0x0,
date_str=0x0, flag=0) at ident.c:300
#3  0x00000000004efb25 in git_committer_info (flag=0) at ident.c:366
#4  0x000000000052fc6f in log_ref_write_1 (refname=0x16236c0
"refs/remotes/origin/HEAD", old_sha1=0x7ffc91e44190 "",
new_sha1=0x7ffc91e44170
"\355\025\033\215p{o\177V\234qX\212j?!v|}D\177", msg=0x1620e50 "clone:
from https://github.com/rswier/c4.git", logfile=0x7ffc91e44100,
flags=0, err=0x7ffc91e44150) at refs.c:3403
#5  0x000000000052fd85 in log_ref_write (refname=0x16236c0
"refs/remotes/origin/HEAD", old_sha1=0x7ffc91e44190 "",
new_sha1=0x7ffc91e44170
"\355\025\033\215p{o\177V\234qX\212j?!v|}D\177", msg=0x1620e50 "clone:
from https://github.com/rswier/c4.git", flags=0, err=0x7ffc91e44150)
at refs.c:3424
#6  0x00000000005304af in create_symref (ref_target=0x16236c0
"refs/remotes/origin/HEAD", refs_heads_master=0x1624cc0
"refs/remotes/origin/master", logmsg=0x1620e50 "clone: from
https://github.com/rswier/c4.git") at refs.c:3592
#7  0x000000000042e50c in update_remote_refs (refs=0x1622d40,
mapped_refs=0x1622cc0, remote_head_points_at=0x1624bc0,
branch_top=0x1621ca0 "refs/remotes/origin/", msg=0x1620e50 "clone:
from https://github.com/rswier/c4.git", transport=0x1622960,
check_connectivity=1) at builtin/clone.c:639
#8  0x000000000042f80c in cmd_clone (argc=2, argv=0x7ffc91e44ab8,
prefix=0x0) at builtin/clone.c:1066
#9  0x0000000000405fda in run_builtin (p=0x825948 <commands+456>,
argc=5, argv=0x7ffc91e44ab8) at git.c:352
#10 0x00000000004061d0 in handle_builtin (argc=5, argv=0x7ffc91e44ab8)
at git.c:542
#11 0x00000000004062ec in run_argv (argcp=0x7ffc91e4498c,
argv=0x7ffc91e449a0) at git.c:588
#12 0x00000000004064df in main (argc=5, av=0x7ffc91e44aa8) at git.c:695
-- 
Duy
