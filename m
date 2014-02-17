From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug: relative core.worktree is resolved from symlink and not its target
Date: Mon, 17 Feb 2014 19:30:25 +0700
Message-ID: <CACsJy8B=34f71uW27J_qkq5auqwRdgHrraunon-H0eZvpKDbnA@mail.gmail.com>
References: <52F0BEF7.5020600@thequod.de> <20140209090803.GA24578@lanh> <5301D835.1060301@thequod.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Hahler <genml+git-2014@thequod.de>
X-From: git-owner@vger.kernel.org Mon Feb 17 13:31:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFNLi-0000Xq-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 13:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbaBQMa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Feb 2014 07:30:58 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:44566 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbaBQMa5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Feb 2014 07:30:57 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so21319218qab.37
        for <git@vger.kernel.org>; Mon, 17 Feb 2014 04:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IStPedpHeMq3U61ubA1KLziJcVj/VD0713F5BAZOl5Y=;
        b=JYSvI6ynu3UrcFUhLEZLkfW7yQHW0YrriLPGvUBnMv3OvUK4uceMad4h5TYY+lA5JU
         r7VrpAdvcyC00Jn8Tw5Es3j9qWXtMWlcp+AwwqxPV+E5h6VmrR9t2gbYhLJBTDmfn2vB
         UNb2gNB8IVucV885or6H1gRhruVIdHlN89ijwHqrCSg2i0KDQPWFj4cHmkW5Q6g6rYLv
         z9c3q9WzJG2MzRHHACB+XP188BVAdHfEWviod4UR6gROBbppoiYRhEPCA/WmiCrtGHNJ
         5/P5zLvOAbOcinQFBQYAo+TVmvTxf4qUS3D7UQZMlsiXia7YKD3WgdYou2YOqpytibeN
         uhJA==
X-Received: by 10.224.19.199 with SMTP id c7mr1953159qab.78.1392640256142;
 Mon, 17 Feb 2014 04:30:56 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 17 Feb 2014 04:30:25 -0800 (PST)
In-Reply-To: <5301D835.1060301@thequod.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242258>

On Mon, Feb 17, 2014 at 4:36 PM, Daniel Hahler
<genml+git-2014@thequod.de> wrote:
> On 09.02.2014 10:08, Duy Nguyen wrote:
>> On Tue, Feb 04, 2014 at 11:20:39AM +0100, Daniel Hahler wrote:
>
> Thanks for looking into this.
>
>>> when using a submodule "sm", there is a relative worktree in its co=
nfig:
>>>
>>>    .git/modules/sm/config:
>>>    [core]
>>>     worktree =3D ../../../smworktree
>>>
>>> git-new-worktree (from contrib) symlinks this config the new worktr=
ee.
>>>
>>> From inside the new worktree, git reads the config, but resolves th=
e
>>> relative worktree setting based on the symlink's location.
>>
>> Hmm.. core.worktree is relative to $GIT_DIR. Whether "config" is a
>> symlink should have no effects.
>
> If "config" is a symlink, the relative path for worktree is meant to =
be
> resolved based on the config file's location, and not from the symlin=
k
> ($GIT_DIR).

I think you started with a wrong assumption. See config.txt it says

-- 8< --
core.worktree::
Set the path to the root of the working tree.
This can be overridden by the GIT_WORK_TREE environment
variable and the '--work-tree' command line option.
The value can be an absolute path or relative to the path to
the .git directory, which is either specified by --git-dir
or GIT_DIR, or automatically discovered.
-- 8< --

So I think it fails "correctly" (by the book).

> Here is a test case to reproduce it:
>
>   # Create a submodule repo
>   mkdir /tmp/t-sm
>   cd /tmp/t-sm
>   git init
>   touch foo
>   git add foo
>   git commit -m init
>
>   # Create the root repo
>   mkdir /tmp/t-root
>   cd /tmp/t-root
>   git init
>   mkdir submodules
>   git submodule add /tmp/t-sm submodules/sm
>   git commit -m init
>
>   # Create a new worktree from the submodule
>   cd /tmp/t-root/submodules/sm
>   git-new-workdir . /tmp/new-workdir
>
> This then fails when checking out:
> + git checkout -f
> fatal: Could not chdir to '../../../../submodules/sm': No such file o=
r directory
>
> % ls -l /tmp/new-workdir/.git/config
> [=E2=80=A6] /tmp/new-workdir/.git/config -> /tmp/t-root/.git/modules/=
submodules/sm/config
>
> % cat /tmp/new-workdir/.git/config
> [core]
>         repositoryformatversion =3D 0
>         filemode =3D true
>         bare =3D false
>         logallrefupdates =3D true
>         worktree =3D ../../../../submodules/sm
>
>
> From inside of /tmp/new-workdir `git rev-parse --git-dir` fails alrea=
dy
> (with the same "cannot chdir" error).
>
> The problem appears to be that it tries to chdir based on
> /tmp/new-workdir/.git, but should do so based on
> $(readlink -f .git/config).
>
> I recognize that this case is constructed anyway, because even if
> `worktree` would get resolved correctly, it would not be what you'd
> expect: the point of git-new-workdir is to get a separate worktree, a=
nd
> not use the existing one.
>
> Therefore I see two problems here:
> 1. worktree is not resolved correctly by git itself (with .git/config
>    being a symlink)
> 2. git-new-workdir should handle this better, e.g. by creating a copy=
 of
>    the "config" file with the worktree setting removed and printing a
>    warning about it.
>
> The workaround appears to be to explicitly set
> GIT_WORK_TREE=3D/tmp/new-workdir.

No if you copy "config" out then it may be not what you want anymore
(e.g. new remotes not reflected in new worktree). A better solution is
move core.worktree out of "config". Notice t-root/submodules/sm is a
file that contains the path to the true .git directory. We could have
stored worktree path in that file instead of in "config".
--=20
Duy
