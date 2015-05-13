From: Jeff King <peff@peff.net>
Subject: [PATCH] add: check return value of launch_editor
Date: Tue, 12 May 2015 21:21:58 -0400
Message-ID: <20150513012158.GA3066@peff.net>
References: <CAA8EjDS9HePk6ZFa0kOy7GDa9_c_TsJ7uv7t+N9RL-3z=ZrQFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Russ Cox <rsc@golang.org>
X-From: git-owner@vger.kernel.org Wed May 13 03:22:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsLN8-0001ln-VZ
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 03:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbbEMBWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 21:22:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:57512 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964912AbbEMBWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 21:22:01 -0400
Received: (qmail 22653 invoked by uid 102); 13 May 2015 01:22:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 20:22:01 -0500
Received: (qmail 5534 invoked by uid 107); 13 May 2015 01:21:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 21:21:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 May 2015 21:21:58 -0400
Content-Disposition: inline
In-Reply-To: <CAA8EjDS9HePk6ZFa0kOy7GDa9_c_TsJ7uv7t+N9RL-3z=ZrQFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268911>

On Tue, May 12, 2015 at 08:31:26PM -0400, Russ Cox wrote:

> The root cause seems to be that builtin/add.c's edit_patch does not
> check the result of  the launch_editor call. It probably should.

Yes, definitely. Patch is below.

> The call to launch_editor in builtin/config.c should probably also be
> checked, although there it's not as big a deal, provided the editor
> did not modify the file; reapplying the same file should be a no-op.
> This is different from git add -e.

This one is trickier. Certainly we could propagate the return value and
say "hey, editing did not work". But we otherwise have no operation to
abort. This is because "git config --edit" does not actually take our
normal dot-lock, but rather edits the file in place.

IMHO this is questionable, as proper locking seems like half of the
purpose of "config --edit" (the other half being that you do not have to
type the location of the config file yourself). But I wonder if
switching it would make people unhappy, as it would probably break
editor rules to do syntax highlighting (e.g., if they are looking for
"*/.gitconfig" in the path).

-- >8 --
Subject: add: check return value of launch_editor

When running "add -e", if launching the editor fails, we do
not notice and continue as if the output is what the user
asked for. The likely case is that the editor did not touch
the contents at all, and we end up adding everything.

Reported-by: Russ Cox <rsc@golang.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/add.c       | 3 ++-
 t/t3702-add-edit.sh | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 3390933..4bd98b7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -208,7 +208,8 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	if (run_diff_files(&rev, 0))
 		die(_("Could not write patch"));
 
-	launch_editor(file, NULL, NULL);
+	if (launch_editor(file, NULL, NULL))
+		die(_("editing patch failed"));
 
 	if (stat(file, &st))
 		die_errno(_("Could not stat '%s'"), file);
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index 4ee47cc..3cb74ca 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -118,4 +118,11 @@ test_expect_success 'add -e' '
 
 '
 
+test_expect_success 'add -e notices editor failure' '
+	git reset --hard &&
+	echo change >>file &&
+	test_must_fail env GIT_EDITOR=false git add -e &&
+	test_expect_code 1 git diff --exit-code
+'
+
 test_done
-- 
2.4.0.192.g5f8138b
