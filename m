From: Geofrey Sanders <geofrey.sanders@gmail.com>
Subject: Windows path handling changed between versions
Date: Tue, 1 Sep 2015 12:55:38 -0400
Message-ID: <CAFPYLHASH_LZ2YgQWjfPKCwq_n-9HVNotkimiQDY1Qy8_8gtwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 18:56:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWoqr-0005gF-0j
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 18:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbbIAQ4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 12:56:00 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35019 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbbIAQz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 12:55:59 -0400
Received: by lbpo4 with SMTP id o4so3301370lbp.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=E0As6AqTyJnY3dYCYth8Ef5WQsr8ily7UdnDp4/bH8Y=;
        b=lOmTQj61vYRaGukPpX04k5vzcQuydSn87A00wauCH5Cuonb7r3qopf1W/LcE1CAsIy
         5m3L6GbFHEus80gvIOolbo2GeQ97K8Ta0givP56Cgo1+f3DqAWOylD49g7nsJfGgNPHm
         LLUw/q74/eDxAocts7LkOi+QyhIjX74pYm0haQ6aTpkcmE50Ed3wEXobCC6FpWiV0Chb
         sVzJ+hRyowsrXxunVR+g/lSUYehO94+fiZVd5ME7CpdOQ3TOQSXFk6uCYmXWqnavqozt
         5ETaWwIDrOhult5hMj6sJORkudFdkCLGRIxQ7YWg/3dUk8VpWGhWhS+HtEpdUfV8f5hw
         9/aw==
X-Received: by 10.152.23.4 with SMTP id i4mr2723351laf.51.1441126557775; Tue,
 01 Sep 2015 09:55:57 -0700 (PDT)
Received: by 10.112.200.134 with HTTP; Tue, 1 Sep 2015 09:55:38 -0700 (PDT)
X-Google-Sender-Auth: S3Z_FOphpVZtQrN9u5FdOyJY_Oc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276992>

I recently upgraded from Windows Git 1.6.2 to 2.5.0 and found myself
unable to rebase. Turns out paths didn't used to be case-sensitive and
now they are, causing a number of operations to halt. A repo created
by pointing at the directory
    c:\core\guidewire\Dev\2.4
would (I suppose) technically have been invalid the whole time because
Windows reports the current path as
    C:\core\guidewire\Dev\2.4
, but msys Git 1.6.2 evidently made a case-insensitive path comparison
so the discrepancy was suppressed.

The proximate cause of errors was
    git rev-parse --is-inside-work-tree
which would output 'false' even inside the working tree.
"--is-inside-git-dir" also printed 'false' in directories where it
should have said 'true'. I actually missed the problem in plain sight
at first, because I created a new repo (in which everything worked as
expected), and then did a directory diff... the worktree paths were
different but I only noticed the names, not the case difference in the
drive letter. More details in this SO question:
http://stackoverflow.com/q/32280644/2835086

I was able to repair my existing repos by changing the 'worktree'
value in gitconfig - s/c/C/ did the trick - but the whole thing was a
surprise.

Is this a bug in the current version? Windows doesn't distinguish on
case, so maybe applications shouldn't either.
Was this a bug in the prior version? Maybe creating a repo with a
worktree path that doesn't match the file system should have been an
error from the very beginning.
Was this user error? Maybe I did something wrong and should have known
better, but got away with it for a while.

Any feedback welcome,
-gws
