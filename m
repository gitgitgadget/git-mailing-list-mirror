Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3131F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 03:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdAYDEk (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 22:04:40 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:42278 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbdAYDEk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 22:04:40 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <glandium@glandium.org>)
        id 1cWDsw-0006tG-1o; Wed, 25 Jan 2017 12:04:34 +0900
From:   Mike Hommey <mh@glandium.org>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] gpg-interface: Add some output from gpg when it errors out.
Date:   Wed, 25 Jan 2017 12:04:34 +0900
Message-Id: <20170125030434.26448-1-mh@glandium.org>
X-Mailer: git-send-email 2.11.0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When e.g. signing a tag fails, the user is left with the following
output on their console:
  error: gpg failed to sign the data
  error: unable to sign the tag

There is no indication of what specifically failed, and no indication
how they might solve the problem.

It turns out, gpg still does output some messages without a [GNUPG:]
prefix. The same messages it outputs when run standalone, in fact.

Those messages can be helpful to find what made the gpg command fail.

For instance, after changing my laptop for a new one, I copied my
configs, but had some environment differences that broke gpg.
With this change applied, the output becomes, on this new machine:
  gpg: keyblock resource '/usr/share/keyrings/debian-keyring.gpg': No
such file or directory
  error: gpg failed to sign the data
  error: unable to sign the tag

which makes it clearer what's wrong.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 gpg-interface.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index e44cc27da..2768bb307 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -149,6 +149,26 @@ const char *get_signing_key(void)
 	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
 }
 
+static int pipe_gpg_command(struct child_process *cmd,
+			    const char *in, size_t in_len,
+			    struct strbuf *out, size_t out_hint,
+			    struct strbuf *err, size_t err_hint)
+{
+	int ret = pipe_command(cmd, in, in_len, out, out_hint, err, err_hint);
+	/* Print out any line that doesn't start with [GNUPG:] if the gpg
+	 * command failed. */
+	if (ret) {
+		struct strbuf **err_lines = strbuf_split(err, '\n');
+		for (struct strbuf **line = err_lines; *line; line++) {
+			if (memcmp((*line)->buf, "[GNUPG:]", 8)) {
+				strbuf_rtrim(*line);
+				fprintf(stderr, "%s\n", (*line)->buf);
+			}
+		}
+		strbuf_list_free(err_lines);
+	}
+	return ret;
+}
 /*
  * Create a detached signature for the contents of "buffer" and append
  * it after "signature"; "buffer" and "signature" can be the same
@@ -175,8 +195,8 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	 * because gpg exits without reading and then write gets SIGPIPE.
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
-	ret = pipe_command(&gpg, buffer->buf, buffer->len,
-			   signature, 1024, &gpg_status, 0);
+	ret = pipe_gpg_command(&gpg, buffer->buf, buffer->len,
+			       signature, 1024, &gpg_status, 0);
 	sigchain_pop(SIGPIPE);
 
 	ret |= !strstr(gpg_status.buf, "\n[GNUPG:] SIG_CREATED ");
@@ -232,8 +252,8 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		gpg_status = &buf;
 
 	sigchain_push(SIGPIPE, SIG_IGN);
-	ret = pipe_command(&gpg, payload, payload_size,
-			   gpg_status, 0, gpg_output, 0);
+	ret = pipe_gpg_command(&gpg, payload, payload_size,
+			       gpg_status, 0, gpg_output, 0);
 	sigchain_pop(SIGPIPE);
 
 	delete_tempfile(&temp);
-- 
2.11.0.dirty

