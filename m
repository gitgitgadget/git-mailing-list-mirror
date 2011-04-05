From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 9/9] Documentation: update api-builtin and api-setup
Date: Tue, 5 Apr 2011 18:32:31 +0700
Message-ID: <BANLkTi=opkt7=BSCknKzN9396+urvVkhVQ@mail.gmail.com>
References: <cover.1204130175.git.pclouds@gmail.com> <20080227164045.GA28142@laptop>
 <20110405080729.GA25921@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 13:33:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q74VR-0003BQ-1T
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 13:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab1DELdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 07:33:04 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:52325 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab1DELdC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 07:33:02 -0400
Received: by pxi2 with SMTP id 2so182110pxi.10
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 04:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=81dsoVhciUyHYUEdJmzBGgUIzO2/yjF6/CjDkHaN9cw=;
        b=k5ZQ3PeJE9d4EKHc1Fq/nMK/5aD3MbSf/NY6zItyxtzXA1c2Arl6gzx4/IS6wposP3
         DN9BFreYb0Tx9azJmKWb/0mKdxoYWIBx6KbSWQ+jQ0/ZC/AQYnQIP+rVx+6oda+8GHIb
         yDxyJF5m11ZjVYURMkdI+Hy93U6ZhP+gh4hms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PAgSyu3gT5y+8WCBSUrTnU13+GE28Pr4SGxGK8Md1bHx37f0djnLIrFkpaggKXO457
         pyPnlt0xfz13XK0t7bHQFiZ/YPxTLNz3m+Xim2285EjKbgbCNsxCdx5pSTeHv5ApEKA7
         83wCupGoZ/w2WnDyarbn32QnjVf1Jq6mQ3A6I=
Received: by 10.142.202.12 with SMTP id z12mr7334994wff.442.1302003182031;
 Tue, 05 Apr 2011 04:33:02 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Tue, 5 Apr 2011 04:32:31 -0700 (PDT)
In-Reply-To: <20110405080729.GA25921@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170880>

2011/4/5 Jonathan Nieder <jrnieder@gmail.com>:
> Hi,
>
> On 2008-02-27, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> =C2=A0Documentation/technical/api-builtin.txt | =C2=A0 10 ++++
>> =C2=A0Documentation/technical/api-setup.txt =C2=A0 | =C2=A0 70 +++++=
++++++++++++++++++++++----
>> =C2=A02 files changed, 72 insertions(+), 8 deletions(-)
>
> I'm curious --- did anything ever come of this patch?

No idea. Perhaps nothing :) You should submit a new patch. Your
description looks very good. Some comments..

> Simpler advice might be:
>
> =C2=A0. If the command is builtin and always needs a repository,
> =C2=A0 use the RUN_SETUP flag in the builtin table.
> =C2=A0. If the command is builtin and can benefit from a repository,
> =C2=A0 use RUN_SETUP_GENTLY.
> =C2=A0. If you have to run a repository search later, call
> =C2=A0 "setup_git_directory_gently" or the shortcut "setup_git_direct=
ory"
> =C2=A0 (which means "setup_git_directory_gently(NULL)").

I would discourage people from calling setup_git_directory_* directly,
at least for builtins. It complicates setup handling because there
will be a short time since main() until that function where we are not
sure if we can access repo. There's also alias handling which may set
things up while the command may not want it

I'd rather explicitly mark (RUN_SETUP_NO_THANKS?) commands that want
to setup repo manually (few of them, init/clone and server commands).
Then main() just goes ahead and calls setup_gently() at the very
beginning. Setup hack around alias handling would be gone. If it ends
up with a RUN_SETUP_NO_THANKS one, it undoes the setup. Hmm... I need
to get back to this.

>> +
>> +Do not access git repository (even indirectly like `git_config()`) =
before
>> +calling one of these functions. Otherwise you may encounter `die()`=
 if git
>> +fails to automatically find/setup a repository.
>
> =C2=A0. If you try to access the git repository (even indirectly like
> =C2=A0 `git_config()`) before calling setup_git_directory_gently then=
 git
> =C2=A0 will look in the wrong place.
> =C2=A0. When changing the value of the GIT_DIR environment variable, =
call
> =C2=A0 set_git_dir. =C2=A0setup_git_directory_gently does this alread=
y.

You can also check startup_info.have_repository before you access repo
because setup*gently may find no repo.

> Did we ever figure out what happens/should happen when the requested
> worktree is not an ancestor of cwd?

prefix is NULL, cwd is unchanged. Repo-wide commands should work fine.
cwd-sensitive ones may cry.

>> +When working with pathspecs and prefix, you can use `get_pathspec()=
`
>> +to auto prepend a given prefix to pathspecs. Other helpful function=
s
>> +are `prefix_path()`, `prefix_filename()`
>
> What do prefix_* do when there is no worktree?

These functions are purely string manipulation. If there is no
worktree, prefix would be NULL and be passed to the functions as such.
--=20
Duy
