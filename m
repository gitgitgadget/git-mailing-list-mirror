From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v2 1/3] Add output_prefix_length to diff_options
Date: Thu, 22 Mar 2012 12:27:39 -0700
Message-ID: <1332444461-11957-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	"Adam Simpkins" <adam@adamsimpkins.net>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <junkio@cox.net>,
	"Bo Yang" <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 20:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAngN-0001ix-I5
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759359Ab2CVT2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:28:18 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48069 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab2CVT2S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:28:18 -0400
Received: by pbcun15 with SMTP id un15so1825988pbc.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9pC2d3dW0B1YyTq+oivAoU7tErZJ7rv2EXFKrl4e/vo=;
        b=TJPKDcWKX2m9CB5wcrXMWFvcyHB9su/tNiEKmFES4QySaD16aWHqZ87JsnHuJs34YD
         M4XevYE+h6oKXAUE5MTDdfOHg6UMLwM80dJ+C/0ySMS9lvyB7bCZWZpsiFdswUZ2k5qr
         INWrdlUcQGaYVMzAA1frstfzgbMpF2Zf79NI1YVR26fjSXWxNW6fX7XDdMpYPHpcfYH7
         XYA5xovyIQJugN7HwFMDajQp/IV8hKj2QoeeEztrsoe4GcqnAEkgm7EyQav0+NXtFkSb
         O9e504DB4Kzg8K+/53imhRgSMTklCfMd81NGI/L2SZy06ECPblT807MsOOao47HdZxhf
         Svag==
Received: by 10.68.191.134 with SMTP id gy6mr22541617pbc.152.1332444497547;
        Thu, 22 Mar 2012 12:28:17 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id m5sm4281227pbo.69.2012.03.22.12.28.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:28:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193694>

Add output_prefix_length to diff_options. Initialize the value to 0 and only
set it when graph.c:diff_output_prefix_callback() is called.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 diff.h  |    1 +
 graph.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.h b/diff.h
index cb68743..19d762f 100644
--- a/diff.h
+++ b/diff.h
@@ -150,6 +150,7 @@ struct diff_options {
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
 	diff_prefix_fn_t output_prefix;
+	int output_prefix_length;
 	void *output_prefix_data;
 };
 
diff --git a/graph.c b/graph.c
index 7358416..7e0a099 100644
--- a/graph.c
+++ b/graph.c
@@ -194,8 +194,10 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 	struct git_graph *graph = data;
 	static struct strbuf msgbuf = STRBUF_INIT;
 
+	assert(opt);
 	assert(graph);
 
+	opt->output_prefix_length = graph->width;
 	strbuf_reset(&msgbuf);
 	graph_padding_line(graph, &msgbuf);
 	return &msgbuf;
@@ -245,6 +247,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 */
 	opt->diffopt.output_prefix = diff_output_prefix_callback;
 	opt->diffopt.output_prefix_data = graph;
+	opt->diffopt.output_prefix_length = 0;
 
 	return graph;
 }
-- 
1.7.3.4
