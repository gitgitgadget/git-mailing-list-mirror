From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 09/10] git-rebase--interactive.sh: don't use the -a or -o option with the test command
Date: Thu, 15 May 2014 07:21:49 -0700
Message-ID: <1400163710-28333-9-git-send-email-gitter.spiros@gmail.com>
References: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:22:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwY6-0008Oe-JL
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbaEOOWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:22:10 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:35444 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbaEOOWC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:22:02 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so1170764pbc.30
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKMf2DK7O22q13q/O+nvgwS6WCV190ocqcl0jTSNvR8=;
        b=rcxoNfguEN4IMY/x9M6GUUh0FxZ5y5oXvwb6sre7hVx8TGVLMQmwIdn+CG3dA9pVZo
         VbqCVyQk37FjpXCPgcbltHT4dtt4Wtj0HOsdOzu6Vpd0bZ610jy10ymxy23sAEqKfkUH
         +5TgyXNld4pHs5qd5kBoNg3uEupatsdr+C1JQtX4rG5N4G8Tl+bRXGyY1l8q16VYTtig
         cEFoCO7s1IOXsbBstyxrY3CVn8YqoOTo+zuzVCF0+9iEKdrGlLzSMv03X5gfewPfwJ7f
         9u6W6kcqNIuVk80MIYJkhWWHc2ASgLXECy7UdZsSRZJ7BzrW/rz+HgnyFgm+3Y5Wym1k
         puzw==
X-Received: by 10.68.106.36 with SMTP id gr4mr12792168pbb.64.1400163722359;
        Thu, 15 May 2014 07:22:02 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id sy2sm9397666pbc.28.2014.05.15.07.22.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:22:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249096>

Even though POSIX.1 lists -a/-o as options to "test", they are
marked "Obsolescent XSI". Scripts using these expressions
should be converted  as follow:

test "$1" -a "$2"

should be written as:

test "$1" && test "$2"

Likewise

test "$1" -o "$2"

should be written as:

test "$1"  test "$2"

But note that, in test, -a has higher precedence than -o while
"&&" and "||" have equal precedence in the shell.

The reason for this is that the precedence rules were never well
specified, and this made many sane-looking uses of "test -a/-o" problematic.

For example, if $x is "=", these work according to POSIX (it's not
portable, but in practice it's okay):

   $ test -z "$x"
   $ test -z "$x" && test a = b

but this doesn't

   $ test -z "$x" -a a = b
   bash: test: too many arguments

because it groups "test -n = -a" and is left with "a = b".

Similarly, if $x is "-f", these

   $ test "$x"
   $ test "$x" || test c = d

correctly adds an implicit "-n", but this fails:

   $ test "$x" -o c = d
   bash: test: too many arguments

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
Inspired from this discussion http://permalink.gmane.org/gmane.comp.version-control.git/137056

 git-rebase--interactive.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6ec9d3c..797571f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1013,7 +1013,7 @@ then
 	git rev-list $revisions |
 	while read rev
 	do
-		if test -f "$rewritten"/$rev -a "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
+		if test -f "$rewritten"/$rev && test "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
 		then
 			# Use -f2 because if rev-list is telling us this commit is
 			# not worthwhile, we don't want to track its multiple heads,
-- 
1.7.10.4
