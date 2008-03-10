From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Write diff output to a file in struct diff_options
Date: Mon, 10 Mar 2008 13:58:26 -0400
Message-ID: <1205171906.31046.27.camel@gaara.boston.redhat.com>
References: <alpine.LNX.1.00.0803092235150.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 19:12:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYmU0-00007h-K5
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 19:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbYCJSLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 14:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbYCJSLK
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 14:11:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55349 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbYCJSLI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 14:11:08 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2AHwW0P031907;
	Mon, 10 Mar 2008 13:58:32 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2AHwVEs020008;
	Mon, 10 Mar 2008 13:58:31 -0400
Received: from [192.168.1.104] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2AHwVPZ015505;
	Mon, 10 Mar 2008 13:58:31 -0400
In-Reply-To: <alpine.LNX.1.00.0803092235150.19665@iabervon.org>
X-Mailer: Evolution 2.21.91 (2.21.91-2.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76748>

On Sun, 2008-03-09 at 22:43 -0400, Daniel Barkalow wrote:
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> I remember there being some expectation that this would be difficult, but 
> it was a pretty straightforward conversion, so I'm wondering if I've 
> missed something. In any case, this is missing tests and documentation for 
> --output=, but I really want it to use directly for rebase-interactive, 
> and I only did the command line option so I could do informal testing.

I ended up just dup()-ing files around in wt-status.c, but it wasn't
that converting looked difficult, just that I was trying to finish the
builtin-commit work and didn't want to undertake a new rewrite :)  With
your patch, we can now avoid the dup-dance.

cheers,
Kristian


diff --git a/wt-status.c b/wt-status.c
index 32d780a..181821b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -314,25 +314,13 @@ static void wt_status_print_verbose(struct wt_status *s)
 	struct rev_info rev;
 	int saved_stdout;
 
-	fflush(s->fp);
-
-	/* Sigh, the entire diff machinery is hardcoded to output to
-	 * stdout.  Do the dup-dance...*/
-	saved_stdout = dup(STDOUT_FILENO);
-	if (saved_stdout < 0 ||dup2(fileno(s->fp), STDOUT_FILENO) < 0)
-		die("couldn't redirect stdout\n");
-
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
+	rev.diffopt.file = s->fp;
+	rev.diffopt.close_file = 0;
 	run_diff_index(&rev, 1);
-
-	fflush(stdout);
-
-	if (dup2(saved_stdout, STDOUT_FILENO) < 0)
-		die("couldn't restore stdout\n");
-	close(saved_stdout);
 }
 
 void wt_status_print(struct wt_status *s)
