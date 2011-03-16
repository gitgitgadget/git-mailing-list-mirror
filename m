From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] run-command: prettify -D_FORTIFY_SOURCE workaround
Date: Tue, 15 Mar 2011 22:51:52 -0500
Message-ID: <20110316035135.GA30348@elie>
References: <d2e97e801001291438k21a652cakb05ec34fc8bee227@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Wookey <michaelwookey@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 04:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzhmF-0001WU-Qe
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 04:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171Ab1CPDv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 23:51:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54605 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1CPDv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 23:51:57 -0400
Received: by gyf1 with SMTP id 1so495699gyf.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ZieqEPDOIPpUhgu/dPMCyVgzV3467fJOOKE0Tzzdjv4=;
        b=dWjLJ72VQTf38n1+OdC0aM2iRT2Y7B4FhreenbqN/GYUP7KH5gkUVkTz886IRTVvKj
         I6KWwEuwLnOBB70A8zrsezLnGYagnR1d8GUkSUwd0beTPpOI+l4ighFJNq+Z2mgpcAFO
         nX5ldnOoF9V3oWjNxI9H44XRwAK6Ub0g+C4Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LpveUX3c1K2HTnwdpNEF9/LJ8xQvtlQPZ5XBkpHvubQjT4aCJukPN0C6SvLkQu0TDq
         puf3rm2nZC0DQwqaBu88sCh4kWAz1cwHG7QOQPlOW62bUH61G/2NsMPUXsf9asANyz4J
         VC7lYNTjg5nHt7aWrrooKlNe6j/Sxwbw3jcuw=
Received: by 10.91.121.15 with SMTP id y15mr838844agm.105.1300247516986;
        Tue, 15 Mar 2011 20:51:56 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id e24sm614285ana.22.2011.03.15.20.51.55
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 20:51:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d2e97e801001291438k21a652cakb05ec34fc8bee227@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169100>

Current gcc + glibc with -D_FORTIFY_SOURCE try very aggressively to
protect against a programming style which uses write(...) without
checking the return value for errors.  Even the usual hint of casting
to (void) does not suppress the warning.

Sometimes when there is an output error, especially right before exit,
there really is nothing to be done.  The obvious solution, adopted in
v1.7.0.3~20^2 (run-command.c: fix build warnings on Ubuntu,
2010-01-30), is to save the return value to a dummy variable:

	ssize_t dummy;
	dummy = write(...);

But that (1) is ugly and (2) triggers -Wunused-but-set-variable
warnings with gcc-4.6 -Wall, so we are not much better off than when
we started.

Instead, use an "if" statement with an empty body to make the intent
clear.

	if (write(...))
		; /* yes, yes, there was an error. */

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Michael Wookey wrote:

> Although this will fix the build warnings, I am unsure if there is a
> better way to achieve the same result. Using "(void)write(...)" still
> gives warnings and I am unaware of any annotations that will silence
> gcc.

It's been a long time (and meanwhile the patch has been working;
thanks!).  How about something like this?

 run-command.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3206d61..5b68907 100644
--- a/run-command.c
+++ b/run-command.c
@@ -67,21 +67,21 @@ static int child_notifier = -1;
 
 static void notify_parent(void)
 {
-	ssize_t unused;
-	unused = write(child_notifier, "", 1);
+	if (write(child_notifier, "", 1))
+		; /* ok. */
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
+	if (write(child_err, "fatal: ", 7) ||
+	    write(child_err, msg, len) ||
+	    write(child_err, "\n", 1))
+		; /* ok. */
 	exit(128);
 }
 
-- 
1.7.4.1
