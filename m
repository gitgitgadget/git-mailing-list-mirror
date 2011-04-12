From: "C. Scott Ananian" <cscott@laptop.org>
Subject: precommit hook broken with "git commit <filename>"
Date: Tue, 12 Apr 2011 11:17:10 -0400
Message-ID: <BANLkTimB=TZ1gP-18ywbZUOZSbDamkRwCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 12 17:50:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9frF-0006ER-8F
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 17:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757879Ab1DLPuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 11:50:18 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56524 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757640Ab1DLPuR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 11:50:17 -0400
Received: by pwi15 with SMTP id 15so2426263pwi.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 08:50:17 -0700 (PDT)
Received: by 10.142.250.2 with SMTP id x2mr6528414wfh.381.1302621430793; Tue,
 12 Apr 2011 08:17:10 -0700 (PDT)
Received: by 10.142.44.8 with HTTP; Tue, 12 Apr 2011 08:17:10 -0700 (PDT)
X-Google-Sender-Auth: eTMiVc7x21MBNgWJNbm2dlxfSoo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171400>

It appears that "git commit <filename>" breaks the git precommit hook.
 Every other git command updates the index to make the
commit-about-to-be-made before running the precommit hook, and indeed
the 'pre-commit.sample' distributed with git assumes that the index
reflects the commit.  However, in the case of "git commit <filename>"
the man page states "the commit will ignore changes staged in the
index, and instead record the current content of the listed files
(which must already be known to git)".

This seems like a bug.  The precommit hook does not know (and has no
apparent way of knowing) the contents of the commit-in-progress!  If
there is a workaround, it should be incorporated into the
'pre-commit.sample', which otherwise displays the same bug; to wit,
you can inadvertently commit changes which would fail the pre-commit
check by simply using the 'git commit <filename>' form.
Worse/alternatively, bad files already existing in the index can block
the commit of "good" files named on the command line.

The fix appears clear: "git commit <filename>..." should do the
equivalent of stashing the current index, adding the named files,
*then* run the precommit hook, then do the commit, before restoring
the stashed index.  That would provide a consistent state for the
precommit hook.
  --scott
