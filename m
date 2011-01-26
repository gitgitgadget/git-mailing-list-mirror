From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 19:11:56 +0100
Message-ID: <4D4063EC.7090509@lsrfire.ath.cx>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 26 19:12:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi9rI-0001bN-Tw
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 19:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab1AZSMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 13:12:19 -0500
Received: from india601.server4you.de ([85.25.151.105]:47048 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034Ab1AZSMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 13:12:18 -0500
Received: from [192.168.2.104] (p4FFDB6DB.dip.t-dialin.net [79.253.182.219])
	by india601.server4you.de (Postfix) with ESMTPSA id 9BC1E2F8091;
	Wed, 26 Jan 2011 19:12:16 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <m239og12pe.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165526>

Am 26.01.2011 09:36, schrieb Francis Moreau:
> Francis Moreau <francis.moro@gmail.com> writes:
>=20
>> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>
>>> Try -m (show full diff for merge commits), as the change you're loo=
king
>>> for seems to have been introduced by a merge, not a regular commit.
>>>
>>> 	$ opts=3D"--stat -Sblacklist_iommu -m --oneline"
>>> 	$ revs=3D"v2.6.27..v2.6.28"
>>>
>>> 	$ git log $opts $revs -- drivers/pci/intel-iommu.c
>>>
>>> This returns nothing.  Hmm.  Let's try this instead:
>>>
>>> 	$ git log $opts $revs -- drivers/pci/
>>> 	057316c (from 3e2dab9) Merge branch 'linus' into test
>>> 	 drivers/pci/intel-iommu.c |  307 ++++++++++++++++++++------------=
------------
>>> 	 1 files changed, 140 insertions(+), 167 deletions(-)
>>> 	6b2ada8 (from 3b7ecb5) Merge branches 'core/softlockup', 'core/sof=
tirq', 'core/resources', 'core/printk' and 'core/misc' into core-v28-fo=
r-linus
>>> 	 drivers/pci/intel-iommu.c |  187 ++++++--------------------------=
------------
>>> 	 1 files changed, 26 insertions(+), 161 deletions(-)
>>> 	d847059 (from 725c258) Merge branch 'x86/apic' into x86-v28-for-li=
nus-phase4-B
>>> 	 drivers/pci/intel-iommu.c |  185 ++++++--------------------------=
-------------
>>> 	 1 files changed, 25 insertions(+), 160 deletions(-)
>>> 	725c258 (from 129d6ab) Merge branches 'core/iommu', 'x86/amd-iommu=
' and 'x86/iommu' into x86-v28-for-linus-phase3-B
>>> 	 drivers/pci/intel-iommu.c |   25 ++++++++++++++++++++++++-
>>> 	 1 files changed, 24 insertions(+), 1 deletions(-)
>>> 	6e03f99 (from 9821626) Merge branch 'linus' into x86/iommu
>>> 	 drivers/pci/intel-iommu.c |   23 +++++++++++++++++++++++
>>> 	 1 files changed, 23 insertions(+), 0 deletions(-)
>>>
>>> Strange, why did we need to remove the last path component to get t=
hese
>>> results which say that exactly the file we previously specified was=
 changed?
>>
>> ah... I think I've been hit by this, since I tried '-m' too but see
>> nothing and was not smart enough to remove the filename from the pat=
h.
>>
>>> Also interesting, and matching the above results in that we see the=
 need for
>>> the -m flag confirmed:
>=20
> BTW, couldn't '-m' automatically set when '-S' is given ?

I can't see a connection between the two options.  Merges are ignored b=
y
default (without -m) because they shouldn't contain any changes that
aren't already present in one of the merged branches (by convention),
and diffs with a single parent are easier to read.  This is true with o=
r
without -S.

So far we have two action items, I think:

	- Make git grep report non-matching path specs (new feature).

	- Find out why removing the last path component made a
	  difference in the case above (looks like a bug, but I don't
	  understand what's going on).

Taking into account what Johannes said regarding the disappearance of
the function during a merge instead of as part of a regular commit, I
don't think these changes would help you much with your use case,
though.  You would still be looking at a complicated net of commits,
with the action happening in non-obvious places (merges).

Perhaps --graph can help a bit, see for yourself:

	$ git log --graph -Sblacklist_iommu -m --oneline \
	v2.6.27..v2.6.28 -- drivers/pci/

If you start at v.2.6.26 instead -- e.g. to catch the commit that
introduced the function -- then the graph gets a lot more colourful and
too complicated, at least for me, though.

Ren=E9
