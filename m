From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 23/23] untracked cache: guard and disable on system
 changes
Date: Thu, 11 Dec 2014 21:41:25 +0100
Message-ID: <548A0175.6000008@web.de>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com> <1418047507-22892-25-git-send-email-pclouds@gmail.com> <20141209100430.GC76457@vauxhall.crustytoothpaste.net> <CACsJy8A5-smRXN0k5TK8uPg4-j-Z83KWLNSO_w-eFivTNB_www@mail.gmail.com> <5487D543.7060801@web.de> <CACsJy8BPzcAPJZG4=+mt=LmhhheJjXkfD2+znMjBbjbB9mODDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 21:41:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzAYP-0003Q8-Qx
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 21:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758989AbaLKUlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Dec 2014 15:41:37 -0500
Received: from mout.web.de ([212.227.17.11]:59111 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758987AbaLKUlg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 15:41:36 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MUFGo-1YP7eR1cmo-00Qx29; Thu, 11 Dec 2014 21:41:33
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CACsJy8BPzcAPJZG4=+mt=LmhhheJjXkfD2+znMjBbjbB9mODDQ@mail.gmail.com>
X-Provags-ID: V03:K0:bq/RsAJmvuZsmdxyj/l/JU5b2UMxMLry7DD0TVTTJoXkwOzjU9R
 dxtlWv5YR1k9a1b2Zrr/oDWXHTGoL0yYjkGwSTDoIXqRPfyeIw3zpa9AxAPTc/Uwd2nGUNu
 qTB9CZLsW7sHZCQeYeeB04p7RjYsXU6Tksd1vINyoiMBq132vgfs3trCs+5z47ktSrrA5mT
 9EphHnS1c0+3JnibUdCUQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261291>

On 10.12.14 13:22, Duy Nguyen wrote:
> On Wed, Dec 10, 2014 at 12:08 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>> That opens another question:
>> How flexible/extensible/self-describing is the format of the UNTR ex=
tension
>> ?
>> If we drop the OS name & root dir check because it disallows network=
 use,
>> but later add a better method to verify that the underlying chain
>> local OS - network - remote OS-remote FS is OK,
>> do we need to change the file format of UNTR ?
>> If yes, can old clients read the new format and vice versa?
>> Do we need a version information of some kind, or does the
>> old client skip unknown entries like we do with extensions in the in=
dex ?
> The way index extensions are done so far, there's no actual versionin=
g
> inside an extension.Once an extension is out, its format is set in
> stone. If you change your mind, you make a new extension (with a
> different signature), so signatures are sort of "version". Code is
> shared mostly so it should not be a problem. Old clients don't
> recognize new extensions, so they drop them. New clients either stick
> to old extensions or convert them to new ones. This is all local
> matters, so I don't think we need to worry too much.
Thanks for the info.
Even if I share the the concerns that the cache may work on one system,
but not on the other, there should be better ways to protect from that.

Using the uname does not really help, if you move one repo from NTFS to=
 VFAT,
we will not detect it (assuming we use Windows).
(And how much do we need to support the move of a repo ?)

There is a concern that this may not work, when different clients are a=
ccessing
the repo, using the UNTR extension.

Some kind of sanity check would be good to have, what can be done ?
The most important things are the timestamps.
I can think of 2 sanity checks:
- If the modified time stamp of a directory is older then the create ti=
me of any file,
  the UNTR cache can not be used.
- If the timestamp of a file changes, but the sha1 sum is the same, wha=
t does this mean?
  The file (or the whole repo) has been copied, or the time stamping do=
es not work.

A simple verification of the FS could be to stat() .git/, create a temp=
 file, delete it and
stat() again. If mtime does not change, the FS is unusable for UNTR.

Then we could extend the uname idea:
Create a string in UNTR which is a collection of lines like this:

Working-For: Linux;/mnt/nfs/projects/project1
Not-OK-For: WIndows:/a:/project1
(Of course the strings can be made nicer, and '\n' is URL-encoded.)

Each system that is not listed needs to probe the repo, add another lin=
e
and re-write the index.

We can even add a "best-for" line, and invalidate the UNTR every 12 hou=
rs or so.

Should we think about having an ASCII area for additional information, =
which is part
of the stone, but the content is flexible ?

The patch-series really speeds up "git status" on a network, thanks for=
 working on it.
The next days^H^H^H^H weeks I will do some more tests, using different =
combinations
of OS and network protocols.
