Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF68120A5E
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbdH3Ruw (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:52 -0400
Received: from mout.web.de ([217.72.192.78]:54295 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751993AbdH3RuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:08 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MaJro-1e6ppm3G8m-00Jvo1 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:06 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 09/34] convert: release strbuf on error return in filter_buffer_or_fd()
Date:   Wed, 30 Aug 2017 19:49:40 +0200
Message-Id: <20170830175005.20756-10-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:XUH0OUSscpdXsPrOtYXRKNYPwRg1ryu1Gp4X48CdZ5gq8aqTsS3
 dJC/c+FI7xuw2tPzy65OxSknNp5XpElvcBsuE1LLWXEaIKiKUlk6BUJkbYAplCiW0Zw8Nb3
 jvSSGSi6pKL2mnmOxvgws+tzkAIZpBpUqXdq/MAz8iX9PVZCjoio8rVf40SgZjaTF1QdW/n
 EgC/J6UDejsGBLfWi3IKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XT/KsiCjdgw=:RMkgfewx3mD1OJ29ePoqJU
 NzQqEiw+qzTWKRAmXsSI5Mbu6UzAhcoptCXk3wIwBGibui/EQ4fKgMPSh6QEPs3fuVG3/24Gy
 iXjnT3sbmUIlYVagrUVAwce1FWqUUfpZNdxJB99QIpcO7FiGhkONNG1iQBmM0Q4jDhoK3420g
 37PAT/prFwct6UDfTFbCzbJz5ikYDdamzgdoxA3gi6BZVDVhMfCRt9J/E/dsL2Q1gNHWaK/Fg
 s/rgDSSiwLipEB3o+jqQCv8R/yJjTAtmzXlHjcd89H5KJDuH/IIHLyWsw7mUZB3V3NlIDwc8Q
 IDwucpljo5IsJoytLpH9BKmzbNJNFnyiomkd28Yfj2ek2VNMkzD6HyLOXY8WLUlK2OulRt3SC
 K0pX+UKv1vKeGoUVy16AUcfwxlkuDp8yIjm6m4uBInd+mr0USCwGq5g28xnWrz6MU32gKSs5B
 NABdGA0uAn8cbiN+wPTqLcCaxQBXZnQ93BYp7CxcFumMfz6SC+P450eoiwFexu6gB02S/Gf+R
 1x4rPh/Jagf5OHj02kWwGH96d0HRuz+Q4tiIFKSAidE97rKWlKylrEwWNuFUhsJzXBSlPKa3w
 e5M9xFhqCjOwiFIjAuF56uCvJ78n8jrAPo85BzSzk+bynxFiAYueYQG3wGXmbmGSbDDZof+JN
 peF13tHMuJm/oIiZSvZ7WW03oPYwW62Bn6Ro885B3dTJgCceqSqTJJCDmOQFpJrOBsNyjKZ3h
 cz2zTKEOPdemI3wIsu/dxCWCw83lFEIXgnqljDioPxIYMtilRlNtSkzcceEnlYnVDcHoQ9zsc
 08J8zl2HhW30PVpnORDabgHNH23Vg==
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

