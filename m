From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] upload-pack: send keepalive packets during pack
 computation
Date: Sun, 8 Sep 2013 05:01:31 -0400
Message-ID: <20130908090131.GA17060@sigill.intra.peff.net>
References: <20130908085915.GA4097@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 11:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIasG-0003Xa-FT
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 11:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab3IHJBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 05:01:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:43954 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3IHJBf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 05:01:35 -0400
Received: (qmail 12959 invoked by uid 102); 8 Sep 2013 09:01:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 04:01:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 05:01:31 -0400
Content-Disposition: inline
In-Reply-To: <20130908085915.GA4097@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234229>

Whenn upload-pack has started pack-objects, there may be a
quiet period while pack-objects prepares the pack (i.e.,
counting objects and delta compression).  Normally we would
see (and send to the client) progress information, but if
"--quiet" is in effect, pack-objects will produce nothing at
all until the pack data is ready. On a large repository,
this can take tens of seconds (or even minutes if the system
is loaded or the repository is badly packed). Clients or
intermediate proxies can sometimes give up in this
situation, assuming that the server or connection has hung.

This patch introduces a "keepalive" option; if upload-pack
sees no data from pack-objects for a certain number of
seconds, it will send an empty sideband data packet to let
the other side know that we are still working on it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 11 +++++++++++
 upload-pack.c            | 25 ++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..5d748f7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2216,6 +2216,17 @@ uploadpack.allowtipsha1inwant::
 	of a hidden ref (by default, such a request is rejected).
 	see also `uploadpack.hiderefs`.
 
+uploadpack.keepalive::
+	When `upload-pack` has started `pack-objects`, there may be a
+	quiet period while `pack-objects` prepares the pack. Normally
+	it would output progress information, but if `--quiet` was used
+	for the fetch, `pack-objects` will output nothing at all until
+	the pack data begins. Some clients and networks may consider
+	the server to be hung and give up. Setting this option instructs
+	`upload-pack` to send an empty keepalive packet every
+	`uploadpack.keepalive` seconds. Setting this option to 0
+	disables keepalive packets entirely. The default is 0.
+
 url.<base>.insteadOf::
 	Any URL that starts with this value will be rewritten to
 	start, instead, with <base>. In cases where some site serves a
diff --git a/upload-pack.c b/upload-pack.c
index 127e59a..c3e4a20 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -40,6 +40,7 @@ static unsigned int timeout;
 static struct object_array want_obj;
 static struct object_array extra_edge_obj;
 static unsigned int timeout;
+static int keepalive = -1;
 /* 0 for no sideband,
  * otherwise maximum packet size (up to 65520 bytes).
  */
@@ -200,6 +201,7 @@ static void create_pack_file(void)
 	while (1) {
 		struct pollfd pfd[2];
 		int pe, pu, pollsize;
+		int ret;
 
 		reset_timeout();
 
@@ -222,7 +224,8 @@ static void create_pack_file(void)
 		if (!pollsize)
 			break;
 
-		if (poll(pfd, pollsize, -1) < 0) {
+		ret = poll(pfd, pollsize, 1000 * keepalive);
+		if (ret < 0) {
 			if (errno != EINTR) {
 				error("poll failed, resuming: %s",
 				      strerror(errno));
@@ -284,6 +287,21 @@ static void create_pack_file(void)
 			if (sz < 0)
 				goto fail;
 		}
+
+		/*
+		 * We hit the keepalive timeout without saying anything; send
+		 * an empty message on the data sideband just to let the other
+		 * side know we're still working on it, but don't have any data
+		 * yet.
+		 *
+		 * If we don't have a sideband channel, there's no room in the
+		 * protocol to say anything, so those clients are just out of
+		 * luck.
+		 */
+		if (!ret && use_sideband) {
+			static const char buf[] = "0005\1";
+			write_or_die(1, buf, 5);
+		}
 	}
 
 	if (finish_command(&pack_objects)) {
@@ -785,6 +803,11 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var))
 		allow_tip_sha1_in_want = git_config_bool(var, value);
+	else if (!strcmp("uploadpack.keepalive", var)) {
+		keepalive = git_config_int(var, value);
+		if (!keepalive)
+			keepalive = -1;
+	}
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-- 
1.8.4.2.g87d4a77
