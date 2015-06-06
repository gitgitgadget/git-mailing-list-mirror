From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v2 0/2] specify commit by negative pattern
Date: Sat,  6 Jun 2015 01:24:53 +0100
Message-ID: <1433550295-15098-1-git-send-email-wmpalmer@gmail.com>
Cc: Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 02:25:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z11vt-0000wb-MA
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 02:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbbFFAZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 20:25:47 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:36430 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbbFFAZq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 20:25:46 -0400
Received: by wgbgq6 with SMTP id gq6so67354872wgb.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 17:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mzSHygqO0zZqvpHrNyRMcOBKYBrCu1YWkVGMGulVFMY=;
        b=JqpdUnAORZMbardQbevrkNaj1dUuW3treE0IOYIFSfkpf4Bc6jbgwY4n6vdE77ngY4
         4D/oE4EJ2skRSWrY9Qjt1TAbDm3hukv/wqAFsbDqHnllA3umdMSq6mMJec/7Oi0FZY9o
         SLsR/W3mhtPnXm+Uwf728iBPnalp1+tz5DCGSOqz+biQdAs2dikpSEYlJccIOaWAAriX
         u70TQnzzAJEBIsxTr3i2c5Nj9daWvNT92zVrdNj6nJQrFiofO+L0AP33TBXtgbT/Zgw9
         Dv0rhw8Pa2mX3kuA5xRS2MTpW2Yl6mA3CWXi0EJkzlTVFfBZ0Y8f89qbP7p1HH0/03Eb
         8zQA==
X-Received: by 10.194.76.73 with SMTP id i9mr10851971wjw.149.1433550345168;
        Fri, 05 Jun 2015 17:25:45 -0700 (PDT)
Received: from localhost.localdomain (cpc12-folk2-2-0-cust138.1-2.cable.virginm.net. [81.109.109.139])
        by mx.google.com with ESMTPSA id 12sm12755607wjw.17.2015.06.05.17.25.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Jun 2015 17:25:44 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270896>

add support for negative pattern matching in @^{/<pattern>} style
revision specifiers. So now you can find the first commit whose message
doesn't match a pattern, complementing the existing positive matching.
e.g.:

    $ git rebase -i @^{/!-^WIP}

My use-case is in having a "work, work, work, rebase, push"-style
workflow, which generates a lot of "WIP foo" commits. While rebasing is
usually handled via "git rebase -i origin/master", occasionally I will
already have several "good, but not yet ready to push" commits hanging
around while I finish work on related commits. In these situations, the
ability to quickly "git diff @^{/!-^WIP}" to get an overview of all
changes "since the last one I was happy with", can be useful.

This is the second version of the patch series. The previous attempt
used the notation @^{/!WIP}, rather than @^{/!-WIP}, so the "modifier"
was the '!' character. Now, '!' is taken as an indicator that the
pattern is to be interpreted differently, and '-' is taken as an
indicator of how it is to be interpreted differently. This follows
recent discussion with "Junio C Hamano" <gitster@pobox.com> and much-less
recent discussion archived at:

http://thread.gmane.org/gmane.comp.version-control.git/40460/focus=40477

In summary, '!' is to be used as an "escape hatch", for further
extension of the "name commit by pattern" functionality. Theorised future
extensions indicated things like "what was to be searched",
e.g.: @^{/!(a=author)}.  With only two interpretations of the '!'
leader, for now (including the '!!' literal notation), adding such a
verbose form, such as '@^{/!(negative)foo}', seemed inappropriate at this
time. In the event that such verbose forms are ever implemented, this new
form may act as a shorthand, for a basic case.

Will Palmer (2):
  test for '!' handling in rev-parse's named commits
  object name: introduce '^{/!-<negative pattern>}' notation

 Documentation/revisions.txt | 11 +++++-----
 sha1_name.c                 | 20 ++++++++++++-----
 t/t1511-rev-parse-caret.sh  | 53 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 11 deletions(-)

-- 
2.3.0.rc1
