From: Jeff King <peff@peff.net>
Subject: [PATCH 3/2] clone: always set transport options
Date: Wed, 18 Sep 2013 16:35:13 -0400
Message-ID: <20130918203513.GA24928@sigill.intra.peff.net>
References: <20130918200152.GA17074@sigill.intra.peff.net>
 <20130918200650.GB731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 22:35:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMOT8-0007xa-M4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 22:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab3IRUfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 16:35:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:57147 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab3IRUfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 16:35:22 -0400
Received: (qmail 26871 invoked by uid 102); 18 Sep 2013 20:35:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Sep 2013 15:35:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Sep 2013 16:35:13 -0400
Content-Disposition: inline
In-Reply-To: <20130918200650.GB731@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234992>

On Wed, Sep 18, 2013 at 04:06:50PM -0400, Jeff King wrote:

> Note that we do not set up that progress flag for a local
> clone, as we do not fetch using the transport at all. That's
> acceptable here, though, because we also do not perform a
> connectivity check in that case.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Though the last paragraph explains why this is OK, it feels a bit
> fragile. I wonder if we should hoist the call to transport_set_verbosity
> outside the "!is_local" conditional. I do not think it would hurt
> anything.

Actually, I think the option-setting in clone is a little bit broken.
Mostly it is just making fragile assumptions that happen to be true
(e.g., that fetching the ref list will never care about the progress
flag), but there are some options that should be respected in both
cases.

I think we should do this on top.

-- >8 --
Subject: [PATCH] clone: always set transport options

A clone will always create a transport struct, whether we
are cloning locally or using an actual protocol. In the
local case, we only use the transport to get the list of
refs, and then transfer the objects out-of-band.

However, there are many options that we do not bother
setting up in the local case. For the most part, these are
noops, because they only affect the object-fetching stage
(e.g., the --depth option).  However, some options do have a
visible impact. For example, giving the path to upload-pack
via "-u" does not currently work for a local clone, even
though we need upload-pack to get the ref list.

We can just drop the conditional entirely and set these
options for both local and non-local clones. Rather than
keep track of which options impact the object versus the ref
fetching stage, we can simply let the noops be noops (and
the cost of setting the options in the first place is not
high).

The one exception is that we also check that the transport
provides both a "get_refs_list" and a "fetch" method. We
will now be checking the former for both cases (which is
good, since a transport that cannot fetch refs would not
work for a local clone), and we tweak the conditional to
check for a "fetch" only when we are non-local.

Signed-off-by: Jeff King <peff@peff.net>
---
The diff is rather unreadable, but using "show -b" reveals the actual
changes.

 builtin/clone.c        | 30 ++++++++++++++----------------
 t/t5701-clone-local.sh |  4 ++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 7c62298..7ac677d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -884,27 +884,25 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
 
-	if (!is_local) {
-		if (!transport->get_refs_list || !transport->fetch)
-			die(_("Don't know how to clone %s"), transport->url);
+	if (!transport->get_refs_list || (!is_local && !transport->fetch))
+		die(_("Don't know how to clone %s"), transport->url);
 
-		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
+	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
-		if (option_depth)
-			transport_set_option(transport, TRANS_OPT_DEPTH,
-					     option_depth);
-		if (option_single_branch)
-			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
+	if (option_depth)
+		transport_set_option(transport, TRANS_OPT_DEPTH,
+				     option_depth);
+	if (option_single_branch)
+		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 
-		transport_set_verbosity(transport, option_verbosity, option_progress);
+	transport_set_verbosity(transport, option_verbosity, option_progress);
 
-		if (option_upload_pack)
-			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
-					     option_upload_pack);
+	if (option_upload_pack)
+		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
+				     option_upload_pack);
 
-		if (transport->smart_options && !option_depth)
-			transport->smart_options->check_self_contained_and_connected = 1;
-	}
+	if (transport->smart_options && !option_depth)
+		transport->smart_options->check_self_contained_and_connected = 1;
 
 	refs = transport_get_remote_refs(transport);
 
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 7ff6e0e..c490368 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -134,4 +134,8 @@ test_expect_success 'cloning a local path with --no-local does not hardlink' '
 	! repo_is_hardlinked force-nonlocal
 '
 
+test_expect_success 'cloning locally respects "-u" for fetching refs' '
+	test_must_fail git clone --bare -u false a should_not_work.git
+'
+
 test_done
-- 
1.8.4.rc4.16.g228394f
