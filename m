From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 0/9 v2] difftool: teach command to perform directory diffs
Date: Sat, 17 Mar 2012 21:55:25 -0400
Message-ID: <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 02:56:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S95MI-000489-Cw
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 02:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368Ab2CRBz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 21:55:56 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55335 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab2CRBz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 21:55:56 -0400
Received: by iagz16 with SMTP id z16so7559135iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yYVPdUwRn35+47ndL5HRv6J1mfwpDYxXXg+D/8nl3YA=;
        b=pBts1CgrR0n5NzES/R+7hmHNdrHtxOHHM556wsIt4ETXszlhX+mU8hqHYN9bUM4omG
         CACpSwarekPQkJOFQ5wlmOW4ji8Y07pKHxlZnpPgRKTRnloJ3WNz+8wmFeyqGS0dwnsn
         M3giZ33HCjfNj7OUzcvOvsgE688nzdeAWBmKODS9EDAoSSKw0GaBWz5f0ij1hPDItLx3
         b106bWtJ/DFpYy8+QdslmV0PNvD9k1L8U53QTMMjWfqk19WSVksaVjfqH/WQNHRquOnc
         3MhLoeD2zZxbzj02zPGMjykreZKRypPvjl3acjNIUSpwHoXLQ5ga7J9h5Kgkst+bESKp
         sW/g==
Received: by 10.50.41.161 with SMTP id g1mr2971634igl.5.1332035755581;
        Sat, 17 Mar 2012 18:55:55 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id rd7sm2954140igb.14.2012.03.17.18.55.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 18:55:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193355>

Changes in v2:
  [PATCH 7/9] difftool: teach difftool to handle directory diffs
    - Location of /tmp is now determined via the File::Temp::tempdir. In
      v1, the location was hard-coded to '/tmp'.
    - Lexical filehandles are now used for open().
    - Modern, 3 argument, form of open() is now used.
    - Arguments to the 'system' call for $extcmd are now given in list form.
    - Replaced 'system' call to 'git difftool--helper' with Git::command_noisy

  [PATCH 9/9] difftool: print list of valid tools with '--tool-help'
    - The glob statement used to find the mergetool options now uses the
      fully qualified path.  This insures that 'git difftool --tool-help'
      can be called from any directory.

Series overview:

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
 git-difftool.perl              |  259 +++++++++++++++++++++++++++-------------
 3 files changed, 202 insertions(+), 94 deletions(-)

-- 
1.7.9.1.290.gbd444
