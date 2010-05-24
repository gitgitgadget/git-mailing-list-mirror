From: Tomas Pospisek <tpo@sourcepole.ch>
Subject: Re: Bug? file at the same time being deleted and not registered
Date: Mon, 24 May 2010 10:02:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1005240932130.7107@tpo-laptop>
References: <alpine.DEB.2.00.1005232245220.18372@tpo-laptop> <20100523234459.GA8285@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-596278452-1274688134=:7107"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 24 10:04:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGSeT-0002oU-Fj
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 10:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab0EXICf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 04:02:35 -0400
Received: from pizol.sourcepole.ch ([80.74.153.203]:62035 "EHLO
	pizol.sourcepole.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab0EXICe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 04:02:34 -0400
Received: from cable-dynamic-87-245-106-94.shinternet.ch ([87.245.106.94] helo=localhost)
	by mail.sp-metanet with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <tpo_hp@sourcepole.ch>)
	id 1OGSc8-0007uI-Ct; Mon, 24 May 2010 10:02:29 +0200
X-X-Sender: tpo@tpo-laptop
In-Reply-To: <20100523234459.GA8285@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-SA-Score: -4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147607>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-596278452-1274688134=:7107
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 23 May 2010, Jeff King wrote:

> On Sun, May 23, 2010 at 11:09:53PM +0200, Tomas Pospisek wrote:
>
>> So we have a file that was committed, that git thinks it's scheduled to =
be
>> deleted and at the same time is untracked. Doesn't make any sense,
>> does it?
>>
>> This happens only on the mhddfs backed filesystem. The same procedure
>> works well in /tmp or on plain ext3.
>>
>> Here's the strace of the commit step (from a identical try):
>>
>>    http://pastebin.com/htUmWYGh
>>
>> Jan 'jast' Kr=C3=BCger from the git IRC channel spotted in that strace t=
he
>> fact that the 'link' call is failing.
>>
>> In that case IMHO git should complain and let the user know, that
>> something went wrong and it can't proceed meaningfully.
>
> If you mean this (from your strace):
>
>  link(".git/objects/df/tmp_obj_cL0wfQ", ".git/objects/df/2b8fc99e1c1d4dbc=
0a854d9f72157f1d6ea078") =3D -1 ENOSYS (Function not implemented)
>
> Note that it is immediately followed by:
>
>  rename(".git/objects/df/tmp_obj_cL0wfQ", ".git/objects/df/2b8fc99e1c1d4d=
bc0a854d9f72157f1d6ea078") =3D 0
>
> IOW, git tries the hard-link first, then falls back to the rename. If
> the rename also fails, git does complain. So I don't think that is your
> problem.

(Yes, I was refering to those lines)

> I would guess your real problem is that when we traverse the directory
> structure and see "a_file", for some reason git is not connecting that
> with the index entry for "a_file". In the past, problems like this are
> usually due to filesystems which munge the filename behind git's back.
> I.e., if you do "touch foo" you get some file whose name _looks_ like
> "foo" but is not bit-for-bit compatible. HFS will do this when
> normalizing utf8 characters, but I don't think we've ever seen it on
> anything as plain as "a_file".
>
> Can you try running the output of "git diff-files --name-only" and "git
> ls-files -o" through xxd or something that would show individual bytes?
> My suspicion is that the "a_file" shown in each may not be bit-for-bit
> identical.

  $ git diff-files --name-only
  $ # no output at all

  $ git ls-files -o | xxd
  0000000: 615f 6669 6c65 0a                        a_file.
  $ ls|xxd
  0000000: 615f 6669 6c65 0a                        a_file.

For completeness:

  $ git ls-files
  $ git ls-files -c
  $ git ls-files -d
  $ git ls-files -m
  $ git ls-files -s
  $ git ls-files --directory
  $ git ls-files -u
  $ git ls-files -k
  $ git ls-files -t
  $ git ls-files -o -t
  ? a_file
  $ git ls-files --full-name -o
  a_file
  $ git ls-files -s a_file
  $ # nothing


However:

  $ pwd
  /home/tpo/src/projects/abook/bar
  $ ls
  a_file
  $ realpath a_file
  /mnt/mhddfs/home/tpo/src/projects/abook/bar/a_file

Which is because:

  $ ls -l /home/tpo/|grep src
  lrwxrwxrwx  1 tpo tpo     24 2008-08-14 10:29 src -> /mnt/mhddfs/home/tpo=
/src


The 'name' trail might be the right one though, because mhddfs will=20
distribute its files on different backing filesystems (I thin depending on=
=20
where it still has space left). However I 'stat'ed all files below the=20
working directory (including a_file and .git*) and they're all on the same=
=20
device.

*t
--8323329-596278452-1274688134=:7107--
