From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] "diff --check" should affect exit status
Date: Thu, 13 Dec 2007 18:10:10 -0800
Message-ID: <7vbq8uxbzx.fsf@gitster.siamese.dyndns.org>
References: <1197552751-53480-1-git-send-email-win@wincent.com>
	<1197552751-53480-2-git-send-email-win@wincent.com>
	<7vir32ywyz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 03:11:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J301K-0006J1-Gv
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 03:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763502AbXLNCKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 21:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763936AbXLNCKW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 21:10:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763276AbXLNCKU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 21:10:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 665008E96;
	Thu, 13 Dec 2007 21:10:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BB778E94;
	Thu, 13 Dec 2007 21:10:12 -0500 (EST)
In-Reply-To: <7vir32ywyz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 13 Dec 2007 15:51:48 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68214>

Junio C Hamano <gitster@pobox.com> writes:

> I think highjacking the "did we encounter problems" return value of the
> entire callchain for the purpose of checkdiff is very ugly and wrong to
> begin with,...

How about this on top of your 1/5?  It mostly is about reverting the
damage to the higher level callchain.  Instead, builtin_checkdiff()
inspects the checkdiff data and sets the CHECK_FAILED flag to the
diffopt structure.  The callers are already checking that flag so there
is nothing to change for them.

--

diff --git a/diff.c b/diff.c
index 39109a6..fc496bf 100644
--- a/diff.c
+++ b/diff.c
@@ -1456,7 +1456,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	diff_free_filespec_data(two);
 }
 
-static int builtin_checkdiff(const char *name_a, const char *name_b,
+static void builtin_checkdiff(const char *name_a, const char *name_b,
 			     struct diff_filespec *one,
 			     struct diff_filespec *two, struct diff_options *o)
 {
@@ -1464,7 +1464,7 @@ static int builtin_checkdiff(const char *name_a, const char *name_b,
 	struct checkdiff_t data;
 
 	if (!two)
-		return 0;
+		return;
 
 	memset(&data, 0, sizeof(data));
 	data.xm.consume = checkdiff_consume;
@@ -1493,7 +1493,8 @@ static int builtin_checkdiff(const char *name_a, const char *name_b,
  free_and_return:
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
-	return data.status;
+	if (data.status)
+		DIFF_OPT_SET(o, CHECK_FAILED);
 }
 
 struct diff_filespec *alloc_filespec(const char *path)
@@ -2078,14 +2079,14 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	builtin_diffstat(name, other, p->one, p->two, diffstat, o, complete_rewrite);
 }
 
-static int run_checkdiff(struct diff_filepair *p, struct diff_options *o)
+static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 {
 	const char *name;
 	const char *other;
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
-		return 0;
+		return;
 	}
 
 	name = p->one->path;
@@ -2094,7 +2095,7 @@ static int run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	diff_fill_sha1_info(p->one);
 	diff_fill_sha1_info(p->two);
 
-	return builtin_checkdiff(name, other, p->one, p->two, o);
+	builtin_checkdiff(name, other, p->one, p->two, o);
 }
 
 void diff_setup(struct diff_options *options)
@@ -2596,17 +2597,17 @@ static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
 	run_diffstat(p, o, diffstat);
 }
 
-static int diff_flush_checkdiff(struct diff_filepair *p,
+static void diff_flush_checkdiff(struct diff_filepair *p,
 		struct diff_options *o)
 {
 	if (diff_unmodified_pair(p))
-		return 0;
+		return;
 
 	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
-		return 0; /* no tree diffs in patch format */
+		return; /* no tree diffs in patch format */
 
-	return run_checkdiff(p, o);
+	run_checkdiff(p, o);
 }
 
 int diff_queue_is_empty(void)
@@ -2725,19 +2726,16 @@ static int check_pair_status(struct diff_filepair *p)
 	}
 }
 
-static int flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
+static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 {
 	int fmt = opt->output_format;
 
 	if (fmt & DIFF_FORMAT_CHECKDIFF)
-		return diff_flush_checkdiff(p, opt);
+		diff_flush_checkdiff(p, opt);
 	else if (fmt & (DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))
 		diff_flush_raw(p, opt);
 	else if (fmt & DIFF_FORMAT_NAME)
 		write_name_quoted(p->two->path, stdout, opt->line_termination);
-
-	/* return value only matters with DIFF_FORMAT_CHECKDIFF */
-	return 0;
 }
 
 static void show_file_mode_name(const char *newdelete, struct diff_filespec *fs)
@@ -2976,8 +2974,8 @@ void diff_flush(struct diff_options *options)
 			     DIFF_FORMAT_CHECKDIFF)) {
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p) && flush_one_pair(p, options))
-				DIFF_OPT_SET(options, CHECK_FAILED);
+			if (check_pair_status(p))
+				flush_one_pair(p, options);
 		}
 		separator++;
 	}
-- 
1.5.4.rc0.1.g37d0
