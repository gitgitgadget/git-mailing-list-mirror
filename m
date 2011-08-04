From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v17 7/7] bisect: add documentation for --no-checkout option.
Date: Thu,  4 Aug 2011 22:01:03 +1000
Message-ID: <1312459263-16911-8-git-send-email-jon.seymour@gmail.com>
References: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 14:02:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qowd9-000490-I8
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 14:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab1HDMCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 08:02:20 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33284 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab1HDMCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 08:02:19 -0400
Received: by yxj19 with SMTP id 19so742107yxj.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 05:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Z2QbRYeeTN15nDuPVnin7GvLujZAzZFI73fr7MebvrE=;
        b=UG7ZdNgJW+dDKD7QMIgYcZiwowai2mnHndiyS7sSQFS3eZ9D0zKlGRpwoS1axC+RmK
         qquwhgxCX0UaGE5pTE0nRs5ao98XlmQS/qbaCughIvYz28uvFZhqr1np38MmTCsGZg+9
         nH0vpjHnP74V1YP9Ik2teuhBOYwV7K5BEMra4=
Received: by 10.142.165.18 with SMTP id n18mr743627wfe.235.1312459338129;
        Thu, 04 Aug 2011 05:02:18 -0700 (PDT)
Received: from localhost.localdomain ([120.16.214.215])
        by mx.google.com with ESMTPS id i5sm249965wff.18.2011.08.04.05.02.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 05:02:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g50d6f
In-Reply-To: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178745>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ab60a18..41e6ca8 100644
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
+	GOOD=$(git for-each-ref "--format=%(objectname)" refs/bisect/good-*) &&
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
1.7.6.353.g50d6f
