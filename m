From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] run-command: prettify -D_FORTIFY_SOURCE workaround
Date: Wed, 16 Mar 2011 02:32:39 -0500
Message-ID: <20110316073239.GJ5988@elie>
References: <d2e97e801001291438k21a652cakb05ec34fc8bee227@mail.gmail.com>
 <20110316035135.GA30348@elie>
 <7v7hbzaan9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Wookey <michaelwookey@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 08:32:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzlDw-0006mS-RZ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 08:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab1CPHcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 03:32:45 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38229 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab1CPHco (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 03:32:44 -0400
Received: by gwaa18 with SMTP id a18so547450gwa.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=l4/kxNyXoex1KuGBSuyMjpcxGqkXCRouXor9g8I8838=;
        b=JAPv3qz1TV7Uzv16j33jpRCi5tQoYOljdWJAQtF47eUdpT2mtHy9H5E4IjA3XJrm2s
         ewlDifEBrjyVCybFcO4y2CH4kYGitX+4BJJmZGd68DnqmNKhpQFW2cqemUZp3r+/j/vZ
         Ltt6AkdawWj5R0efjm6ws3zquiCL2FNGQS9zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VW2qZZvY6+EhLiCE5N5hEhkiZjeNDF835FgpoPKrSVGCj3rXdIj5YooR3iMBYDlEqz
         b7XexsaJse7fJl6PlPECmqJCgtWF0x0aOGMI+JMZ6Kgir3HxjdfLvbNiSb4jYft2WvN2
         4izHF7SKs3Zi8JKXl1F5hM43UisPhPAgExdPQ=
Received: by 10.150.114.7 with SMTP id m7mr969310ybc.383.1300260763605;
        Wed, 16 Mar 2011 00:32:43 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id y21sm445129yhc.18.2011.03.16.00.32.41
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 00:32:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v7hbzaan9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169117>

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
Improved-by: Junio C Hamano <gitster@pobox.com>
---
Junio C Hamano wrote:

>               The unusual "if ()" whose condition is solely for its side
> effect, with an empty body, is a strong enough sign to any reader that
> there is something fishy going on, and it would be helpful to the reader
> to hint _why_ such an unusual construct is there.  It would be much better
> for the longer term maintainability to say at least "gcc" in the comment,
> i.e.
> 
> 	if (write(...))
>         	; /* we know we are ignoring the error, mr gcc! */

Very true.  Some comments to that effect below.

 run-command.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3206d61..ecd9d1c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -67,21 +67,26 @@ static int child_notifier = -1;
 
 static void notify_parent(void)
 {
-	ssize_t unused;
-	unused = write(child_notifier, "", 1);
+	/*
+	 * execvp failed.  If possible, we'd like to let start_command
+	 * know, so failures like ENOENT can be handled right away; but
+	 * otherwise, finish_command will still report the error.
+	 */
+	if (write(child_notifier, "", 1))
+		; /* yes, dear gcc -D_FORTIFY_SOURCE, there was an error. */
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
+		; /* yes, gcc -D_FORTIFY_SOURCE, we know there was an error. */
 	exit(128);
 }
 
-- 
1.7.4.1
