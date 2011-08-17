From: Owen Stephens <git@owenstephens.co.uk>
Subject: Malformed branch name in fast-export when specifying non-HEAD/branch revision
Date: Wed, 17 Aug 2011 17:21:34 +0100
Message-ID: <CAORuUR154Dhg5vDojga-01bDxxf+=R2X-oJK-0417CgmqxCwvA@mail.gmail.com>
References: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 18:21:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtisA-0007Js-FR
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 18:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1HQQVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 12:21:36 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33781 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab1HQQVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 12:21:35 -0400
Received: by ewy4 with SMTP id 4so444752ewy.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 09:21:34 -0700 (PDT)
Received: by 10.14.145.67 with SMTP id o43mr379327eej.208.1313598094492; Wed,
 17 Aug 2011 09:21:34 -0700 (PDT)
Received: by 10.14.119.144 with HTTP; Wed, 17 Aug 2011 09:21:34 -0700 (PDT)
X-Originating-IP: [152.78.94.138]
In-Reply-To: <CAORuUR1viqG27+dYOFS_5SLxFOE2wHJqAQ3i3RByg_fbWACh-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179519>

Hi,

fast-export gives an invalid branch name for commits, if the revision specified
is not HEAD or a branch name.

$ git --version
git version 1.7.6

$ # Create
$ git init export_test && cd export_test
$ touch a && git add a && git commit -m 'Add a'
$ touch b && git add b && git commit -m 'Add b'
$ git branch branch1

$ # ok
$ git fast-export HEAD

$ # also ok
$ git fast-export branch1

$ # uses HEAD~1 instead of refs/heads/master
$ git fast-export HEAD~1

blob
mark :1
data 0

reset HEAD~1
commit HEAD~1
mark :2
author Owen Stephens <git@owenstephens.co.uk> 1313597436 +0100
committer Owen Stephens <git@owenstephens.co.uk> 1313597436 +0100
data 6
Add a
M 100644 :1 a

$ # Uses the commit hash rather than refs/heads/master
$ git fast-export $(git rev-parse HEAD~1)

blob
mark :1
data 0

reset 5a8a8abb1ab44890501c64f2d51f671ab2108d60
commit 5a8a8abb1ab44890501c64f2d51f671ab2108d60
mark :2
author Owen Stephens <git@owenstephens.co.uk> 1313597436 +0100
committer Owen Stephens <git@owenstephens.co.uk> 1313597436 +0100
data 6
Add a
M 100644 :1 a

$ # fast-import cannot handle this stream:
$ git init subgit
$ git fast-export HEAD~1 | (cd subgit/ && git fast-import)
fatal: Branch name doesn't conform to GIT standards: HEAD~1
fast-import: dumping crash report to .git/fast_import_crash_26863

Regards,
Owen.
