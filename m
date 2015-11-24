From: Anthony Sottile <asottile@umich.edu>
Subject: Fwd: Git clone fails during pre-commit hook due to GIT_WORK_TREE=.
 (regression 2.5 -> 2.6)
Date: Mon, 23 Nov 2015 18:22:11 -0800
Message-ID: <CA+dzEB=XiGVFg+AhuJM-jUCPmgZKCJHTp3sinrFt8yzXeC_63Q@mail.gmail.com>
References: <CA+dzEB=2LJXiLSTqyLw8AeHNwdQicwvEiMg=hVEX0-_s1bySpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 03:22:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a13FZ-0003gL-8S
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 03:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbbKXCWP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 21:22:15 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33901 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbbKXCWN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2015 21:22:13 -0500
Received: by lffu14 with SMTP id u14so3531264lff.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 18:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=GDkoqGN/zVxKliKV5JMNE7qguVE/54uEqlL2qhjhhL8=;
        b=bOEEJ23aAgVBD+Kz6o2uGWg6FPWxzNck480NN6CjyOVQ9ERylLxSbJOp0ggfcr8LDO
         xOksMfr0K5kUXCR+CFN40JqLqsSM2pwKoRlGzbCxhtzvz4/GKcyS8K6/il1y0+Lq/iKX
         QeZ3ROQkBkkFtkEfOq76mu4tlsgjHtRt0EloRtT45Ir4hihk+rmaDuDi4ftcJLc8sbVY
         AGN19mO5zCphECE5hUDwQWr4+wof0FIu7BWbQiiQ9cR69Q6jIccQStHB05T8T6t17Juk
         BcJe7nORbaxsz9Oh06HEaY4xnkXdrxXCiVVrP1WXnbwwiVQghZAtBYN41ws6iB7VMSUa
         0W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=GDkoqGN/zVxKliKV5JMNE7qguVE/54uEqlL2qhjhhL8=;
        b=Bz6fcchgVBtTXG0GAC3l3KuC71CsHj1cmYJDOAa+vubpdkGVc64OmtiucWZo3eBN13
         xteDdWbvXhuxBwRclsujcYPqzZ5j/f7V2dUaMdJOLPohOeXHG8PKpAIXhucXkDiuvnH/
         3x71TbDvjI4SyuAqlzy4iLXwL1D7ifkomZKOGADMcbRvW8EtTIg0ChLhsUV5YPltr6FK
         uNQJkosEAfKBvYVk9/FMk9U8ycP03LmWOKkK4kBj6F4nPTZmzpSThwNuOgXeToImZZt7
         IaAEvYs3md84o+UOgQAAVoEJgAdBlp/Tr/0QGv4Rf8T8lYexM/sxoSIPbOmNkJ58WZ1n
         nvOg==
X-Gm-Message-State: ALoCoQmf/RHjuA1p5cMzFzMbRE7cUEJXMtcb3mVpQyIQ9Y7OMe35ihr2MuROXUKUWe6xQJ7eUvx7
X-Received: by 10.112.171.74 with SMTP id as10mr11746175lbc.137.1448331731643;
 Mon, 23 Nov 2015 18:22:11 -0800 (PST)
Received: by 10.25.22.164 with HTTP; Mon, 23 Nov 2015 18:22:11 -0800 (PST)
In-Reply-To: <CA+dzEB=2LJXiLSTqyLw8AeHNwdQicwvEiMg=hVEX0-_s1bySpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281608>

* Short description of the problem *

It seems GIT_WORK_DIR is now exported invariantly when calling git
hooks such as pre-commit.  If these hooks involve cloning repositories
they will not fail due to this exported environment variable.  This
was not the case in prior versions (such as v2.5.0).

* Simple reproduction *

```
$ cat test.sh
#!/usr/bin/env bash
set -ex

rm -rf test

# Exit non {0, 1} to abort git bisect
make -j 8 > /dev/null || exit 2

# Put our new git on the path
PATH=3D"$(pwd):$PATH"

git init test

pushd test
mkdir -p .git/hooks
echo 'git clone git://github.com/asottile/css-explore css-explore' >
=2Egit/hooks/pre-commit
chmod 755 .git/hooks/pre-commit

git commit -m foo --allow-empty || exit 1
```

