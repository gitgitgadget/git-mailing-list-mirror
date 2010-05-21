From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 5/6 v3] Register a callback for graph output.
Date: Thu, 20 May 2010 18:52:43 -0700
Message-ID: <1274406764-32278-6-git-send-email-struggleyb.nku@gmail.com>
References: <1274406764-32278-1-git-send-email-struggleyb.nku@gmail.com>
 <1274406764-32278-2-git-send-email-struggleyb.nku@gmail.com>
 <1274406764-32278-3-git-send-email-struggleyb.nku@gmail.com>
 <1274406764-32278-4-git-send-email-struggleyb.nku@gmail.com>
 <1274406764-32278-5-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 03:53:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFHQJ-0004JK-Bh
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 03:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757037Ab0EUBxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 21:53:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64076 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab0EUBxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 21:53:04 -0400
Received: by mail-pv0-f174.google.com with SMTP id 3so196508pvg.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 18:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HzcDs4r3N4X32ovzWy829IiA6jeNBKvDjzMetLcd9vs=;
        b=q/6sIRoM4aFLnzHlT5vz+sF3KhgjV6ULaKiullXTLhKgCn5ov1ZGCykRkqihHtTOZC
         FRD/mu1A3MhAdkv4NJhYUhk9gVKWq8bhZLkymVPdcYnL/jN45VnR1lNBJFDpx9DY1Gmk
         aPth0ISYuiDQnT10Wuw7QtMbzkKXb0gV5Y0Ms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kLNmMNc5p80YBBqgnEtBzMPVyC8Skjsisjju+d4MeVbgwRISS5Lq4S5XwL8NNCApSt
         aLlbZIreb7AXleq7H6VuLrypJOS9DBwYJ8snAz7R28XOoXfs1HxRddFhG5Kf987uqNBh
         87fqZmvzM9ed3daHexTqCLcsTSu+AmZ+X2zVM=
Received: by 10.141.101.15 with SMTP id d15mr686092rvm.10.1274406784312;
        Thu, 20 May 2010 18:53:04 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id o38sm442378rvp.12.2010.05.20.18.53.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 18:53:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274406764-32278-5-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147427>

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
