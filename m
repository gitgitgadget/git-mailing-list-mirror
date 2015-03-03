From: Mike Botsko <botsko@gmail.com>
Subject: Unexpected/unexplained difference between git pull --rebase and git rebase
Date: Tue, 3 Mar 2015 12:39:31 -0800
Message-ID: <CAPfvZp6oNnM=M-9BAVqAE052jQApH-O_t3gEoq6JWC2kQrR8gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 21:39:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YStbM-00005E-TQ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 21:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650AbbCCUjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 15:39:33 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:64659 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590AbbCCUjc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 15:39:32 -0500
Received: by mail-qa0-f47.google.com with SMTP id v10so30187752qac.6
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 12:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Bwn3Jt5I/g1DGaIDoU+Nv14YkmTHr5gBS4azLo5Sr/g=;
        b=tezOPWmT1zKSoN5kAga0ulVStIp3yo32hFOn4JaPyeinw2Ry1gdxY7r86DF9uOgHpf
         idFIV+ngS1amgFtYyx298flGuc/YDZ7Q+gap+u4G52wEZUEvQToCLZcunXIfD8BJbh97
         4ulublnMeidrrfbjgBf6UxVe+a4Nl+TuqefZFZg3ryIP7b643jwnH2Bp2GQgPomPvs9U
         AZzRlJEWSOlhsRo5aZboMSJPncGqBvs/cPLiO+6o3jq7Ln9BDE8lnqDMptEZE8Sil+B7
         Vkr9bsAA9bX7Nh9Zd6zXweyZalKk4WstBLfzkzyanbySEZcbeer7JfCsQjVPYv6kKzLs
         UykQ==
X-Received: by 10.140.81.74 with SMTP id e68mr1038458qgd.41.1425415171593;
 Tue, 03 Mar 2015 12:39:31 -0800 (PST)
Received: by 10.140.80.203 with HTTP; Tue, 3 Mar 2015 12:39:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264686>

Hello,

I'm seeing unexpected behavior between "git pull --rebase" and "git
rebase" commands, which are supposed to be (and always described as)
synonymous:

git pull --rebase upstream our-branch-name

and

git fetch upstream
git rebase upstream/our-branch-name

We have a situation where the upstream/our-branch-name was rebased, to
incorporate changes from master. Somehow, the person who did the
rebase discarded a merge commit:

634b622 Sue Merge pull request #254 from bob/B-07290
bc76e5b Bob [B-07290] Order Parts Ship To/Comments

became:

c1452be Sue [B-07290] Order Parts Ship To/Comments


A developer who had a local branch tried to rebase their work (a
single commit on top of that feature branch).

At the moment, his now-out-of-date branch looks like this:

92b2194 Rick B-07241
634b622 Sue Merge pull request #254 from dboyle/B-07290
bc76e5b Bob [B-07290] Order Parts Ship To/Comments

I've done some debugging, and the above "git pull" command generates
the following and sends it to eval():

git-rebase --onto c1452be62cf271a25d3d74cc63cd67eca51a127d
634b622870a1016e717067281c7739b1fe08e08d

This process works perfectly. The old commits are discarded and his
branch now correctly reflects upstream/our-branch-name, with his
single new commit at the top.


However, if he runs the "git rebase" command above, several of the
commits that have changed hashes (they've also changed patch id
slightly, because during the rebase someone fixed a merge conflict)
are treated as new work, and git tries to re-apply them and we get
tons of merge conflicts.

The git rebase command above is trying to rebase onto:

revisions = c1452be62cf271a25d3d74cc63cd67eca51a127d..92b2194e3adc29eb3fadd93ddded0ed34513d587


These two features should work the same, yet one is choosing a
different commit hash than the other.

If this is not a bug, I can't find anyone who can explain what's
happening. I'm using git 2.2.1 on mac, but other people on our team
have a variety of older versions and we're all seeing the same result.

Thanks!

-- 
Mike Botsko
Lead Dev @ Helion3
Ph: 1-(503)-897-0155
