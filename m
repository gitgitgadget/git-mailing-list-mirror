From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Fix crlf attribute handling to match documentation
Date: Fri, 18 May 2007 13:33:32 +0100
Message-ID: <200705181333.32719.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 14:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp1eQ-0008Im-U7
	for gcvg-git@gmane.org; Fri, 18 May 2007 14:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbXERMdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 08:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbXERMdh
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 08:33:37 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:42622 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135AbXERMdg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 08:33:36 -0400
Received: by py-out-1112.google.com with SMTP id a29so1135826pyi
        for <git@vger.kernel.org>; Fri, 18 May 2007 05:33:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=ecNTnXu1BBtvxDgd6Wam5HaOr+2L73U8i75r++jjY9buG+w983lDF11Z3URL/CUjmSuot66biCAK1V6ROSkKtDkMYTZT/jL/PYN7cNYzYt/NT4mOS8QUG7wiT+oR7keYKENU+zSys9PrICU56J+xRwdp6tzbJWpygvoR/9Sg7xI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=L66YlMx8k2MEdOqnwfJzuyHQ/byQUATw8ueDHRVTeVMqFwPPbegPbNjvEYpWaR6eoIFuHzQKeENh4BYBlhGdVmGxLTPkSsPvrJj8R6zjGJWdfQWFBhB4HvbJ84/45xwrqjXwpMDsMBMeHPbeBjerGtJpLyX6PMJFRfyRLUKEQ7Q=
Received: by 10.64.249.18 with SMTP id w18mr6304282qbh.1179491615309;
        Fri, 18 May 2007 05:33:35 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id a29sm3911760qbd.2007.05.18.05.33.34;
        Fri, 18 May 2007 05:33:34 -0700 (PDT)
X-TUID: 66bf61ad0564c4af
X-UID: 310
X-Length: 2613
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47601>

gitattributes.txt says, of the crlf attribute:

 Set::
    Setting the `crlf` attribute on a path is meant to mark
    the path as a "text" file.  'core.autocrlf' conversion
    takes place without guessing the content type by
    inspection.

That is to say that the crlf attribute does not force the file to have
CRLF line endings, instead it removes the autocrlf guesswork and forces
the file to be treated as text.  Then, whatever line ending is defined
by the autocrlf setting is applied.

However, that is not what convert.c was doing.  The conversion to CRLF
was being skipped in crlf_to_worktree() when the following condition was
true:

 action == CRLF_GUESS && auto_crlf <= 0

That is to say conversion took place when not in guess mode (crlf attribute
not specified) or core.autocrlf set to true.  This was wrong.  It meant
that the crlf attribute being on for a given file _forced_ CRLF
conversion, when actually it should force the file to be treated as
text, and converted accordingly.  The real test should simply be

 auto_crlf <= 0

That is to say, if core.autocrlf is falsei (or input), conversion from
LF to CRLF is never done.  When core.autocrlf is true, conversion from
LF to CRLF is done only when in CRLF_GUESS (and the guess is "text"), or
CRLF_TEXT mode.

Similarly for crlf_to_worktree(), if core.autocrlf is false, no conversion
should _ever_ take place.  In reality it was only not taking place if
core.autocrlf was false _and_ the crlf attribute was unspecified.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 convert.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 12abdaf..86d8167 100644
--- a/convert.c
+++ b/convert.c
@@ -86,7 +86,7 @@ static char *crlf_to_git(const char *path, const char *src, unsigned long *sizep
 	unsigned long size, nsize;
 	struct text_stat stats;
 
-	if ((action == CRLF_BINARY) || (action == CRLF_GUESS && !auto_crlf))
+	if ((action == CRLF_BINARY) || !auto_crlf)
 		return NULL;
 
 	size = *sizep;
@@ -154,7 +154,7 @@ static char *crlf_to_worktree(const char *path, const char *src, unsigned long *
 	unsigned char last;
 
 	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
-	    (action == CRLF_GUESS && auto_crlf <= 0))
+	    auto_crlf <= 0)
 		return NULL;
 
 	size = *sizep;
-- 
1.5.2.rc3.51.gd07bc
