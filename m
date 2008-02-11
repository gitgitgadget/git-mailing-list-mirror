From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add "--dirstat" for some directory statistics
Date: Mon, 11 Feb 2008 14:06:10 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802111349090.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802111230200.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802112122300.3870@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOgxM-0004bh-6X
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 23:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYBKWQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 17:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYBKWQV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 17:16:21 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33495 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752442AbYBKWQU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 17:16:20 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BMBlHn001113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 14:14:31 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BM6A6k002673;
	Mon, 11 Feb 2008 14:06:25 -0800
In-Reply-To: <alpine.LSU.1.00.0802112122300.3870@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.731 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73596>



On Mon, 11 Feb 2008, Johannes Schindelin wrote:
> 
> I mean, sometimes even 0.01% is worth showing.

I tried this, and no. It's not. Not even 0.1%. If you care at that level,  
you're better off just looking at the diffstat itself. The noise factor 
with the summary makes it useless with even 0.1%.

That said, the *reporting* sometimes looks better with tenths of percents. 
This is an example of "report in tenths of percent, limit to 1%":

   4.8% arch/um/include/
   6.1% arch/um/os-Linux/drivers/
   5.7% arch/um/os-Linux/include/
   2.6% arch/um/os-Linux/skas/
   1.7% arch/um/os-Linux/sys-i386/
   9.2% arch/um/os-Linux/sys-x86_64/
  69.6% arch/um/os-Linux/

and maybe that format would be nicer (and more "future proof" in case 
people want to make the limiting go down to fractional percentages too).

If people want to play around with it, here's a trial patch (and yes, if 
you want it down to 0.1%, you can use "--dirstat=0", and it will only 
remove the ones that really round down to 0.0%, but it really isn't any 
good for summaries any more).

For summaries, I'd suggest testing with something like

	git diff --dirstat=? v2.6.23..v2.6.24

and comparing the 0% cutoff (pretty damn useless) to 1 (already *much* 
better and perhaps appropriate as a "deep summary") to 2 (probably the 
best if you actually want a short summary) to 3 (fairly similar, but 
dropped a few "2.x%" cases that were relevant).

The 1% cutoff case is already big enough that I don't think it's good as a 
summary, and while it contains "more information", it's actually likely 
much more informative in that case to do the default 3% case, and then 
noticing that "drivers" and "include" are pretty high, and at that point 
it makes sense to say "ok, let's re-do it but limiting it to that 
subdirectory", and do a

	git diff --dirstat=3 v2.6.23..v2.6.24 drivers/

where now you'll actually see *more* information than for the 1% case, but 
only as it pertains for that drivers subdirectory.

So I seriously doubt that you often want to have small percentages, and 
that it's much more productive to give people the overview and then they 
can "drill down" into that overview.

Anyway, here's the patch to try out..

		Linus

---
 diff.c |   11 ++++++++-----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -1012,10 +1012,13 @@ static long gather_dirstat(struct diffstat_dir *dir, unsigned long changed, cons
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
+				return 0;
+			}
 		}
 	}
 	return this_dir;
