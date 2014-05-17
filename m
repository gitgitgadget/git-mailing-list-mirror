From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: Problem: staging of an alternative repository
Date: Sat, 17 May 2014 09:31:33 -0700
Message-ID: <CAKpPgvdC3VEHoW4eqmjoPtr4Duh8hkaeHL-JehaVMVUAdGhLAw@mail.gmail.com>
References: <CAKpPgveXqraM4bXb499mJm5Ls+EinihfEJ6VgOFikC0_Qp8iTA@mail.gmail.com>
 <20140430213545.GV9218@google.com> <CACsJy8C4bO_ZB-DMOkbJc9cJd_LmR6z0RZ1UZB3wKPEX005xmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 18:32:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlhXE-0003yT-Kx
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 18:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbaEQQbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 12:31:55 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:52383 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964773AbaEQQby (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 12:31:54 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so4449995oag.2
        for <git@vger.kernel.org>; Sat, 17 May 2014 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TCm0HoCpNV2tASZ4JhFNHENGDyL39dGRTpC5t/RF/j0=;
        b=bLvBgw/aXZSC1F14s/fTjUBV9Y2+iyriiaVDSc4ST3Hg59U+QpkgC6Nsk2+vE/mdwR
         jHZOWxbu6scXc0GBD2wO/iAC8E4NrcCCNIDZWIlFsWUDmjKLxRG7INyKJbllqvMefl3W
         TCEL7W7hqBwXpguBOy+l8UBn1XaJ4Tx55yUDj4P0Y5d/bzHwBEg5aZQYPoBq77VrqfBz
         4u2n/qvaK/kjnk5SpbEFeQTCYdtLxLI1SXnU9aXUifPfbboyAdK/7Co24b3wTJzb3VfL
         +514oVaUrQd7yGycm/TFDeKb32FeRFbP56rp3IOMrkPGSJ0u/aqszgcBTGKXlJxaMGhN
         1fzA==
X-Received: by 10.182.42.228 with SMTP id r4mr25037437obl.20.1400344313563;
 Sat, 17 May 2014 09:31:53 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Sat, 17 May 2014 09:31:33 -0700 (PDT)
In-Reply-To: <CACsJy8C4bO_ZB-DMOkbJc9cJd_LmR6z0RZ1UZB3wKPEX005xmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249488>

        Hi again

    I've come up with a fix for this. It's just two and a half lines,
and required more studying the code than typing.
A lot of path-processing work has been implemented in "abspath.c" and
"dir.c", including the symlinks and checking whether one path is a
subdirectory of another. I just added an "exclude" for GITDIR without
touching anything else.

    Now the best place to add that exclude would probably be "git.c",
right after the option "--git-dir" is processed. But this is not
actually the place where excludes are initialized or used any how.
Since initialization of excludes is done more or less individually by
each command concerned about them, the most "centralized" place
happens to be dir:setup_standard_excludes(), and that's where I did
it. One of the (side?) effects is that the excludes work in such a way
that any directory named ".metadata" in the directory tree will be
ignored once "-git-dir=.metadata" has been given

    Now if you guys don't see anything against this, I would shoot out a patch?

    regards
Pasha


On Thu, May 1, 2014 at 11:20 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, May 1, 2014 at 4:35 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>>     Now I know, the '--git-dir' option may usually be meant to use
>>> when the repository is somewhere outside of the work tree, and such a
>>> problem would not arise. And even if it is inside, sure enough, you
>>> can add this '.git_new' to the ignores or excludes. But is this really
>>> what you expect?
>>
>> I think it's more that it never came up.  Excluding the current
>> $GIT_DIR from what "git add" can add (on top of the current rule of
>> excluding all instances of ".git") seems like a sensible change,
>> assuming it can be done without hurting the code too much. ;-)
>
> I think it came up before. Changes could be very messy (but I did not
> check carefully) because right now we just compare $(basename $path)
> with ".git", one path component, simple and easy. Checking against
> $GIT_DIR means all path components. You also have to deal with
> relative and absolute paths and symlinks in some path components. You
> may also need to think if submodule detection code (checking ".git"
> again) is impacted. On top of that, read_directory() code is already
> messy (or at least scary to me) with all kinds of shortcuts we have
> added over the years. A simpler solution may be ignoring all
> directories whose last component is  "$GIT_DIR_NAME" (e.g.
> GIT_DIR_NAME=.git_new).
> --
> Duy
