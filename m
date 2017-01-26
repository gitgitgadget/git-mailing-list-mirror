Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4692C1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 05:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbdAZFVG (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 00:21:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:45120 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752734AbdAZFVG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 00:21:06 -0500
Received: (qmail 3053 invoked by uid 109); 26 Jan 2017 05:21:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 05:21:06 +0000
Received: (qmail 20321 invoked by uid 111); 26 Jan 2017 05:21:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 00:21:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 00:21:03 -0500
Date:   Thu, 26 Jan 2017 00:21:03 -0500
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Add some output from gpg when it errors
 out.
Message-ID: <20170126052103.mpudt63l7dynf3h6@sigill.intra.peff.net>
References: <20170125030434.26448-1-mh@glandium.org>
 <xmqqtw8m7ncp.fsf@gitster.mtv.corp.google.com>
 <20170125235410.byxwmo7o7zdszzot@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170125235410.byxwmo7o7zdszzot@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 08:54:10AM +0900, Mike Hommey wrote:

> > Implementation-wise, I'd be happier if we do not add any new
> > callsites of strbuf_split(), which is a horrible interface.  But
> > that is a minor detail.
> 
> What would you suggest otherwise?

Try string_list_split() (or its in_place() variant, since it is probably
OK to hack up the string for your use case). Like this:

diff --git a/gpg-interface.c b/gpg-interface.c
index 2768bb307..051bb7d3e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -158,14 +158,16 @@ static int pipe_gpg_command(struct child_process *cmd,
 	/* Print out any line that doesn't start with [GNUPG:] if the gpg
 	 * command failed. */
 	if (ret) {
-		struct strbuf **err_lines = strbuf_split(err, '\n');
-		for (struct strbuf **line = err_lines; *line; line++) {
-			if (memcmp((*line)->buf, "[GNUPG:]", 8)) {
-				strbuf_rtrim(*line);
-				fprintf(stderr, "%s\n", (*line)->buf);
-			}
+		struct string_list lines = STRING_LIST_INIT_NODUP;
+		int i;
+
+		string_list_split_in_place(&lines, err->buf, '\n', 0);
+		for (i = 0; i < lines.nr; i++) {
+			const char *line = lines.items[i].string;
+			if (!starts_with(line, "[GNUPG:]"))
+				fprintf(stderr, "%s\n", line);
 		}
-		strbuf_list_free(err_lines);
+		string_list_clear(&lines, 0);
 	}
 	return ret;
 }

Note that I also replaced the memcmp with starts_with(). That avoids the
magic number "8". I also suspect your original can read off the end of
the buffer when the line is shorter than 8 characters (e.g., if memcmp
does 64-bit loads).

-Peff
