Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC51208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdIEMOa (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:14:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:57144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751291AbdIEMO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:14:28 -0400
Received: (qmail 31276 invoked by uid 109); 5 Sep 2017 12:14:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:14:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12212 invoked by uid 111); 5 Sep 2017 12:15:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:15:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:14:26 -0400
Date:   Tue, 5 Sep 2017 08:14:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/20] always check return value of close_tempfile
Message-ID: <20170905121426.sc4u4unmwzhamjsa@sigill.intra.peff.net>
References: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If close_tempfile() encounters an error, then it deletes the
tempfile and resets the "struct tempfile". But many code
paths ignore the return value and continue to use the
tempfile. Instead, we should generally treat this the same
as a write() error.

Note that in the postimage of some of these cases our error
message will be bogus after a failed close because we look
at tempfile->filename (either directly or via get_tempfile_path).
But after the failed close resets the tempfile object, this
is guaranteed to be the empty string. That will be addressed
in a future patch (because there are many more cases of the
same problem than just these instances).

Note also in the hunk in gpg-interface.c that it's fine to
call delete_tempfile() in the error path, even if
close_tempfile() failed and already deleted the file. The
tempfile code is smart enough to know the second deletion is
a noop.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c          | 4 ++--
 gpg-interface.c | 4 ++--
 shallow.c       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 3d3e553a98..fdb974014b 100644
--- a/diff.c
+++ b/diff.c
@@ -3738,9 +3738,9 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 		blob = buf.buf;
 		size = buf.len;
 	}
-	if (write_in_full(fd, blob, size) != size)
+	if (write_in_full(fd, blob, size) != size ||
+	    close_tempfile(&temp->tempfile))
 		die_errno("unable to write temp-file");
-	close_tempfile(&temp->tempfile);
 	temp->name = get_tempfile_path(&temp->tempfile);
 	oid_to_hex_r(temp->hex, oid);
 	xsnprintf(temp->mode, sizeof(temp->mode), "%06o", mode);
diff --git a/gpg-interface.c b/gpg-interface.c
index 455b6c04b4..05ca6ecbfd 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -209,13 +209,13 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	fd = mks_tempfile_t(&temp, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
 		return error_errno(_("could not create temporary file"));
-	if (write_in_full(fd, signature, signature_size) < 0) {
+	if (write_in_full(fd, signature, signature_size) < 0 ||
+	    close_tempfile(&temp) < 0) {
 		error_errno(_("failed writing detached signature to '%s'"),
 			    temp.filename.buf);
 		delete_tempfile(&temp);
 		return -1;
 	}
-	close_tempfile(&temp);
 
 	argv_array_pushl(&gpg.args,
 			 gpg_program,
diff --git a/shallow.c b/shallow.c
index c7fd68ace0..f49e6ae122 100644
--- a/shallow.c
+++ b/shallow.c
@@ -295,10 +295,10 @@ const char *setup_temporary_shallow(const struct oid_array *extra)
 	if (write_shallow_commits(&sb, 0, extra)) {
 		fd = xmks_tempfile(&temp, git_path("shallow_XXXXXX"));
 
-		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
+		if (write_in_full(fd, sb.buf, sb.len) != sb.len ||
+		    close_tempfile(&temp) < 0)
 			die_errno("failed to write to %s",
 				  get_tempfile_path(&temp));
-		close_tempfile(&temp);
 		strbuf_release(&sb);
 		return get_tempfile_path(&temp);
 	}
-- 
2.14.1.721.gc5bc1565f1

