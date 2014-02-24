From: Jeff King <peff@peff.net>
Subject: [PATCH] remote: handle pushremote config in any order order
Date: Mon, 24 Feb 2014 03:59:03 -0500
Message-ID: <20140224085903.GA10698@sigill.intra.peff.net>
References: <CAMYxyaUwPXXdvGv786_p5n7-biMLOFbur-gQ1pxXOttc0R0=eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jack Nagel <jacknagel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 09:59:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHrNY-0005nI-4i
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 09:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbaBXI7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 03:59:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:55906 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751568AbaBXI7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 03:59:06 -0500
Received: (qmail 19043 invoked by uid 102); 24 Feb 2014 08:59:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 02:59:05 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 03:59:03 -0500
Content-Disposition: inline
In-Reply-To: <CAMYxyaUwPXXdvGv786_p5n7-biMLOFbur-gQ1pxXOttc0R0=eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242581>

On Mon, Feb 24, 2014 at 12:10:04AM -0500, Jack Nagel wrote:

> There seems to be a difference in the behavior of "git push" depending
> on whether remote.pushdefault is defined before or after
> branch.<name>.pushremote in .git/config.
> [...]
> I would expect the order that things are defined in the config file to
> have no effect on the behavior of "git push".

Yes, with a few exceptions, we usually try to make the ordering in the
config file irrelevant. This is a bug. The patch below should fix it.

-- >8 --
Subject: remote: handle pushremote config in any order

The remote we push can be defined either by
remote.pushdefault or by branch.*.pushremote for the current
branch. The order in which they appear in the config file
should not matter to precedence (which should be to prefer
the branch-specific config).

The current code parses the config linearly and uses a
single string to store both values, overwriting any
previous value. Thus, config like:

  [branch "master"]
  pushremote = foo
  [remote]
  pushdefault = bar

erroneously ends up pushing to "bar" from the master branch.

We can fix this by storing both values and resolving the
correct value after all config is read.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c              |  7 ++++++-
 t/t5516-fetch-push.sh | 12 ++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index e41251e..7232a33 100644
--- a/remote.c
+++ b/remote.c
@@ -49,6 +49,7 @@ static int branches_nr;
 
 static struct branch *current_branch;
 static const char *default_remote_name;
+static const char *branch_pushremote_name;
 static const char *pushremote_name;
 static int explicit_default_remote_name;
 
@@ -352,7 +353,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 			}
 		} else if (!strcmp(subkey, ".pushremote")) {
 			if (branch == current_branch)
-				if (git_config_string(&pushremote_name, key, value))
+				if (git_config_string(&branch_pushremote_name, key, value))
 					return -1;
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
@@ -492,6 +493,10 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config, NULL);
+	if (branch_pushremote_name) {
+		free(pushremote_name);
+		pushremote_name = branch_pushremote_name;
+	}
 	alias_all_urls();
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 926e7f6..1309c4d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -536,6 +536,18 @@ test_expect_success 'push with config branch.*.pushremote' '
 	check_push_result down_repo $the_commit heads/master
 '
 
+test_expect_success 'branch.*.pushremote config order is irrelevant' '
+	mk_test one_repo heads/master &&
+	mk_test two_repo heads/master &&
+	test_config remote.one.url one_repo &&
+	test_config remote.two.url two_repo &&
+	test_config branch.master.pushremote two_repo &&
+	test_config remote.pushdefault one_repo &&
+	git push &&
+	check_push_result one_repo $the_first_commit heads/master &&
+	check_push_result two_repo $the_commit heads/master
+'
+
 test_expect_success 'push with dry-run' '
 
 	mk_test testrepo heads/master &&
-- 
1.8.5.2.500.g8060133
