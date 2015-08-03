From: Per Cederqvist <cederp@opera.com>
Subject: "git pull --rebase" fails if pager.pull is true, after producing a
 colorized diff it cannot apply
Date: Mon, 3 Aug 2015 17:21:43 +0200
Message-ID: <CAP=KgsTp=D1cSPmudDVEe32Q8gHhfSfuL7+V9YGZ65F1ZDUFiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 17:21:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMHYk-0005W8-4R
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 17:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbbHCPVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 11:21:46 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:35687 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbHCPVp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 11:21:45 -0400
Received: by labsr2 with SMTP id sr2so13902231lab.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 08:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=SbAylRhMBvNhSWQQUwLTQH80UAwixXZ/VkLQ0OCz2Do=;
        b=lgQIvg10Rs+X+u4XRflco4WcP7RxS2N0PpNiQ/TuD7GSTBatL85eTYLPwCCYlXmRgj
         7y11ahlJb0JZ3p+AfJ7b+Nd85CvvSOQJ3aDb0vC4Uz7NazyG7FHYieUtyjXbD+qPGw51
         MqiCZ2QNaHUXGvyrarsCmhgBEdGk9G9ecEBqUsMnv66nGlmECsOspeW9b8zfgJmvsjML
         WUZY51qCWElGV22DYU2UnAPuhZKrvQw3OL3BsgXd4zdFHW9l+179CQVN1iwVwqrKwhxb
         1L/8Xt+UDL0IP4QDOjeKnL1vn/T8yRO0dSPPKVqHoUjGmuoUbiThtnYfbJ1fa3W7EQsp
         GfqA==
X-Gm-Message-State: ALoCoQmUpVq5owVLh+eSkMPok/fa0txtUzkizGrSYhk87KPg7G5aTJnitU1HVrZxV0aexj/jhgf8
X-Received: by 10.152.116.109 with SMTP id jv13mr17840925lab.77.1438615304030;
 Mon, 03 Aug 2015 08:21:44 -0700 (PDT)
Received: by 10.25.170.65 with HTTP; Mon, 3 Aug 2015 08:21:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275170>

If you run:

    git config pager.pull true

in the hope of getting the output of "git pull" via a pager, you are
in for a surpise the next time you run "git pull --rebase" and it has
to rebase your work.  It will fail with a nonsensical error message:

> Applying: First B commit
> fatal: unrecognized input
> Repository lacks necessary blobs to fall back on 3-way merge.
> Cannot fall back to three-way merge.
> Patch failed at 0001 First B commit
> The copy of the patch that failed is found in:
>    /home/cederp/badcolor/repo-b/.git/rebase-apply/patch
>
> When you have resolved this problem, run "git rebase --continue".
> If you prefer to skip this patch, run "git rebase --skip" instead.
> To check out the original branch and stop rebasing, run "git rebase --abort".

Using "cat -vet" to look at the problematic patch, you can see that
there are embedded escape codes that tries to colorize the patch.

This bug is dependent on the TERM setting.  On my system (Ubuntu
14.04) it reproduces if TERM=vt220 or TERM=rxvt-unicode, but not if
TERM=dumb.  It might depend on the color.diff setting as well, but
it does reproduce with the default setting.

The following script reproduces the problem.  I've tried both git
2.4.3 and git 2.5.0.

----- cut here -----
#!/bin/sh
set -e -x

# All created files are created inside the "badcolor" directory.
mkdir badcolor
cd badcolor

# Create a bare repo.
mkdir upstream.git
(cd upstream.git && git init --bare)

# Make an initial commit.
git clone upstream.git repo-a
(cd repo-a && echo one > a && git add a && git commit -m"First A commit")
(cd repo-a && git push origin master)

# Make a second clone.
git clone upstream.git repo-b

# Make one more commit, that the second clone won't have for a while.
(cd repo-a && echo two > a && git add a && git commit -m"Second A commit")
(cd repo-a && git push origin master)

# Create a third commit; this make the history non-linear, but since
# the commit only touched a new file it should be trivial to linearize
# it.
(cd repo-b && echo one > b && git add b && git commit -m"First B commit")

# Set pager.pull true so that we trigger the bug.
(cd repo-b && git config pager.pull true)

# Attempt to make the history linear.  This command will fail if TERM
# specifies a color-capable terminal.

(cd repo-b && git pull --rebase)

exit 0
----- cut here -----

Thanks,

    /ceder
-- 
Per Cederqvist <cederp@opera.com>
