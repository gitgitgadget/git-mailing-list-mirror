From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Bump core.deltaBaseCacheLimit to 96m
Date: Mon, 05 May 2014 13:20:09 +0200
Message-ID: <874n14tqty.fsf@fencepost.gnu.org>
References: <1399223637-29964-1-git-send-email-dak@gnu.org>
	<CACsJy8BG8fRPk74R_-YABCGMn-YwbDcLHtjUNX7KE66jX1mR4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:31:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhyG-0005Yp-El
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756330AbaEELUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2014 07:20:34 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:59168 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215AbaEELUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2014 07:20:33 -0400
Received: from localhost ([127.0.0.1]:58210 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WhGwh-0003sD-S8; Mon, 05 May 2014 07:20:32 -0400
Received: by lola (Postfix, from userid 1000)
	id 67AE8E04E9; Mon,  5 May 2014 13:20:09 +0200 (CEST)
In-Reply-To: <CACsJy8BG8fRPk74R_-YABCGMn-YwbDcLHtjUNX7KE66jX1mR4A@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 5 May 2014 17:26:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248185>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, May 5, 2014 at 12:13 AM, David Kastrup <dak@gnu.org> wrote:
>> The default of 16m causes serious thrashing for large delta chains
>> combined with large files.
>>
>> Here are some benchmarks (pu variant of git blame):
>>
>> time git blame -C src/xdisp.c >/dev/null
>
> ...
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 1932e9b..21a3c86 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -489,7 +489,7 @@ core.deltaBaseCacheLimit::
>>         to avoid unpacking and decompressing frequently used base
>>         objects multiple times.
>>  +
>> -Default is 16 MiB on all platforms.  This should be reasonable
>> +Default is 96 MiB on all platforms.  This should be reasonable
>>  for all users/operating systems, except on the largest projects.
>>  You probably do not need to adjust this value.
>
> So emacs.git falls exactly into the "except on the largest projects"
> part.

git gc --aggressive has been used/recommended for _all_ projects
regularly, leading to delta chains with a length of 250.  So this delta
chain size is not exceptional but will eventually occur in any archive
that has been created and maintained according to the recommendations o=
f
Git's documentation (which recommends gc --aggressive every few hundred=
s
of revisions).  I was illustrating the effect on a file of size 1MB.
That's not an egregiously large file either.

96MB is the point of diminuishing returns for this case which is _6_
times larger than the current default and _small_ in comparison with th=
e
memory installed on developer machines nowadays.  Similar slowdowns
occur with other examples.  Git will with the current defaults accept
files of 512Mb size into its compression scheme (and thus its core
memory) before punting.

The current delteBaseCacheLimit of 16Mb is rather ridiculous in
particular with the pre-2.0 settings for gc --aggressive and causes
serious performance degration.  It was actually ridiculous even 10 year=
s
ago.

> Would it make more sense to advise git devs to set this per repo
> instead? The majority of (open source) repositories out there are
> small if I'm not mistaken. Of those few big repos, we could have a
> section listing all the tips and tricks to tune git. This is one of
> them. Index v4 and sparse checkout are some other. In future, maybe
> watchman support, split index and untracked cache as well.

Shrug.  The last version of the patch was refused because of wanting
more evidence.  I added the evidence.

And I have it on record in the mailing list and can point to it when
people ask me why Git is so slow for "git blame" in comparison to other
version control systems in spite of my purporting to having improved it=
=2E

I'm definitely not going to jump through any more hoops here.  I=A0don'=
t
see a point in this kind of spectacle.

--=20
David Kastrup
