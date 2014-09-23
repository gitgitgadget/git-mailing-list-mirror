From: Laszlo Ersek <lersek@redhat.com>
Subject: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 03:09:43 +0200
Message-ID: <1411434583-27692-1-git-send-email-lersek@redhat.com>
To: gitster@pobox.com, git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com, lersek@redhat.com
X-From: git-owner@vger.kernel.org Tue Sep 23 03:10:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWEc9-00013n-UI
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 03:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbaIWBJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 21:09:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60956 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbaIWBJx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 21:09:53 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8N19pFj032233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Sep 2014 21:09:51 -0400
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-28.ams2.redhat.com [10.36.116.28])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s8N19ljb013404;
	Mon, 22 Sep 2014 21:09:48 -0400
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257392>

The edk2 (EFI Development Kit II) project at
<https://github.com/tianocore/edk2/> uses CRLF line endings.

The following small reproducer demonstrates how gitdiff_verify_name()
breaks when it meets the usual git patches workflow in combination with
CRLF line endings:

1. Prepare the test repo:

  mkdir testdir
  cd testdir
  git init
  git config core.whitespace cr-at-eol
  git config am.keepcr true
  touch f1
  git add f1
  git commit -m 'initial import'

2. In the contributor role, write a patch that creates a new file
(adhering to the CRLF convention), submit it, then clean up:

  git checkout -b branch1 master
  echo 'hello world' | unix2dos >f2
  git add f2
  git commit -m 'add f2'
  git format-patch master..branch1
  git send-email 0001-add-f2.patch
  # send it to yourself -- make sure it goes through your MTA
  git clean -fdx

3. In the reviewer / tester / maintainer role, save the patch from your
email client to a local file. Assume that your email client does not
corrupt the patch when saving it. (Thunderbird doesn't corrupt it, for
example.) Once saved, try to apply the patch email to a new branch.

  git checkout -b branch2 master
  git am /path/to/the/saved/file

  -> Applying: add f2
  -> fatal: git apply: bad git-diff - expected /dev/null on line 9

This happens because am.keepcr==true keeps the CRLFs intact (as it should
in fact), but then "/dev/null\r" in the diff header trips up
gitdiff_verify_name().

Fix it by reusing the is_dev_null() helper function, which in effect
changes the condition from

  memcmp("/dev/null", line, 9) || line[9] != '\n'

to

  memcmp("/dev/null", line, 9) || !isspace(line[9])

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    I'm not subscribed to the list; please keep me CC'd. Thanks.

 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6b7c764..a9c6a08 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -955,7 +955,7 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 	}
 	else {
 		/* expect "/dev/null" */
-		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
+		if (!is_dev_null(line))
 			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);
 		return NULL;
 	}
-- 
1.8.3.1
