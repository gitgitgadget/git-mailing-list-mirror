From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6 v2] Make git log --graph looks better with -p and
 other diff options
Date: Thu, 20 May 2010 09:24:25 -0400
Message-ID: <20100520132425.GA5504@coredump.intra.peff.net>
References: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
 <20100520123650.GA7665@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 15:24:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF5jm-0007mR-CF
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 15:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab0ETNY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 09:24:28 -0400
Received: from peff.net ([208.65.91.99]:35517 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712Ab0ETNY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 09:24:27 -0400
Received: (qmail 13868 invoked by uid 107); 20 May 2010 13:24:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 20 May 2010 09:24:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 May 2010 09:24:25 -0400
Content-Disposition: inline
In-Reply-To: <20100520123650.GA7665@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147386>

On Thu, May 20, 2010 at 08:36:50AM -0400, Jeff King wrote:

>   git log --graph --oneline --summary 212f0ba
> 
> Summary lines for some reason don't get properly indented or prefixed
> with branch lines.

This is my naive attempt at fixing it just by copying your other
changes. However, it seems to sometimes put several copies of the prefix
in front of summary lines (and sometimes the next commit line!?). So
clearly there is something about the output prefix code that I don't
quite understand.

Maybe this is helpful, and maybe not. :)

diff --git a/diff.c b/diff.c
index 3a1e05a..656f40b 100644
--- a/diff.c
+++ b/diff.c
@@ -3460,27 +3460,41 @@ static void show_rename_copy(FILE *file, const char *renamecopy, struct diff_fil
 	show_mode_change(file, p, 0);
 }
 
-static void diff_summary(FILE *file, struct diff_filepair *p)
+static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 {
+	FILE *file = opt->file;
+	char *line_prefix = "";
+
+	if (opt->output_prefix) {
+		struct strbuf *buf = opt->output_prefix(file, opt->output_prefix_data);
+		line_prefix = buf->buf;
+	}
+
 	switch(p->status) {
 	case DIFF_STATUS_DELETED:
+		fputs(line_prefix, file);
 		show_file_mode_name(file, "delete", p->one);
 		break;
 	case DIFF_STATUS_ADDED:
+		fputs(line_prefix, file);
 		show_file_mode_name(file, "create", p->two);
 		break;
 	case DIFF_STATUS_COPIED:
+		fputs(line_prefix, file);
 		show_rename_copy(file, "copy", p);
 		break;
 	case DIFF_STATUS_RENAMED:
+		fputs(line_prefix, file);
 		show_rename_copy(file, "rename", p);
 		break;
 	default:
 		if (p->score) {
+			fputs(line_prefix, file);
 			fputs(" rewrite ", file);
 			write_name_quoted(p->two->path, file, ' ');
 			fprintf(file, "(%d%%)\n", similarity_index(p));
 		}
+		fputs(line_prefix, file);
 		show_mode_change(file, p, !p->score);
 		break;
 	}
@@ -3692,7 +3706,7 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_SUMMARY && !is_summary_empty(q)) {
 		for (i = 0; i < q->nr; i++)
-			diff_summary(options->file, q->queue[i]);
+			diff_summary(options, q->queue[i]);
 		separator++;
 	}
 
