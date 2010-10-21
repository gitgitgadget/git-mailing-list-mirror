From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [long] worktree setup cases
Date: Thu, 21 Oct 2010 08:46:44 +0700
Message-ID: <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com>
References: <20101020085859.GA13135@do> <20101020190709.GB10537@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, fbriere@fbriere.net, drizzd@aon.at,
	575917@bugs.debian.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 03:47:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8kFR-0002ap-BM
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 03:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408Ab0JUBrK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 21:47:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55138 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab0JUBrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 21:47:09 -0400
Received: by wwf26 with SMTP id 26so1916458wwf.1
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 18:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5U/NRjUVd0vlxtX9Xpz00HKGsrXb9pyK2qsS2eizKpM=;
        b=cYsfrCGWl6/Y7HUnj7xfkwE/+LdGXi9TZHFPm34il7+u9iIRD8DDEwtTHbZfDxvUx3
         x58G3k1uB67QJJvTzwJZU4Gn4BMf4WJMoQXOFAxa/suUopofAeTgtNqxD9v9sWdhyz2r
         oNO2/H7RMSpvsnH3CoTTguuoiRgH8/V5Xk70E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nItkhfAAVdV0HLEcpX92JEdd1LRAU/CtiFVlyHY5VwAMRjX3gV+7rR6L07nQS43PQg
         q9S1xmER3JqsRkHlOyQ8RfppDDKmYB4bFFcGa+e0KlbExo+2mlUxxGpksFjuQkAt1avC
         /TLDkuGApS8inBbZdf5txuJyg0OkvF6yHfqTw=
Received: by 10.216.56.18 with SMTP id l18mr1107560wec.36.1287625624135; Wed,
 20 Oct 2010 18:47:04 -0700 (PDT)
Received: by 10.216.171.207 with HTTP; Wed, 20 Oct 2010 18:46:44 -0700 (PDT)
In-Reply-To: <20101020190709.GB10537@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159454>

On Thu, Oct 21, 2010 at 2:07 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> So there are 2^5 =3D 32 cases in total. Let's look at them one by
>> one.
>
> Thanks! =C2=A0To summarize (and make sure I understand correctly):
> anything not following the below rules is a bug, yes?

Let's see.

> A. Weird cases.
>
> =C2=A0- using a .git file is just like setting GIT_DIR;

Yes, except that GIT_DIR can be detected early when cwd has not been
moved. When .git is found a file, cwd could have been changed.

> B. Repository search.
>
> =C2=A0- if GIT_DIR was set explicitly, GIT_WORK_TREE defaults to
> =C2=A0 "." (for legacy reasons).

Correct.

> =C2=A0- otherwise, if original cwd was under repository, it will not
> =C2=A0 prompt a search for work tree, even if the repo happens
> =C2=A0 to be named ".git" or core.bare is false. =C2=A0That is, in
> =C2=A0 this case, GIT_WORK_TREE defaults to unset.

What do you mean by "under repository"? If the repo is /tmp/git/.git,
then cwd is at /tmp/git/.git?

> =C2=A0- otherwise, if original cwd was under a directory containing
> =C2=A0 repository as ".git", GIT_WORK_TREE defaults to that
> =C2=A0 directory (i.e., parent to .git dir).

Yes.

> =C2=A0- otherwise, there is no repository. =C2=A0GIT_DIR is unset,
> =C2=A0 GIT_WORK_TREE defaults to unset.

- Otherwise, move up one dir and repeat?

> C. Working directory and prefix
>
> =C2=A0- if GIT_WORK_TREE is still unset after repository search,
> =C2=A0 stay in the original cwd, prefix =3D NULL.

if GIT_WORK_TREE and core.worktree are still unset, we get a bare repo
here (or force it to be a bare repo), so yes, cwd should stay in
original cwd and prefix =3D NULL.

> =C2=A0- if original cwd is inside worktree, chdir to toplevel,
> =C2=A0 prefix =3D path to original cwd.

Yes.

> =C2=A0- otherwise, stay in the original cwd, prefix =3D NULL.

I'm not really happy with this, which is why I wrote the
--cwd-to-worktree and --worktree-to-cwd patch. But this should be
enough for full-tree operations to work, so yes.

> D. User-supplied relative paths.
>
> =C2=A0- path in .git file is relative to containing directory
> =C2=A0- path in GIT_DIR is relative to original cwd
> =C2=A0- paths in GIT_WORK_TREE and core.worktree are relative to
> =C2=A0 $GIT_DIR

I think $GIT_WORK_TREE is relative to original cwd. Yes, core.worktree
should be relative to $GIT_DIR.

> =C2=A0- paths passed to git commands are generally relative to
> =C2=A0 original cwd

And filename output should also be relative to original cwd (except a
few special, like diff output).

> E. Internally used relative paths.
>
> =C2=A0- all paths are relative to current cwd.

Yes.
--=20
Duy
