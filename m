Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3645C9
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 22:53:42 -0800 (PST)
Received: (qmail 9643 invoked by uid 109); 7 Dec 2023 06:53:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 06:53:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 689 invoked by uid 111); 7 Dec 2023 06:53:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 01:53:45 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 01:53:41 -0500
From: Jeff King <peff@peff.net>
To: Janik Haag <janik@aq0.de>
Cc: git@vger.kernel.org
Subject: [PATCH] bisect: always clean on reset
Message-ID: <20231207065341.GA778781@coredump.intra.peff.net>
References: <bef9d5b3-bb64-4662-8952-d000872c5244@aq0.de>
 <20231113210820.GB2028092@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113210820.GB2028092@coredump.intra.peff.net>

On Mon, Nov 13, 2023 at 04:08:20PM -0500, Jeff King wrote:

> So really, you just want the "clean" part of "bisect reset", but not the
> "reset". We could have a separate "bisect clean" that would do what you
> want (clean state without trying to reset HEAD). But I don't think it
> would be unreasonable to "reset" to just unconditionally clean. I think
> it would probably just be a few lines in bisect_reset() to avoid the
> early return, and skip the call to "checkout" when we have no branch to
> go back to.
> 
> Maybe a good simple patch for somebody interested in getting into Git
> development?

I didn't want to forget about this, so I rolled it up into a patch.

-- >8 --
Subject: [PATCH] bisect: always clean on reset

Usually "bisect reset" cleans up any refs/bisect/ refs, along with
meta-files like .git/BISECT_LOG. But it only does so after deciding that
a bisection is active, which it does by reading BISECT_START. This is
usually fine, but it's possible to get into a confusing state if the
BISECT_START file is gone, but other cruft is left (this might be due to
a bug, or a system crash, etc).

And since "bisect reset" refuses to do anything in this state, the user
has no easy way to clean up the leftover cruft. While another "bisect
start" would clear the state, in the interim it can be annoying, as
other tools (like our bash prompt code) think we are bisecting, and
for-each-ref output may be polluted with refs/bisect/ entries.

Further adding to the confusion is that running "bisect reset $some_ref"
skips the BISECT_START check. So it never realizes that there's no
bisection active and does the cleanup anyway!

So let's just make sure we always do the cleanup, whether we looked at
BISECT_START or not. If the user doesn't give us a commit to reset to,
we'll still say "We are not bisecting" and skip the call to "git
checkout".

Reported-by: Janik Haag <janik@aq0.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/bisect.c            | 9 ++++-----
 t/t6030-bisect-porcelain.sh | 6 ++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 35938b05fd..c5565686bf 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -233,11 +233,10 @@ static int bisect_reset(const char *commit)
 	struct strbuf branch = STRBUF_INIT;
 
 	if (!commit) {
-		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
+		if (!strbuf_read_file(&branch, git_path_bisect_start(), 0))
 			printf(_("We are not bisecting.\n"));
-			return 0;
-		}
-		strbuf_rtrim(&branch);
+		else
+			strbuf_rtrim(&branch);
 	} else {
 		struct object_id oid;
 
@@ -246,7 +245,7 @@ static int bisect_reset(const char *commit)
 		strbuf_addstr(&branch, commit);
 	}
 
-	if (!ref_exists("BISECT_HEAD")) {
+	if (branch.len && !ref_exists("BISECT_HEAD")) {
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 2a5b7d8379..7b24d1684e 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -170,6 +170,12 @@ test_expect_success 'bisect reset when not bisecting' '
 	cmp branch.expect branch.output
 '
 
+test_expect_success 'bisect reset cleans up even when not bisecting' '
+	echo garbage >.git/BISECT_LOG &&
+	git bisect reset &&
+	test_path_is_missing .git/BISECT_LOG
+'
+
 test_expect_success 'bisect reset removes packed refs' '
 	git bisect reset &&
 	git bisect start &&
-- 
2.43.0.664.ga12c899002

