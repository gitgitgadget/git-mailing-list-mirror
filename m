From: Joe Perches <joe@perches.com>
Subject: Re: [RFC PATCH] builtin-log: Add options to --coverletter
Date: Fri, 15 May 2009 13:19:22 -0700
Message-ID: <1242418762.3373.90.camel@Joe-Laptop.home>
References: <1242349041.646.8.camel@Joe-Laptop.home>
	 <7v63g2tewu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 22:19:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M53sV-0000Jm-NF
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 22:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbZEOUT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 16:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZEOUT0
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 16:19:26 -0400
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:2263 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbZEOUTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 16:19:25 -0400
Received: from [192.168.1.158] ([192.168.1.158])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id NAA12486;
	Fri, 15 May 2009 13:19:09 -0700
In-Reply-To: <7v63g2tewu.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119291>

On Fri, 2009-05-15 at 11:11 -0700, Junio C Hamano wrote:
> I think it makes sense to let users affect how the short-log in the cover
> letter is generated.  I do not think overloading the --cover-letter option
> for doing it is the ideal approach, though.

OK.  How about this patch?

diff --git a/builtin-log.c b/builtin-log.c
index 5eaec5d..49fd42a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -460,6 +460,11 @@ static void add_header(const char *value)
 static int thread = 0;
 static int do_signoff = 0;
 
+static int coverletter_wrap = 1;
+static int coverletter_wrappos = 72;
+static int coverletter_indent1 = 2;
+static int coverletter_indent2 = 4;
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
@@ -668,10 +673,10 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	strbuf_release(&sb);
 
 	shortlog_init(&log);
-	log.wrap_lines = 1;
-	log.wrap = 72;
-	log.in1 = 2;
-	log.in2 = 4;
+	log.wrap_lines = coverletter_wrap;
+	log.wrap = coverletter_wrappos;
+	log.in1 = coverletter_indent1;
+	log.in2 = coverletter_indent2;
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
@@ -868,6 +873,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			fmt_patch_suffix = argv[i] + 9;
 		else if (!strcmp(argv[i], "--cover-letter"))
 			cover_letter = 1;
+		else if (!prefixcmp(argv[i], "--cover-letter-wrap=")) {
+			if (sscanf(argv[i] + 20, "%d,%d,%d",
+				   &coverletter_wrappos,
+				   &coverletter_indent1,
+				   &coverletter_indent2) <= 0)
+				die("Need options for --cover-letter-wrap=");
+			if (coverletter_wrappos == 0)
+				coverletter_wrap = 0;
+			}
 		else if (!strcmp(argv[i], "--no-binary"))
 			no_binary_diff = 1;
 		else if (!prefixcmp(argv[i], "--add-header="))
