From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 07:56:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
 <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 16:56:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNB7r-0002bY-MC
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 16:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWCYP4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 10:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWCYP4L
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 10:56:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750716AbWCYP4K (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 10:56:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2PFu5DZ014854
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 07:56:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2PFu3Pv001869;
	Sat, 25 Mar 2006 07:56:04 -0800
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17987>



On Sat, 25 Mar 2006, Linus Torvalds wrote:
> 
> I'll be taking a look at trying to fix it. 

Actually, it ended up being easier than I expected it to be.

This (on top of the previous patch) should fix it.

And yes, with this, I can pass the output of

	git diff v2.6.16..

to "git-apply" and it not only passes the "--stat" thing (which verifies 
that git-apply is happy with the diff) but it also results in exactly the 
same tree when applied on top of v2.6.16 (and the patch has two cases 
where the "no newline" test triggers).

The speed-up is quite noticeable, especially when doing things like

	git diff v2.6.16.. | git-apply --stat

which just _used_ to be painfully slow (25 seconds for me) and is now 
under five seconds. That's the difference between "twiddling your thumbs" 
and "ok, that wasn't too bad".

Now, to be honest, the real reason I wanted a built-in diff wasn't the 
speed advantage, but the fact that it's so much more flexible. The lack of 
fork/exec just allows us to do things that weren't practical before.

		Linus

----
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 01e6765..b68afa2 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -31,14 +31,22 @@
 
 int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 		     xdemitcb_t *ecb) {
-	mmbuffer_t mb[2];
+	mmbuffer_t mb[3];
+	int i;
 
 	mb[0].ptr = (char *) pre;
 	mb[0].size = psize;
 	mb[1].ptr = (char *) rec;
 	mb[1].size = size;
+	i = 2;
 
-	if (ecb->outf(ecb->priv, mb, 2) < 0) {
+	if (!size || rec[size-1] != '\n') {
+		mb[2].ptr = "\n\\ No newline at end of file\n";
+		mb[2].size = strlen(mb[2].ptr);
+		i = 3;
+	}
+
+	if (ecb->outf(ecb->priv, mb, i) < 0) {
 
 		return -1;
 	}
