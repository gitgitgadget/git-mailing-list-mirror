Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8495F20285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbdH3R6f (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:58:35 -0400
Received: from mout.web.de ([217.72.192.78]:63344 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbdH3R61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:58:27 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOzwh-1dq7fR0Shz-006N7v for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:58:26 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 09/34] convert: release strbuf on error return in filter_buffer_or_fd()
Date:   Wed, 30 Aug 2017 19:58:09 +0200
Message-Id: <20170830175825.20905-5-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175825.20905-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175825.20905-1-l.s.r@web.de>
X-Provags-ID: V03:K0:9DEYjY4aCMOvXO86Xt43+jrOY3zhFCHMwYyHTXzPX3mp79WEGCX
 K+1AGZZPQ0930tTdLKvJBuusFw1GBXgMZx5BCVj91/X33NxI7Tb+fCPy6XKMwSWAS+bSNXb
 PBo1aL/wMA5WkeAzgIBvZOahAUmCE3UkrWDjpKZI4ttGATSepFH+cYD+FqIUBusAlyiHknK
 ggpb4zeihfaOjkUxNRTHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N4ibegkCgWY=:U+qY1cL9LLZkMl8cN57Qtm
 HW/wSVQC2enUKtSyMTHi4BlU+IPZ3FVQiDVDpak4PQfpm66j65+Uwka5/lU6LEQc3gnuc/8zI
 29dGpg4JvgtUK/oREEB6aLJp3X0rbXrSGM92f/Hg1FZy6tAO8Y4bBu1MHNQPHtABUpxbzjtcC
 jhH6KwHiGqaALkZTZnrh2SOu/Xl6Abw9KbYgviQBr+j96l6RgSpFDaDNhuyHD5Q3yCoCF1mjJ
 6vhsWiTqfHjv38alAcsdFC8eqLrRfuJM0KtUE3mBADLnelMXRNr+Ytgp9oAieEJ/GnXLKPBJi
 jE4CNuUYXLzAemkZc99y4QgNyOimFHLvrgO5GYR4E89uViCo3cQHjTh8O2d2Idpo117XuxcEc
 4U+d4x4Dr0mU9HG3k4oBI5BHdqjL4f90dlzG8iEu8tMRLIUvR8qYKjeKJrXsDh/zRqLzRg2tV
 2Ff0Lw18WflF2qpeTfjNV80giHcc5ICEnszGeigaSjDl6B9IlZ0MibJJTkXta0JbOnVV38/fR
 FxWTgmnl8d9E5ZJINqLjmPz6gavxkueLa/zbfrSQDyC6PR/ijnAQpB4D+u5uuvJ1TD5PlZMS3
 Ztzys/J47U2WcJJ18lOqzlcxYuRop9SrpR220z/e5s1gt2BqmELoIgmEjmTruHXa6QsrFGYkM
 nC5naRA23XLViRUNsGqdSaLep+5uSsKXi48VIkXxdc7pkIwfNjARhiYoWbhTTHcNF/T+ylFd7
 yW1FfVLxKSf5F8Tp4igGUpFIaDZZ5kdKh2wmTVRIfWeHklnBTqoGf9GBJt4f+VEAjNtxeLJb+
 EoHoBJSPgX2L3hkA9gF1A5MozK3Fg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 convert.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index c5f0b21037..4a0ed8d3cb 100644
--- a/convert.c
+++ b/convert.c
@@ -393,63 +393,65 @@ struct filter_params {
 static int filter_buffer_or_fd(int in, int out, void *data)
 {
 	/*
 	 * Spawn cmd and feed the buffer contents through its stdin.
 	 */
 	struct child_process child_process = CHILD_PROCESS_INIT;
 	struct filter_params *params = (struct filter_params *)data;
 	int write_err, status;
 	const char *argv[] = { NULL, NULL };
 
 	/* apply % substitution to cmd */
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf_expand_dict_entry dict[] = {
 		{ "f", NULL, },
 		{ NULL, NULL, },
 	};
 
 	/* quote the path to preserve spaces, etc. */
 	sq_quote_buf(&path, params->path);
 	dict[0].value = path.buf;
 
 	/* expand all %f with the quoted path */
 	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
 	strbuf_release(&path);
 
 	argv[0] = cmd.buf;
 
 	child_process.argv = argv;
 	child_process.use_shell = 1;
 	child_process.in = -1;
 	child_process.out = out;
 
-	if (start_command(&child_process))
+	if (start_command(&child_process)) {
+		strbuf_release(&cmd);
 		return error("cannot fork to run external filter '%s'", params->cmd);
+	}
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
 	if (params->src) {
 		write_err = (write_in_full(child_process.in,
 					   params->src, params->size) < 0);
 		if (errno == EPIPE)
 			write_err = 0;
 	} else {
 		write_err = copy_fd(params->fd, child_process.in);
 		if (write_err == COPY_WRITE_ERROR && errno == EPIPE)
 			write_err = 0;
 	}
 
 	if (close(child_process.in))
 		write_err = 1;
 	if (write_err)
 		error("cannot feed the input to external filter '%s'", params->cmd);
 
 	sigchain_pop(SIGPIPE);
 
 	status = finish_command(&child_process);
 	if (status)
 		error("external filter '%s' failed %d", params->cmd, status);
 
 	strbuf_release(&cmd);
 	return (write_err || status);
 }
-- 
2.14.1

