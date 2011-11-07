From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] Documentation/gitignore: "foo/" patterns match
 directories, not files under them
Date: Mon, 7 Nov 2011 16:57:01 +0700
Message-ID: <CACsJy8CZFihbS8MrG=0gWdRPu6F0BqG2FLp48KDxOXWc+4amuQ@mail.gmail.com>
References: <20111107080449.GA30448@elie.hsd1.il.comcast.net> <20111107080711.GA30486@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Blake <eblake@redhat.com>,
	Johannes Sixt <j6t@kdbg.org>, "Y.G." <yamomo1@hotmail.com>,
	Eli Barzilay <eli@barzilay.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 10:57:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNLxT-0008Lq-6f
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 10:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab1KGJ5e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 04:57:34 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47068 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab1KGJ5d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 04:57:33 -0500
Received: by bke11 with SMTP id 11so3424740bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 01:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=U7s2R03J9idW02ZmNvzlD/AemPaRjLD7r2e8+4K1Zgo=;
        b=xMjSWIAiwUJHcG/OYIJ/NqNsBIGHD6gr1mYgiT05yegm6GtzgxsGgmZzRb4SIdTLbp
         ALyPvLsgL9ShYrVS98Xlo/iknjKN0g/b9zh/yN716sRrROSIiiUh+LgDgv3AzJodbAiD
         1ncI5orYZ4DhBUhWKPhLHmSlS2sFg2ryB2Sxk=
Received: by 10.204.143.74 with SMTP id t10mr7931286bku.45.1320659852144; Mon,
 07 Nov 2011 01:57:32 -0800 (PST)
Received: by 10.205.134.1 with HTTP; Mon, 7 Nov 2011 01:57:01 -0800 (PST)
In-Reply-To: <20111107080711.GA30486@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184968>

2011/11/7 Jonathan Nieder <jrnieder@gmail.com>:
> The gitignore(5) manpage says that "foo/" will match a directory foo
> and paths underneath it.

If git ignores a directory, then it essentially ignores all paths
underneath it, doesn't it?

> But that is completely false: as Johannes
> Sixt likes to remind us, patterns with a trailing '/' match the named
> directory, not files under that directory. =C2=A0For example, the fol=
lowing
> .gitignore file
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/build/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0!/build/tests/results
>
> does not un-ignore build/tests/results since it was never ignored in
> the first place; and commands like "git status" will not notice
> changes to build/tests/results because git doesn't enter the (ignored=
)
> build/ directory.

I haven't checked but I think it's because when a directory is
ignored, git just stops checking further ignore rules. So "build" _is_
ignored, too strongly that it does not care if some files may need to
be un-ignored later on.

I remember the argument was, because ignore rules are distributed
across .gitignore files, we would need to go into ignored directories
for collecting potential un-ignore rules (for example "!results" on
build/tests/.gitignore) and that just does not make much sense because
we always have to go into ignored directories.

But in your example, where we know we have negated rules, we should
follow the rules and ignore all but build/tests/results.

> Correct the manual to just say that "foo/" matches the directory
> "foo", and make the wording a little clearer in other ways while at
> it.

I haven't not read the next patches, maybe you have mentioned this
already. We should make clear that git does not look for negated rules
once a directory is ignored.

Your example however demonstrates a bug that should be fixed in my
opinion. So maybe one or two lines under BUGS section.

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> =C2=A0Documentation/gitignore.txt | =C2=A0 14 ++++++++------
> =C2=A01 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.tx=
t
> index 2e7328b8..5b070bf0 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -72,12 +72,14 @@ PATTERN FORMAT
> =C2=A0 =C2=A0included again. =C2=A0If a negated pattern matches, this=
 will
> =C2=A0 =C2=A0override lower precedence patterns sources.
>
> - - If the pattern ends with a slash, it is removed for the
> - =C2=A0 purpose of the following description, but it would only find
> - =C2=A0 a match with a directory. =C2=A0In other words, `foo/` will =
match a
> - =C2=A0 directory `foo` and paths underneath it, but will not match =
a
> - =C2=A0 regular file or a symbolic link `foo` (this is consistent
> - =C2=A0 with the way how pathspec works in general in git).
> + - If the pattern ends with a slash, it will only match
> + =C2=A0 directories. =C2=A0In other words, `foo/` will match a
> + =C2=A0 directory `foo` but will not match a regular file or a
> + =C2=A0 symbolic link `foo` (this is consistent with the way
> + =C2=A0 pathspecs work in general in git).

Looks good.

> ++
> +The trailing slash is removed before applying the remaining
> +rules.

Why does the trailing slash of a rule affect the remaining rules?
--=20
Duy
