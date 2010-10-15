From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Fri, 15 Oct 2010 19:57:31 +0700
Message-ID: <AANLkTim8wTQiX5L1gcXWNR9xuTPATxY6_+0Q=KdoxpPL@mail.gmail.com>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org> <AANLkTimkBsTN-gJ5Wwe_Y=UxSpSpYhn8HcZyUDGngLPn@mail.gmail.com>
 <F06C63D1-26AE-4278-96CE-2F6B2D6DD300@sb.org> <20101013121552.GA29486@do> <3F6772ED-7BCA-4ED0-B089-0E3C4CBDF015@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Oct 15 14:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6jrR-00018i-MH
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 14:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352Ab0JOM6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 08:58:04 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48529 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab0JOM6D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 08:58:03 -0400
Received: by wwj40 with SMTP id 40so979101wwj.1
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qNqGL7DLU386/7+WM5pMwleW4poJ+zrJTU49B/396jw=;
        b=fjAjYhpqwur6M4/IflnhU4Y1wudoLqX4gbBNtgD/jvEy19icMaa6jBKqxsGW1lfP6D
         N4iQyXOl5iwE6on0F2GfCOCJ/ta3hitMNLDzzRLdhUzOw0IZZfWa4ISiR4DoARhxxo31
         hAP7QKLV7dQJug3eNM1HFNEMP4dchkDnDx8RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LMiQHgFhxkt3mC6uS71HqzfNRHFLBezyLlNJL5CywYXj2zYsWPhLAVX2/16tsAC8iB
         VMeKrg+Eo2dz+a46f+UbFui1suMRLr7ECZNmnXXr+0hOXESkOWNSqz/Djm9liypsXgIB
         8/TdDBBRq+cUkjeoDsCoewGNiw6cTz7ZG9RVU=
Received: by 10.216.136.27 with SMTP id v27mr1553135wei.12.1287147472345; Fri,
 15 Oct 2010 05:57:52 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Fri, 15 Oct 2010 05:57:31 -0700 (PDT)
In-Reply-To: <3F6772ED-7BCA-4ED0-B089-0E3C4CBDF015@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159119>

On Fri, Oct 15, 2010 at 6:01 PM, Kevin Ballard <kevin@sb.org> wrote:
> Got around to glancing at your patch. Looks pretty good, and it does build if you simply define EXC_FLAG_STARSTAR, though there are a few changes that are definitely necessary (a path of "*" will cause this to run off the end of the string while trying to detect "**/"). I'll have some more time next week to take a much closer look though. As for performance, I'm not particularly worried. The only performance change is if EXC_FLAG_STARSTAR is checked, in the worst-case it'll try to apply the pattern once per level of directory nesting. As this is just string twiddling, it's bound to be pretty fast, and I don't think there's any viable alternative to doing this kind of loop anyway. That said, I'd still like to support putting **/ anywhere in the pattern instead of just at the beginning, an
 d possibly even support ** (without the trailing /).

Well that would mean reimplementing fnmatch(). I don't know, maybe
it's not hard to do that. '*' can already match '/' if FNM_PATHNAME is
not given. So one just needs to tell fnmatch() '**' is '*' without
FNM_PATHNAME.

"**/" optimization can be extended to support "path/to/**/" quite
easily as long as no wildcards are used in "path/to/" part.

> If we do support ** by itself, I wonder if we should special-case having ** as the last path component of the pattern. The possible behavior change we could have is making this only match files and not directories. The use-case here is putting something like "foo/**" in the top-level .gitignore and then a few levels into foo we could put another .gitignore with an inverse pattern in order to un-ignore some deep file (or just "!foo/*/*/bar.c" inside that top-level .gitignore as well). The only way I can think of to achieve this behavior with the current gitignore is something along the lines of
>
> foo/*
> !foo/bar/
> foo/bar/*
> !foo/bar/baz/
> foo/bar/baz/*
> !foo/bar/baz/bar.c
>
> And even this will only work if you know all the intermediate directories. I cannot think of any way at all right now to ignore everything in a single directory except for one file at least 1 level of nesting deeper if you don't know the names of the intermediate directories. With the proposed special-case we can say
>
> foo/**
> !foo/*/*/bar.c
>
> and it will behave exactly as specified.
>
> It occurs to me that we could actually tweak this slightly, to say that if a ** is encountered and there are zero slashes in the pattern after it, then it will only match files (with zero or more leading directories). This way you can have a pattern "foo/**.d" which only ignores files with the extension ".d" but will still avoid ignoring directories that end in ".d".

No idea. Seems overkill to me. But I don't use .gitignore heavily. For
really complex ignore rules, how about allowing an external process to
do the job? It would keep .gitignore syntax simple, yet powerful when
needed.

A leading '|' marks an external process and can be used intermixed
with normal patterns in .gitignore. When excluded_from_list examines a
'|' pattern, it sends all information to the associated process' stdin
and expects to a result code in stdout. The process is started when it
is examined the first time and is kept alive until git process
terminates.
-- 
Duy