* Under 2.6.3 *

```
$ ./test.sh

=2E..

+ git init test
warning: templates not found /home/anthony/share/git-core/templates
Initialized empty Git repository in /home/anthony/workspace/git/test/.g=
it/
+ pushd test
~/workspace/git/test ~/workspace/git
+ mkdir -p .git/hooks
+ echo 'git clone git://github.com/asottile/css-explore css-explore'
+ chmod 755 .git/hooks/pre-commit
+ git commit -m foo --allow-empty
fatal: working tree '.' already exists.
+ exit 1
```

* Under 2.5 *

```
$ ./test.sh

=2E..

+ git init test
warning: templates not found /home/anthony/share/git-core/templates
Initialized empty Git repository in /home/anthony/workspace/git/test/.g=
it/
+ pushd test
~/workspace/git/test ~/workspace/git
+ mkdir -p .git/hooks
+ echo 'git clone git://github.com/asottile/css-explore css-explore'
+ chmod 755 .git/hooks/pre-commit
+ git commit -m foo --allow-empty
Cloning into 'css-explore'...
warning: templates not found /home/anthony/share/git-core/templates
remote: Counting objects: 214, done.
remote: Total 214 (delta 0), reused 0 (delta 0), pack-reused 214
Receiving objects: 100% (214/214), 25.89 KiB | 0 bytes/s, done.
Resolving deltas: 100% (129/129), done.
Checking connectivity... done.
[master (root-commit) 5eb999d] foo
```


* Bisect *

```
$ git bisect good v2.5.0
$ git bisect bad origin/master
$ git bisect run ./test.sh

=2E..

d95138e695d99d32dcad528a2a7974f434c51e79 is the first bad commit
commit d95138e695d99d32dcad528a2a7974f434c51e79
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Fri Jun 26 17:37:35 2015 +0700

    setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR

    In the test case, we run setup_git_dir_gently() the first time to r=
ead
    $GIT_DIR/config so that we can resolve aliases. We'll enter
    setup_discovered_git_dir() and may or may not call set_git_dir() ne=
ar
    the end of the function, depending on whether the detected git dir =
is
    ".git" or not. This set_git_dir() will set env var $GIT_DIR.

    For normal repo, git dir detected via setup_discovered_git_dir() wi=
ll be
    ".git", and set_git_dir() is not called. If .git file is used howev=
er,
    the git dir can't be ".git" and set_git_dir() is called and $GIT_DI=
R
    set. This is the key of this problem.

    If we expand an alias (or autocorrect command names), then
    setup_git_dir_gently() is run the second time. If $GIT_DIR is not s=
et in
    the first run, we run the same setup_discovered_git_dir() as before=
=2E
    Nothing to see. If it is, however, we'll enter setup_explicit_git_d=
ir()
    this time.

    This is where the "fun" is.  If $GIT_WORK_TREE is not set but
    $GIT_DIR is, you are supposed to be at the root level of the
    worktree.  But if you are in a subdir "foo/bar" (real worktree's to=
p
    is "foo"), this rule bites you: your detected worktree is now
    "foo/bar", even though the first run correctly detected worktree as
    "foo". You get "internal error: work tree has already been set" as =
a
    result.

    Bottom line is, when $GIT_DIR is set, $GIT_WORK_TREE should be set =
too
    unless there's no work tree. But setting $GIT_WORK_TREE inside
    set_git_dir() may backfire. We don't know at that point if work tre=
e is
    already configured by the caller. So set it when work tree is
    detected. It does not harm if $GIT_WORK_TREE is set while $GIT_DIR =
is
    not.

    Reported-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 9daa0ba4a36ced9f63541203e7bcc2ab9e1eae56
36fbba57fc83afd36d99bf5d4f3a1fc3feefba09 M    environment.c
:040000 040000 1d7c4bf77e0fd49ca315271993cb69a8b055c3aa
145d85895cb6cb0810597e1854a7721ccfc8f457 M    t
bisect run success
```

Causing me a few headaches in
https://github.com/pre-commit/pre-commit/issues/300
I'm working around it in https://github.com/pre-commit/pre-commit/pull/=
301

Thanks,

Anthony
