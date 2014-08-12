From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Tue, 12 Aug 2014 17:31:30 +0200
Message-ID: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 17:31:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHE35-000729-Io
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 17:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbaHLPbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 11:31:39 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:54076 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbaHLPbi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 11:31:38 -0400
Received: by mail-we0-f174.google.com with SMTP id x48so10188764wes.19
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TH9stpv0nRuxr/XZ1FmVV1CPhgyg1rc4nfboL64/trw=;
        b=T4Ktm98dk1Gb/DmgAGQ8P3YtfuvZyPEqkzWu/AbJaoCqOoEcnPyosIHjd4TZmFOkCX
         6ukEZ4Rg2E81QAc3qYUF5ObaYxFJNyQyOhR6yFf7576tZphXf8p0AGIVxLwFAB9ifqio
         FL5NdKu4CL/o2gDP5pp5ssmCgGQ3g2faWw3OOkEU9RonSlohKxF+/XMREEcHE+4KLy2t
         ZfPnfMdRYfRxV/uJBTmW78ei++SnyEzkfPn7/vIyoe0+FuMoFW8pkSHLUrIH/cPyXioM
         cgT8Tfs3dCu1API5ppp3Z3mym0vuwvLOTRhLGUDsTUonNvnJ/npPfW2MkGJBxGpt2p5J
         ZLaQ==
X-Received: by 10.194.118.232 with SMTP id kp8mr6000814wjb.42.1407857497584;
        Tue, 12 Aug 2014 08:31:37 -0700 (PDT)
Received: from ubuntu-jsoriano.tuenti.local (94.red-80-28-98.adsl.static.ccgg.telefonica.net. [80.28.98.94])
        by mx.google.com with ESMTPSA id a4sm57320438wie.21.2014.08.12.08.31.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Aug 2014 08:31:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.1.g8a38f21.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255149>

A file in the index can be left as merged and unmerged at the same time
by some tools as libgit2, this causes some undesiderable behaviours in git.

I have seen, at least, these behaviours:
- git reset --hard consuming 100% CPU and never ending
- git reset --hard consuming all memory in git < 2.0
- git add/git mergetool not resolving a conflict, even if they finish
  succesfully

The state is something like this:

$ git ls-files -s
100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 0       conflict
100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       conflict
100644 5716ca5987cbf97d6bb54920bea6adde242d87e6 2       conflict
100644 f2e41136eac73c39554dede1fd7e67b12502d577 3       conflict

This can be caused e.g. by libgit2 doing this:
1. Merge with conflicts, without solving them
2. Force checkout

I see that this is not caused by git (I haven't been able to reproduce it
only using git) but I think that git should be able to detect this situation
and even handle it, specially to avoid the never-ending git resets.   

The proposed patch serves as protection and autoremediation for this
kind of cases.
Another option would be to detect the issue and tell the user to clean the
index with git read-tree --empty, but I think this would be more intrussive
than the patch.

Regards,
Jaime Soriano.

Jaime Soriano Pastor (1):
  read-cache.c: Ensure unmerged entries are removed

 read-cache.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.0.4.1.g8a38f21.dirty
