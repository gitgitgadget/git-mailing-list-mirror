From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 13:02:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703021249010.3953@woody.linux-foundation.org>
References: <200703011206.47213.andyparkins@gmail.com> <es9aal$5gf$1@sea.gmane.org>
 <Pine.LNX.4.64.0703020850470.3953@woody.linux-foundation.org>
 <200703021937.33648.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 22:02:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNEtq-00009K-48
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 22:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965625AbXCBVC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 16:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965620AbXCBVC2
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 16:02:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41154 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965624AbXCBVC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 16:02:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l22L2Oq8001652
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Mar 2007 13:02:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l22L2ONK018828;
	Fri, 2 Mar 2007 13:02:24 -0800
In-Reply-To: <200703021937.33648.andyparkins@gmail.com>
X-Spam-Status: No, hits=-5.449 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41247>



On Fri, 2 Mar 2007, Andy Parkins wrote:

> On Friday 2007, March 02, Linus Torvalds wrote:
> 
> > Yes. How about just having the built-in git pager do the right thing?
> 
> Perfect.  This is absolutely the right thing to do I think.

Well, it would be perfect, except it's rather hard to do. Right now we 
simply don't have any way to tell the pager what to do with the data, and 
we'd need to do some communications passing thing to let it know.

It *could* just look at the data directly, but that's actually hard: if we 
start looking at the data, there's no way to push the data back onto the 
head of a pipe, and there's no really good way to tell an external pager 
to "start off with this data that I already read earlier to figure out the 
type, and then continue with that other file descriptor that I'm passing 
in".

So then we'd have to have a totally useless process in between the git 
process and the external pager to just feed the data from one pipe to the 
other..

Doing the pager internally would obviously solve that issue, but I really 
don't think we want to do that, especially since it's very 
system-dependent. And temporary files suck for all the other reasons 
(incrementally generated data).

So we're in the situation where:

 - the pager process *will* wait until actual data is starting to appear,
   so we *can* have some side-band channel to tell it "oh, btw, if there 
   is a pager, this is going to be image data, so start up an external 
   image viewer instead". 

 - but I don't have a good clue what side-band to use. We could use 
   a special "FILE *pagerdata", of course (which would just be fd#3 in 
   the pager). Then, "git show" could just do something like

	if (pager_in_use)
		fprintf(pagerdata, "'%s'\n", type);

   and we could change pager.c to do something like the appended patch.

but I have to say, it looks a bit strange.

		Linus

---
diff --git a/pager.c b/pager.c
index 5f280ab..b71dd44 100644
--- a/pager.c
+++ b/pager.c
@@ -9,6 +9,8 @@
 
 static void run_pager(const char *pager)
 {
+	static char input_type[100] = "text";
+
 	/*
 	 * Work around bug in "less" by not starting it until we
 	 * have real input
@@ -17,7 +19,16 @@ static void run_pager(const char *pager)
 
 	FD_ZERO(&in);
 	FD_SET(0, &in);
-	select(1, &in, NULL, &in, NULL);
+	FD_SET(3, &in);
+	select(4, &in, NULL, &in, NULL);
+	if (FS_ISSET(3, &in)) {
+		int n = read(3, input_type, sizeof(input_type)-1);
+		if (n > 0)
+			input_type[n] = 0;
+	}
+	close(3);
+
+	pager = select_pager(input_type, pager);
 
 	execlp(pager, pager, NULL);
 	execl("/bin/sh", "sh", "-c", pager, NULL);
