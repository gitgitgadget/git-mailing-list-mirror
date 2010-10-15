From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Fri, 15 Oct 2010 13:15:35 -0700
Message-ID: <40CE50FF-C2F0-4403-9248-1D8872BF567E@sb.org>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org> <AANLkTimkBsTN-gJ5Wwe_Y=UxSpSpYhn8HcZyUDGngLPn@mail.gmail.com> <F06C63D1-26AE-4278-96CE-2F6B2D6DD300@sb.org> <20101013121552.GA29486@do> <3F6772ED-7BCA-4ED0-B089-0E3C4CBDF015@sb.org> <AANLkTim8wTQiX5L1gcXWNR9xuTPATxY6_+0Q=KdoxpPL@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 22:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6qhf-0000zO-Ml
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 22:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704Ab0JOUPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 16:15:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51816 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932553Ab0JOUPl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 16:15:41 -0400
Received: by pwj4 with SMTP id 4so230972pwj.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 13:15:41 -0700 (PDT)
Received: by 10.142.213.3 with SMTP id l3mr1070081wfg.6.1287173741376;
        Fri, 15 Oct 2010 13:15:41 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm7658153wfh.3.2010.10.15.13.15.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 13:15:38 -0700 (PDT)
In-Reply-To: <AANLkTim8wTQiX5L1gcXWNR9xuTPATxY6_+0Q=KdoxpPL@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159137>

On Oct 15, 2010, at 5:57 AM, Nguyen Thai Ngoc Duy wrote:

> On Fri, Oct 15, 2010 at 6:01 PM, Kevin Ballard <kevin@sb.org> wrote:
>> Got around to glancing at your patch. Looks pretty good, and it does build if you simply define EXC_FLAG_STARSTAR, though there are a few changes that are definitely necessary (a path of "*" will cause this to run off the end of the string while trying to detect "**/"). I'll have some more time next week to take a much closer look though. As for performance, I'm not particularly worried. The only performance change is if EXC_FLAG_STARSTAR is checked, in the worst-case it'll try to apply the pattern once per level of directory nesting. As this is just string twiddling, it's bound to be pretty fast, and I don't think there's any viable alternative to doing this kind of loop anyway. That said, I'd still like to support putting **/ anywhere in the pattern instead of just at the beginning, a
 nd possibly even support ** (without the trailing /).
> 
> Well that would mean reimplementing fnmatch(). I don't know, maybe
> it's not hard to do that. '*' can already match '/' if FNM_PATHNAME is
> not given. So one just needs to tell fnmatch() '**' is '*' without
> FNM_PATHNAME.
> 
> "**/" optimization can be extended to support "path/to/**/" quite
> easily as long as no wildcards are used in "path/to/" part.

I think both cases can be dealt with while still using fnmatch(). We can split the string along all instances of "**" and then match each pattern segment with fnmatch() along parts of the path. If a given segment matches part of the path, then we can assume that's correct and move on (e.g. never backtrack to the ** before it). The only specialization is the very last path segment has to match at the end of the path, and we can use slash-counting in each path segment in order to figure out how to slice up the path to pass to fnmatch().

>> If we do support ** by itself, I wonder if we should special-case having ** as the last path component of the pattern. The possible behavior change we could have is making this only match files and not directories. The use-case here is putting something like "foo/**" in the top-level .gitignore and then a few levels into foo we could put another .gitignore with an inverse pattern in order to un-ignore some deep file (or just "!foo/*/*/bar.c" inside that top-level .gitignore as well). The only way I can think of to achieve this behavior with the current gitignore is something along the lines of
>> 
>> foo/*
>> !foo/bar/
>> foo/bar/*
>> !foo/bar/baz/
>> foo/bar/baz/*
>> !foo/bar/baz/bar.c
>> 
>> And even this will only work if you know all the intermediate directories. I cannot think of any way at all right now to ignore everything in a single directory except for one file at least 1 level of nesting deeper if you don't know the names of the intermediate directories. With the proposed special-case we can say
>> 
>> foo/**
>> !foo/*/*/bar.c
>> 
>> and it will behave exactly as specified.
>> 
>> It occurs to me that we could actually tweak this slightly, to say that if a ** is encountered and there are zero slashes in the pattern after it, then it will only match files (with zero or more leading directories). This way you can have a pattern "foo/**.d" which only ignores files with the extension ".d" but will still avoid ignoring directories that end in ".d".
> 
> No idea. Seems overkill to me. But I don't use .gitignore heavily. For
> really complex ignore rules, how about allowing an external process to
> do the job? It would keep .gitignore syntax simple, yet powerful when
> needed.
> 
> A leading '|' marks an external process and can be used intermixed
> with normal patterns in .gitignore. When excluded_from_list examines a
> '|' pattern, it sends all information to the associated process' stdin
> and expects to a result code in stdout. The process is started when it
> is examined the first time and is kept alive until git process
> terminates.

That would certainly be powerful, but I don't know how much work it would take to implement. I still haven't really looked at the gitignore code yet. I think this is a good suggestion to do, but I still want to handle ** natively if possible.

-Kevin Ballard