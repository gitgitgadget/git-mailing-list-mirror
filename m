Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BEB31FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755819AbdC1Tq5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:46:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:53165 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755808AbdC1Tqz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:46:55 -0400
Received: (qmail 11804 invoked by uid 109); 28 Mar 2017 19:46:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:49 +0000
Received: (qmail 7021 invoked by uid 111); 28 Mar 2017 19:47:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:47:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:47 -0400
Date:   Tue, 28 Mar 2017 15:46:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/18] receive-pack: print --pack-header directly into argv
 array
Message-ID: <20170328194647.ac4rj3aw7jbteqjh@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After receive-pack reads the pack header from the client, it
feeds the already-read part to index-pack and unpack-objects
via their --pack-header command-line options.  To do so, we
format it into a fixed buffer, then duplicate it into the
child's argv_array.

Our buffer is long enough to handle any possible input, so
this isn't wrong. But it's more complicated than it needs to
be; we can just argv_array_pushf() the final value and avoid
the intermediate copy. This drops the magic number and is
more efficient, too.

Note that we need to push to the argv_array in order, which
means we can't do the push until we are in the "unpack-objects
versus index-pack" conditional.  Rather than duplicate the
slightly complicated format specifier, I pushed it into a
helper function.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fb2a090a0..2ca93adef 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1634,12 +1634,17 @@ static const char *parse_pack_header(struct pack_header *hdr)
 
 static const char *pack_lockfile;
 
+static void push_header_arg(struct argv_array *args, struct pack_header *hdr)
+{
+	argv_array_pushf(args, "--pack_header=%"PRIu32",%"PRIu32,
+			ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
+}
+
 static const char *unpack(int err_fd, struct shallow_info *si)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
 	int status;
-	char hdr_arg[38];
 	struct child_process child = CHILD_PROCESS_INIT;
 	int fsck_objects = (receive_fsck_objects >= 0
 			    ? receive_fsck_objects
@@ -1653,9 +1658,6 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 			close(err_fd);
 		return hdr_err;
 	}
-	snprintf(hdr_arg, sizeof(hdr_arg),
-			"--pack_header=%"PRIu32",%"PRIu32,
-			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
 
 	if (si->nr_ours || si->nr_theirs) {
 		alt_shallow_file = setup_temporary_shallow(si->shallow);
@@ -1679,7 +1681,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 	tmp_objdir_add_as_alternate(tmp_objdir);
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
-		argv_array_pushl(&child.args, "unpack-objects", hdr_arg, NULL);
+		argv_array_push(&child.args, "unpack-objects");
+		push_header_arg(&child.args, &hdr);
 		if (quiet)
 			argv_array_push(&child.args, "-q");
 		if (fsck_objects)
@@ -1697,8 +1700,8 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 	} else {
 		char hostname[256];
 
-		argv_array_pushl(&child.args, "index-pack",
-				 "--stdin", hdr_arg, NULL);
+		argv_array_pushl(&child.args, "index-pack", "--stdin", NULL);
+		push_header_arg(&child.args, &hdr);
 
 		if (gethostname(hostname, sizeof(hostname)))
 			xsnprintf(hostname, sizeof(hostname), "localhost");
-- 
2.12.2.845.g55fcf8b10

