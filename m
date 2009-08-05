From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] transport: pass "quiet" flag to pack-objects
Date: Wed, 5 Aug 2009 16:22:36 -0400
Message-ID: <20090805202236.GB23226@coredump.intra.peff.net>
References: <20090805201937.GB9004@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:22:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYn0h-0001So-Jn
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZHEUWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbZHEUWm
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:22:42 -0400
Received: from peff.net ([208.65.91.99]:37861 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbZHEUWk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:22:40 -0400
Received: (qmail 12239 invoked by uid 107); 5 Aug 2009 20:24:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 05 Aug 2009 16:24:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2009 16:22:36 -0400
Content-Disposition: inline
In-Reply-To: <20090805201937.GB9004@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124965>

When pushing over the git protocol, pack-objects gives
progress reports about the pack being sent. If "push" is
given the --quiet flag, it now passes "-q" to pack-objects,
suppressing this output.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-send-pack.c |    3 +++
 send-pack.h         |    1 +
 transport.c         |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 47fb9f7..37e528e 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -44,6 +44,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
@@ -53,6 +54,8 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		argv[i++] = "--thin";
 	if (args->use_ofs_delta)
 		argv[i++] = "--delta-base-offset";
+	if (args->quiet)
+		argv[i++] = "-q";
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
diff --git a/send-pack.h b/send-pack.h
index 1d7b1b3..8b3cf02 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -3,6 +3,7 @@
 
 struct send_pack_args {
 	unsigned verbose:1,
+		quiet:1,
 		send_mirror:1,
 		force_update:1,
 		use_thin_pack:1,
diff --git a/transport.c b/transport.c
index 8a42e76..2d0c491 100644
--- a/transport.c
+++ b/transport.c
@@ -878,6 +878,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.force_update = !!(flags & TRANSPORT_PUSH_FORCE);
 	args.use_thin_pack = data->thin;
 	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
+	args.quiet = !!(flags & TRANSPORT_PUSH_QUIET);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
-- 
1.6.4.218.g9f65c.dirty
