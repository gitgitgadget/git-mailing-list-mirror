From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git cherry improvements suggestions
Date: Wed, 23 Mar 2011 09:11:24 +0100
Message-ID: <AANLkTimk0bkOGVy2W+XddHRuf-1xw+d0RwzPhnk40vi8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 23 09:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2JAD-0005Yk-Rj
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 09:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925Ab1CWIL1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 04:11:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57678 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab1CWILY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 04:11:24 -0400
Received: by iyb26 with SMTP id 26so8300491iyb.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=0T5sISTH1Uszk1CNk4n317QcDTcQPEr3KbzZO2I7ycI=;
        b=fxZGj/Q0E267QmymfeC3C9jRKXl8rQ+wsgavZ8YMP7lHY+5thpEbQvzWRStn8r8Fg2
         aG9g/lPhk5Qm3NokzS2yhX1i00ZkZmuNX0wUrb2yI84NyiD2VD+ltFoUtHID4w22PNgJ
         spagBdV0Wc9fbosOyLY/76Wr350qoEZmW8NTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vUNJK5zXAUm/SQRZwAEHr9F4jjev/2ufJ+BUr9uPPeyc579+9Bv3yaLS10QcG5CVMT
         tZKW/8J/n3wV2BbviPtngTOKDE2dnsnTpbIKujdLi+/DaRR0gz45GHaOvQGILWKA8RFE
         DbgaCB21odRbOyNvkqx07OZghBhgr6HBPdQqs=
Received: by 10.42.151.131 with SMTP id e3mr219368icw.157.1300867884065; Wed,
 23 Mar 2011 01:11:24 -0700 (PDT)
Received: by 10.42.225.138 with HTTP; Wed, 23 Mar 2011 01:11:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169804>

Hi,

Short version:

1. The <limit> is misleading IMO
2. Please extend the output to show "full diff"
3. Please add numerical/time <limit>
4. Would it be possible to use "=3D" for "equivalent change"?

Please tell me your opinions.


Long version:

I have a branch that have diverged long time ago from main branch. I ca=
n't use
merge, so I'm using cherry-pick to transplant changes between branches
(the other reason is I'm using git-svn...)

I noticed I did not transplant a certain commit recently. I wanted to
see if there
are any other commits I didn't transplant. I tried using git cherry:


1. man page says: git cherry [-v] [<upstream> [<head> [<limit>]]]

   $ git cherry -v master 9_1 20
   fatal: Unknown commit 20

After reading man page I though the limit is a numeric limit, like "che=
ck
last 20 commits".

I just realized it is a commit sha1. I think man could be improved to e=
xplicitly
say it's sha1 - maybe change the name from <limit> to something else
(<sha1>? <sha1_limit>?)


2. The cherry currently shows only changes against one branch:

   Every commit that doesn=92t exist in the <upstream> branch has its i=
d (sha1)
   reported[...] The ones that have equivalent change already in the <u=
pstream>
   branch are prefixed with a minus (-) sign, and those that only exist=
 in the
   <head> branch are prefixed with a plus (+)  symbol

So it will not show commits that exist only in <upstream> but not in <h=
ead>.

In my case changes are transplanted both ways (in general), so I have t=
o check
both branches.

I understand I can switch branch positions, but this requires post-proc=
essing
to get rid of equivalent commits, maybe something like this:.

    git cherry upstream head | grep '^[+]' > head_only
    git cherry head upstream | grep '^[+]' > upstream_only

This is not very convenient, and I think you won't be able to see trans=
planted
changes with different ids (e.g. with conflicts) next to each other (su=
ch
commits would have probably the same commit message and it's possible
they were done at the same/close time, so it should be easy to see that
although the commits are shown as different, they represent the same ch=
ange)

I think it would be usable to be able to see all changes:
    - commits in upstream only
    - commits in head only
    - equivalent commits (in both upstream and head)

Not sure how it should act in case of <limit> - maybe it should be ille=
gal
to use <limit> in this mode. See also next point.


3. I think a numerical limit (or even: time limit etc) of checked commi=
ts would
be useful, especially in "full diff" mode. Without it would be not
possible to do a
full diff with a limit, and when switching branch positions you'd have =
to lookup
two commits:

    <find commit on head>
    git cherry upstream head  head_limit | grep '^[+]' > head_only
    <find commit on upstream>
    git cherry head upstream upstream_limit | grep '^[+]' > upstream_on=
ly

In case of numerical <limit> it should probably take <limit> changes
from head and
<limit> changes from upstream and see what is their status. So the actu=
al
output would list from <limit> to 2*<limit> commits depending if all
commits are on
both branches, or no commit is equal.


4. The output format uses "-" to show commits that exist in both branch=
es.
I find this unnatural. There probably is a reason for this? But maybe i=
t would
be possible to change the symbols? For example:

   - commit in upstream only
   + commit in head only
   =3D equivalent commit

Or "<", ">", " " or any other graphic symbol.


Thanks for you time reading this long post :)

--=20
Piotr Krukowiecki
