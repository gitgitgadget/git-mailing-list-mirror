From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] init: handle empty "template" parameter, was Re: fetch
	refspec foo/* matches foo*
Date: Mon, 28 Jul 2008 02:02:04 -0400
Message-ID: <20080728060204.GC7294@sigill.intra.peff.net>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com> <1216858043-53646-1-git-send-email-lee.marlow@gmail.com> <20080725204051.GB23202@spearce.org> <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org> <20080726082405.GA10104@sigill.intra.peff.net> <20080726083356.GB10104@sigill.intra.peff.net> <alpine.DEB.1.00.0807261511490.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 08:03:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNLpL-0003as-Tz
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbYG1GCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 02:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbYG1GCJ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:02:09 -0400
Received: from peff.net ([208.65.91.99]:3191 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbYG1GCI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 02:02:08 -0400
Received: (qmail 29540 invoked by uid 111); 28 Jul 2008 06:02:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 28 Jul 2008 02:02:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2008 02:02:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807261511490.26810@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90412>

On Sat, Jul 26, 2008 at 03:13:26PM +0200, Johannes Schindelin wrote:

> > Also, while I have your attention, Junio, here is another bug fix
> > that should go into 1.6.0. I posted the patch as a "how about this" deep
> > in a thread and got no response (which means no complaints, right?).
> 
> Again it is in a thread...

Heh. Point taken.

My meaning was "you, Junio, did not see this because it was in another
thread, so I am pointing it out to you" but the irony of the rest of the
statement was lost on me during the original writing.

> I deem this patch obviously correct, and your reasoning as to what an 
> empty parameter should mean makes sense.

Thank you for reviewing, anyway. ;)

Here is a re-post with a test for the new behavior added in (and an
extra test just to make sure --template works at all. It does get used
by test-lib, so we were implicitly checking it to some degree, but it's
entirely possible that it could fail and the tests wouldn't necessarily
notice (e.g., if it accidentally used an installed set of templates
instead)).

-- >8 --
init: handle empty "template" parameter

If a user passes "--template=", then our template parameter
is blank. Unfortunately, copy_templates() assumes it has at
least one character, and does all sorts of bad things like
reading from template[-1] and then proceeding to link all of
'/' into the .git directory.

This patch just checks for that condition in copy_templates
and aborts. As a side effect, this means that --template=
now has the meaning "don't copy any templates."
---
 builtin-init-db.c |    2 ++
 t/t0001-init.sh   |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 38b4fcb..baf0d09 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -117,6 +117,8 @@ static void copy_templates(const char *template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
 	if (!template_dir)
 		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
+	if (!template_dir[0])
+		return;
 	strcpy(template_path, template_dir);
 	template_len = strlen(template_path);
 	if (template_path[template_len-1] != '/') {
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 2a38d98..620da5b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -141,4 +141,30 @@ test_expect_success 'reinit' '
 	test_cmp again/empty again/err2
 '
 
+test_expect_success 'init with --template' '
+	mkdir template-source &&
+	echo content >template-source/file &&
+	(
+		mkdir template-custom &&
+		cd template-custom &&
+		git init --template=../template-source
+	) &&
+	test_cmp template-source/file template-custom/.git/file
+'
+
+test_expect_success 'init with --template (blank)' '
+	(
+		mkdir template-plain &&
+		cd template-plain &&
+		git init
+	) &&
+	test -f template-plain/.git/info/exclude &&
+	(
+		mkdir template-blank &&
+		cd template-blank &&
+		git init --template=
+	) &&
+	! test -f template-blank/.git/info/exclude
+'
+
 test_done
-- 
1.6.0.rc1.155.gd3310
