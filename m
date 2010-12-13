From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC] ident: die on bogus date format
Date: Mon, 13 Dec 2010 12:02:25 -0500
Message-ID: <20101213170225.GA16033@sigill.intra.peff.net>
References: <loom.20101213T161633-993@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 18:02:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSBnJ-0002rj-4X
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 18:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339Ab0LMRCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 12:02:31 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42514 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758287Ab0LMRCa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 12:02:30 -0500
Received: (qmail 8782 invoked by uid 111); 13 Dec 2010 17:02:29 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 13 Dec 2010 17:02:28 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Dec 2010 12:02:25 -0500
Content-Disposition: inline
In-Reply-To: <loom.20101213T161633-993@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163566>

On Mon, Dec 13, 2010 at 03:20:07PM +0000, Sergio wrote:

> on 1.7.3.3, I have noticed that git --commit silently ignores the 
> --date=<date> switch if <date> is not in the current format.
> 
> for instance
> 
> git --commit --amend --date="10.11.2010" creates a commit with the current
> date and time, because the --date argument misses the time.
> 
> possibly, it would be better to stop with an error message.

Yeah, we should definitely be flagging the error. This patch fixes it,
but I'm not sure if it is optimal (see below).

-- >8 --
Subject: [PATCH/RFC] ident: die on bogus date format

If the user gives "git commit --date=foobar", we silently
ignore the --date flag. We should note the error.

This patch puts the fix at the lowest level of fmt_ident,
which means it also handles GIT_AUTHOR_DATE=foobar, as well.

There are two down-sides to this approach:

  1. Technically this breaks somebody doing something like
     "git commit --date=now", which happened to work because
     bogus data is the same as "now". Though we do
     explicitly handle the empty string, so anybody passing
     an empty variable through the environment will still
     work.

     If the error is too much, perhaps it can be downgraded
     to a warning?

  2. The error checking happens _after_ the commit message
     is written, which can be annoying to the user. We can
     put explicit checks closer to the beginning of
     git-commit, but that feels a little hack-ish; suddenly
     git-commit has to care about how fmt_ident works. Maybe
     we could simply call fmt_ident earlier?

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c           |    6 ++++--
 t/t7501-commit.sh |    4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index 9e24388..1c4adb0 100644
--- a/ident.c
+++ b/ident.c
@@ -217,8 +217,10 @@ const char *fmt_ident(const char *name, const char *email,
 	}
 
 	strcpy(date, git_default_date);
-	if (!name_addr_only && date_str)
-		parse_date(date_str, date, sizeof(date));
+	if (!name_addr_only && date_str && date_str[0]) {
+		if (parse_date(date_str, date, sizeof(date)) < 0)
+			die("invalid date format: %s", date_str);
+	}
 
 	i = copy(buffer, sizeof(buffer), 0, name);
 	i = add_raw(buffer, sizeof(buffer), i, " <");
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 8297cb4..8980738 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -230,6 +230,10 @@ test_expect_success 'amend commit to fix date' '
 
 '
 
+test_expect_success 'commit complains about bogus date' '
+	test_must_fail git commit --amend --date=10.11.2010
+'
+
 test_expect_success 'sign off (1)' '
 
 	echo 1 >positive &&
-- 
1.7.3.3.784.gccc31.dirty
