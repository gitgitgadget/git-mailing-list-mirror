From: Alexey Kuznetsov <kuznetsov.alexey@gmail.com>
Subject: clone bug
Date: Thu, 12 Jan 2012 16:43:50 +0300
Message-ID: <CAO1Zr+pSLwRbsEZ_0LCeE2qLn+S=iMKVcMjqtYrmiBoQmjac_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 14:44:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlKxJ-0003MY-Ji
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 14:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab2ALNod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 08:44:33 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:59219 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab2ALNoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 08:44:32 -0500
Received: by wibhm14 with SMTP id hm14so1191911wib.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 05:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Eqw6H+MTMsK8l3H4a8r/I+14DwWh41niI+B6ettNuMI=;
        b=Jnai3TUAtx1kK6Z/bb6qMvVrc48c8h5tLCdbvQGX+cG0HzVZ5o8QMmz2QNvpn9YN0J
         th8FGzh/LoXYpCocSAT5pw1jKL756YBr0/A0RP+womFL3olOaSMR0uPkNT+oaEUP1KoA
         RIKydAhuluR11tYcLf58otS1QNKYBIx5fkIaQ=
Received: by 10.180.105.129 with SMTP id gm1mr797675wib.1.1326375871414; Thu,
 12 Jan 2012 05:44:31 -0800 (PST)
Received: by 10.223.79.16 with HTTP; Thu, 12 Jan 2012 05:43:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188445>

Hello!

Seems like I found a bug in the clone / push logic. I'm trying to
clone remote branch master into local branch called common and unable
to push back common to master. Git trying to push local master from
different origin to common/master instead.

Here is a simple example:

# mkdir 123
# git init
# > 123
# git add .
# git commit -m "initial"
# git branch
axet-laptop:123 axet$ git branch
* master
# git remote add common https://github.com/axet/common-bin.git
# git fetch common
From https://github.com/axet/common-bin
 * [new branch]      master     -> common/master

?? already strange master (local) to the remote common/master

# axet-laptop:123 axet$ git checkout -b common common/master
Branch common set up to track remote branch master from common.
Switched to a new branch 'common'

# axet-laptop:123 axet$ git branch
* common
  master
axet-laptop:123 axet$

# cat .git/config
[...]

[branch "common"]
	remote = common
	merge = refs/heads/master

?? correct

axet-laptop:123 axet$ git pull
Already up-to-date.
axet-laptop:123 axet$ git push
To https://github.com/axet/common-bin.git
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'https://github.com/axet/common-bin.git'
To prevent you from losing history, non-fast-forward updates were rejected
Merge the remote changes (e.g. 'git pull') before pushing again.  See the
'Note about fast-forwards' section of 'git push --help' for details.
axet-laptop:123 axet$


it tries to push local master to remote common/master which is not correct.

-- AK
