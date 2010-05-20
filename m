From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 5/6 v2] Register a callback for graph output.
Date: Thu, 20 May 2010 03:25:37 -0700
Message-ID: <1274351138-11813-6-git-send-email-struggleyb.nku@gmail.com>
References: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-2-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-3-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-4-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-5-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 12:33:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF34b-0001Ha-C0
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 12:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab0ETKdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 06:33:49 -0400
Received: from mail-pz0-f176.google.com ([209.85.222.176]:59833 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab0ETKds (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 06:33:48 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 May 2010 06:33:48 EDT
Received: by pzk6 with SMTP id 6so4454173pzk.1
        for <git@vger.kernel.org>; Thu, 20 May 2010 03:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fIJwsJArXyxRM6D3p1bvFL2VICIQiXprqynqw7aUc4Q=;
        b=qE3fdKnF5AFCll/i6hCaMSJx1QKtK77AomErq/HUclOT/j7cSh8xmCgb0PUbu96zTy
         cL4Rs97ZQQI3vo8i5aMHUIUW9qiOctGMKoviWKBPSBa8yo/DixjDRUB8QgtU3pKewavf
         k3tNHEggEWeEEHEpcHQ0RLi5sZdkgMVEPkYz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xlLjTZnGp6shVjJGAdsAQ00Mc41VXcODyRa1gi7TncJx4oF19sngeYUxGleygrozmo
         97QDcQzNsXcIPxIUveMJWXvNw4H58VVgI8hDF7WApFzjiExt2EFTNuEKy4o8N+IRl8P5
         yEWCCXZdesPo3C2vltSEYaaO7WUqDrow9G//s=
Received: by 10.114.33.14 with SMTP id g14mr8491136wag.94.1274351159183;
        Thu, 20 May 2010 03:25:59 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n32sm76160636wae.22.2010.05.20.03.25.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 03:25:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274351138-11813-5-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147380>

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
index e6bbcaa..6982d7a 100644
--- a/graph.c
+++ b/graph.c
@@ -211,6 +211,18 @@ struct git_graph {
 	unsigned short default_column_color;
 };
 
+static struct strbuf *diff_output_prefix_callback(FILE *file, void *data)
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
