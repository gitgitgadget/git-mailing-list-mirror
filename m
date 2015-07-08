From: X H <music_is_live_lg@hotmail.com>
Subject: Re: Git force push fails after a rejected push (unpack failed)?
Date: Wed, 8 Jul 2015 22:28:51 +0200
Message-ID: <BLU436-SMTP166B786EBE483D3F47F666F6910@phx.gbl>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
 <20150707141305.GA629@peff.net> <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
 <20150707194956.GA13792@peff.net> <559D60DC.4010304@kdbg.org>
 <20150708180539.GA12353@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:29:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCvxf-0006ln-HF
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 22:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758299AbbGHU2v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 16:28:51 -0400
Received: from blu004-omc3s16.hotmail.com ([65.55.116.91]:52322 "EHLO
	BLU004-OMC3S16.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757946AbbGHU2u convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 16:28:50 -0400
Received: from BLU436-SMTP16 ([65.55.116.72]) by BLU004-OMC3S16.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Wed, 8 Jul 2015 13:28:49 -0700
X-TMN: [UlBA4eAdIQD7ILIGghj8RDJRSc2RYr9E]
X-Originating-Email: [music_is_live_lg@hotmail.com]
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <20150708180539.GA12353@peff.net>
X-OriginalArrivalTime: 08 Jul 2015 20:28:48.0014 (UTC) FILETIME=[B1B4A2E0:01D0B9BC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273707>

Le 8/07/2015 20:05, Jeff King a =C3=A9crit :
> On Wed, Jul 08, 2015 at 07:41:48PM +0200, Johannes Sixt wrote:
>
>>> Yes, but remember that git stores all of the objects for all of the
>>> commits. So for some reason your push is perhaps trying to send an
>>> object that the other side already has. Usually this does not happe=
n
>>> (the receiver says "I already have these commits, do not bother sen=
ding
>>> their objects"), but it's possible that you have an object that is =
not
>>> referenced by any commit, or a similar situation. It's hard to say
>>> without looking at the repository.
>>
>> After a non-fast-forward push fails, a subsequent forced push sends =
the same
>> set of objects, which are already present at the server side, but ar=
e
>> dangling objects.
>>
>> Apparently, Git for Windows fails to replace the read-only files tha=
t live
>> on the network file system.
>
> I left one bit out from my original explanation, which is that
> we generally prefer existing objects to new ones. So we would general=
ly
> want to throw out the new object rather than try to write it out. I'm
> not sure why unpack-objects would try to write an object we already
> have.
>
> We also don't write objects directly, of course; we write to a tempor=
ary
> file and try to link them into place. It really sounds more like the
> "objects/d9" directory is where the permission problems are. But, hmm=
=2E..
>
> The code path should be unpack-objects.c:write_object, which calls
> sha1_file.cwrite_sha1_file, which then checks has_sha1_file(). These
> days it uses the freshen_* functions instead of the latter, which doe=
s a
> similar check.  But it does report failure if we cannot call utime() =
on
> the file, preferring to write it out instead (this is the safer choic=
e
> from a preventing-prune-corruption perspective).
>
> So it's possible that the sequence is:
>
>    - unpack-objects tries to write object 1234abcd...
>
>    - write_sha1_file calls freshen_loose_object
>
>    - we call access("12/34abcd...", F_OK) and see that it does indeed
>      exist
>
>    - we call utime("12/34abcd...") which fails (presumably due to EPE=
RM);
>      we return failure and assume we must write out the object
>
>    - write_sha1_file then writes to a temporary file, and tries to li=
nk
>      it into place. Now what? If we get EEXIST, we say "OK, somebody =
else
>      beat us here", and we consider that a success. But presumably we=
 get
>      some other error here (which may even be a Windows-ism), fall ba=
ck
>      to rename(), and that fails with EPERM, which we then report.
>
> If that's the case, then one solution is to have the
> timestamp-freshening code silently report success, and skip writing o=
ut
> the object. I'm not entirely comfortable with that, just because it i=
s
> loosening a safety mechanism. But perhaps we could loosen it _only_ i=
n
> the case of checking the loose object, and when we get EPERM. We know
> that the next step is going to be writing out that same loose object,
> which is almost certainly going to fail for the same reason.
>
> I dunno. The whole concept of trying to write to an object database f=
or
> which you do not have permissions seems a little bit weird. This woul=
d
> definitely be a workaround. But I suspect it did work prior to v2.2.0=
=2E
>
> -Peff
>

I've made some tests:
1) Linux Mint:
- ntfs share mounted (with noacl) since
$ chacl -l /the/mountpoint gives
chacl: cannot get access ACL on '/the/mountpoint': Operation not suppor=
ted
- Create a remote repository on the ntfs share
- Push some test files
- ls -al for files in the objects folder gives:
-rw-r--r--
- with subsequent amend, push the permissions stays the same.

2) On Windows:
- ntfs share mapped as drive by windows
- remote repository created by git on windows
- Push some test files
- ls -al for files in the objects folder gives:
-r--r--r--
- chmod all files to add w permission
- then amend commit and push, push is successful but all files rewritte=
n=20
by the push are again:
-r--r--r--
but all folders under objects are:
drwxr-xr-x

So I suppose it some issue with Windows or MSYS2. I'm not sure it's a=20
problem related to your explanations, I will read it whit fresh mind.
