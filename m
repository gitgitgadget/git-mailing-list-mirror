From: crquan@gmail.com
Subject: [PATCH 2/2] git-remote: add verbose mode to git remote update
Date: Tue, 18 Nov 2008 19:04:02 +0800
Message-ID: <1227006242-21290-1-git-send-email-crquan@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 12:04:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2ONv-0007yS-A5
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 12:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbYKRLD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 06:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbYKRLD2
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 06:03:28 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:43028 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbYKRLD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 06:03:27 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1826127tic.23
        for <git@vger.kernel.org>; Tue, 18 Nov 2008 03:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=gw3L2iMQQCHamZJ4LZQnuLCOK88FFhwFzhM1QnZUl8E=;
        b=fvzN/KtvSWSdLZdopa6Wk8/C1SoOKSflLqZ9k6mJW89MDUd7uXJ4jhJU9Fatrzuya+
         FANYlX4mPgXnlQ4jdEwIcK4fGoAsLhUiTysc14Etd6q6gZbzk9arzyN6hrqJEASZp6oA
         IZXSchAkOnxtLartYIuN8cSE400O37Ay+lmVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YEvTUvg/86ALIGl+yQgIllS+T6jMXQuJ9PNToETGRgy2MX3LuyJpbOa3u+HSwW6g9A
         hFpo9eUGahOr9mxgTUResi/Ry9r1a14rxk5MSOQkCKXzCDDa9UEuWnOwmn8wthzhjDfp
         qMcBcnDhykt0S1E9v1ixMZ5UrncwSGWF+SC4U=
Received: by 10.110.105.5 with SMTP id d5mr6444126tic.39.1227006205270;
        Tue, 18 Nov 2008 03:03:25 -0800 (PST)
Received: from tux ([219.134.89.155])
        by mx.google.com with ESMTPS id w5sm1206456tib.14.2008.11.18.03.03.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Nov 2008 03:03:23 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Tue, 18 Nov 2008 19:04:02 +0800
X-Mailer: git-send-email 1.6.0.4.757.g6d002.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101269>

From: Cheng Renquan <crquan@gmail.com>

Pass the verbose mode parameter to the underlying fetch command.

  $ ./git remote -v update
  Updating origin
  From git://git.kernel.org/pub/scm/git/git
   = [up to date]      html       -> origin/html
   = [up to date]      maint      -> origin/maint
   = [up to date]      man        -> origin/man
   = [up to date]      master     -> origin/master
   = [up to date]      next       -> origin/next
   = [up to date]      pu         -> origin/pu
   = [up to date]      todo       -> origin/todo

Signed-off-by: Cheng Renquan <crquan@gmail.com>
---

To Junio:
  I found that fetch's verbose mode will dump the url, that's really
what I need, so with passing verbose mode to fetch, the fetch_remote
function doesn't need a url parameter, and changes to get_one_remote_for_update
are also not required.
  So now the patch looks very simple.

 builtin-remote.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 14774e3..0af742b 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote rm <name>",
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote update [group]",
+	"git remote update [-v | --verbose] [group]",
 	NULL
 };
 
@@ -42,7 +42,11 @@ static int opt_parse_track(const struct option *opt, const char *arg, int not)
 
 static int fetch_remote(const char *name)
 {
-	const char *argv[] = { "fetch", name, NULL };
+	const char *argv[] = { "fetch", name, NULL, NULL };
+	if (verbose) {
+		argv[1] = "-v";
+		argv[2] = name;
+	}
 	printf("Updating %s\n", name);
 	if (run_command_v_opt(argv, RUN_GIT_CMD))
 		return error("Could not fetch %s", name);
-- 
1.6.0.4.757.g6d002.dirty
