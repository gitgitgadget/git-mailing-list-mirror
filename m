From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] On watchman support
Date: Tue, 18 Nov 2014 17:48:50 +0700
Message-ID: <CACsJy8BfxP7KF1XF29BOgC6XhO8iAy-ycEoLkDG5rn6TYH_DrA@mail.gmail.com>
References: <20141111124901.GA6011@lanh> <1416270336.13653.23.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 11:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqgLn-0001La-7k
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 11:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381AbaKRKtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 05:49:31 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38479 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbaKRKta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 05:49:30 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so3285546iec.33
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 02:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kiXsGalkpaWOC6YrfrFuLlKIj6XlmVDH5evANXeKLwI=;
        b=XsDsrqVYvFuw/5YkZKG47lK1WADwJpBZa30SgPif3UQr3gO9LBjQBdUnrzUUzt5AZz
         93NGmAajNfxR1Je0JhYtnyIF+6LuD0iu36C0xG7yP/KPwfH7Pxnm7GiILPgIGZ7L5Eie
         Lsf2S2ygueHxtkSDquqFhGvScEeGMjy2zQ228Bhe66srYPy3h2MFVrlary9tW6qPmPP9
         EUZMbOPNVG3JtbQR3D0Q7xow6QEEtWCOe9Xr5jiH0Y7Y7X6MRMKqW9GToby20RtPOk34
         kcIbnAcURIK84gBWcTb3zSrfh8ig0Ntqxe5jLPESIhuniJ2UYl+dSWEBjBmY1herrYef
         MfxQ==
X-Received: by 10.43.76.67 with SMTP id zd3mr34351653icb.42.1416307760236;
 Tue, 18 Nov 2014 02:49:20 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Tue, 18 Nov 2014 02:48:50 -0800 (PST)
In-Reply-To: <1416270336.13653.23.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 7:25 AM, David Turner <dturner@twopensource.com> wrote:
>> So we got a few options:
>>
>> 1) Convince watchman devs to add something to make it work
>
> Based on the thread on the watchman github it looks like this won't
> happen.

Yeah. I came to the conclusion that I needed an extra daemon. And
because I would need an extra daemon anyway to speed up index read
time, that one could be used for caching something else like watchman.
It works out quite nice: because watchman is not tied to the main
'git' binary, people don't need libwatchman and libjansson by default.
When people want watchman, they can install an extra package that
includes the index-helper and its dependencies. This only matters for
binary-based distros of course.

>> Comments?
>
> I don't think it would be impossible to add Windows support to watchman;
> the necessary functions exist, although I don't know how well they work.
> My experience with watchman is that it is something of a stress test of
> a filesystem's notification layer.  It has exposed bugs in inotify, and
> caused system instability on OS X.

The way i'm adding watchman to index-helper should work on Windows as
well, IPC is really simple. But let's wait and see.

> My patches are not the world's most beautiful, but they do work.  I
> think some improvement might be possible by keeping info about tracked
> files in the index, and only storing the tree of ignored and untracked
> files separately.  But I have not thought this through fully.  In any
> case, making use of shared memory for the fs_cache (as some of your
> other patches do for the index) would definitely save time.

By the way, what happened to your sse optimization in refs.c? I see
it's reverted but I didn't follow closely to know why. Or will you go
with cityhash now.. I ask because you have another sse optimization
for hashmap on your watchman branch and that could reduce init time
for name-hash. Name-hash is used often on case-insensitive fs (less
often on case-sensitive fs).

I did a simple test and your optimization could init name-hash (on
webkit) in 35ms, while unmodified hashmap took 88ms. Loading index on
this machine took 360ms for reference (probably down too 100ms with
index-helper running, when that 88ms starts to become significant).
-- 
Duy
