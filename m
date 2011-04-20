From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] run-command: handle short writes and EINTR in die_child
Date: Wed, 20 Apr 2011 05:40:05 -0500
Message-ID: <20110420104005.GC6027@elie>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <7v4o5v8dlp.fsf@alter.siamese.dyndns.org>
 <20110419070510.GB28291@elie>
 <4DAE8E66.5060705@viscovery.net>
 <20110420103319.GA6027@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 12:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCUpc-00056x-06
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 12:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab1DTKkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 06:40:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59965 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab1DTKkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 06:40:17 -0400
Received: by iwn34 with SMTP id 34so485541iwn.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 03:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=m98r1xAfLUJsHk/IhMdDtLL+rc1XEMCrRS/glI4e/7M=;
        b=tU5EC5N2398mAn9MoPZ0Z8olzkCS67BYuhSV0p3gghrq1GXI3Q6OHF9rhFI75+69oj
         L3kaUE1aaDsC4jAS2iIs9snfWIfSwCmDbIa1CgI/Gq8+6P9hfRIljt0zC+fT3Jcwfmdm
         J/RcwR1j+f7Nfx0eZ7+DUKtZ/ZwO3NsBnGYbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YbnRBcXqVl+GYlalQpZ+h8AZ7lAhfTOoTFUL8MkgCmzS8fTsRERVxYq92USUK5U81s
         O6iSNnRu0j6dX50ikvuCudziJ5f/wrxh+15reDifeNA0zfeawDEGlEM/sfsTLcB/Vdfe
         HmEILDVCuGjH8BH2JM5Rnp6KmH3Ekwmpwi3AY=
Received: by 10.43.65.75 with SMTP id xl11mr8924731icb.497.1303296016352;
        Wed, 20 Apr 2011 03:40:16 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id xg14sm298542icb.7.2011.04.20.03.40.10
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 03:40:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110420103319.GA6027@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171857>

If start_command fails after forking and before exec finishes, there
is not much use in noticing an I/O error on top of that.
finish_command will notice that the child exited with nonzero status
anyway.  So as noted in v1.7.0.3~20^2 (run-command.c: fix build
warnings on Ubuntu, 2010-01-30) and v1.7.5-rc0~29^2 (2011-03-16), it
is safe to ignore errors from write in this codepath.

Even so, the result from write contains useful information: it tells
us if the write was cancelled by a signal (EINTR) or was only
partially completed (e.g., when writing to an almost-full pipe).
Let's use write_in_full to loop until the desired number of bytes have
been written (still ignoring errors if that fails).

As a happy side effect, the assignment to a dummy variable to appease
gcc -D_FORTIFY_SOURCE is no longer needed.  xwrite and write_in_full
check the return value from write(2).

Noticed with gcc -Wunused-but-set-variable.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes from v1:

 - rewrite the commit message from the pov of a person who does not
   care about this patch's origin as a brown paper bag

 - drop the "if"s.  If the fussy compiler/library combination was
   right in some strange sense after all, then it does not make much
   sense to take the opportunity to make another token effort to
   appease it as a preventative step.

 run-command.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index f91e446..70e8a24 100644
--- a/run-command.c
+++ b/run-command.c
@@ -67,21 +67,24 @@ static int child_notifier = -1;
 
 static void notify_parent(void)
 {
-	ssize_t unused;
-	unused = write(child_notifier, "", 1);
+	/*
+	 * execvp failed.  If possible, we'd like to let start_command
+	 * know, so failures like ENOENT can be handled right away; but
+	 * otherwise, finish_command will still report the error.
+	 */
+	xwrite(child_notifier, "", 1);
 }
 
 static NORETURN void die_child(const char *err, va_list params)
 {
 	char msg[4096];
-	ssize_t unused;
 	int len = vsnprintf(msg, sizeof(msg), err, params);
 	if (len > sizeof(msg))
 		len = sizeof(msg);
 
-	unused = write(child_err, "fatal: ", 7);
-	unused = write(child_err, msg, len);
-	unused = write(child_err, "\n", 1);
+	write_in_full(child_err, "fatal: ", 7);
+	write_in_full(child_err, msg, len);
+	write_in_full(child_err, "\n", 1);
 	exit(128);
 }
 #endif
-- 
1.7.5.rc2
