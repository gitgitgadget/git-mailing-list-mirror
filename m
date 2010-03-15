From: =?utf-8?Q?=C5=81ukasz?= Stelmach <lukasz.stelmach@iem.pw.edu.pl>
Subject: Re: merging unmanaged working tree
Date: Tue, 16 Mar 2010 00:30:00 +0100
Message-ID: <87eijlw4cn.fsf@kotik.lan>
References: <87ljdtkedl.fsf@dasa3.iem.pw.edu.pl>
	<46a29168.6d880e7c.4b9e296c.483a1@o2.pl>
	<87d3z5k3yb.fsf@dasa3.iem.pw.edu.pl>
	<32541b131003151222r32244cf4o6182545e3a1eb1aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 00:35:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJoV-00013w-1b
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410Ab0COXfG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 19:35:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:47102 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756651Ab0COXfF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 19:35:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NrJoN-00011P-5q
	for git@vger.kernel.org; Tue, 16 Mar 2010 00:35:03 +0100
Received: from 87-205-242-55.adsl.inetia.pl ([87.205.242.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 00:35:03 +0100
Received: from lukasz.stelmach by 87-205-242-55.adsl.inetia.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 00:35:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 87-205-242-55.adsl.inetia.pl
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:53pyfLRZxE7i9DMvTMeR4sqxy0s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142278>

Avery Pennarun <apenwarr@gmail.com> writes:

> 2010/3/15 =C5=81ukasz Stelmach <lukasz.stelmach@iem.pw.edu.pl>:
>> 1. There is a repository (non-bare one) with all changes
>> =C2=A0 commited. Commit A.
>>
>> 2. I take some files put them on my pendrive. I take a note that the=
y come
>> =C2=A0 from commit A. I don't clone the repository.
>>
>> 3. I make changes here (in the repository) and commit them (commits =
B,
>> =C2=A0 C, D) and there (on my pendrive).
>>
>> 4. I want to merge things with something like this
>
> You have a few options that I can think of.
>
> a) Look at 'git clone --depth' so you can clone only the most recent
> version of the files, not the *entire* repo.  This lets you do commit=
s
> on any computer you want with the pen drive plugged in, but saves
> space.

I've tried this one. It works (but why the --depht 1 gives two
revisions?) but even thoug the main repository and the portable one hav=
e
common commits I can't pull changes back from the mobile to the main
one. Is there any wise trick to make git try a little harder?

> b) Keep your .git directory on your main PC's disk, and the working
> tree on your pen drive.  Look at the GIT_DIR environment variable in
> 'man git'.  Then when you bring the pen drive back to your PC, you
> have the full repo available.  (If you use 'git clone --reference'
> when making the new repo, the extra .git directory should take only
> minimal space.)

This one's nice and seems to be most space efficient as far as flash
space is concerned. However, I'd be able to sync only with the machine
that holds the portable GIT_DIR while the previous method, if only
there was a way to make git work with shallow clones, could work with
different hosts if I synec my No1 desktop with them too.

> c) Make a clone of your repo on the PC, then rsync the non-git parts
> of that clone's work tree to and from your pen drive.  (This option i=
s
> the most error-prone since you have to make sure you never rsync in
> the wrong direction at the wrong time.  But it's maybe the easiest to
> understand.)

Doesn't look good. As easy to under as to mess up.

I've just invented yet another method. Push the content to the pendrive=
:

$ git commit -am branching
$ git archive --format tar HEAD | tar -C /media/pendrive/project -xf -
$ git log -1 > /media/pendrive/project/HEAD # to remember=20

Now you can make some changes to both the local and the portable copies=
=2E
You commit the only local changes. Next you retrieve the branching poin=
t
into a temporary directory

$ git archive --prefix sync-prj/ --format tar \
  $(head -1 /media/pendrive/project/HEAD | cut -f 2 -d ' ') | \
  tar -C  /tmp -xf -

# run diff3 on ./* /tmp/sync-prj/* /media/pendrive/project/*
# fix conflicts
$ git commit -a merged

The biggest drawback, at the moment, seems to be the fact that I need
some space for the branching point archive. And diff3 can't compare
directories like diff -uNr does. But in the end it seems quite robust
and might actually work with multiple hosts (as long as you can find th=
e
commit from /media/pendrive/project/HEAD on each of them).

Thanks.

--=20
Mi=C5=82ego dnia,
=C5=81ukasz Stelmach
