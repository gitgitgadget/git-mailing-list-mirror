From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Sun, 5 Feb 2012 22:17:00 +0700
Message-ID: <CACsJy8BRRWnPhO6U_WrfXa_pr0R0Zm9m=ZRgVjpUERYkELjxwA@mail.gmail.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com> <CACsJy8DkLCK0ZUKNz_PJazsxjsRbWVVZwjAU5n2EAjJfCYtpoQ@mail.gmail.com>
 <4F2E99C2.7090609@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 16:18:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru3qq-00006A-6h
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 16:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab2BEPRc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 10:17:32 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40365 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab2BEPRb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 10:17:31 -0500
Received: by wics10 with SMTP id s10so3643190wic.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 07:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bCIUvCUo769RwkFDW1QF60QmD7bgcJw1qn5nD8Nj488=;
        b=BY9blkfE4kGo4ScPPj4m7bBpLKrSb9FDmwgTvOjBOwZfuy8YyBrrLJHrXHEwZ8njRQ
         XTOcEyr5+BV14kF0fnt74BHtGe8l1khQfMENpLR+wSDU3QN6NsXKyT4br+mAZi7ejwbw
         OKlLqiItqa0C6e/ytyRoKplv5Ht/h1inJfCFE=
Received: by 10.180.19.97 with SMTP id d1mr22433582wie.12.1328455050250; Sun,
 05 Feb 2012 07:17:30 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Sun, 5 Feb 2012 07:17:00 -0800 (PST)
In-Reply-To: <4F2E99C2.7090609@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189944>

On Sun, Feb 5, 2012 at 10:01 PM, Tomas Carnecky <tom@dbservice.com> wro=
te:
> On 2/4/12 7:53 AM, Nguyen Thai Ngoc Duy wrote:
>>
>> On Fri, Feb 3, 2012 at 9:20 PM, Joshua Redstone<joshua.redstone@fb.c=
om>
>> =C2=A0wrote:
>>>
>>> I timed a few common operations with both a warm OS file cache and =
a cold
>>> cache. =C2=A0i.e., I did a 'echo 3 | tee /proc/sys/vm/drop_caches' =
and then
>>> did
>>> the operation in question a few times (first timing is the cold tim=
ing,
>>> the next few are the warm timings). =C2=A0The following results are=
 on a
>>> server
>>> with average hard drive (I.e., not flash) =C2=A0and> =C2=A010GB of =
ram.
>>>
>>> 'git status' : =C2=A0 39 minutes cold, and 24 seconds warm.
>>>
>>> 'git blame': =C2=A0 44 minutes cold, 11 minutes warm.
>>>
>>> 'git add' (appending a few chars to the end of a file and adding it=
): =C2=A0 7
>>> seconds cold and 5 seconds warm.
>>>
>>> 'git commit -m "foo bar3" --no-verify --untracked-files=3Dno --quie=
t
>>> --no-status': =C2=A041 minutes cold, 20 seconds warm. =C2=A0I also =
hacked a version
>>> of git to remove the three or four places where 'git commit' stats =
every
>>> file in the repo, and this dropped the times to 30 minutes cold and=
 8
>>> seconds warm.
>>
>> Have you tried "git update-index --assume-unchaged"? That should
>> reduce mass lstat() and hopefully improve the above numbers. The
>> interface is not exactly easy-to-use, but if it has significant gain=
,
>> then we can try to improve UI.
>>
>> On the index size issue, ideally we should make minimum writes to
>> index instead of rewriting 191 MB index. An improvement we could do
>> now is to compress it, reduce disk footprint, thus disk I/O. If you
>> compress the index with gzip, how big is it?
>
> If you're not afraid to add filesystem-specific code to git, you coul=
d
> leverage the btrfs find-new command (or use the ioctl directly) to qu=
ickly
> find changed files since a certain point in time. Other CoW filesyste=
ms may
> have similar mechanisms. You could for example store the last generat=
ion id
> in an index extension, that's what those extensions are for, right?

Sure they could be stored as index extensions. I'm more concerned of
the index size. I guess fs-specific code, if properly implemented
(e.g. clean, handling repos crossing fs boundaries, moving repos...),
may get Junio's approval. There were also talks of implementing NTFS's
journal (or something) on msysgit for similar goal.
--=20
Duy
