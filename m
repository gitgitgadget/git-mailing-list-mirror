From: Jon Nelson <jnelson@jamponi.net>
Subject: Re: git gc / git repack not removing unused objects?
Date: Sun, 7 Feb 2010 17:40:17 -0600
Message-ID: <cccedfc61002071540l7019d5d0mc4666dbd81189064@mail.gmail.com>
References: <cccedfc61002051145q1ff673e7s3db3bd7290be25e1@mail.gmail.com> 
	<alpine.LFD.2.00.1002051539080.1681@xanadu.home> <cccedfc61002051304t6030d3f7if4bb14709ee6c918@mail.gmail.com> 
	<alpine.LFD.2.00.1002051634380.1681@xanadu.home> <cccedfc61002060553w464d5d9drd582b3b3c3f35227@mail.gmail.com> 
	<alpine.LFD.2.00.1002061935180.1681@xanadu.home> <cccedfc61002070948m2491b1e2ua633f125f3573ff9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Feb 08 00:40:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeGk7-0005gF-Pm
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 00:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078Ab0BGXkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 18:40:39 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:41569 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773Ab0BGXki convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 18:40:38 -0500
Received: by wwi18 with SMTP id 18so1469661wwi.19
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 15:40:37 -0800 (PST)
Received: by 10.216.90.78 with SMTP id d56mr1985915wef.126.1265586037166; Sun, 
	07 Feb 2010 15:40:37 -0800 (PST)
In-Reply-To: <cccedfc61002070948m2491b1e2ua633f125f3573ff9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139265>

On Sun, Feb 7, 2010 at 11:48 AM, Jon Nelson <jnelson@jamponi.net> wrote=
:
> On Sat, Feb 6, 2010 at 7:16 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
>> On Sat, 6 Feb 2010, Jon Nelson wrote:
>>
>>> Last night, the repo size was 153G after removing some commits and
>>> objects by way of git filter-branch.
>>> I'm using "du -sh" in the .git directory to determine the disk usag=
e.
>>>
>>> Before: 136G
>>> git repack -dAl
>>> After: 153G
>>
>> Why are you using -A instead of -a ?
>
> As it turns out, I've been using both -a and -A. I suspect -A is a
> typo on my part.
>
>>> Then, just to make sure of some things, I changed nothing and simpl=
y
>>> re-ran "git repack -dAl".
>>> After: 167G
>>
>> Could you run 'git count-objects -v' before and after a repack in su=
ch
>> cases as well?
>
> Yes.
>
>>> [pack]
>>> =A0 =A0 =A0 =A0 packsizelimit =3D 256m
>>
>> Why are you using this?
>
> I didn't want my pack files to be too huge. I've bumped that up to 2G=
=2E
>
>>> pack.packsizelimit=3D2M
>
> My ~/.gitconfig normally uses 2M for easy rsyncing. In this repo I
> thought the value was overridden by the project's config (which was
> specifying 256m and now specifies 2048m).
>
> Suboptimal or not, it still doesn't explain why the repo grows with e=
ach repack.
>
> Now running:
>
> =A0git count-objects -v ; git repack -ad ; git count-objects -v

The results (two lines of whitespace added for clarity):

turnip:/mnt/backups.git # git count-objects -v ; git repack -ad ; git
count-objects -v
count: 0
size: 0
in-pack: 2408195
packs: 675
size-pack: 174924053
prune-packable: 0
garbage: 0

Counting objects: 266309, done.
Compressing objects: 100% (207820/207820), done.
Writing objects: 100% (266309/266309), done.
Total 266309 (delta 47751), reused 227730 (delta 45117)

count: 0
size: 0
in-pack: 2674504
packs: 686
size-pack: 196517094
prune-packable: 0
garbage: 0
turnip:/mnt/backups.git # du -sh .
188G    .
turnip:/mnt/backups.git # find objects -name '*.pack' | wc -l
686
turnip:/mnt/backups.git #

So we went from 136G to 153G to 167G and now 188G.

The oldest .pack file is Jan 29 at 7.0M
The pack files vary considerably in size from 220B to 2.0G
There are 433 packs that are between 200M and 300M in size.
There are 78 packs that are between 500M and 600M in size.
There are 211 packs that are less than 256M in size.

I ran "git prune -v --prune=3Dnow" and it claims to have removed nothin=
g
and the exit status was 0.

I hope this helps!

--=20
Jon
