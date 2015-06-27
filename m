From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR
Date: Sat, 27 Jun 2015 12:57:44 +0700
Message-ID: <CACsJy8AuO5PNy=oFN1W9EQKK5_=jRkSNx8KhQYjL-0mW+jvr0A@mail.gmail.com>
References: <CA+cck7GD+JgR4O-XoBeUX1gJAG6suP9iLwASyRygK8hR4KP7pw@mail.gmail.com>
 <1435315055-27011-1-git-send-email-pclouds@gmail.com> <20150626115603.GB4315@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Bj=C3=B8rnar_Snoksrud?= <snoksrud@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 07:58:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8j89-00019x-25
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 07:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbbF0F6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2015 01:58:16 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35173 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbbF0F6O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jun 2015 01:58:14 -0400
Received: by iebrt9 with SMTP id rt9so87885754ieb.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Y2UqwHuaulqxekD8hwP2Q5JHJACfdmDA2xiQR6bJoek=;
        b=cvDy/FY14RWAIyu5V1szSr/oQhJZBwVmZkNWzpxomoPCifwQ8SfzFy8AZtGwmTBLjc
         TZ5p/lo0sDNisBENU0uT5Ia3JFGwZZJKruvvyVglCHP8VXZmfHYmPmztnUiOxyRoVG/2
         H4cVGaXWUf0kQPooTmecchEtx1mtdxNZ7LdVKyza1ceOFcdCpDW+xOZbyua8jQ6Y2Kv+
         xNWBY/YsaYmVDjZy3RNC6lNKYIyG35h+7dmQpe+qk0dftlTx07tErjob9YlmIE+ZBlzf
         PViXC2z3iBLoKmuwDOYXkwWZUVxFcvN4+A527Y8u1dHlq0tRuKKC2S1jumJ84vT8e0Gl
         2ihg==
X-Received: by 10.50.7.68 with SMTP id h4mr2217957iga.40.1435384693870; Fri,
 26 Jun 2015 22:58:13 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Fri, 26 Jun 2015 22:57:44 -0700 (PDT)
In-Reply-To: <20150626115603.GB4315@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272851>

On Fri, Jun 26, 2015 at 6:56 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 26, 2015 at 05:37:35PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> This is where the "fun" is. The legacy behavior is, if $GIT_WORK_TRE=
E is
>> not set but $GIT_DIR is, cwd is chosen as worktree's top. If you hap=
pen
>> to stand at worktree's top when you do this, all is well. If you are=
 in
>> a subdir "foo/bar" (real worktree's top is "foo"), this behavior bit=
es
>> you: your detected worktree is now "foo/bar", but the first run
>> correctly detected worktree as "foo". You get "internal error: work =
tree
>> has already been set" as a result.
>
> I think this makes sense. I feel like we've dealt with this before, b=
ut
> the two previous rounds I found were basically:
>
>   - we have GIT_IMPLICIT_WORK_TREE, but that is for the _opposite_ ca=
se.
>     I.e., when we do not have a work tree and must communicate so to
>     later code (including sub-processes).
>
>   - a discussion about switching the "work tree defaults to '.' when
>     $GIT_DIR is set" behavior yielded almost the identical patch:
>
>       http://article.gmane.org/gmane.comp.version-control.git/219196
>
>     but we were so wrapped up in the greater discussion we did not ap=
ply
>     that simple fix. :)

There's also the patch "[PATCH v2] setup.c: set workdir when gitdir is
not default" from Max Kirillov last year (gmane down, no link), so we
have one patch about this every year since 2013 :)

Junio if you are worried about unnecessary setenv, I think Max's
approach is safer as he solves a specific use case. If this problem
pops up again in another use case, we can deal with that again.

>> +     if (setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1))
>> +             error("Could not set GIT_WORK_TREE to '%s'", work_tree=
);
>
> Should this be die()? setenv() should basically never fail, but if it
> does, it could be confusing and/or dangerous to run without the varia=
ble
> set.

It's a straight copy from set_git_dir() but I guess the situation is a
bit different. If setenv fails in gitdir, no repo is found but if it
fails here we may select a wrong worktree and could wipe it out by
mistake. Will fix if Junio chooses this patch instead of Max's.
--=20
Duy
