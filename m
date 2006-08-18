From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Unresolved issues #3
Date: Fri, 18 Aug 2006 09:54:03 +0100
Message-ID: <tnx1wre4e6s.fsf@arm.com>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 10:54:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE07N-0005xL-By
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 10:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWHRIyO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 04:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWHRIyN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 04:54:13 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:43649 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751290AbWHRIyN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 04:54:13 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k7I8s5Gf009159;
	Fri, 18 Aug 2006 09:54:05 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 18 Aug 2006 09:54:05 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 17 Aug 2006 21:09:03 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 18 Aug 2006 08:54:05.0268 (UTC) FILETIME=[DBF9D940:01C6C2A3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25636>

--=-=-=

Junio C Hamano <junkio@cox.net> wrote:
> * Martin Langhoff proposed git-xxdiff as a helper after a failed
>   merge.
>
>   Message-ID: <11546492331601-git-send-email-martin@catalyst.net.nz>
>
>   I like the general idea of this a lot, but am having a bit of
>   trouble envisioning how we can integrate this while making
>   sure mergers other than xxdiff can be added easily without
>   disrupting the end user experience.

In StGIT I can configure the merge command and I currently use the
attached script (I need to add it to the StGIT repository). It tries
diff3 first and, if that fails, invokes emacs' merge (can use xxdiff
as well). It also checks whether the file was modified in case I want
to exit and solve the conflict later (maybe after getting conflict
information for the other files).

-- 
Catalin


--=-=-=
Content-Type: text/x-python
Content-Disposition: inline; filename=merge-interactive.py

#!/usr/bin/env python
"""Run diff3 and an interactive tool if this fails.
"""

__copyright__ = """
Copyright (C) 2006, Catalin Marinas <catalin.marinas@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License version 2 as
published by the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
"""

import sys, os

if len(sys.argv) != 5:
    print >> sys.stderr, 'Usage: %s ancestor branch1 branch2 output' \
          % sys.argv[0]
    sys.exit(1)

ancestor = sys.argv[1]
branch1  = sys.argv[2]
branch2  = sys.argv[3]
output   = sys.argv[4]

# default merger
if os.system('diff3 -L current -L ancestor -L patched -m -E '
             '"%s" "%s" "%s" > "%s"'
             % (branch1, ancestor, branch2, output)):
    # interactive merge
    if os.path.exists(output):
        mtime = os.path.getmtime(output)
    else:
        mtime = 0

    ret = os.system('emacs --eval \'(ediff-merge-files-with-ancestor '
                    '"%s" "%s" "%s" nil "%s")\''
                    % (branch1, branch2, ancestor, output))

    #ret = os.system(
    #    'xxdiff --title1 current --title2 ancestor --title3 patched '
    #    '--show-merged-pane -m -E -O -X -M "%s" "%s" "%s" "%s"'
    #    % (output, branch1, ancestor, branch2))

    # error in the interactive merger, just exit
    if ret:
        sys.exit(2)

    # check for file modification
    if not os.path.exists(output) or mtime == os.path.getmtime(output):
        sys.exit(3)

# everything's fine
sys.exit(0)

--=-=-=--
