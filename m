From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add push --set-upstream
Date: Fri, 15 Jan 2010 12:42:20 -0500
Message-ID: <20100115174220.GA15821@coredump.intra.peff.net>
References: <1263573407-13642-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100115171745.GB2115@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:42:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVqBq-0005pk-4t
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 18:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757818Ab0AORm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 12:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757620Ab0AORm0
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 12:42:26 -0500
Received: from peff.net ([208.65.91.99]:39835 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab0AORmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 12:42:25 -0500
Received: (qmail 28800 invoked by uid 107); 15 Jan 2010 17:47:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 15 Jan 2010 12:47:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2010 12:42:20 -0500
Content-Disposition: inline
In-Reply-To: <20100115171745.GB2115@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137087>

On Fri, Jan 15, 2010 at 12:17:45PM -0500, Jeff King wrote:

> The patch below is squash-able, but note that the final test, "git push
> -u HEAD" is marked as broken. We should probably support that. I suspect
> is is an issue of dereferencing symrefs before doing the
> prefixcmp("refs/heads/", ...) but I haven't checked yet.

The patch below fixes it, but I am not 100% happy with it. Calling
resolve_ref means we actually bother to look up the ref again, which is
wasted effort. The ref struct has a "symref" field which should contain
this information, but for some reason it is not recorded. So we can
probably do better by simply recording the information properly when we
resolve the ref in the first place.

Unfortunately, I don't have time to look at it anymore right now, so it
will have to wait.

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index e977553..d43473f 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -39,7 +39,7 @@ test_expect_success 'push -u --all' '
 	check_config all2 upstream refs/heads/all2
 '
 
-test_expect_failure 'push -u HEAD' '
+test_expect_success 'push -u HEAD' '
 	git checkout -b headbranch &&
 	git push -u upstream HEAD &&
 	check_config headbranch upstream refs/heads/headbranch
diff --git a/transport.c b/transport.c
index 956d2ed..01ff364 100644
--- a/transport.c
+++ b/transport.c
@@ -140,6 +140,7 @@ static void set_upstreams(struct transport *trans, struct ref *refs)
 {
 	struct ref *i;
 	for (i = refs; i; i = i->next) {
+		const char *branch;
 		/*
 		 * Check suitability for tracking. Must be successful /
 		 * alreay up-to-date ref create/modify (not delete) and
@@ -152,14 +153,20 @@ static void set_upstreams(struct transport *trans, struct ref *refs)
 			continue;
 		if (!i->new_sha1 || is_null_sha1(i->new_sha1))
 			continue;
-		if (prefixcmp(i->peer_ref->name, "refs/heads/"))
-			continue;
 		if (prefixcmp(i->name, "refs/heads/"))
 			continue;
 
+		if (!prefixcmp(i->peer_ref->name, "refs/heads/"))
+			branch = i->peer_ref->name;
+		else {
+			unsigned char sha1[20];
+			branch = resolve_ref(i->peer_ref->name, sha1, 1, NULL);
+			if (!branch || prefixcmp(branch, "refs/heads/"))
+				continue;
+		}
+
 		install_branch_config(BRANCH_CONFIG_VERBOSE,
-			i->peer_ref->name + 11, trans->remote->name,
-			i->name);
+			branch + 11, trans->remote->name, i->name);
 	}
 }
 
