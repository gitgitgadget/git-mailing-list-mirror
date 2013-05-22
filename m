From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] guilt: skip empty line after from: line in patch descriptoin
Date: Tue, 21 May 2013 22:43:13 -0400
Message-ID: <1369190593-6363-1-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Wed May 22 04:43:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uez1Z-0008Ci-G7
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 04:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab3EVCnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 22:43:19 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:50499 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753915Ab3EVCnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 22:43:18 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1Uez3t-00047J-HQ; Wed, 22 May 2013 02:45:57 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id AB32E580FC5; Tue, 21 May 2013 22:43:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc0.22.gcdd159b
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225120>

Commit 2cc8d353d7ecb broke manually written patch descriptions of the
form:

    > Frobnozzle: this is a patch subject
    >
    > From: Fred McNurk <fred@mcnurt.foo>
    >
    > This is the patch description

Commit 8f88f953580a0 partially fixed things by filtering out the From:
field, but it did not filter out the empty line (if present) after the
From: field, so it resulted in commit bodies which looked like this:

    > Frobnozzle: this is a patch subject
    >
    >
    > This is the patch description

instead of

    > Frobnozzle: this is a patch subject
    >
    > This is the patch description

The ext4 patch queue has used this format for years, and this change
should not break other patches which look like mail headers and
bodies.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 guilt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt b/guilt
index 4edd1ad..309437a 100755
--- a/guilt
+++ b/guilt
@@ -365,7 +365,7 @@ do_get_header()
 BEGIN{body=0; subj=0}
 /^Subject:/ && (body == 0 && subj == 0){subj=1; print substr($0, 10) "\n"; next}
 /^(Subject:|Author:|Date:|commit)/ && (body == 0){next}
-/^From:/ {next}
+/^From:/ {body=0; next}
 /^(Commit-ID:|Gitweb:|AuthorDate:|Committer:CommitDate:)/ && (body == 0){next}
 /^[ \t\f\n\r\v]*$/ && (body==0){next}
 /^.*$/ && (body==0){body=1}
-- 
1.7.12.rc0.22.gcdd159b
