Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E232018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbcGOKnv (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:43:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:45335 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932187AbcGOKnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:43:50 -0400
Received: (qmail 18717 invoked by uid 102); 15 Jul 2016 10:43:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:43:50 -0400
Received: (qmail 14500 invoked by uid 107); 15 Jul 2016 10:44:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:44:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:43:47 -0400
Date:	Fri, 15 Jul 2016 06:43:47 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 12/12] receive-pack: send keepalives during quiet periods
Message-ID: <20160715104347.GL19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

After a client has sent us the complete pack, we may spend
some time processing the data and running hooks. If the
client asked us to be quiet, receive-pack won't send any
progress data during the index-pack or connectivity-check
steps. And hooks may or may not produce their own progress
output. In these cases, the network connection is totally
silent from both ends.

Git itself doesn't care about this (it will wait forever),
but other parts of the system (e.g., firewalls,
load-balancers, etc) might hang up the connection. So we'd
like to send some sort of keepalive to let the network and
the client side know that we're still alive and processing.

We can use the same trick we did in 05e9515 (upload-pack:
send keepalive packets during pack computation, 2013-09-08).
Namely, we will send an empty sideband data packet every `N`
seconds that we do not relay any stderr data over the
sideband channel. As with 05e9515, this means that we won't
bother sending keepalives when there's actual progress data,
but will kick in when it has been disabled (or if there is a
lull in the progress data).

The concept is simple, but the details are subtle enough
that they need discussing here.

Before the client sends us the pack, we don't want to do any
keepalives. We'll have sent our ref advertisement, and we're
waiting for them to send us the pack (and tell us that they
support sidebands at all).

