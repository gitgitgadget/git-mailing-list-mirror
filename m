From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 22/22] untracked cache: guard and disable on system changes
Date: Mon, 10 Nov 2014 06:47:29 +0700
Message-ID: <CACsJy8AM2pADQy8+eAsAdikW3gGKwtTjvqBzojPRCzuD1jQ+Jw@mail.gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com> <1415439595-469-23-git-send-email-pclouds@gmail.com>
 <545FDF22.2020404@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 00:48:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XncDH-0008EG-2b
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 00:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbaKIXsA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 18:48:00 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:43116 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaKIXsA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 18:48:00 -0500
Received: by mail-ie0-f172.google.com with SMTP id at20so8275928iec.31
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 15:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LlZxsjwJgqGARmRCt9cJU6CxsDPwM81/5vJf7Xj2RIs=;
        b=n+Aez8yniW73X/7s186XJY4oOjIu7z9DoBpC/r9sCeln2kxXbIjo5wf8Co3nSwVzo4
         hphTTzDENPJMO8xCj3G//RWvedXBdFrchGKw1oF5ZUQaVO2Anvba1Q8IGOpAcIvQNxl3
         3s4DtoevwKHNT63dlTIkmZqx77wA6ykiji+/iR1Re3fOJOhqMUG89YvhMnHVluJ56B7n
         Yg76nCGBE2BS/VXDwHWkf6w+ZxcBYBiKD2iSgv10oH1E2e1+FXZJ9nZhMIfjIP6VFN5/
         sZCUPqsRn3DyBXBVFIlIrETmvDmGVNo56aPaGvFC55DwmgxtMJGp3WpJJNY5I9EUD41q
         Npew==
X-Received: by 10.107.35.13 with SMTP id j13mr5420294ioj.55.1415576879314;
 Sun, 09 Nov 2014 15:47:59 -0800 (PST)
Received: by 10.107.176.8 with HTTP; Sun, 9 Nov 2014 15:47:29 -0800 (PST)
In-Reply-To: <545FDF22.2020404@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 4:39 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2014-11-08 10.39, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> If the user enables untracked cache, then
>>
>>  - move worktree to an unsupported filesystem
>
> How do we detect this move ?
> Shouldn't we be able to detect an unsupported file system
> (by probing if stat(root_dir_of_repo) =3D=3D stat(what_we_have_in_ind=
ex_file))

I don't see any generic way of detecting this. So I just save $(cwd)
and check if the repo is moved. False positive if you move your repo
within the same filesystem. If you move your stuff to a new filesystem
and mount it to the same place as before, my test fails.

>>  - or simply upgrade OS
>>  - or move the whole (portable) disk from one machine to another
> How does this effect Git ?
> I would rather expect an update of Git to be an issue,
> but knowing that Git strongly tends to be backward compatible, there
> shouldn't be a issue.

If this link [1] is true and you use vfat on Linux, then we should
disable the cache when moving it to Windows.

[1] http://support.microsoft.com/kb/299648

>>  - or access a shared fs from another machine
> This is interesting.
> I have done some basic test on git.git using a medium fast laptop
> talking to a medium fast server using a medium normal WLAN.
> git status was is in a range of 2-3 seconds, with your patch 1-1.5 se=
conds.
>
> (That all depends on the network load, some caching here or there)
>
> But roughly twice the speed, very nice!

=46or network fs, that's probably about it. For local fs, we still have
watchman option to speed it up a little more. Still not sure if I can
beat ".. made Mercurial's status command more than 5x faster than
Git's status command."

> I am not really sure when we need this protection.
> What I understand is that stat(dir).mtime must be reliable.

Yes and [1] shows that mtime is not reliable, at least on Windows+vfat.

> Another problem may be mixing old Git with new Git, but the old Git
> should write an index file without UNTR, and we should be safe ?
> The new Git will write an index file with UNTR, which the old Git wil=
l ignore.

Old git should ignore (and discard) untr extension and go with the slow=
 old way.
--=20
Duy
