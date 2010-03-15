From: Jay Soffian <jaysoffian@gmail.com>
Subject: Dealing with an upstream cherry-picked branch
Date: Mon, 15 Mar 2010 00:17:23 -0400
Message-ID: <76718491003142117w4fd10449j51deef27548c4d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 15 05:25:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr1sB-0002AY-6J
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 05:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594Ab0COEZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 00:25:42 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:56967 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0COEZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 00:25:41 -0400
Received: by yxe29 with SMTP id 29so1296949yxe.4
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 21:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=JM3g17oiS+xyJ6O7gesWun8dSnQHp3Al5lJ2CuM+ICs=;
        b=mWpF6AOI9hpkkNbrWNvCiLOikftzZeCcCy3NdAClpFXZ6f+JpkE+DUOB8VfW+oZUAu
         EyBPTJRaBiyKl0SXBO+yjIG3up+cMm2NXTgGDgZ1jqUEb4fIaq3e6ZBJKHj7FDSP0ZvD
         YQRPf+rBRAwovjoDpK9Xr6/WVH/4NKeMcTq24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=kdg+NMmuUmgo+tZ+J42cfXn7mvYI7jxmZxq1OxPcCffdgbd5Jm8X2C3Cv4rysLyS05
         emQe9fh5dogowmGT4bIUjhEy1LoSrZ6wQWAytahzPM+AdXVSw/KAJ8GfopImo2RZ3c50
         51S75EIbxWO8Dq0gE0AEvrNv8JWLaLyYEeuV4=
Received: by 10.150.119.33 with SMTP id r33mr2721326ybc.304.1268626643201; 
	Sun, 14 Mar 2010 21:17:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142167>

I have the following scenario:

  o---o---Ma---o---o    local-master
 /       /
|       | .-b'------d'  upstream-a
|       |/  :       :
o---o---a---b---c---d   upstream-master

Local-master branched from upstream-master in distant past.
upstream-master periodically cuts tentative release branch upstream-a.
When they do this, that branch point (a) is merged into local-master
(Ma).

Over time, upstream applies fixes to upstream-a, but does so by
committing the fixes to upstream-master and then cherry-picking them
to upstream-a.

The question is how to best integrate the fixes on upstream-a into
local-master, w/o causing a headache when upstream cuts the next
tentative release branch, at which point upstrea-master will again
need to be merged into local-master (and that will also have other
local development). Here are two options I've considered:

1) Create a local-a integration branch, merged from upstream-a and
local-master. Keep this branch up-to-date by periodically merging
local-master and upstream-a:

  o---o---Ma---o---o     local-master
 /       /  \       \
|       |    `o------`o  local-a
|       |    /       /
|       | .-b'------d'   upstream-a
|       |/  :       :
o---o---a---b---c---d    upstream-master

2) Periodically merge upstream-a into local-master:

  o---o---Ma--o---o---o  local-master
 /       /   /       /
|       | .-b'------d'   upstream-a
|       |/  :       :
o---o---a---b---c---d    upstream-master

Then when it is next time to merge upstream-master into local-master either:

(a) Backout the upstream-a merges to local-master by reverting the
merge commits which introduced them to local-master, then merge
upstream-master.

(b) Just merge upstream-master and carefully deal with all the
conflicts. I think this will necessarily be an evil merge.

(c) Create a new branch at point Ma and cherry-pick only the local
commits from local-master past point Ma. This essentially gives me the
clean local-master I would've had if I'd been doing (1) all along.

- Are there any other options I'm missing?

- If I'm going to do (2a), I'm wondering if I'm missing any
subtleties. I've read the revert-a-faulty-merge how-to and I realize
my history won't be the cleanest, but I think it should work and leave
a picture like:

  o---o---Ma--o---o---o---o---Wd'---Wb'---Mi  local-master
 /       /   /       /                   /
|       | .-b'------d' upstream-a       |
|       |/  :       :                   |
o---o---a---b---c---d---e---f---g---h---i    upstream-master

Wd' is the revert of d' into local master. Wb' is the revert of b'
into local master. This reverts both merges from upstream-a into local
master. There may be conflicts to resolve due to the local changes
that happened in local-master. However, local-master should now be
"clean" to merge in upstream-master w/o having to worry about
conflicts between b and b', d and d'. Correct?

Thanks,

j.