While we're receiving the pack from the client (or waiting
for it to start), there's no need for keepalives; it's up to
them to keep the connection active by sending data.
Moreover, it would be wrong for us to do so. When we are the
server in the smart-http protocol, we must treat our
connection as half-duplex. So any keepalives we send while
receiving the pack would potentially be buffered by the
webserver. Not only does this make them useless (since they
would not be delivered in a timely manner), but it could
actually cause a deadlock if we fill up the buffer with
keepalives. (It wouldn't be wrong to send keepalives in this
phase for a full-duplex connection like ssh; it's simply
pointless, as it is the client's responsibility to speak).

As soon as we've gotten all of the pack data, then the
client is waiting for us to speak, and we should start
keepalives immediately. From here until the end of the
connection, we send one any time we are not otherwise
sending data.

But there's a catch. Receive-pack doesn't know the moment
we've gotten all the data. It passes the descriptor to
index-pack, who reads all of the data, and then starts
resolving the deltas. We have to communicate that back.

To make this work, we instruct the sideband muxer to enable
keepalives in three phases:

  1. In the beginning, not at all.

  2. While reading from index-pack, wait for a signal
     indicating end-of-input, and then start them.

  3. Afterwards, always.

The signal from index-pack in phase 2 has to come over the
stderr channel which the muxer is reading. We can't use an
extra pipe because the portable run-command interface only
gives us stderr and stdout.

Stdout is already used to pass the .keep filename back to
receive-pack. We could also send a signal there, but then we
would find out about it in the main thread. And the
keepalive needs to be done by the async muxer thread (since
it's the one writing sideband data back to the client). And
we can't reliably signal the async thread from the main
thread, because the async code sometimes uses threads and
sometimes uses forked processes.

Therefore the signal must come over the stderr channel,
where it may be interspersed with other random
human-readable messages from index-pack. This patch makes
the signal a single NUL byte.  This is easy to parse, should
not appear in any normal stderr output, and we don't have to
worry about any timing issues (like seeing half the signal
bytes in one read(), and half in a subsequent one).

This is a bit ugly, but it's simple to code and should work
reliably.

Another option would be to stop using an async thread for
muxing entirely, and just poll() both stderr and stdout of
index-pack from the main thread. This would work for
index-pack (because we aren't doing anything useful in the
main thread while it runs anyway). But it would make the
connectivity check and the hook muxers much more
complicated, as they need to simultaneously feed the
sub-programs while reading their stderr.

The index-pack phase is the only one that needs this
signaling, so it could simply behave differently than the
other two. That would mean having two separate
implementations of copy_to_sideband (and the keepalive
code), though. And it still doesn't get rid of the
signaling; it just means we can write a nicer message like
"END_OF_INPUT" or something on stdout, since we don't have
to worry about separating it from the stderr cruft.

One final note: this signaling trick is only done with
index-pack, not with unpack-objects. There's no point in
doing it for the latter, because by definition it only kicks
in for a small number of objects, where keepalives are not
as useful (and this conveniently lets us avoid duplicating
the implementation).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |  9 +++++++
 builtin/index-pack.c     |  5 ++++
 builtin/receive-pack.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 16dc22d..08efd50 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2473,6 +2473,15 @@ receive.fsck.skipList::
 	can be safely ignored such as invalid committer email addresses.
 	Note: corrupt objects cannot be skipped with this setting.
 
+receive.keepAlive::
+	After receiving the pack from the client, `receive-pack` may
+	produce no output (if `--quiet` was specified) while processing
+	the pack, causing some networks to drop the TCP connection.
+	With this option set, if `receive-pack` does not transmit
+	any data in this phase for `receive.keepAlive` seconds, it will
+	send a short keepalive packet.  The default is 5 seconds; set
+	to 0 to disable keepalives entirely.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1cba120..54f2cfb 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1626,6 +1626,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	struct pack_idx_option opts;
 	unsigned char pack_sha1[20];
 	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
+	int report_end_of_input = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
@@ -1697,6 +1698,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				verbose = 1;
 			} else if (!strcmp(arg, "--show-resolving-progress")) {
 				show_resolving_progress = 1;
+			} else if (!strcmp(arg, "--report-end-of-input")) {
+				report_end_of_input = 1;
 			} else if (!strcmp(arg, "-o")) {
 				if (index_name || (i+1) >= argc)
 					usage(index_pack_usage);
@@ -1754,6 +1757,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		obj_stat = xcalloc(st_add(nr_objects, 1), sizeof(struct object_stat));
 	ofs_deltas = xcalloc(nr_objects, sizeof(struct ofs_delta_entry));
 	parse_pack_objects(pack_sha1);
+	if (report_end_of_input)
+		write_in_full(2, "\0", 1);
 	resolve_deltas();
 	conclude_pack(fix_thin_pack, curr_pack, pack_sha1);
 	free(ofs_deltas);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7db1639..e41f55f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -76,6 +76,13 @@ static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
 static struct ref_transaction *transaction;
 
+static enum {
+	KEEPALIVE_NEVER = 0,
+	KEEPALIVE_AFTER_NUL,
+	KEEPALIVE_ALWAYS
+} use_keepalive;
+static int keepalive_in_sec = 5;
+
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
 	if (value) {
@@ -193,6 +200,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.keepalive") == 0) {
+		keepalive_in_sec = git_config_int(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -319,10 +331,60 @@ static void rp_error(const char *err, ...)
 static int copy_to_sideband(int in, int out, void *arg)
 {
 	char data[128];
+	int keepalive_active = 0;
+
+	if (keepalive_in_sec <= 0)
+		use_keepalive = KEEPALIVE_NEVER;
+	if (use_keepalive == KEEPALIVE_ALWAYS)
+		keepalive_active = 1;
+
 	while (1) {
-		ssize_t sz = xread(in, data, sizeof(data));
+		ssize_t sz;
+
+		if (keepalive_active) {
+			struct pollfd pfd;
+			int ret;
+
+			pfd.fd = in;
+			pfd.events = POLLIN;
+			ret = poll(&pfd, 1, 1000 * keepalive_in_sec);
+
+			if (ret < 0) {
+				if (errno == EINTR)
+					continue;
+				else
+					break;
+			} else if (ret == 0) {
+				/* no data; send a keepalive packet */
+				static const char buf[] = "0005\1";
+				write_or_die(1, buf, sizeof(buf) - 1);
+				continue;
+			} /* else there is actual data to read */
+		}
+
+		sz = xread(in, data, sizeof(data));
 		if (sz <= 0)
 			break;
+
+		if (use_keepalive == KEEPALIVE_AFTER_NUL && !keepalive_active) {
+			const char *p = memchr(data, '\0', sz);
+			if (p) {
+				/*
+				 * The NUL tells us to start sending keepalives. Make
+				 * sure we send any other data we read along
+				 * with it.
+				 */
+				keepalive_active = 1;
+				send_sideband(1, 2, data, p - data, use_sideband);
+				send_sideband(1, 2, p + 1, sz - (p - data + 1), use_sideband);
+				continue;
+			}
+		}
+
+		/*
+		 * Either we're not looking for a NUL signal, or we didn't see
+		 * it yet; just pass along the data.
+		 */
 		send_sideband(1, 2, data, sz, use_sideband);
 	}
 	close(in);
@@ -1566,6 +1628,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 
 		if (!quiet && err_fd)
 			argv_array_push(&child.args, "--show-resolving-progress");
+		if (use_sideband)
+			argv_array_push(&child.args, "--report-end-of-input");
 		if (fsck_objects)
 			argv_array_pushf(&child.args, "--strict%s",
 				fsck_msg_types.buf);
@@ -1595,6 +1659,7 @@ static const char *unpack_with_sideband(struct shallow_info *si)
 	if (!use_sideband)
 		return unpack(0, si);
 
+	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
 	muxer.proc = copy_to_sideband;
 	muxer.in = -1;
@@ -1782,6 +1847,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			unpack_status = unpack_with_sideband(&si);
 			update_shallow_info(commands, &si, &ref);
 		}
+		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
-- 
2.9.1.434.g748be50
