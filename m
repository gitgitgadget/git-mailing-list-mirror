From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-* --with-raw
Date: Mon, 10 Apr 2006 17:06:07 -0700
Message-ID: <7v3bgl7z80.fsf@assigned-by-dhcp.cox.net>
References: <7v7j5x7zh3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 11 02:06:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT6Oc-00047F-A9
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 02:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWDKAGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 20:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWDKAGL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 20:06:11 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:38103 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932240AbWDKAGK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 20:06:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060411000608.RMOR26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Apr 2006 20:06:08 -0400
To: git@vger.kernel.org
In-Reply-To: <7v7j5x7zh3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 10 Apr 2006 17:00:40 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18602>

Junio C Hamano <junkio@cox.net> writes:

> Pasky wanted to have an option to get both diff-raw output and
> diff-patch output.  This implements "git-diff-* --with-raw"
> (which obviously implies -p as well) to do so.
>
> Because all the necessary information is already on extended
> header lines such as "index xxxxxx..yyyyyy" and "rename from"
> lines, this is not strictly necessary, but if it helps
> Porcelains...

And this alternative gives raw upfront followed by patch.  It
was unclear which one Pasky wanted, so...

--
diff --git a/diff.c b/diff.c
index 2fa285a..12924f2 100644
--- a/diff.c
+++ b/diff.c
@@ -862,6 +862,10 @@ int diff_opt_parse(struct diff_options *
 	const char *arg = av[0];
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
 		options->output_format = DIFF_FORMAT_PATCH;
+	else if (!strcmp(arg, "--with-raw")) {
+		options->output_format = DIFF_FORMAT_PATCH;
+		options->with_raw = 1;
+	}
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
 	else if (!strncmp(arg, "-l", 2))
@@ -1270,46 +1274,58 @@ static void diff_resolve_rename_copy(voi
 	diff_debug_queue("resolve-rename-copy done", q);
 }
 
-void diff_flush(struct diff_options *options)
+static void flush_one_pair(struct diff_filepair *p,
+			   int diff_output_format,
+			   struct diff_options *options)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
-	int i;
 	int inter_name_termination = '\t';
-	int diff_output_format = options->output_format;
 	int line_termination = options->line_termination;
-
 	if (!line_termination)
 		inter_name_termination = 0;
 
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-
-		switch (p->status) {
-		case DIFF_STATUS_UNKNOWN:
+	switch (p->status) {
+	case DIFF_STATUS_UNKNOWN:
+		break;
+	case 0:
+		die("internal error in diff-resolve-rename-copy");
+		break;
+	default:
+		switch (diff_output_format) {
+		case DIFF_FORMAT_PATCH:
+			diff_flush_patch(p, options);
 			break;
-		case 0:
-			die("internal error in diff-resolve-rename-copy");
+		case DIFF_FORMAT_RAW:
+		case DIFF_FORMAT_NAME_STATUS:
+			diff_flush_raw(p, line_termination,
+				       inter_name_termination,
+				       options);
 			break;
-		default:
-			switch (diff_output_format) {
-			case DIFF_FORMAT_PATCH:
-				diff_flush_patch(p, options);
-				break;
-			case DIFF_FORMAT_RAW:
-			case DIFF_FORMAT_NAME_STATUS:
-				diff_flush_raw(p, line_termination,
-					       inter_name_termination,
-					       options);
-				break;
-			case DIFF_FORMAT_NAME:
-				diff_flush_name(p,
-						inter_name_termination,
-						line_termination);
-				break;
-			case DIFF_FORMAT_NO_OUTPUT:
-				break;
-			}
+		case DIFF_FORMAT_NAME:
+			diff_flush_name(p,
+					inter_name_termination,
+					line_termination);
+			break;
+		case DIFF_FORMAT_NO_OUTPUT:
+			break;
 		}
+	}
+}
+
+void diff_flush(struct diff_options *options)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	int i;
+	int diff_output_format = options->output_format;
+
+	if (options->with_raw) {
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			flush_one_pair(p, DIFF_FORMAT_RAW, options);
+		}
+	}
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		flush_one_pair(p, diff_output_format, options);
 		diff_free_filepair(p);
 	}
 	free(q->queue);
diff --git a/diff.h b/diff.h
index a02ef28..07b153b 100644
--- a/diff.h
+++ b/diff.h
@@ -24,6 +24,7 @@ struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
 	unsigned recursive:1,
+		 with_raw:1,
 		 tree_in_recursive:1,
 		 full_index:1;
 	int break_opt;
