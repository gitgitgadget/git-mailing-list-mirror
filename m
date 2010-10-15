From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PROPOSAL] .gitignore syntax modification
Date: Fri, 15 Oct 2010 04:01:37 -0700
Message-ID: <3F6772ED-7BCA-4ED0-B089-0E3C4CBDF015@sb.org>
References: <113B4C41-ECDA-479D-A281-DF6ACDFE8FBB@sb.org> <AANLkTimkBsTN-gJ5Wwe_Y=UxSpSpYhn8HcZyUDGngLPn@mail.gmail.com> <F06C63D1-26AE-4278-96CE-2F6B2D6DD300@sb.org> <20101013121552.GA29486@do>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 13:01:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6i2n-0008Tj-Qc
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 13:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab0JOLBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 07:01:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49336 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382Ab0JOLBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 07:01:40 -0400
Received: by iwn35 with SMTP id 35so791689iwn.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 04:01:40 -0700 (PDT)
Received: by 10.231.33.4 with SMTP id f4mr397467ibd.197.1287140500195;
        Fri, 15 Oct 2010 04:01:40 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id gy41sm12948676ibb.17.2010.10.15.04.01.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 04:01:39 -0700 (PDT)
In-Reply-To: <20101013121552.GA29486@do>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159111>

On Oct 13, 2010, at 5:15 AM, Nguyen Thai Ngoc Duy wrote:

> On Tue, Oct 12, 2010 at 07:32:54PM -0700, Kevin Ballard wrote:
>> As soon as I find the time, I'll be working on a patch for this. I
>> only wrote up the proposal because I want to make sure that what I
>> end up implementing is actually something that will be accepted. At
>> this point I'm actually in favor of simply assuming all paths that
>> don't start with / can be matched at any level but I recognize that
>> this is a change to existing functionality, though I personally
>> think that all patterns that are meant to match only at the current
>> level should be prefixed with / anyway. Would such a change to
>> existing behavior be rejected out-of-hand?
> 
> Yes, patterns that only match current level should be prefixed with a
> slash. There are also other cases apart from "current level only" and
> "any level": foo/a* will match only second level, not any level.

Sure, "foo/a*" will match second level only, but that's identical to "/foo/a*". I would have preferred the semantics of .gitignore to behave as if all patterns are prefixed with "**/" unless the pattern starts with "/", but that ship sailed a long time ago and I agree that it would be a bad idea to introduce that behavior now.

> I was thinking of doing like this. It's not complete (not even build)
> but it shows the idea. I don't think this way it will change existing
> behaviors. Performance is something I haven't thought through.
> 
> Anyway, what do you think? I'm afraid I don't have time to work on
> this. The pathspec unification work still needs to be done.

Got around to glancing at your patch. Looks pretty good, and it does build if you simply define EXC_FLAG_STARSTAR, though there are a few changes that are definitely necessary (a path of "*" will cause this to run off the end of the string while trying to detect "**/"). I'll have some more time next week to take a much closer look though. As for performance, I'm not particularly worried. The only performance change is if EXC_FLAG_STARSTAR is checked, in the worst-case it'll try to apply the pattern once per level of directory nesting. As this is just string twiddling, it's bound to be pretty fast, and I don't think there's any viable alternative to doing this kind of loop anyway. That said, I'd still like to support putting **/ anywhere in the pattern instead of just at the beginning, and 
 possibly even support ** (without the trailing /).

If we do support ** by itself, I wonder if we should special-case having ** as the last path component of the pattern. The possible behavior change we could have is making this only match files and not directories. The use-case here is putting something like "foo/**" in the top-level .gitignore and then a few levels into foo we could put another .gitignore with an inverse pattern in order to un-ignore some deep file (or just "!foo/*/*/bar.c" inside that top-level .gitignore as well). The only way I can think of to achieve this behavior with the current gitignore is something along the lines of

foo/*
!foo/bar/
foo/bar/*
!foo/bar/baz/
foo/bar/baz/*
!foo/bar/baz/bar.c

And even this will only work if you know all the intermediate directories. I cannot think of any way at all right now to ignore everything in a single directory except for one file at least 1 level of nesting deeper if you don't know the names of the intermediate directories. With the proposed special-case we can say

foo/**
!foo/*/*/bar.c

and it will behave exactly as specified.

It occurs to me that we could actually tweak this slightly, to say that if a ** is encountered and there are zero slashes in the pattern after it, then it will only match files (with zero or more leading directories). This way you can have a pattern "foo/**.d" which only ignores files with the extension ".d" but will still avoid ignoring directories that end in ".d".

This turned out a bit longer than intended, and slightly more rambling as well, and I apologize for that. I will revisit this again next week.

-Kevin Ballard