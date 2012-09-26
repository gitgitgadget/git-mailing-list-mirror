From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: DWIM .git repository discovery
Date: Wed, 26 Sep 2012 18:02:23 +0700
Message-ID: <CACsJy8B5xXSrqoYX_5BW34Sq0QpP6U=E6e+prJRe_0FWf4Bz0w@mail.gmail.com>
References: <CACsJy8DOtPWgkq=KSHCb=J3qg4o1aPaLo4aj7U5f_qa+kCCipQ@mail.gmail.com>
 <7v7grhv2fu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 13:03:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGpOU-00010C-GR
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 13:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab2IZLCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 07:02:55 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63238 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab2IZLCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 07:02:54 -0400
Received: by ieak13 with SMTP id k13so1017318iea.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Kx/fcxpsdjkZqIq0nHZsY0jfVbJePhzNT0ZbXWcwsfI=;
        b=wlLZugSXYuXFv43KfX+M455YP1YVe4YnUGUd3F+msFr04ZeI3AY9xKoKvMSlM5U3K9
         7rJenhXjetA46Qe/JJ4B7rDg1WngCs18yeD9WktYOUyh9FISu0/k4/vc7X73W/KdmUeX
         PCoDTEjN5mKYO05DTe5gy7N3EAJkgLOqGkTB+EM91KmFHqpRYd1HNTt7dDC4/rsahFeG
         02YU0HmdZIw2j0A6Q7VMHXvA6MrjkBqmGgh96gKx9XY6GYM1dqsE8az2n/pOt/PogNky
         FH5Ybv+HIt7yvmXOlb2bq/SeDhMaUJJpv6amqSUXjxU+XZ5Qlu4uCYnQiyO/uoHjQmxl
         DtUw==
Received: by 10.50.220.129 with SMTP id pw1mr540081igc.47.1348657374270; Wed,
 26 Sep 2012 04:02:54 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Wed, 26 Sep 2012 04:02:23 -0700 (PDT)
In-Reply-To: <7v7grhv2fu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206405>

On Wed, Sep 26, 2012 at 11:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> I often find myself attempting to examine another repository,
>> especially in projects that are closely related but put in different
>> git repos. It's usually just a diff or log command
>>
>> git log --patch ../path/to/another/repo/path/to/file.c
>
> I personally do not think it is _too_ bad to internally do
>
>         (cd ../path/to/another/repo/path/to &&
>          git log --patch file.c)
>

As long as the .git discovery and path rewriting can be done
automatically, that'd be nice. But..

> but I doubt it is worth the numerous implications (I am not talking
> about implementation complexity at all, but the conceptual burden).
>
> For example, where in the working tree of the other project should
> the command run?  The output from "log -p" happens to be always
> relative to the top of the working tree, but that does not
> necessarily hold true for other subcommands.

Returned paths should always be relative to cwd (well except diff/log
which are prefixed by [ab]/). cd'ing internally like above makes it
more confusing imo. Take grep for example, I find it natural for "git
grep foo -- ../other/repo/bar/" to return "../other/repo/bar/foo.c
...".

Prefix currently does not take "../blah" form, but I see no reasons
why it can't/shouldn't. $(cwd) is most likely outside the other
project's working directory. An exception running from inside a
submodule and examining the parent repository.

For too long relative paths, we could even display in ":/" pathspec
notation. Users who don't recognize them either look up documentation,
or gradually learn to drop the ":/" part, even without know what it's
for.

Repo modification commands like git-add could cause greater confusion
(I added and committed it (on the other repo), but when I pushed (on
this repo), the changes aren't there). We could and probably should
avoid dwim-ing these cases.

A good way to make it clear you're accessing another repository is
prompt (y/n) from users. I don't think pressing Ctrl-C to abort the
command is too much hassle (the command would fail anyway with
"outside repository" message, without dwim).

> A worse thing is that there is an oddball case "diff[ --no-index]"
> that changes behaviour depending on the pathspec points at inside or
> outside the repository.

Yep. But not many commands do this fortunately (diff and grep only?)

> I think that this is a road to insanity; anybody who thinks along
> this line is already on the other side of the line, I would have to
> say ;-).

We could go slowly and stop before being diagnosed insane. I mean the
trick can be opted in for a command subset where it makes sense to do
so.
-- 
Duy
