From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 0/9] difftool: teach command to perform directory diffs
Date: Fri, 16 Mar 2012 21:57:13 -0400
Message-ID: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 02:58:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8iuI-0005WN-N9
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 02:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032977Ab2CQB5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 21:57:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51068 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031441Ab2CQB5f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 21:57:35 -0400
Received: by iagz16 with SMTP id z16so6233121iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 18:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3WnVDYKv7GOjy7WyIiVR1Qb1f7nQ6dLFzKW1xSFCr+4=;
        b=T6cnb2PqW1LwGi8+ThJetmjpbTSr+6AG9yxksbMpT8Y3/4r/Yv27n9rt4NseOESZDQ
         AfelyGeDgzLeW/y/5XRGoZlawOKBzvSqE+4BbK6AXAxzJ7VhM788ayJ9mMX98GJS/hMS
         F84HaqohjNTFT0I3Sm+s2wgkgDHg2Q18VJTECcZMiD89K/AQ4iVY3joEKQl6cISjis/D
         tUb7Ialn7lgsj+XCS2GMZCtxDpyrHi8+Vji3qicWQKUhL5jTblCWBLTjaiyuyQmfC2kV
         X1x2+ck3YNTROiVcjfO8LK7Fx2Za6aMHmaLe2qO1v7o/Pl7+S+KOG9Fj8lt2Cmwqcv7T
         scvg==
Received: by 10.50.106.132 with SMTP id gu4mr934818igb.59.1331949454747;
        Fri, 16 Mar 2012 18:57:34 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id al5sm1240222igc.5.2012.03.16.18.57.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 18:57:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193289>

'git difftool' is a very useful command that allows git diffs to be opened
in an external tool. Currently, difftool opens a separate instance of the
external tool for each file that changed. This can be tedious when many
files have changed.

This series teaches difftool to perform directory diffs, so that all file
changes can be opened/reviewed in a single instance of the external tool.

This is the second phase of development for this feature. The first phase
was added as a separate command (git diffall) in 1252bbe (contrib: add
git-diffall script). During review of that script on the Git developers
list, an informal development roadmap was suggested [1]. The next phase
of that plan is to integrate the 'git-diffall' feature into 'difftool'.
This series gets that done.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/191297/focus=191383


Patches 1-6 are clean-up and rewrite to prepare for later changes. They
are not intended to change the behavior of difftool. Instead, they teach
the script to use standard modules for option parsing and interacting with
the Git repo. I understand that these changes may be controversial due to
the amount of rewrite, but the end result is that the script is half the
previous size and I believe is easier to understand and maintain.

Patches 7 and 8 are the core changes in this series. They teach difftool the
new "--dir-diff" option. When this option is used, difftool will copy files
that were changed to a temporary location and run a single directory diff on
them rather than run a separate instance of the diff tool for each file.

Patch 9 is a new implementation of a patch that I submitted recently.
061e672 (difftool: print list of valid tools with '--tool-help' was written
prior to these other changes. It needed to be rewritten to fit into the
Getopt::Long option parsing framework included with this series.

Tim Henigan (9):
  difftool: parse options using Getopt::Long
  difftool: exit(0) when usage is printed
  difftool: remove explicit change of PATH
  difftool: stop appending '.exe' to git
  difftool: eliminate setup_environment function
  difftool: replace system call with Git::command_noisy
  difftool: teach difftool to handle directory diffs
  difftool: teach dir-diff to copy modified files back to working tree
  difftool: print list of valid tools with '--tool-help'

 Documentation/git-difftool.txt |   17 ++-
 git-difftool--helper.sh        |   20 +++-
 git-difftool.perl              |  257 +++++++++++++++++++++++++++-------------
 3 files changed, 200 insertions(+), 94 deletions(-)

-- 
1.7.9.1.290.gbd444
