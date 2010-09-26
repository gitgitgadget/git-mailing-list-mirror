From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Eliminate cryptic "needs update" error message
Date: Sun, 26 Sep 2010 20:51:54 +0530
Message-ID: <1285514516-5112-1-git-send-email-artagnon@gmail.com>
References: <4C9E07B1.50600@workspacewhiz.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 26 17:23:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozt4b-0001gY-Ql
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 17:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab0IZPXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 11:23:24 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58236 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab0IZPXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 11:23:24 -0400
Received: by pvg2 with SMTP id 2so1044246pvg.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 08:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=W9U+e9ant0C6odGcptc1DtRuhtapClos2AgIa/TKgq0=;
        b=aViosqQvNUfdGa8fKxF2VWWaZ41um0/X9nIFqm3DllBBGOmWgDXZhVB3p2TW5krnYE
         dG/wobLrr8op8aqCgSsM9tpNqvy4yoC8jvXJrq0fa+fY6SVE1E4DoIqsa2Jn4bOIYWXs
         4F74q7APQjKUnJb3B2SFwMMtdCJvkeS8fVh6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cw4MVxiw+Jcqo1WDwoLqNZLowO8GbN4J3HcoWJfmXD1VH4bcsw5lT4tuPdR47UXC4v
         oVphV+CCdh1Z/Rqc9ExRnXREtJmKVNU/Wf4clvJB+6cEWfqBHhQV2anvFbGBlcc2rauA
         YGNbOskfP+UKVf4Y8l2hZscWFTfML3pgSYLpA=
Received: by 10.114.24.15 with SMTP id 15mr6893203wax.122.1285514603452;
        Sun, 26 Sep 2010 08:23:23 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d39sm8436936wam.16.2010.09.26.08.23.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 08:23:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a.dirty
In-Reply-To: <4C9E07B1.50600@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157231>

Hi Joshua,

Joshua Jensen writes:
> Is there opposition to modernizing this *term* to make it more clear
> based on the porcelain commands being run?

Most porcelain commands already contain checks to specifically prevent
it from displaying this message. See:

cache.h:506:#define REFRESH_IN_PORCELAIN        0x0020  /* user friendly output, not "needs update" */
git-add--interactive.perl:215:          ;# ignore 'needs update'
read-cache.c:1109:      needs_update_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
builtin/add.c:190:      refresh_index(&the_index, verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET,
builtin/commit.c:284:   if (refresh_cache(refresh_flags | REFRESH_IN_PORCELAIN))
builtin/reset.c:326:                            quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
builtin/reset.c:377:                            quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
cache.h:506:#define REFRESH_IN_PORCELAIN        0x0020  /* user friendly output, not "needs update" */
read-cache.c:1104:      int in_porcelain = (flags & REFRESH_IN_PORCELAIN);

The real problem is with the shell scripts that invoke `git
update-index --refresh` without `-q` and forget to redirect output to
/dev/null. The Git infrastructure thinks update-index is a
non-porcelain: little does it know that update-index being run from a
porcelain-level shell script.

Thank you for reporting this bug.

-- Ram

Ramkumar Ramachandra (2):
  sh-setup: Write a new require_clean_work_tree function
  Porcelain scripts: Rewrite cryptic "needs update" error message

 git-pull.sh                |    5 +----
 git-rebase--interactive.sh |   16 ++++------------
 git-rebase.sh              |   14 +-------------
 git-sh-setup.sh            |   23 +++++++++++++++++++++++
 4 files changed, 29 insertions(+), 29 deletions(-)

-- 
1.7.2.2.409.gdbb11.dirty
