From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 5/6] Register a callback for graph output
Date: Wed, 26 May 2010 15:23:56 +0800
Message-ID: <1274858637-13243-3-git-send-email-struggleyb.nku@gmail.com>
References: <1274858637-13243-1-git-send-email-struggleyb.nku@gmail.com>
 <1274858637-13243-2-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 09:24:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHAyt-00035K-Vl
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 09:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab0EZHYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 03:24:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35361 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0EZHYa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 03:24:30 -0400
Received: by mail-pv0-f174.google.com with SMTP id 3so962438pvg.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 00:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HzcDs4r3N4X32ovzWy829IiA6jeNBKvDjzMetLcd9vs=;
        b=UpBDZH/f4CDa63uM7ecnJj1gkbDRUqcyh58/vj9sCBZfhfImfFVNnOrk0UhMkymYCR
         zDBybbNNcEeyLkDpPIVnAKkbCVv7b6WBLk9lkP7Sc4QA2l3F87Kb2dANGOI/TDOZMY5b
         Fb3oHSFDBsVovyE7OEw5nEZFVuy2ob9S3T+YA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vUypse6G54/JDZFbiI/ffkZf7mM7uoJ7nE8YelwWbF4Q6INuZDCoEmEeq3tDtIa0Pb
         psrP5fOe1J1YNhPlp2GzSazmbf50EuaY9V8kYP1na/cF3bCJHWshVQDY+sYz3mQEZgU4
         dm8GLyEVfVZ8NI24BKJvJDNbe8oKY2B0OU8a8=
Received: by 10.142.247.7 with SMTP id u7mr5139411wfh.95.1274858670376;
        Wed, 26 May 2010 00:24:30 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.99])
        by mx.google.com with ESMTPS id 33sm54800802wad.8.2010.05.26.00.24.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 00:24:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274858637-13243-2-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147777>

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
