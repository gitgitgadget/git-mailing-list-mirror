From: Dmitry Neverov <dmitry.neverov@gmail.com>
Subject: Re: Git gc removes all packs
Date: Fri, 27 Feb 2015 11:16:09 +0100
Message-ID: <CAC+L6n3OFYsjm+5PMW3DBzJo7LnUsxRq1TRE4PMvFvWVG6DQ+A@mail.gmail.com>
References: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com>
	<20150205200332.GD15326@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 27 11:16:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRHxw-0001PA-VN
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 11:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbbB0KQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 05:16:12 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36159 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbbB0KQK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 05:16:10 -0500
Received: by wghk14 with SMTP id k14so19083598wgh.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 02:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/TuPtn6D9DCUnz0ndPTCsaAcys3034gCxDVNenhj47U=;
        b=m6Z5lu/DnmZfmN+1PBxTwPIGzLa+i2xu4SgETPmBAqsDzC5WEn0EVkZcH10rg9IKBE
         kTOZAu9yVAzBSMFyVyJ95jQ867aon6NkAhTEZcbqiQgMEHmQBPe/mUIvtVRHCvA3kB41
         dMa86BQ4CwZHH3pVQo4qE9p1XrrveDqIl3YsOINE/QFBfyi3bUGKV6WTpZ3y1Xp82BEW
         7XL1HWzf+S3iRkPmpCaF9Z+PbDLpvY2TuZgcmHNvKlOrzUCQVTLS20/LdOc6BXbG684G
         aDWb+PVIxz6Rt0xn2XCyVJhRRaQ1P1eZDkvDR5zV9hid5pktwk8f/3x25vGvkGmrFMUG
         zFyA==
X-Received: by 10.195.13.168 with SMTP id ez8mr25797973wjd.30.1425032169467;
 Fri, 27 Feb 2015 02:16:09 -0800 (PST)
Received: by 10.194.106.9 with HTTP; Fri, 27 Feb 2015 02:16:09 -0800 (PST)
In-Reply-To: <20150205200332.GD15326@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264492>

I followed your advice and removed a symlink ref from my repository.
But didn't help.. automatic GC has just removed all packs again. May
alternates cause such a behavior? Are any ways to make gc log
somewhere why it removes packs?

On Thu, Feb 5, 2015 at 9:03 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 05, 2015 at 04:13:03PM +0100, Dmitry Neverov wrote:
>
>> I'm using git p4 for synchronization with perforce. Sometimes after 'git
>> p4 rebase' git starts a garbage collection. When gc finishes a local
>> repository contains no pack files only loose objects, so I have to
>> re-import repository from perforce. It also doesn't contain a temporary
>> pack git gc was creating.
>
> It sounds like git didn't find any refs; it will pack only objects which
> are reachable. Unreachable objects are either:
>
>   1. Exploded into loose objects if the mtime on the pack they contain
>      is less than 2 weeks old (and will eventually expire when they
>      become 2 weeks old).
>
>   2. Dropped completely if older than 2 weeks.
>
>> One more thing about my setup: since git p4 promotes a use of a linear
>> history I use a separate repository for another branch in perforce. In
>> order to be able to cherry-pick between repositories I added this
>> another repo objects dir as an alternate and also added a ref which is a
>> symbolic link to a branch in another repo (so I don't have to do any
>> fetches).
>
> You can't symlink refs like this. The loose refs in the filesystem may
> be migrated into the "packed-refs" file, at which point your symlink
> will be broken. That is a likely reason why git would not find any refs.
>
> So your setup will not ever work reliably.  But IMHO, it is a bug that
> git does not notice the broken symlink and abort an operation which is
> computing reachability in order to drop objects. As you noticed, it
> means a misconfiguration or filesystem error results in data loss.
>
> -Peff
