From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Is there a "git reset --keep <sha1> || git reset --hard <sha1>" alternative?
Date: Wed, 20 Apr 2016 19:18:14 +0200
Message-ID: <CACBZZX6k6sFv2GWOzu0Ow1T+5ci2gmMOvaD37bvbm1_qfetr8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 19:18:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asvlv-0000Sh-CX
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 19:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbcDTRSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 13:18:35 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34407 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbcDTRSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 13:18:35 -0400
Received: by mail-qg0-f53.google.com with SMTP id c6so32766455qga.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=t1M00ClES58rWn9CND0/u68arEV0N0HcXmY32CSAJ3Q=;
        b=YGMW77F5G8WKqiS0vGOz38ZSTJBQfGWKUfQvkSsis7uzZin+vRvjaaKDXe3fWsKg+0
         w0cLLa9y4y06HTcPzr9Oc8Va3gFZbotJw4SKj1eAU7p8jNpkCCPkcZ92JMyAJTTFCjZk
         BYvSJ4g5SwBkVTNhjluWtFyt77gy464r8EHU9XYiK1P8vY2JsW/B2BLdACRTiBAe+8bz
         k6OrBAbZ5Xd8YVQqpqO33yflfg9E65/e3uw3h6sNGgFtljBfqHOueKUcFXkujF+JK6PA
         GNJ+GE8yL839apxCRwCVo/jKrdkNJlf14ywdEFusE/xfrTCZtI7KQTDm01BFfeitA/yr
         9scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=t1M00ClES58rWn9CND0/u68arEV0N0HcXmY32CSAJ3Q=;
        b=LarNO4tx9RKo0PumJnFhb6PLC0hGsXYZ7uvsKy2zkPG1bfzWLd1vHwEPEyPh3iO6Gr
         BDHT9bY2mLWuO07ahh3v9g0YZSS9B78StW7J5a9T/F6kzmob1V4EH6kBXQnDriCFkpg5
         oLnGmpfDsthn/E/ABZoahl9f7u3adyIGLEQMbb1nOgCDdUdfN9UeR2rh00TjxIv9n/EV
         04lzMf2pTciIc/zUjzYDMssupm2GUIccHBWyPzpzDAJ2wX5an29MbdTgb4T0QOU2lFVs
         Nc95oKSoobuUx7FvwIujY+inPGBrxp67/QWshcDdWnLLwvDXgxc+eQqE5mmiEiwnr1Jf
         O5Qw==
X-Gm-Message-State: AOPr4FVDXwVlMYPCvywWfGvYQEjpI8TkGQ6BWBhI0LI+NyAYUQSKmEyfax1SEVeuhTYYIZXCz/mteZ8xDof9BA==
X-Received: by 10.140.218.82 with SMTP id o79mr13263999qhb.33.1461172714158;
 Wed, 20 Apr 2016 10:18:34 -0700 (PDT)
Received: by 10.55.77.82 with HTTP; Wed, 20 Apr 2016 10:18:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292046>

If you check out a git repository and chmod a checked-in file there
there away from git defaults then "git reset --hard" will re-chmod it.

The use-case for not having this happen is if you e.g. have some
inotify thing or a stat() loop monitoring changes to the files, and
you'd like them to fire on "real" updates, not just updates that were
introduced because something re-chmoded a file.

E.g. on current git.git master:

    $ ls -l INSTALL ; chmod 600 INSTALL ; git reset --hard @{u} ; ls -l INSTALL
    -rw-r--r-- 1 avar avar 9147 Apr 20 17:11 INSTALL
    HEAD is now at e6ac6e1 Fifth batch for post 2.8 cycle
    -rw-r--r-- 1 avar avar 9147 Apr 20 17:12 INSTALL

What I'd like is for the permissions not to be altered:

    $ ls -l INSTALL ; chmod 600 INSTALL ; git reset --keep @{u} ; ls -l INSTALL
    -rw-r--r-- 1 avar avar 9147 Apr 20 17:12 INSTALL
    -rw------- 1 avar avar 9147 Apr 20 17:12 INSTALL

But I don't want this to happen:

    $ echo "Blah" > INSTALL && git add INSTALL && git commit -m"blah"
    [master d29463e] blah
     1 file changed, 1 insertion(+), 223 deletions(-)
     rewrite INSTALL (100%)
    $ ls -l INSTALL ; chmod 600 INSTALL ; git reset --keep @{u} ; ls -l INSTALL
    -rw------- 1 avar avar 5 Apr 20 17:14 INSTALL
    error: Entry 'INSTALL' not uptodate. Cannot merge.
    fatal: Could not reset index file to revision '@{u}'.
    -rw------- 1 avar avar 5 Apr 20 17:14 INSTALL

Instead I want:

    $ ls -l INSTALL ; chmod 600 INSTALL ; git reset --keep @{u} || git
reset --hard @{u}  ; ls -l INSTALL
    -rw------- 1 avar avar 5 Apr 20 17:14 INSTALL
    error: Entry 'INSTALL' not uptodate. Cannot merge.
    fatal: Could not reset index file to revision '@{u}'.
    HEAD is now at e6ac6e1 Fifth batch for post 2.8 cycle
    -rw-r--r-- 1 avar avar 9147 Apr 20 17:15 INSTALL

And the expectation here is that I'll have something that does a chmod
after the reset happens, which is fine because we had a "real" change,
I just don't want the repo to keep having flip-flopping permissions
because I'd both like:

 * Local chmod to be respected
 * Actual file content changes to be wiped away by reset --hard

Is there another way to do this, or dare I say alternatively maybe we
could use another option to reset making it even more confusing :)
