From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] dir.c: fix ignore processing within not-ignored directories
Date: Sat, 1 Jun 2013 17:44:44 +0700
Message-ID: <CACsJy8D4wmhGkEsn8r5OEQv_hX=OFD5W8abnBnYFcFCQZfLOoQ@mail.gmail.com>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
 <CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com>
 <CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com>
 <51A62A96.6040009@gmail.com> <51A665E4.9080307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Misty De Meo <misty@brew.sh>,
	=?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 12:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UijJW-0001kU-K2
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 12:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721Ab3FAKpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 06:45:20 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:45581 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab3FAKpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 06:45:17 -0400
Received: by mail-lb0-f179.google.com with SMTP id r11so2464251lbv.38
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 03:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=34vtRbDasWe7G+NYpZLhFnBZmaV/PFP5wVFGB1mjdLs=;
        b=QagNWftlC8/p6euvrR9ZixVACG1ZBQzAZ9AzAVnTNv4M+icYvQ2CPXdhFbXLqhBqay
         qdo0LwYJH62Ow121fqBgW8WFBzORaK6Hnn0+uUfrHyIhn1+c5hZziGr0WA52qsjgVIGM
         eyMRyp/c27CaJtp9QmN06vqWvjWaVxEYwUXp94j5rW6mhK1fO18zg9Yv1fmw1WpetnTG
         VWbkRi2Z2ECvCbcjDzXDw/+m8a4RXvcYxRhev+7XGvYZECL39sby/c1wEhyPWIDAd0IY
         O+74LXR8srZdWf+a6mYkfK6SOrsTzU4yWZYH+TopwcQB9qUwjF5DP9ftobTXm6RuZUN/
         kN5w==
X-Received: by 10.112.182.10 with SMTP id ea10mr7430769lbc.36.1370083514153;
 Sat, 01 Jun 2013 03:45:14 -0700 (PDT)
Received: by 10.114.24.234 with HTTP; Sat, 1 Jun 2013 03:44:44 -0700 (PDT)
In-Reply-To: <51A665E4.9080307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226120>

On Thu, May 30, 2013 at 3:32 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> As of 95c6f271 "dir.c: unify is_excluded and is_path_excluded APIs", the
> is_excluded API no longer recurses into directories that match an ignore
> pattern, and returns the directory's ignored state for all contained paths.
>
> This is OK for normal ignore patterns, i.e. ignoring a directory affects
> the entire contents recursively.
>
> Unfortunately, this also "works" for negated ignore patterns ('!dir'), i.e.
> the entire contents is "not-ignored" recursively, regardless of ignore
> patterns that match the contents directly.
>
> In prep_exclude, skip recursing into a directory only if it is really
> ignored (i.e. the ignore pattern is not negated).
>
> Signed-off-by: Karsten Blees <blees@dcon.de>

I think I've got a hang on the "unify" patch now.

Reviewed-by: Duy Nguyen <pclouds@gmail.com>


> diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
> +test_expect_success 'excluded directory overrides content patterns' '
> +
> +       git ls-files --others --exclude="one" --exclude="!one/a.1" >output &&
> +       if grep "^one/a.1" output

Actually I think this is a shortcoming of gitignore. You ask to
"exclude one except one/a.1" and one/a.1 should show up. '!' is
designed from day one to deal with the other way around ("include one
except one/a.1"). And it's arguable (and it was in the mail archive)
that if you already exclude "one", we should never ever descend there
to pick up "!a.1" from one/.gitignore. But we should do it with
already collected patterns, at least if we detect there are negated
patterns following the pattern that excludes a directory, e.g.
!one/a.1 or even !*.c. For the latter case, the user can always move
"!*.c" up before "one" if they don't want git to misinterpret and
descend in every excluded directory.

> +       then
> +               false
> +       fi
> +'

Nit pick, maybe this instead?

test_must_fail grep "^one/a.1" output

> +
> +test_expect_success 'negated directory doesn'\''t affect content patterns' '
> +
> +       git ls-files --others --exclude="!one" --exclude="one/a.1" >output &&
> +       if grep "^one/a.1" output
> +       then
> +               false
> +       fi
> +'

Same.
--
Duy
