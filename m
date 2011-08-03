From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v16 7/7] bisect: add documentation for --no-checkout option.
Date: Thu,  4 Aug 2011 07:57:06 +1000
Message-ID: <1312408626-8600-8-git-send-email-jon.seymour@gmail.com>
References: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 23:58:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojSR-0007Xt-Tg
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614Ab1HCV61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:58:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44630 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab1HCV60 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:58:26 -0400
Received: by gyh3 with SMTP id 3so742114gyh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+1iSofseg0BsPVY+4fT7ZB5oHyEm1ylYqwVu+3iQA9Q=;
        b=iJDjc5N1oOg4rp53bf2caukEeof2TZAykzTQTSAYpnIDd/FG56juL3ycuK6Iwn79Yq
         JyhdQgLeh241D5Hrg+QEACD6BJqHir80zMyrt0K6ocCQ+G/3X197FlWLdUjkW3hv0pVO
         +i5UR1BoYJg08ntOPdHDfnk1OyMWIsWz5ugyQ=
Received: by 10.150.228.11 with SMTP id a11mr1182138ybh.257.1312408705530;
        Wed, 03 Aug 2011 14:58:25 -0700 (PDT)
Received: from localhost.localdomain ([120.16.210.46])
        by mx.google.com with ESMTPS id e7sm625568ybg.18.2011.08.03.14.58.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 14:58:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g172e
In-Reply-To: <1312408626-8600-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178636>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ab60a18..44b9845 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect help
- git bisect start [<bad> [<good>...]] [--] [<paths>...]
+ git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad [<rev>]
  git bisect good [<rev>...]
  git bisect skip [(<rev>|<range>)...]
@@ -263,6 +263,17 @@ rewind the tree to the pristine state.  Finally the script should exit
 with the status of the real test to let the "git bisect run" command loop
 determine the eventual outcome of the bisect session.
 
+OPTIONS
+-------
+--no-checkout::
++
+Do not checkout the new working tree at each iteration of the bisection
+process. Instead just update a special reference named 'BISECT_HEAD' to make
+it point to the commit that should be tested.
++
+This option may be useful when the test you would perform in each step
+does not require a checked out tree.
+
 EXAMPLES
 --------
 
@@ -343,6 +354,25 @@ $ git bisect run sh -c "make || exit 125; ~/check_test_case.sh"
 This shows that you can do without a run script if you write the test
 on a single line.
 
+* Locate a good region of the object graph in a damaged repository
++
+------------
+$ git bisect start HEAD <known-good-commit> [ <boundary-commit> ... ] --no-checkout
+$ git bisect run sh -c '
+	GOOD=$(git for-each-ref "--format=%(objectname)" refs/bisect/good-*") &&
+	git rev-list --objects BISECT_HEAD --not $GOOD >tmp.$$ &&
+	git pack-objects --stdout >/dev/null <tmp.$$
+	rc=$?
+	rm -f tmp.$$
+	test $rc = 0'
+
+------------
++
+In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit that
+has at least one parent whose reachable graph is fully traversable in the sense
+required by 'git pack objects'.
+
+
 SEE ALSO
 --------
 link:git-bisect-lk2009.html[Fighting regressions with git bisect],
-- 
1.7.6.352.g172e
