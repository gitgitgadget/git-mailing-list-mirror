From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 6/7] Register a callback for graph output.
Date: Sat, 15 May 2010 04:02:10 -0700
Message-ID: <1273921331-32702-7-git-send-email-struggleyb.nku@gmail.com>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-2-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-3-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-4-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-5-git-send-email-struggleyb.nku@gmail.com>
 <1273921331-32702-6-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 13:02:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODF8r-0007wy-Q6
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 13:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026Ab0EOLCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 07:02:35 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42018 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900Ab0EOLC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 07:02:27 -0400
Received: by mail-pv0-f174.google.com with SMTP id 1so973492pvh.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pQi5DP62i9LTFFSRgxOnw4SOxWWS4zjHbWXAOE+R3O0=;
        b=wG4LGEQnOoMXT5TpJ4up7hAphPSouZ1hJAcHlIjaiwJmh0tmiKWqhVvrKd82j5Mw3u
         hYgAdsiCcYepoYY96+++LtSYFNlG3tQEdKdGZM/XtWLNVrKBLykMdIBOELWc4+ijbmgQ
         ft9NpjgjO2E0WbfMXBNu/PqyAKKS1+scPvcZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NCnwJUURbsPVN8APhrodAadQZkJGwUV22hN0EMA6MLCKCkMPgTt3uZXcVylbSb+Awh
         GFtMCkKNf0uqi6SI7EDS703R7gCidhTKTtbM+st16w2kuNQUBwmXcKCN0pBLTwcV5pae
         b/uBpLGBKakAChKRQPStR0sRXGwxpha2WDQ+4=
Received: by 10.115.115.9 with SMTP id s9mr2163701wam.66.1273921345453;
        Sat, 15 May 2010 04:02:25 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id d16sm28703988wam.12.2010.05.15.04.02.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 04:02:24 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1273921331-32702-6-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147145>

It will look better if the 'git log --graph' print
the graph pading lines before the diff output just
like what it does for commit message.
And this patch leverage the new diff prefix callback
function to achieve this.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 graph.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/graph.c b/graph.c
index e6bbcaa..d4d2719 100644
--- a/graph.c
+++ b/graph.c
@@ -211,6 +211,21 @@ struct git_graph {
 	unsigned short default_column_color;
 };
 
+static struct strbuf *diff_output_prefix_callback(FILE *file, int print, void *data)
+{
+	struct git_graph *graph = data;
+	static struct strbuf msgbuf = STRBUF_INIT;
+
+	assert(graph);
+
+	strbuf_reset(&msgbuf);
+	graph_padding_line(graph, &msgbuf);
+	if (print) {
+		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+	}
+	return &msgbuf;
+}
+
 struct git_graph *graph_init(struct rev_info *opt)
 {
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
@@ -244,6 +259,13 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->mapping = xmalloc(sizeof(int) * 2 * graph->column_capacity);
 	graph->new_mapping = xmalloc(sizeof(int) * 2 * graph->column_capacity);
 
+	/*
+	 * The diff output prefix callback, with this we can make
+	 * all the diff output to align with the graph lines.
+	 */
+	opt->diffopt.output_prefix = diff_output_prefix_callback;
+	opt->diffopt.output_prefix_data = graph;
+
 	return graph;
 }
 
-- 
1.7.1.94.gc3269
