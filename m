From: Caleb Jorden <cjorden@gmail.com>
Subject: Git submodule regression in 2.7.0+
Date: Wed, 24 Feb 2016 13:35:37 -0600
Message-ID: <CABD8wQkN8bLQzqtUru9X+Mxji8U4UoUVdiioCNrJsWEzwcL50g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 20:35:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYfDs-0004Fk-A8
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 20:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbcBXTfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 14:35:39 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:35066 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbcBXTfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 14:35:38 -0500
Received: by mail-io0-f179.google.com with SMTP id g203so61290661iof.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 11:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Wiew3dUpTl701l/Y041fip0HHb5hH74PVKsgszqFy1w=;
        b=PN8DAdYY/jYeNTSdsTIS7A08+rxlbH6wH5TDFH5knpMK3dUHXbjJj/5tYYIcyC1udE
         WlHu8Guk/BY5a1uanatJDInCk6MIMRCmgudkmNqXF2M6GnyW8khFXNgrAbSZkduvPmi0
         wsoG2MAeyKdeZGzGOsl2kKB6O0Td7hC6i6FAaFgy4NlGQZLIZAp9uRABdPfSsxOmXybQ
         iAmK9ylzoBARdf3T4YCrqZiA8EhoqXIBLWCFnMvDdgfPLDus+nUzmP+em9vdu3IjiId8
         JSrUUT+wmEUNVYJrgU9hLgZNDFqJbHVzfs9yCkpRJIJcV3gzAfNpcVbyi/lIbG/dSCOD
         PLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Wiew3dUpTl701l/Y041fip0HHb5hH74PVKsgszqFy1w=;
        b=DPf6gQhclet1jvYUnqaR/FjVqnKTctjEcXoOwKX6uU99CdwdRyiVJEyZCQGQCsZzsw
         gQt4TypsbbwCkLkRO76hAFFcgfG1dkLQUVFQlUad0MpP2x/WF/zCUDEh9Jk+GT1iJUW/
         mnQZta2DMWTx0pHo/8ddHX/+w5j95Pm9lR30FMz1EckidQj0MVNxveOInhxnjbdz1UmR
         TzHU9/UPiUWr5cFNKglFenknEnAn54grE9kpOuBxChFHzFNncvfBjOsPPVaR0RK2clYR
         DbvVFxbIWqxvjmDBIRCkkGN4PWeP3Tuik3OuapO5m+VxjcgUhAzh2DAS57CghguWW+3G
         t+4w==
X-Gm-Message-State: AG10YOTlpqeEJwsaXGcpa0wLyv5ZPCflP90PXLIu+edhOmYlcr3Pyj94e3H94FxmosDiLV9Lr3LoSyu0qszfIA==
X-Received: by 10.50.20.98 with SMTP id m2mr21418303ige.9.1456342537862; Wed,
 24 Feb 2016 11:35:37 -0800 (PST)
Received: by 10.79.111.136 with HTTP; Wed, 24 Feb 2016 11:35:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287219>

Git community,

I have hit a rather significant regression in recent versions of Git,
when using submodules.  I have narrowed it down to a simple set of
commands that demonstrates the problem (commands for a unix-style OS):

---- Start list of commands to reproduce issue ----
mkdir -p test/a/b
cd test
git init
cd a/b
git init
echo hello > testfile1
git add .
git commit -m "test1"
cd ../..
mkdir -p 1/b
cd 1/b
git init
echo hi > testfile2
git add .
git commit -m "test2"
cd ../..
git submodule add /a/b a/b
git submodule add /1/b 1/b
git commit -m "first submodule commit"
git submodule--helper list a/b
---- End list of commands ----

On my machines, this shows 1/b, not a/b.

It seems that the submodule--helper (at least for the list command) is
not properly taking into account the path in the repository, but
rather just the submodule name itself.

This manifests itself if you have a Git repo that uses submodules that
has been updated (or just cloned), and you want to specifically update
a single submodule (which is where this problem was discovered).  If
you run in "git submodule update <submodule path>", and you have two
submodules with the same name (but in different paths in the
repository), then you will update the first one found
(lexicographically, as far as I can tell), every time.  There may be
other operations on submodules that are impacted as well, but I have
not explored them completely.

This may seem like a contrived situation, but this problem was found
in a live repo that uses submodules (albeit a private one).

Note that this behavior changed in 2.7.0 and is still current (happens
in 2.7.1, 2.7.2, and master in git repo as of 2/23/2016).  Prior to
2.7.0 (which introduced the submodule--helper command) the behavior
for this was as expected - the entire path was taken into account for
the submodule update command.  This has been observed on a Gentoo
machine (x86_64), as well as numerous Ubuntu installs (x86_64, 14.04).
This occurs both with the ubuntu git PPA (Git stable releases "Ubuntu
Git Maintainers" team, 2.7.1 at the time of this writing) and from a
fresh compile of 2.7.2 from source.

This regression can be fixed in 2.7.2 if one reverts the three commits
which introduced submodule--helper.c file and associated changes
(ee8838d157761acf4cc38f2378277dc894c10eb0,
0ea306ef1701d6f42e74d3c33addfcd630248904, and
74703a1e4dfc5affcb8944e78b53f0817b492246).  Just to be clear, I am not
advocating reverting these changes - I would rather see the
submodule--helper.c work continue, but also see this fixed.

I have not yet had the time to dive into the code to find what the
problem is, but I wanted to make sure this was reported so that others
who may be hitting this can be aware of it.  Also, I wanted to make
Stefan Beller aware of this, as he seems to still be working on the
submodule--helper.c code.

I am not currently subscribed to the Git mailing list, so please CC me
in any response.

Regards,

Caleb Jorden
cjorden@gmail.com
