From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: BUG. git rebase -i  successfully continues (and also skips
 rewording) when pre-commit hook fails (exits with non-zero code)
Date: Thu, 17 Nov 2011 12:58:47 +0400
Message-ID: <20111117125847.190e9b25@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 09:58:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQxo9-0004k7-Rx
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 09:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab1KQI6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 03:58:53 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49554 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab1KQI6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 03:58:52 -0500
Received: by eye27 with SMTP id 27so1614024eye.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 00:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:date:from:to:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=7yaBi/Au4L+xx+BtywwXk0EEsKGeHgMT0kXYeoA2yY8=;
        b=PpSHBpQedXdBJx7Yjpebi+W8UJ6xXyIpArbYdkRI+He5TDcuGjmogZmOUXxBVTHYOz
         pqF+Yhi3EFeWKX0/S0zNNeLR3Nj1NgKv1Up1zgvDWhR2oN83HzHqUVZ9QxhMvvM0AcQP
         P+j3vhPeJ0BQ+qZoPxzmGrlRFJgqA3Vu7tjTQ=
Received: by 10.213.34.202 with SMTP id m10mr575758ebd.1.1321520330303;
        Thu, 17 Nov 2011 00:58:50 -0800 (PST)
Received: from ashu.dyn.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id k13sm2974740fah.0.2011.11.17.00.58.48
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 00:58:49 -0800 (PST)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185579>

For a project I have a pre-commit hook that monitors
whether files in a folder (scripts of DB) changed or not
and fails if another special file (DB version) did not changed, too.

So, I did some commits and then I decided to change the order of them.
Of course, I used a lovely "git rebase -i" command. I changed the order
of the commits, then rebasing went ok. But I noticed that my pre-commit
hook output failure message (one of the commits did not meet
above-mentioned condition). It's not too bad but ugly. But when I
decided to correct a message of that specific commit I ran
"git rebase -i" again, marked that commit for rewording, rewording did
not start (because pre-commit hook failed, obviously) and rebasing went
on (commit had an unchanged message) and successfully finished. That is
not what I expected.
I guess if any of hooks fail (which usually fail the commit), rebasing
have to be interrupted (as when there are conflicts)

Here is a sample to reproduce the error
git init .
echo content > file
git add -fv file
git commit -a -m 'first commit'
echo line 2 >> file
git commit -a -m 'secont commit' # note a typo ;)
echo '#!/bin/bash
echo commit failed
exit 1' > .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
echo fail >> file
git commit -a -m 'failed commit' # to show that pre-commit hook fails
# and outputs "commit failed"
git reset --hard
git rebase -i HEAD^
# mark commit for rewording and exit an editor

note following output after all this:
>commit fail/1)
>Successfully rebased and updated refs/heads/master
