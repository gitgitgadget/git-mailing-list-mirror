From: Jeff King <peff@peff.net>
Subject: Re: git clone silently aborts if stdout gets a broken pipe
Date: Wed, 18 Sep 2013 15:04:37 -0400
Message-ID: <20130918190437.GD18821@sigill.intra.peff.net>
References: <A612847CFE53224C91B23E3A5B48BAC798CD91DB0B@xmail3.se.axis.com>
 <20130918184551.GC18821@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 21:04:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMN3S-0003oo-IK
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 21:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab3IRTEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 15:04:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:56543 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab3IRTEq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 15:04:46 -0400
Received: (qmail 22335 invoked by uid 102); 18 Sep 2013 19:04:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Sep 2013 14:04:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Sep 2013 15:04:37 -0400
Content-Disposition: inline
In-Reply-To: <20130918184551.GC18821@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234984>

On Wed, Sep 18, 2013 at 02:45:51PM -0400, Jeff King wrote:

> That being said, the new messages should almost certainly go to stderr.
> 
> -- >8 --
> Subject: [PATCH] clone: write "checking connectivity" to stderr
> 
> In commit 0781aa4 (clone: let the user know when
> check_everything_connected is run, 2013-05-03), we started
> giving the user a progress report during clone. However,
> since the actual work happens in a sub-process, we do not
> use the usual progress code that counts the objects, but
> rather just print a message ourselves.
> 
> This message goes to stdout via printf, which is unlike
> other progress messages (both the eye candy within clone,
> and the "checking connectivity" progress in other commands).
> Let's send it to stderr for consistency.

Hrm, this actually breaks t5701, which expects "clone 2>err" to print
nothing to stderr.

What should happen here? The message is emulating the usual progress
messages, which are silent when stderr is redirected. So we could
actually use isatty() in the usual way to suppress them. On the other
hand, the point of that suppression is that the regular progress code
produces long output that is not meant to be seen sequentially (i.e., it
is overwritten in the terminal with "\r"). But this message does not do
so. So we can just tweak t5701 to be more careful about what it is
looking for.

Also, we should arguably give the "Cloning into..." message the same
treatment. We have printed that to stdout for a very long time, so there
is a slim chance that somebody actually tries to parse it. But I think
they are wrong to do so; we already changed it once (in 28ba96a), and
these days it is internationalized, anyway.

In May of 2012 I posted this patch, but it got overlooked, and I forgot
about it but carried it in my tree since then. Maybe we should apply it
now (it fixes t5701; the "checking connectivity" patch can come on top,
or even just be squashed in).

-- >8 --
Subject: [PATCH] clone: send diagnostic messages to stderr

Putting messages like "Cloning into.." and "done" on stdout
is un-Unix and uselessly clutters the stdout channel. Send
them to stderr.

We have to tweak two tests to accommodate this:

  1. t5601 checks for doubled output due to forking, and
     doesn't actually care where the output goes; adjust it
     to check stderr.

  2. t5702 is trying to test whether progress output was
     sent to stderr, but naively does so by checking
     whether stderr produced any output. Instead, have it
     look for "%", a token found in progress output but not
     elsewhere (and which lets us avoid hard-coding the
     progress text in the test).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c          | 6 +++---
 t/t5601-clone.sh         | 2 +-
 t/t5702-clone-options.sh | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 3c91844..8723a3a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -379,7 +379,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 	}
 
 	if (0 <= option_verbosity)
-		printf(_("done.\n"));
+		fprintf(stderr, _("done.\n"));
 }
 
 static const char *junk_work_tree;
@@ -849,9 +849,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (0 <= option_verbosity) {
 		if (option_bare)
-			printf(_("Cloning into bare repository '%s'...\n"), dir);
+			fprintf(stderr, _("Cloning into bare repository '%s'...\n"), dir);
 		else
-			printf(_("Cloning into '%s'...\n"), dir);
+			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
 	}
 	init_db(option_template, INIT_DB_QUIET);
 	write_config(&option_config);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0629149..b3b11e6 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -36,7 +36,7 @@ test_expect_success C_LOCALE_OUTPUT 'output from clone' '
 
 test_expect_success C_LOCALE_OUTPUT 'output from clone' '
 	rm -fr dst &&
-	git clone -n "file://$(pwd)/src" dst >output &&
+	git clone -n "file://$(pwd)/src" dst >output 2>&1 &&
 	test $(grep Clon output | wc -l) = 1
 '
 
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 85cadfa..67e170e 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -22,14 +22,14 @@ test_expect_success 'redirected clone -v' '
 test_expect_success 'redirected clone' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
-	test_must_be_empty err
+	! grep % err
 
 '
 test_expect_success 'redirected clone -v' '
 
 	git clone --progress "file://$(pwd)/parent" clone-redirected-progress \
 		>out 2>err &&
-	test -s err
+	grep % err
 
 '
 
-- 
1.8.4.rc4.16.g228394f
