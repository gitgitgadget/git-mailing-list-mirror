From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 5/6 rebase-version] Register a callback for graph output.
Date: Tue, 25 May 2010 17:02:33 +0800
Message-ID: <1274778154-29976-6-git-send-email-struggleyb.nku@gmail.com>
References: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-2-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-3-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-4-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-5-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 11:03:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGq2e-0006UN-M9
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab0EYJDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:03:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42015 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab0EYJDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:03:06 -0400
Received: by pwi2 with SMTP id 2so947653pwi.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HzcDs4r3N4X32ovzWy829IiA6jeNBKvDjzMetLcd9vs=;
        b=HMlCx5P5dTQjBRvoOLXBaM1B7Hti2XKwsrlyNl7fIcanrKWFOuegGqA131MA/JWTJ0
         d6kkNpuODw1eAn5DCMyCBQzCSGer2FZ91fZJ/C7WnjgiBzfrhti7TuJf0TBkih8HmQ6M
         vjhrVEiOH05cjIvQ5fjghd06g55JNZG+Jb8c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Qmqp2SYxoW3igcMh+v4JLqH4FL649tyU9waXLKqsZm6PJzbUita1O0v/sdnzcOLUZA
         FPsphyohAgO+KZgAzizFhRn6XN+zLgRhAXx1kIJLMp6eqZXMUlBpfoAik3fieErEbjwR
         taPakQPUQ273TclzrxAxXNvz/blUTnJnMcLc0=
Received: by 10.115.98.19 with SMTP id a19mr5922466wam.82.1274778185592;
        Tue, 25 May 2010 02:03:05 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.99])
        by mx.google.com with ESMTPS id d16sm46058650wam.0.2010.05.25.02.03.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 02:03:04 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274778154-29976-5-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147693>

It will look better if the 'git log --graph' print
the graph pading lines before the diff output just
like what it does for commit message.
And this patch leverage the new diff prefix callback
function to achieve this.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 graph.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/graph.c b/graph.c
index e6bbcaa..ac7c605 100644
--- a/graph.c
+++ b/graph.c
@@ -211,6 +211,18 @@ struct git_graph {
 	unsigned short default_column_color;
 };
 
+static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void *data)
+{
+	struct git_graph *graph = data;
+	static struct strbuf msgbuf = STRBUF_INIT;
+
+	assert(graph);
+
+	strbuf_reset(&msgbuf);
+	graph_padding_line(graph, &msgbuf);
+	return &msgbuf;
+}
+
 struct git_graph *graph_init(struct rev_info *opt)
 {
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
@@ -244,6 +256,13 @@ struct git_graph *graph_init(struct rev_info *opt)
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
1.6.0.4
