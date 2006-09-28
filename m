From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Thu, 28 Sep 2006 15:07:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609281458420.3952@g5.osdl.org>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0609281349110.3952@g5.osdl.org> <7vac4ju1f1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Fri Sep 29 00:12:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT45d-0001FK-7J
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 00:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161330AbWI1WKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 18:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161332AbWI1WKl
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 18:10:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161330AbWI1WKk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 18:10:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8SM7LnW007667
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 15:07:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8SM7Go4025466;
	Thu, 28 Sep 2006 15:07:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac4ju1f1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28053>



On Thu, 28 Sep 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > So how about just extending the existing "--stat" thing, and just making 
> > it do something like
> >
> > 	git diff --stat=72,30
> >
> > instead (perhaps along with a config option to set the defaults to 
> > something else if we want to).
> >
> > What do you think?
> 
> I am all for it.

Here. Something like this.

You should probably check the "width" and "name_width" values for sanity. 
The old code didn't, so I didn't do it, but this actually does check that 
the number was a real number (and didn't have crap after it). And it's 
easy to check the values, since all cases go through the same point.

I could have made it a more obvious "stupid" parser, I just think it's 
better to do it this way.

		Linus

----
diff --git a/diff.c b/diff.c
index 98c29bf..8546dde 100644
--- a/diff.c
+++ b/diff.c
@@ -1825,15 +1825,33 @@ int diff_opt_parse(struct diff_options *
 	else if (!strcmp(arg, "--patch-with-raw")) {
 		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW;
 	}
-	else if (!strcmp(arg, "--stat"))
-		options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	else if (!strncmp(arg, "--stat-width=", 13)) {
-		options->stat_width = strtoul(arg + 13, NULL, 10);
-		options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	}
-	else if (!strncmp(arg, "--stat-name-width=", 18)) {
-		options->stat_name_width = strtoul(arg + 18, NULL, 10);
+	else if (!strncmp(arg, "--stat", 6)) {
+		char *end;
+		int width = options->stat_width;
+		int name_width = options->stat_name_width;
+		arg += 6;
+		end = arg;
+
+		switch (*arg) {
+		case '-':
+			if (!strncmp(arg, "-width=", 7))
+				width = strtoul(arg + 7, &end, 10);
+			else if (!strncmp(arg, "-name-width=", 12))
+				name_width = strtoul(arg + 12, &end, 10);
+			break;
+
+		case '=':
+			width = strtoul(arg+1, &end, 10);
+			if (*end == ',')
+				name_width = strtoul(end+1, &end, 10);
+		}
+
+		/* Important! This checks all the error cases! */
+		if (*end)
+			return 0;
 		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+		options->stat_name_width = name_width;
+		options->stat_width = width;
 	}
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
