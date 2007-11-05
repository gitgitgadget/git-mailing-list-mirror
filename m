From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: [BUG] git grep broken on master - won't work when merging
Date: Tue, 6 Nov 2007 12:53:21 +1300
Message-ID: <46a038f90711051553p6202cc62wfda6b45ff7769984@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBlC-0004wt-Un
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbXKEXxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbXKEXxY
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:53:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:4130 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbXKEXxX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:53:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1012799ugc
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 15:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=smwIPJD++N6GE4CDKTA445uetauOhhPMew7xW9JTgIQ=;
        b=bwB8wYPrUeLLTz0+YuPPOgIFFreOhc5bJtKNRdDg+XcUnERVSJ/r7t3uph4CmkpxWnlf+XVzBHpBKtXQ1s8Wdk7pQC3YKnhs1ljMW3uW+AC+wCoJmSsEswdx7zKu+TGtrjexSMgKi7/QkUaJo2xrrP0J2eOdOnnpy4UTIMrTLbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mw+fjJSvVkIi+oY+w+4eNlZ63QWLK/BRRbhx31iFtvYmddDSZqydHYmSeo6xsR/FyUIONJ3NkWHJ6mXqQqDuZY3LcXCcxJBOjV373b+58cIhKkXKOWndwOsbHLQptzv/KL2iNC3DBlO1qPs1JWzwHxzkwjGI5uXgrgGW1pmqY2Y=
Received: by 10.66.220.17 with SMTP id s17mr2022618ugg.1194306801272;
        Mon, 05 Nov 2007 15:53:21 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Mon, 5 Nov 2007 15:53:21 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63592>

Strange behaviour of git grep on one of the projects I hack on...

  $ git --version
  git version 1.5.3.5.561.g140d

  $ git grep LOB lib
  fatal: insanely many options to grep

After a bit of head-scratching I realised I was in the middle of a
merge, with some unresolved paths in the lib directory. A bit of
testing shows that the unresolved index is probably the problem:

  $ git grep LOB lib
  fatal: insanely many options to grep

  # an unresolved file
  $ git grep  LOB lib/accesslib.php
  fatal: insanely many options to grep


  $ git grep --cached LOB lib
  (... expected grep output...)

  $ git reset --hard
  $ git grep LOB lib
  (... expected grep output...)

... not sure what the correct behaviour should be -- I guess the most
reasonable action would be to grep the files on disk for those
unresolved paths. In any case, the error message is insanely many
confusing to user! ;-)

Probably whitespace damaged...

diff --git a/builtin-grep.c b/builtin-grep.c
index c7b45c4..1831ef0 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -213,7 +213,7 @@ static int flush_grep(struct grep_opt *opt,
                 * arguments even for the call in the main loop.
                 */
                if (kept)
-                       die("insanely many options to grep");
+                       die("Unresolved index or too many options to grep");

                /*
                 * If we have two or more paths, we do not have to do


cheers,


martin
