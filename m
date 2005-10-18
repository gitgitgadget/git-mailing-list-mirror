From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-checkout-index, flag ordering and --prefix kludgy handling
Date: Mon, 17 Oct 2005 19:48:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510171933200.3369@g5.osdl.org>
References: <200510162114.27429.blaisorblade@yahoo.it>
 <Pine.LNX.4.64.0510171546580.3369@g5.osdl.org> <7v8xwry88u.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510171814430.3369@g5.osdl.org> <7vmzl7tv89.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 04:49:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERhWU-00035i-FY
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 04:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVJRCsP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 22:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVJRCsP
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 22:48:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26067 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932395AbVJRCsO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2005 22:48:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9I2mAFC031457
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Oct 2005 19:48:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9I2m7qq024666;
	Mon, 17 Oct 2005 19:48:09 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzl7tv89.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10204>



On Mon, 17 Oct 2005, Junio C Hamano wrote:
> 
> One reason I have not done nor said much about this was because
> I've been thinking about making the branch/refname more explicit
> on our command line.

Yes, I know it's ambigious at times, but it really is very convenient. 
Usually we allow a "--" to say where a filename starts when it _is_ 
ambiguous.

However, you're right, we fail that at times. In particular, git-rev-parse 
fails it.

Something like this?

		Linus
---
diff --git a/rev-parse.c b/rev-parse.c
index 41b9dae..85230df 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -151,6 +151,12 @@ static void show_datestring(const char *
 	show(buffer);
 }
 
+static void show_file(const char *arg)
+{
+	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV))
+		show(arg);
+}
+
 int main(int argc, char **argv)
 {
 	int i, as_is = 0, verify = 0;
@@ -162,7 +168,7 @@ int main(int argc, char **argv)
 		char *dotdot;
 	
 		if (as_is) {
-			show(arg);
+			show_file(arg);
 			continue;
 		}
 		if (*arg == '-') {
@@ -282,9 +288,7 @@ int main(int argc, char **argv)
 		}
 		if (verify)
 			die("Needed a single revision");
-		if ((filter & (DO_NONFLAGS|DO_NOREV)) ==
-		    (DO_NONFLAGS|DO_NOREV))
-			show(arg);
+		show_file(arg);
 	}
 	show_default();
 	if (verify && revs_count != 1)
