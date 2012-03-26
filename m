From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 0/4] grep: add more information to hunk separators
Date: Sun, 25 Mar 2012 22:41:41 -0400
Message-ID: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 04:42:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBztF-0000YB-Hn
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 04:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab2CZCl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 22:41:59 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:34124 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab2CZCl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 22:41:58 -0400
Received: by qadc11 with SMTP id c11so1895985qad.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=k1bSDqqPanKgeQ4nrlp38WWBn5FycCStG67JSrWBY/k=;
        b=tA+SVWdp+G1QrXVkygijlBY0jCUy6CPSHnIjx9oyddQskf9hvbHITDWZsSLL8O6/Mx
         8TGDtXzuIPlx2ZeES098fWg58tYzdgfj4XV/q4yrJfOm71kdpQHxM5dHzoYSRM25uFbE
         4URvL2NtdGQDGcrEtLp7jrtMPv8ZDewkKCdWt821FHAXDGpsuteA/qEDnv79VZtamc5C
         oXVXUCuItZhyEorQUZPcRo2W+apXZdXT9ySNGOLNUevl7MinF+xRYJG8Nqd2NXfF1N4d
         foa4adGwsYIvs70BSDMmqFY2zhHiuIh858vGtO7yj4g3rNAdKrWIT4x+lXCjmtjgVs6i
         dqxQ==
Received: by 10.224.204.8 with SMTP id fk8mr6906750qab.76.1332729717503;
        Sun, 25 Mar 2012 19:41:57 -0700 (PDT)
Received: from mark.hsd1.dc.comcast.net. (c-76-21-213-235.hsd1.dc.comcast.net. [76.21.213.235])
        by mx.google.com with ESMTPS id fq1sm27711867qab.10.2012.03.25.19.41.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Mar 2012 19:41:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193891>

This patch series adds a new `grep --hunk-heading' option that moves the
filename and line number to the hunk separator lines ("--") rather than at the
beginning of each matching (or context) line.  In my opinion, this makes the
output easier to read, especially when combined with `--heading'.

I am not sure that "hunk-heading" is the best term, so I welcome ideas on
better names.

Here's an example:

    # Current behavior:
    $ git grep -p -C1 -n list_common -- git.c
    git.c=531=int main(int argc, const char **argv)
    --
    git.c-570-              printf("usage: %s\n\n", git_usage_string);
    git.c:571:              list_common_cmds_help();
    git.c-572-              printf("\n%s\n", git_more_info_string);

    # New option:
    $ git grep -p -C1 --hunk-heading list_common -- git.c
    -- git.c:531 --
    int main(int argc, char argv)
    -- git.c:570 --
                    printf("usage: %s\n\n", git_usage_string);
                    list_common_cmds_help();
                    printf("\n%s\n", git_more_info_string);

    # New option with --heading:
    $ git grep -p -C1 --hunk-heading --heading list_common -- git.c
    git.c
    -- 531 --
    int main(int argc, char argv)
    -- 570 --
                    printf("usage: %s\n\n", git_usage_string);
                    list_common_cmds_help();
                    printf("\n%s\n", git_more_info_string);

Originally, I had envisioned also moving the function name (`-p') to the hunk
header, similar to the diff context line.  For example:

    -- git.c:570 -- int main(int argc, char argv)
                    printf("usage: %s\n\n", git_usage_string);
                    list_common_cmds_help();
                    printf("\n%s\n", git_more_info_string);

After implementing this feature, I was not happy with the result and
subsequently removed it.  To me, the output was too cluttered and the line
number was ambigous.  For example, in the above, it is not obvious to me that
line 570 is the "printf" line and not the "int main" line.  Still, if you
would like to see the patch to implement this feature, please let me know.


Mark Lodato (4):
  grep doc: add --break / --heading / -W to synopsis
  add tests for grep --heading with context
  grep: move code to print hunk markers after heading
  grep: add --hunk-heading option

 Documentation/config.txt     |    3 +
 Documentation/git-grep.txt   |   10 +++
 builtin/grep.c               |   10 ++-
 grep.c                       |   49 ++++++++----
 grep.h                       |    1 +
 t/t7810-grep.sh              |   37 +++++++++
 t/t7812-grep-hunk-heading.sh |  181 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 276 insertions(+), 15 deletions(-)
 create mode 100755 t/t7812-grep-hunk-heading.sh

-- 
1.7.9.2
