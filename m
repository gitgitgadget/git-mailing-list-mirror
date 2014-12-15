From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 23/23] untracked cache: guard and disable on system changes
Date: Mon, 15 Dec 2014 10:02:22 +0700
Message-ID: <CACsJy8DLus+M65FCw=rrBStLXnWOmCJRm2NidWth9Roj8zAodw@mail.gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
 <1418047507-22892-25-git-send-email-pclouds@gmail.com> <20141209100430.GC76457@vauxhall.crustytoothpaste.net>
 <CACsJy8A5-smRXN0k5TK8uPg4-j-Z83KWLNSO_w-eFivTNB_www@mail.gmail.com>
 <5487D543.7060801@web.de> <CACsJy8BPzcAPJZG4=+mt=LmhhheJjXkfD2+znMjBbjbB9mODDQ@mail.gmail.com>
 <548A0175.6000008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 15 04:03:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0Lw2-0002ay-K6
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 04:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbaLODCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2014 22:02:55 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:40738 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaLODCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Dec 2014 22:02:53 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so10050408ieb.9
        for <git@vger.kernel.org>; Sun, 14 Dec 2014 19:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cIbcoT/MJsqPrQamSHTkdWMon5bz914BiAJ5z3/vn0g=;
        b=dAyujw0484OCzXG8Gac4Xqj9RapA2o8F+IRAnJ0O+S2615N8HCirdVT59jwAg41ED+
         +E2vBWiHCug38wrlZ8LVqV/78GABoM8pupn8egG+mjMYUZaoqF4LlleTULwrUT21pUM5
         tJQzxKOhZQR/516S7xgMdulJVaPrykPHnvlk1Nx53Hr8lXP8yHtu52YUpPxc6/uKg9L6
         DnbXg1+WibIxbkOOqMnO/E+rngmIPB9Ta8BJQOi3V/tLplb8gCB+0+hw+vTgO5mEe73+
         OyDwOXm6X+YjQByje75NGTcfMXY42qJUo5jiPfT2ldDE5sDosY7fUI/QfBTNaV5TvIq4
         d02A==
X-Received: by 10.51.17.73 with SMTP id gc9mr5602867igd.7.1418612573051; Sun,
 14 Dec 2014 19:02:53 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Sun, 14 Dec 2014 19:02:22 -0800 (PST)
In-Reply-To: <548A0175.6000008@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261405>

On Fri, Dec 12, 2014 at 3:41 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> Even if I share the the concerns that the cache may work on one syste=
m,
> but not on the other, there should be better ways to protect from tha=
t.
>
> Using the uname does not really help, if you move one repo from NTFS =
to VFAT,
> we will not detect it (assuming we use Windows).
> (And how much do we need to support the move of a repo ?)
>
> There is a concern that this may not work, when different clients are=
 accessing
> the repo, using the UNTR extension.
>
> Some kind of sanity check would be good to have, what can be done ?
> The most important things are the timestamps.
> I can think of 2 sanity checks:
> - If the modified time stamp of a directory is older then the create =
time of any file,
>   the UNTR cache can not be used.
> - If the timestamp of a file changes, but the sha1 sum is the same, w=
hat does this mean?
>   The file (or the whole repo) has been copied, or the time stamping =
does not work.
>
> A simple verification of the FS could be to stat() .git/, create a te=
mp file, delete it and
> stat() again. If mtime does not change, the FS is unusable for UNTR.

This is a slow test. Some filesytem only supports second resolution
timestamps. If you create and delete the file so fast, mtime may
remain in the same second even if the fs is supported. We need to wait
a second between those operations (this is why "update-index
--untracked-cache" takes several seconds). So it cannot be done often
(i.e. at startup of every command)

> Then we could extend the uname idea:
> Create a string in UNTR which is a collection of lines like this:
>
> Working-For: Linux;/mnt/nfs/projects/project1
> Not-OK-For: WIndows:/a:/project1
> (Of course the strings can be made nicer, and '\n' is URL-encoded.)
>
> Each system that is not listed needs to probe the repo, add another l=
ine
> and re-write the index.
>
> We can even add a "best-for" line, and invalidate the UNTR every 12 h=
ours or so.

It starts to look complicated. How about letting the user deal with
it? UNTR will support storing multiple "location" lines. Whenever UNTR
is needed at a new location, it's disabled. The user has to use
'update-index' to test the new location and add it to UNTR. The user
can choose to keep current locations (network access), or replace them
all with the new one (repo move), or just mark the new location
unusable so the extension is kept for use in other places, but warning
at this place is suppressed. THe "localtion" consists of worktree
path, system name and host name.

> Should we think about having an ASCII area for additional information=
, which is part
> of the stone, but the content is flexible ?

These lines are already in free form. If the running system generates
the same string as stored in UNTR, it's allowed to use the extension.
We need code to understand this content, so flexibility must be within
limit..
--=20
Duy
