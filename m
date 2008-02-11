From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add "--dirstat" for some directory statistics
Date: Mon, 11 Feb 2008 14:25:26 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802111414590.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802111230200.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802112122300.3870@racer.site> <alpine.LFD.1.00.0802111349090.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOhKw-0004D2-Ll
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 23:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbYBKWka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 17:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbYBKWk3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 17:40:29 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58459 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758949AbYBKWk0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 17:40:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BMc1Pn003480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 14:39:41 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BMPQqX003473;
	Mon, 11 Feb 2008 14:25:26 -0800
In-Reply-To: <alpine.LFD.1.00.0802111349090.2920@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-1.831 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_32,J_CHICKENPOX_35,J_CHICKENPOX_37
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73600>



On Mon, 11 Feb 2008, Linus Torvalds wrote:
> 
> Anyway, here's the patch to try out..

Ok, one more (final, I promise!) patch..

There's another issue: I think the non-cumulative percentages are more 
interesting, but perhaps somebody disagrees. So here's a patch that allows 
you to say

	git diff --dirstat --cumulative v2.6.24..v2.6.25-rc1

and now the percentages will accumulate into the parent directory even 
when they are printed out.

Example difference:

 - without --cumulative:

	   3.2% arch/arm/
	   6.9% arch/powerpc/
	   3.2% arch/sh/
	   6.9% arch/x86/
	  11.0% arch/
	   3.7% drivers/media/
	   7.3% drivers/net/wireless/
	   6.9% drivers/net/
	  19.1% drivers/
	   3.5% fs/
	  10.3% include/
	   6.0% net/
	   3.7% sound/

 - with --cumulative:

	   3.2% arch/arm/
	   6.9% arch/powerpc/
	   3.2% arch/sh/
	   6.9% arch/x86/
	  31.3% arch/
	   3.7% drivers/media/
	   7.3% drivers/net/wireless/
	  14.3% drivers/net/
	  37.2% drivers/
	   3.5% fs/
	  10.3% include/
	   6.0% net/
	   3.7% sound/

and note how the latter may be more "logical" (ie it now says "31.3% arch" 
which simply means that about a third of the changes were somewhere under 
the arch/ subdirectory), it's obvious why I don't like it in general (even 
if it's wonderful in this case) when you start looking at other examples:

 - without --cumulative:

	 100.0% arch/x86/mm/

 - with --cumulative:

	 100.0% arch/x86/mm/
	 100.0% arch/x86/
	 100.0% arch/

which is obviously just noise and confusion, and not helpful at all.

But here's a trial patch against my original patch (ie this contains it 
all - the trivial fixes, tenths of percent reporting, and now the 
cumulative flag too). I was too lazy to try to split it up, and I hadn't 
committed the previous ones in between (bad Linus!).

		Linus

---
 diff.c |   19 +++++++++++++------
 diff.h |    3 ++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index da91bdd..e5b8baa 100644
--- a/diff.c
+++ b/diff.c
@@ -982,7 +982,7 @@ static void show_numstat(struct diffstat_t* data, struct diff_options *options)
 
 struct diffstat_dir {
 	struct diffstat_file **files;
-	int nr, percent;
+	int nr, percent, cumulative;
 };
 
 static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, const char *base, int baselen)
@@ -1012,10 +1012,14 @@ static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, cons
 	}
 
 	if (baselen) {
-		int percent = this_dir * 100 / changed;
-		if (percent >= dir->percent) {
-			printf("%4d%% %.*s\n", percent, baselen, base);
-			return 0;
+		int permille = this_dir * 1000 / changed;
+		if (permille) {
+			int percent = permille / 10;
+			if (percent >= dir->percent) {
+				printf("%4d.%01d%% %.*s\n", percent, permille % 10, baselen, base);
+				if (!dir->cumulative)
+					return 0;
+			}
 		}
 	}
 	return this_dir;
@@ -1042,6 +1046,7 @@ static void show_dirstat(struct diffstat_t *data, struct diff_options *options)
 	dir.files = data->files;
 	dir.nr = data->nr;
 	dir.percent = options->dirstat_percent;
+	dir.cumulative = options->output_format & DIFF_FORMAT_CUMULATIVE;
 	gather_dirstat(&dir, changed, "", 0);
 }
 
@@ -2273,8 +2278,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	else if (!strcmp(arg, "--dirstat"))
+	else if (opt_arg(arg, 'X', "dirstat", &options->dirstat_percent))
 		options->output_format |= DIFF_FORMAT_DIRSTAT;
+	else if (!strcmp(arg, "--cumulative"))
+		options->output_format |= DIFF_FORMAT_CUMULATIVE;
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
diff --git a/diff.h b/diff.h
index 3181263..8c6bb54 100644
--- a/diff.h
+++ b/diff.h
@@ -30,7 +30,8 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_SUMMARY	0x0008
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
-#define DIFF_FORMAT_DIRSTAT	0x0020
+#define DIFF_FORMAT_DIRSTAT	0x0040
+#define DIFF_FORMAT_CUMULATIVE	0x0080
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
